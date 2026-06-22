package storage

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"web-honeypot/internal/models"

	_ "github.com/go-sql-driver/mysql"
)

func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

func getEnvInt(key string, defaultValue int) int {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	intValue, err := strconv.Atoi(value)
	if err != nil {
		return defaultValue
	}
	return intValue
}

func getDBHost() string {
	return getEnv("DB_HOST", "127.0.0.1")
}

func getDBPort() int {
	return getEnvInt("DB_PORT", 3306)
}

func getDBUser() string {
	return getEnv("DB_USER", "root")
}

func getDBPassword() string {
	return getEnv("DB_PASSWORD", "root")
}

func getDBName() string {
	return getEnv("DB_NAME", "web_honeypot")
}

// 全局DB连接
var db *sql.DB

// InitStorage 初始化存储
func InitStorage() error {
	dbHost := getDBHost()
	dbPort := getDBPort()
	dbUser := getDBUser()
	dbPassword := getDBPassword()
	dbName := getDBName()

	// 先连接到MySQL服务器（不指定数据库）
	connStrWithoutDB := fmt.Sprintf("%s:%s@tcp(%s:%d)/?charset=utf8mb4&parseTime=True",
		dbUser, dbPassword, dbHost, dbPort)

	var err error
	tempDB, err := sql.Open("mysql", connStrWithoutDB)
	if err != nil {
		return fmt.Errorf("failed to connect to MySQL server: %w", err)
	}
	defer tempDB.Close()

	// 测试连接到服务器
	if err := tempDB.Ping(); err != nil {
		return fmt.Errorf("failed to ping MySQL server: %w", err)
	}

	// 创建数据库（如果不存在）
	_, err = tempDB.Exec(fmt.Sprintf("CREATE DATABASE IF NOT EXISTS %s DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci", dbName))
	if err != nil {
		return fmt.Errorf("failed to create database: %w", err)
	}

	log.Printf("Database '%s' is ready", dbName)

	// 现在连接到指定的数据库
	connStr := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8mb4&parseTime=True",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	db, err = sql.Open("mysql", connStr)
	if err != nil {
		return fmt.Errorf("failed to connect to database: %w", err)
	}

	// 测试连接
	if err := db.Ping(); err != nil {
		return fmt.Errorf("failed to ping database: %w", err)
	}

	log.Println("Successfully connected to MySQL database")

	// 创建数据库表
	if err := createTables(); err != nil {
		return fmt.Errorf("failed to create tables: %w", err)
	}

	return nil
}

// CloseStorage 关闭存储
func CloseStorage() error {
	if db != nil {
		return db.Close()
	}
	return nil
}

// 创建数据库表
func createTables() error {
	// 创建攻击者表
	attackerTableSQL := `
	CREATE TABLE IF NOT EXISTS attackers (
		id INT AUTO_INCREMENT PRIMARY KEY,
		username VARCHAR(255) NOT NULL,
		password VARCHAR(255) NOT NULL,
		ip VARCHAR(45) NOT NULL,
		ua TEXT NOT NULL,
		timestamp DATETIME NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	`

	if _, err := db.Exec(attackerTableSQL); err != nil {
		return fmt.Errorf("failed to create attackers table: %w", err)
	}

	// 创建插件表
	pluginTableSQL := `
	CREATE TABLE IF NOT EXISTS plugins (
		id VARCHAR(36) PRIMARY KEY,
		name VARCHAR(255) NOT NULL,
		code TEXT NOT NULL,
		enabled BOOLEAN NOT NULL DEFAULT TRUE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	`

	if _, err := db.Exec(pluginTableSQL); err != nil {
		return fmt.Errorf("failed to create plugins table: %w", err)
	}

	// 创建蜜罐日志表
	logTableSQL := `
	CREATE TABLE IF NOT EXISTS honeypot_logs (
		id INT AUTO_INCREMENT PRIMARY KEY,
		type VARCHAR(100) NOT NULL,
		arguments TEXT NOT NULL,
		ip VARCHAR(45) NOT NULL,
		ua TEXT NOT NULL,
		timestamp DATETIME NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	`

	if _, err := db.Exec(logTableSQL); err != nil {
		return fmt.Errorf("failed to create honeypot_logs table: %w", err)
	}

	// 创建蜜罐事件表
	eventTableSQL := `
	CREATE TABLE IF NOT EXISTS honeypot_events (
		id INT AUTO_INCREMENT PRIMARY KEY,
		type VARCHAR(100) NOT NULL,
		data TEXT NOT NULL,
		ip VARCHAR(45) NOT NULL,
		ua TEXT NOT NULL,
		timestamp DATETIME NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	`

	if _, err := db.Exec(eventTableSQL); err != nil {
		return fmt.Errorf("failed to create honeypot_events table: %w", err)
	}

	// 创建webhook请求表
	webhookTableSQL := `
	CREATE TABLE IF NOT EXISTS webhook_requests (
		id INT AUTO_INCREMENT PRIMARY KEY,
		data TEXT NOT NULL,
		ip VARCHAR(45) NOT NULL,
		method VARCHAR(10) NOT NULL,
		headers TEXT NOT NULL,
		timestamp DATETIME NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	`

	if _, err := db.Exec(webhookTableSQL); err != nil {
		return fmt.Errorf("failed to create webhook_requests table: %w", err)
	}

	log.Println("All database tables created successfully")
	return nil
}

// SaveAttacker 保存攻击者信息
func SaveAttacker(attacker models.Attacker) {
	attacker.Timestamp = time.Now()

	result, err := db.Exec("INSERT INTO attackers (username, password, ip, ua, timestamp) VALUES (?, ?, ?, ?, ?)",
		attacker.Username, attacker.Password, attacker.IP, attacker.UA, attacker.Timestamp)
	if err != nil {
		log.Printf("Failed to save attacker: %v", err)
		return
	}

	// 获取自增ID
	id, err := result.LastInsertId()
	if err != nil {
		log.Printf("Failed to get last insert ID: %v", err)
		return
	}

	attacker.ID = int(id)
}

// GetAllAttackers 获取所有攻击者信息
func GetAllAttackers() []models.Attacker {
	rows, err := db.Query("SELECT id, username, password, ip, ua, timestamp FROM attackers ORDER BY timestamp DESC")
	if err != nil {
		log.Printf("Failed to get all attackers: %v", err)
		return []models.Attacker{}
	}
	defer rows.Close()

	var attackers []models.Attacker
	for rows.Next() {
		var a models.Attacker
		if err := rows.Scan(&a.ID, &a.Username, &a.Password, &a.IP, &a.UA, &a.Timestamp); err != nil {
			log.Printf("Failed to scan attacker: %v", err)
			continue
		}
		attackers = append(attackers, a)
	}

	return attackers
}

// SaveHoneypotLog 保存蜜罐日志
func SaveHoneypotLog(honeypotLog models.HoneypotLog) {
	honeypotLog.Timestamp = time.Now()

	// 将arguments转换为JSON字符串
	argumentsJSON, err := json.Marshal(honeypotLog.Arguments)
	if err != nil {
		log.Printf("Failed to marshal log arguments: %v", err)
		return
	}

	_, err = db.Exec("INSERT INTO honeypot_logs (type, arguments, ip, ua, timestamp) VALUES (?, ?, ?, ?, ?)",
		honeypotLog.Type, argumentsJSON, honeypotLog.IP, honeypotLog.UA, honeypotLog.Timestamp)
	if err != nil {
		log.Printf("Failed to save honeypot log: %v", err)
		return
	}
}

// SaveHoneypotEvent 保存蜜罐事件
func SaveHoneypotEvent(event models.HoneypotEvent) {
	event.Timestamp = time.Now()

	_, err := db.Exec("INSERT INTO honeypot_events (type, data, ip, ua, timestamp) VALUES (?, ?, ?, ?, ?)",
		event.Type, event.Data, event.IP, event.UA, event.Timestamp)
	if err != nil {
		log.Printf("Failed to save honeypot event: %v", err)
		return
	}
}

// GetAllHoneypotLogs 获取所有蜜罐日志
func GetAllHoneypotLogs() []models.HoneypotLog {
	rows, err := db.Query("SELECT id, type, arguments, ip, ua, timestamp FROM honeypot_logs ORDER BY timestamp DESC")
	if err != nil {
		log.Printf("Failed to get all honeypot logs: %v", err)
		return []models.HoneypotLog{}
	}
	defer rows.Close()

	var logs []models.HoneypotLog
	for rows.Next() {
		var l models.HoneypotLog
		var argumentsJSON string
		if err := rows.Scan(&l.ID, &l.Type, &argumentsJSON, &l.IP, &l.UA, &l.Timestamp); err != nil {
			log.Printf("Failed to scan honeypot log: %v", err)
			continue
		}

		// 解析arguments JSON
		if err := json.Unmarshal([]byte(argumentsJSON), &l.Arguments); err != nil {
			log.Printf("Failed to unmarshal log arguments: %v", err)
			continue
		}

		logs = append(logs, l)
	}

	return logs
}

// GetAllHoneypotEvents 获取所有蜜罐事件
func GetAllHoneypotEvents() []models.HoneypotEvent {
	rows, err := db.Query("SELECT id, type, data, ip, ua, timestamp FROM honeypot_events ORDER BY timestamp DESC")
	if err != nil {
		log.Printf("Failed to get all honeypot events: %v", err)
		return []models.HoneypotEvent{}
	}
	defer rows.Close()

	var events []models.HoneypotEvent
	for rows.Next() {
		var e models.HoneypotEvent
		if err := rows.Scan(&e.ID, &e.Type, &e.Data, &e.IP, &e.UA, &e.Timestamp); err != nil {
			log.Printf("Failed to scan honeypot event: %v", err)
			continue
		}
		events = append(events, e)
	}

	return events
}

// CreatePlugin 创建插件
func CreatePlugin(plugin models.Plugin) {
	_, err := db.Exec("INSERT INTO plugins (id, name, code, enabled) VALUES (?, ?, ?, ?)",
		plugin.ID, plugin.Name, plugin.Code, plugin.Enabled)
	if err != nil {
		log.Printf("Failed to create plugin: %v", err)
	}
}

// UpdatePlugin 更新插件
func UpdatePlugin(updatedPlugin models.Plugin) bool {
	result, err := db.Exec("UPDATE plugins SET name = ?, code = ?, enabled = ? WHERE id = ?",
		updatedPlugin.Name, updatedPlugin.Code, updatedPlugin.Enabled, updatedPlugin.ID)
	if err != nil {
		log.Printf("Failed to update plugin: %v", err)
		return false
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		log.Printf("Failed to get rows affected: %v", err)
		return false
	}

	return rowsAffected > 0
}

// UpdatePluginStatus 更新插件状态
func UpdatePluginStatus(pluginID string, enabled bool) bool {
	result, err := db.Exec("UPDATE plugins SET enabled = ? WHERE id = ?", enabled, pluginID)
	if err != nil {
		log.Printf("Failed to update plugin status: %v", err)
		return false
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		log.Printf("Failed to get rows affected: %v", err)
		return false
	}

	return rowsAffected > 0
}

// GetActivePlugins 获取所有启用的插件
func GetActivePlugins() []models.Plugin {
	rows, err := db.Query("SELECT id, name, code, enabled FROM plugins WHERE enabled = true")
	if err != nil {
		log.Printf("Failed to get active plugins: %v", err)
		return []models.Plugin{}
	}
	defer rows.Close()

	var plugins []models.Plugin
	for rows.Next() {
		var p models.Plugin
		if err := rows.Scan(&p.ID, &p.Name, &p.Code, &p.Enabled); err != nil {
			log.Printf("Failed to scan plugin: %v", err)
			continue
		}
		plugins = append(plugins, p)
	}

	return plugins
}

// GetAllPlugins 获取所有插件
func GetAllPlugins() []models.Plugin {
	rows, err := db.Query("SELECT id, name, code, enabled FROM plugins")
	if err != nil {
		log.Printf("Failed to get all plugins: %v", err)
		return []models.Plugin{}
	}
	defer rows.Close()

	var plugins []models.Plugin
	for rows.Next() {
		var p models.Plugin
		if err := rows.Scan(&p.ID, &p.Name, &p.Code, &p.Enabled); err != nil {
			log.Printf("Failed to scan plugin: %v", err)
			continue
		}
		plugins = append(plugins, p)
	}

	return plugins
}

// DeletePlugin 删除插件
func DeletePlugin(pluginID string) bool {
	result, err := db.Exec("DELETE FROM plugins WHERE id = ?", pluginID)
	if err != nil {
		log.Printf("Failed to delete plugin: %v", err)
		return false
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		log.Printf("Failed to get rows affected: %v", err)
		return false
	}

	return rowsAffected > 0
}

// SaveWebhookRequest 保存Webhook请求
func SaveWebhookRequest(req models.WebhookRequest) {
	req.Timestamp = time.Now()

	_, err := db.Exec("INSERT INTO webhook_requests (data, ip, method, headers, timestamp) VALUES (?, ?, ?, ?, ?)",
		req.Data, req.IP, req.Method, req.Headers, req.Timestamp)
	if err != nil {
		log.Printf("Failed to save webhook request: %v", err)
		return
	}
}

// GetWebhookRequests 获取所有Webhook请求
func GetWebhookRequests() []models.WebhookRequest {
	rows, err := db.Query("SELECT id, data, ip, method, headers, timestamp FROM webhook_requests ORDER BY timestamp DESC LIMIT 100")
	if err != nil {
		log.Printf("Failed to get webhook requests: %v", err)
		return []models.WebhookRequest{}
	}
	defer rows.Close()

	var requests []models.WebhookRequest
	for rows.Next() {
		var r models.WebhookRequest
		if err := rows.Scan(&r.ID, &r.Data, &r.IP, &r.Method, &r.Headers, &r.Timestamp); err != nil {
			log.Printf("Failed to scan webhook request: %v", err)
			continue
		}
		requests = append(requests, r)
	}

	return requests
}

// ClearWebhookRequests 清空所有Webhook请求
func ClearWebhookRequests() error {
	_, err := db.Exec("DELETE FROM webhook_requests")
	if err != nil {
		log.Printf("Failed to clear webhook requests: %v", err)
		return err
	}
	return nil
}

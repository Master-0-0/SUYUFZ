package controllers

import (
	"bufio"
	"bytes"
	"encoding/json"
	"io"
	"net/http"
	"os"
	"strings"

	"web-honeypot/internal/models"
	"web-honeypot/internal/storage"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// HandleHoneypotLogin 处理假登录页面的数据接收
func HandleHoneypotLogin(c *gin.Context) {
	// 获取表单数据
	var loginReq models.LoginRequest
	if err := c.ShouldBind(&loginReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 获取客户端IP和UA
	clientIP := c.ClientIP()
	clientUA := c.GetHeader("User-Agent")

	// 创建攻击者信息
	attacker := models.Attacker{
		Username: loginReq.Username,
		Password: loginReq.Password,
		IP:       clientIP,
		UA:       clientUA,
	}

	// 保存攻击者信息
	storage.SaveAttacker(attacker)

	// 返回登录失败的响应，迷惑攻击者
	c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid username or password"})
}

// GetAttackersProfile 获取攻击者画像信息汇总
func GetAttackersProfile(c *gin.Context) {
	// 获取所有攻击者信息
	attackers := storage.GetAllAttackers()

	// 返回攻击者信息
	c.JSON(http.StatusOK, gin.H{"attackers": attackers})
}

// CreatePlugin 创建蜜罐插件
func CreatePlugin(c *gin.Context) {
	// 获取插件数据
	var plugin models.Plugin
	if err := c.ShouldBindJSON(&plugin); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 生成唯一的UUID
	plugin.ID = uuid.New().String()

	// 保存插件
	storage.CreatePlugin(plugin)

	// 返回创建成功的响应
	c.JSON(http.StatusCreated, gin.H{"message": "Plugin created successfully"})
}

// UpdatePlugin 更新蜜罐插件
func UpdatePlugin(c *gin.Context) {
	// 获取插件数据
	var plugin models.Plugin
	if err := c.ShouldBindJSON(&plugin); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 更新插件
	if updated := storage.UpdatePlugin(plugin); !updated {
		c.JSON(http.StatusNotFound, gin.H{"error": "Plugin not found"})
		return
	}

	// 返回更新成功的响应
	c.JSON(http.StatusOK, gin.H{"message": "Plugin updated successfully"})
}

// UpdatePluginStatus 更新插件状态
func UpdatePluginStatus(c *gin.Context) {
	// 获取插件ID
	pluginID := c.Param("pluginID")

	// 获取状态参数
	var statusUpdate struct {
		Enabled bool `json:"enabled"`
	}
	if err := c.ShouldBindJSON(&statusUpdate); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 更新插件状态
	if updated := storage.UpdatePluginStatus(pluginID, statusUpdate.Enabled); !updated {
		c.JSON(http.StatusNotFound, gin.H{"error": "Plugin not found"})
		return
	}

	// 返回更新成功的响应
	c.JSON(http.StatusOK, gin.H{"message": "Plugin status updated successfully"})
}

// GetActivePlugins 获取激活的插件
func GetActivePlugins(c *gin.Context) {
	// 获取所有激活的插件
	plugins := storage.GetActivePlugins()

	// 返回激活的插件
	c.JSON(http.StatusOK, gin.H{"plugins": plugins})
}

// GetAllPlugins 获取所有插件
func GetAllPlugins(c *gin.Context) {
	// 获取所有插件
	plugins := storage.GetAllPlugins()

	// 返回所有插件
	c.JSON(http.StatusOK, gin.H{"plugins": plugins})
}

// DeletePlugin 删除插件
func DeletePlugin(c *gin.Context) {
	// 获取插件ID
	pluginID := c.Param("pluginID")

	// 删除插件
	if deleted := storage.DeletePlugin(pluginID); !deleted {
		c.JSON(http.StatusNotFound, gin.H{"error": "Plugin not found"})
		return
	}

	// 返回删除成功的响应
	c.JSON(http.StatusOK, gin.H{"message": "Plugin deleted successfully"})
}

// HandleHoneypotLog 处理蜜罐日志
func HandleHoneypotLog(c *gin.Context) {
	// 获取日志数据
	var logData struct {
		Type      string   `json:"type"`
		Arguments []string `json:"arguments"`
	}

	if err := c.ShouldBindJSON(&logData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 获取客户端IP和UA
	clientIP := c.ClientIP()
	clientUA := c.GetHeader("User-Agent")

	// 创建日志对象
	log := models.HoneypotLog{
		Type:      logData.Type,
		Arguments: logData.Arguments,
		IP:        clientIP,
		UA:        clientUA,
	}

	// 保存日志
	storage.SaveHoneypotLog(log)

	// 返回成功响应
	c.JSON(http.StatusOK, gin.H{"message": "Log saved successfully"})
}

// HandleHoneypotEvent 处理蜜罐事件
func HandleHoneypotEvent(c *gin.Context) {
	// 获取事件数据
	var eventData struct {
		Type string      `json:"type"`
		Data interface{} `json:"data"`
	}

	if err := c.ShouldBindJSON(&eventData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// 获取客户端IP和UA
	clientIP := c.ClientIP()
	clientUA := c.GetHeader("User-Agent")

	// 创建事件对象
	event := models.HoneypotEvent{
		Type: eventData.Type,
		IP:   clientIP,
		UA:   clientUA,
	}

	// 保存事件
	storage.SaveHoneypotEvent(event)

	// 返回成功响应
	c.JSON(http.StatusOK, gin.H{"message": "Event saved successfully"})
}

// ChatRequest 聊天请求结构
type ChatRequest struct {
	Message string `json:"message"`
}

// DeepSeekMessage DeepSeek消息结构
type DeepSeekMessage struct {
	Role    string `json:"role"`
	Content string `json:"content"`
}

// DeepSeekRequest DeepSeek API请求结构
type DeepSeekRequest struct {
	Model    string            `json:"model"`
	Messages []DeepSeekMessage `json:"messages"`
	Stream   bool              `json:"stream"`
}

// DeepSeekResponse DeepSeek API响应结构
type DeepSeekResponse struct {
	ID      string `json:"id"`
	Object  string `json:"object"`
	Created int64  `json:"created"`
	Model   string `json:"model"`
	Choices []struct {
		Index   int `json:"index"`
		Message struct {
			Role    string `json:"role"`
			Content string `json:"content"`
		} `json:"message"`
		FinishReason string `json:"finish_reason"`
	} `json:"choices"`
	Usage struct {
		PromptTokens     int `json:"prompt_tokens"`
		CompletionTokens int `json:"completion_tokens"`
		TotalTokens      int `json:"total_tokens"`
	} `json:"usage"`
}

// HandleXGPTChat 处理XGPT威胁分析智能体聊天请求
func HandleXGPTChat(c *gin.Context) {
	var chatReq ChatRequest
	if err := c.ShouldBindJSON(&chatReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	if chatReq.Message == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Message cannot be empty"})
		return
	}

	apiKey := os.Getenv("DEEPSEEK_API_KEY")
	if apiKey == "" {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "DeepSeek API key not configured"})
		return
	}

	systemPrompt := os.Getenv("XGPT_SYSTEM_PROMPT")
	if systemPrompt == "" {
		systemPrompt = `你是一个专业的威胁情报分析专家，专门帮助用户分析网络安全威胁。
你可以帮助用户：
1. 分析IP地址的威胁情报
2. 分析域名的安全状况
3. 解读常见的攻击类型和防护方法
4. 提供威胁情报分析建议
5. 分析恶意软件特征
6. 提供安全加固建议

请用专业但易懂的语言回答用户的问题。`
	}

	deepseekReq := DeepSeekRequest{
		Model: "deepseek-chat",
		Messages: []DeepSeekMessage{
			{Role: "system", Content: systemPrompt},
			{Role: "user", Content: chatReq.Message},
		},
		Stream: false,
	}

	reqBody, err := json.Marshal(deepseekReq)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to marshal request"})
		return
	}

	req, err := http.NewRequest("POST", "https://api.deepseek.com/chat/completions", bytes.NewBuffer(reqBody))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create request"})
		return
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+apiKey)

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to call DeepSeek API"})
		return
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to read response"})
		return
	}

	if resp.StatusCode != http.StatusOK {
		c.JSON(resp.StatusCode, gin.H{"error": "DeepSeek API error", "details": string(body)})
		return
	}

	var deepseekResp DeepSeekResponse
	if err := json.Unmarshal(body, &deepseekResp); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse response"})
		return
	}

	if len(deepseekResp.Choices) == 0 {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "No response from DeepSeek"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"response": deepseekResp.Choices[0].Message.Content,
	})
}

// SettingsRequest 系统设置请求结构
type SettingsRequest struct {
	DEEPSEEK_API_KEY   string `json:"deepseek_api_key"`
	XGPT_SYSTEM_PROMPT string `json:"xgpt_system_prompt"`
	ADMIN_USERNAME     string `json:"admin_username"`
	ADMIN_PASSWORD     string `json:"admin_password"`
	DB_HOST            string `json:"db_host"`
	DB_PORT            string `json:"db_port"`
	DB_USER            string `json:"db_user"`
	DB_PASSWORD        string `json:"db_password"`
	DB_NAME            string `json:"db_name"`
}

func loadExistingEnv() map[string]string {
	envMap := make(map[string]string)

	file, err := os.Open(".env")
	if err != nil {
		return envMap
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "#") || strings.TrimSpace(line) == "" {
			continue
		}
		parts := strings.SplitN(line, "=", 2)
		if len(parts) == 2 {
			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])
			value = strings.ReplaceAll(value, "\\n", "\n")
			envMap[key] = value
		}
	}

	return envMap
}

// HandleSaveSettings 保存系统设置到.env文件
func HandleSaveSettings(c *gin.Context) {
	var req SettingsRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	envMap := loadExistingEnv()

	hasChanges := false

	if req.DEEPSEEK_API_KEY != "" {
		envMap["DEEPSEEK_API_KEY"] = req.DEEPSEEK_API_KEY
		os.Setenv("DEEPSEEK_API_KEY", req.DEEPSEEK_API_KEY)
		hasChanges = true
	}
	if req.XGPT_SYSTEM_PROMPT != "" {
		envMap["XGPT_SYSTEM_PROMPT"] = req.XGPT_SYSTEM_PROMPT
		os.Setenv("XGPT_SYSTEM_PROMPT", req.XGPT_SYSTEM_PROMPT)
		hasChanges = true
	}
	if req.ADMIN_USERNAME != "" {
		envMap["ADMIN_USERNAME"] = req.ADMIN_USERNAME
		os.Setenv("ADMIN_USERNAME", req.ADMIN_USERNAME)
		hasChanges = true
	}
	if req.ADMIN_PASSWORD != "" {
		envMap["ADMIN_PASSWORD"] = req.ADMIN_PASSWORD
		os.Setenv("ADMIN_PASSWORD", req.ADMIN_PASSWORD)
		hasChanges = true
	}
	if req.DB_HOST != "" {
		envMap["DB_HOST"] = req.DB_HOST
		os.Setenv("DB_HOST", req.DB_HOST)
		hasChanges = true
	}
	if req.DB_PORT != "" {
		envMap["DB_PORT"] = req.DB_PORT
		os.Setenv("DB_PORT", req.DB_PORT)
		hasChanges = true
	}
	if req.DB_USER != "" {
		envMap["DB_USER"] = req.DB_USER
		os.Setenv("DB_USER", req.DB_USER)
		hasChanges = true
	}
	if req.DB_PASSWORD != "" {
		envMap["DB_PASSWORD"] = req.DB_PASSWORD
		os.Setenv("DB_PASSWORD", req.DB_PASSWORD)
		hasChanges = true
	}
	if req.DB_NAME != "" {
		envMap["DB_NAME"] = req.DB_NAME
		os.Setenv("DB_NAME", req.DB_NAME)
		hasChanges = true
	}

	if !hasChanges {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No settings to save"})
		return
	}

	var envLines []string
	envOrder := []string{"DEEPSEEK_API_KEY", "XGPT_SYSTEM_PROMPT", "ADMIN_USERNAME", "ADMIN_PASSWORD", "DB_HOST", "DB_PORT", "DB_USER", "DB_PASSWORD", "DB_NAME"}

	for _, key := range envOrder {
		if value, exists := envMap[key]; exists {
			escapedValue := strings.ReplaceAll(value, "\n", "\\n")
			envLines = append(envLines, key+"="+escapedValue)
		}
	}

	for key, value := range envMap {
		found := false
		for _, k := range envOrder {
			if k == key {
				found = true
				break
			}
		}
		if !found {
			escapedValue := strings.ReplaceAll(value, "\n", "\\n")
			envLines = append(envLines, key+"="+escapedValue)
		}
	}

	envContent := ""
	for _, line := range envLines {
		envContent += line + "\n"
	}

	err := os.WriteFile(".env", []byte(envContent), 0600)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save settings"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Settings saved successfully"})
}

// HandleGetSettings 获取当前系统配置
func HandleGetSettings(c *gin.Context) {
	defaultPrompt := `你是一个专业的威胁情报分析专家，专门帮助用户分析网络安全威胁。
你可以帮助用户：
1. 分析IP地址的威胁情报
2. 分析域名的安全状况
3. 解读常见的攻击类型和防护方法
4. 提供威胁情报分析建议
5. 分析恶意软件特征
6. 提供安全加固建议

请用专业但易懂的语言回答用户的问题。`

	settings := gin.H{
		"deepseek_api_key":   maskAPIKey(os.Getenv("DEEPSEEK_API_KEY")),
		"xgpt_system_prompt": getEnvOrDefault("XGPT_SYSTEM_PROMPT", defaultPrompt),
		"admin_username":     getEnvOrDefault("ADMIN_USERNAME", "admin"),
		"admin_password":     maskPassword(getEnvOrDefault("ADMIN_PASSWORD", "admin123")),
		"db_host":            getEnvOrDefault("DB_HOST", "127.0.0.1"),
		"db_port":            getEnvOrDefault("DB_PORT", "3306"),
		"db_user":            getEnvOrDefault("DB_USER", "root"),
		"db_password":        maskPassword(getEnvOrDefault("DB_PASSWORD", "root")),
		"db_name":            getEnvOrDefault("DB_NAME", "web_honeypot"),
	}

	c.JSON(http.StatusOK, settings)
}

func getEnvOrDefault(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

func maskPassword(password string) string {
	if password == "" {
		return ""
	}
	if len(password) <= 4 {
		return "****"
	}
	return password[:2] + "****" + password[len(password)-2:]
}

// maskAPIKey 遮蔽API Key中间部分
func maskAPIKey(key string) string {
	if key == "" {
		return ""
	}
	if len(key) <= 8 {
		return "****"
	}
	return key[:4] + "****" + key[len(key)-4:]
}

// HandleWebhookReceive 接收Webhook请求
func HandleWebhookReceive(c *gin.Context) {
	if c.Request.Method != "POST" {
		c.JSON(http.StatusMethodNotAllowed, gin.H{"error": "Only POST requests are allowed"})
		return
	}

	body, err := io.ReadAll(c.Request.Body)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to read request body"})
		return
	}

	clientIP := c.ClientIP()
	method := c.Request.Method

	headers := make(map[string]string)
	for key, values := range c.Request.Header {
		if len(values) > 0 {
			headers[key] = values[0]
		}
	}
	headersJSON, _ := json.Marshal(headers)

	webhookReq := models.WebhookRequest{
		Data:    string(body),
		IP:      clientIP,
		Method:  method,
		Headers: string(headersJSON),
	}

	storage.SaveWebhookRequest(webhookReq)

	c.JSON(http.StatusOK, gin.H{"status": "success", "message": "Logs saved successfully"})
}

// GetWebhookRequests 获取所有Webhook请求
func GetWebhookRequests(c *gin.Context) {
	requests := storage.GetWebhookRequests()
	c.JSON(http.StatusOK, gin.H{"requests": requests})
}

// ClearWebhookRequests 清空所有Webhook请求
func ClearWebhookRequests(c *gin.Context) {
	if err := storage.ClearWebhookRequests(); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to clear webhook requests"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Webhook requests cleared successfully"})
}

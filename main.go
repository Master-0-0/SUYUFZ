package main

import (
	"bufio"
	"log"
	"os"
	"strings"

	"web-honeypot/internal/controllers"
	"web-honeypot/internal/middleware"
	"web-honeypot/internal/storage"

	"github.com/gin-gonic/gin"
)

func loadEnvFile() {
	file, err := os.Open(".env")
	if err != nil {
		log.Println("No .env file found, using system environment variables")
		return
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
			os.Setenv(key, value)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Printf("Error reading .env file: %v", err)
	}
}

func main() {
	// 加载.env文件
	loadEnvFile()

	// 初始化存储
	if err := storage.InitStorage(); err != nil {
		log.Fatalf("Failed to initialize storage: %v", err)
	}
	defer storage.CloseStorage()

	// 设置GIN模式
	gin.SetMode(gin.ReleaseMode)

	// 创建GIN路由器
	router := gin.Default()

	// 静态文件服务
	router.Static("/css", "./public/css")
	router.Static("/js", "./public/js")
	router.Static("/images", "./public/images")

	// 假登录页面路由
	router.GET("/", func(c *gin.Context) {
		c.File("./public/login.html")
	})
	router.POST("/honeypot/login", controllers.HandleHoneypotLogin)
	//这两个接口不需要
	//router.POST("/honeypot/log", controllers.HandleHoneypotLog)
	//router.POST("/honeypot/event", controllers.HandleHoneypotEvent)

	// Webhook接收路由（公开，不需要认证）
	router.POST("/webhook/receive", controllers.HandleWebhookReceive)

	// 管理员路由组
	adminGroup := router.Group("/admin")
	adminGroup.Use(middleware.BasicAuthMiddleware())
	{
		// 管理员首页 - 攻击者画像信息汇总
		adminGroup.GET("/dashboard", func(c *gin.Context) {
			c.File("./public/dashboard.html")
		})
		// 获取攻击者数据的API
		adminGroup.GET("/api/attackers", controllers.GetAttackersProfile)
		// 插件管理API
		adminGroup.GET("/api/plugins", controllers.GetAllPlugins)
		adminGroup.DELETE("/api/plugins/:pluginID", controllers.DeletePlugin)
		// XGPT威胁分析智能体API
		adminGroup.POST("/api/xgpt/chat", controllers.HandleXGPTChat)
		// 系统设置API
		adminGroup.GET("/api/settings", controllers.HandleGetSettings)
		adminGroup.POST("/api/settings", controllers.HandleSaveSettings)
		// Webhook管理API
		adminGroup.GET("/api/webhook/requests", controllers.GetWebhookRequests)
		adminGroup.DELETE("/api/webhook/requests", controllers.ClearWebhookRequests)
	}

	// 蜜罐插件路由组
	pluginGroup := router.Group("/plugins")
	pluginGroup.Use(middleware.BasicAuthMiddleware())
	{
		pluginGroup.POST("/", controllers.CreatePlugin)
		pluginGroup.PUT("/", controllers.UpdatePlugin)
		pluginGroup.PATCH("/:pluginID/status", controllers.UpdatePluginStatus)
	}

	// 公开的插件获取路由，不需要认证
	router.GET("/plugins/active", controllers.GetActivePlugins)

	// 启动服务器
	log.Println("Web honeypot server is running on http://localhost:80")
	if err := router.Run(":80"); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

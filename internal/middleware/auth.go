package middleware

import (
	"os"

	"github.com/gin-gonic/gin"
)

func getAdminUsername() string {
	username := os.Getenv("ADMIN_USERNAME")
	if username == "" {
		username = "admin"
	}
	return username
}

func getAdminPassword() string {
	password := os.Getenv("ADMIN_PASSWORD")
	if password == "" {
		password = "admin123"
	}
	return password
}

// BasicAuthMiddleware 实现web_basic_auth认证中间件
func BasicAuthMiddleware() gin.HandlerFunc {
	return gin.BasicAuth(gin.Accounts{
		getAdminUsername(): getAdminPassword(),
	})
}

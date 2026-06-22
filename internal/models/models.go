package models

import (
	"time"
)

// Attacker 攻击者信息结构体
type Attacker struct {
	ID        int       `json:"id"`
	Username  string    `json:"username"`
	Password  string    `json:"password"`
	IP        string    `json:"ip"`
	UA        string    `json:"ua"`
	Timestamp time.Time `json:"timestamp"`
}

// Plugin 蜜罐插件结构体
type Plugin struct {
	ID      string `json:"id"`
	Name    string `json:"name"`
	Code    string `json:"code"`
	Enabled bool   `json:"enabled"`
}

// LoginRequest 登录请求结构体
type LoginRequest struct {
	Username string `form:"username" binding:"required"`
	Password string `form:"password" binding:"required"`
}

// HoneypotLog 蜜罐日志结构体
type HoneypotLog struct {
	ID        int       `json:"id"`
	Type      string    `json:"type"`
	Arguments []string  `json:"arguments"`
	IP        string    `json:"ip"`
	UA        string    `json:"ua"`
	Timestamp time.Time `json:"timestamp"`
}

// HoneypotEvent 蜜罐事件结构体
type HoneypotEvent struct {
	ID        int       `json:"id"`
	Type      string    `json:"type"`
	Data      string    `json:"data"`
	IP        string    `json:"ip"`
	UA        string    `json:"ua"`
	Timestamp time.Time `json:"timestamp"`
}

// WebhookRequest Webhook请求结构体
type WebhookRequest struct {
	ID        int       `json:"id"`
	Data      string    `json:"data"`
	IP        string    `json:"ip"`
	Method    string    `json:"method"`
	Headers   string    `json:"headers"`
	Timestamp time.Time `json:"timestamp"`
}

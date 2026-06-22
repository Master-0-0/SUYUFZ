# SUYUFZ 蜜罐系统

基于 Go Gin 开发的轻量化诱捕型蜜罐系统，融合溯源反制与 AI 智能分析能力。

## 项目简介

SUYUFZ 蜜罐是一个专为网络安全防护设计的轻量化诱捕系统，通过模拟真实服务环境引诱攻击者，收集攻击信息并提供智能分析能力。

<img width="1920" height="863" alt="image" src="https://github.com/user-attachments/assets/faf27b38-1ecb-4182-8c6f-f21046a2cf13" />


## 核心特性

### 1. 插件化溯源反制能力
- 支持动态加载和管理溯源反制插件
- 针对不同场景灵活调配插件
- 插件状态实时可控
- 支持插件的创建、更新、删除操作

<img width="1904" height="850" alt="image" src="https://github.com/user-attachments/assets/5579ff16-aa2a-4a43-9432-3a8a1fa51a62" />


### 2. AI 赋能的安全顾问
- 基于 DeepSeek 大语言模型实现的智能分析 Agent
- 专业的威胁情报分析能力
- 支持 IP 威胁分析、域名安全评估、攻击类型解读
- 提供安全加固建议
<img width="1896" height="860" alt="image" src="https://github.com/user-attachments/assets/08e849dc-ab78-4baa-9de9-d62a5499ec72" />


### 3. 轻量化架构
- 基于 Go Gin 框架开发，高性能低资源消耗
- MySQL 数据存储
- Web 管理后台
- 假登录页面诱捕

## 技术栈

- **后端框架**: Gin v1.11.0
- **编程语言**: Go 1.23.5
- **数据库**: MySQL
- **AI 模型**: DeepSeek API
- **其他依赖**: 
  - go-sql-driver/mysql
  - google/uuid

## 项目结构

```
SUYUFZ/
├── H5phone/              # 电话号码相关工具
├── internal/
│   ├── controllers/      # 控制器层
│   ├── middleware/       # 中间件（认证等）
│   ├── models/           # 数据模型
│   └── storage/          # 数据存储层
├── public/               # 前端静态资源
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── login.html        # 假登录页面
│   └── dashboard.html    # 管理后台
├── .env                  # 环境配置
├── main.go               # 主入口
├── go.mod                # Go 模块依赖
├── web_honeypot.sql      # 数据库初始化脚本
└── README.md
```

## 主要功能模块

### 1. 攻击者信息收集
- 记录攻击者的用户名、密码尝试
- 捕获攻击者 IP 地址和 User-Agent
- 时间戳记录攻击时间

### 2. 插件管理
- 创建、更新、删除溯源反制插件
- 插件启用/禁用状态管理
- 获取激活插件列表

### 3. AI 威胁分析
- 与 DeepSeek API 集成
- 专业的威胁情报分析对话
- 可自定义系统提示词

### 4. Webhook 集成
- 支持接收外部 Webhook 请求
- 记录完整的请求数据、头部信息
- 支持请求历史查看和清空

### 5. 系统配置
- 支持通过 Web 界面管理配置
- DeepSeek API Key 配置
- 管理员账号设置
- 数据库连接配置

## 快速开始

### 环境要求
- Go 1.23.5+
- MySQL 5.7+

### 安装步骤

1. 克隆项目
```bash
git clone <repository-url>
cd SUYUFZ
```

2. 配置数据库
```bash
# 创建数据库
mysql -u root -p
CREATE DATABASE web_honeypot;

# 导入初始化脚本
mysql -u root -p web_honeypot < web_honeypot.sql
```

3. 配置环境变量
编辑 `.env` 文件：
```env
DEEPSEEK_API_KEY=your_deepseek_api_key
XGPT_SYSTEM_PROMPT=your_custom_prompt
ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin123
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=web_honeypot
```

4. 安装依赖
```bash
go mod download
```

5. 运行项目
```bash
go run main.go
```

### 访问地址

- **蜜罐页面**: http://localhost
- **管理后台**: http://localhost/admin/dashboard

默认管理员账号: `admin` / `admin123`

## API 接口

### 公开接口
- `GET /` - 假登录页面
- `POST /honeypot/login` - 处理蜜罐登录
- `POST /webhook/receive` - 接收 Webhook
- `GET /plugins/active` - 获取激活插件

### 管理接口（需要 Basic Auth）
- `GET /admin/dashboard` - 管理后台
- `GET /admin/api/attackers` - 获取攻击者画像
- `GET /admin/api/plugins` - 获取所有插件
- `DELETE /admin/api/plugins/:pluginID` - 删除插件
- `POST /admin/api/xgpt/chat` - AI 对话
- `GET /admin/api/settings` - 获取系统设置
- `POST /admin/api/settings` - 保存系统设置
- `GET /admin/api/webhook/requests` - 获取 Webhook 请求
- `DELETE /admin/api/webhook/requests` - 清空 Webhook 请求

### 插件管理接口（需要 Basic Auth）
- `POST /plugins/` - 创建插件
- `PUT /plugins/` - 更新插件
- `PATCH /plugins/:pluginID/status` - 更新插件状态

## 数据模型

### Attacker（攻击者）
```go
type Attacker struct {
    ID        int       // 主键
    Username  string    // 尝试的用户名
    Password  string    // 尝试的密码
    IP        string    // 攻击者 IP
    UA        string    // User-Agent
    Timestamp time.Time // 攻击时间
}
```

### Plugin（插件）
```go
type Plugin struct {
    ID      string // 插件 UUID
    Name    string // 插件名称
    Code    string // 插件代码
    Enabled bool   // 是否启用
}
```

### WebhookRequest（Webhook 请求）
```go
type WebhookRequest struct {
    ID        int       // 主键
    Data      string    // 请求数据
    IP        string    // 来源 IP
    Method    string    // 请求方法
    Headers   string    // 请求头部
    Timestamp time.Time // 请求时间
}
```

## 特色亮点

1. **插件化架构**: 溯源反制能力可灵活配置，适应不同场景
2. **AI 加持**: DeepSeek 大模型提供专业的威胁分析
3. **轻量化设计**: 资源占用低，易于部署
4. **完整日志**: 全方位记录攻击行为
5. **Web 管理**: 直观的后台管理界面

## 安全建议

- 修改默认管理员密码
- 定期备份数据库
- 合理配置 DeepSeek API Key 权限
- 在生产环境使用强密码
- 定期检查和更新插件

## 许可证

本项目仅供学习和研究使用。

---

**项目名称**: SUYUFZ 蜜罐系统  
**开发语言**: Go  
**框架**: Gin  
**设计理念**: 轻量化、智能化、插件化

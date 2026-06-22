// 蜜罐后台管理系统 JavaScript

// 全局标志，确保插件管理器只初始化一次
let pluginManagerInitialized = false;

// 全局变量存储当前选中的插件
let currentPlugin = null;
let plugins = [];

// 进入编辑模式的函数
function enterEditMode() {
    // 切换到编辑模式
    const codeDisplay = document.getElementById('pluginCodeDisplay');
    const codeEditor = document.getElementById('pluginCodeEditor');
    const editCodeBtn = document.getElementById('editCodeBtn');
    const saveCodeBtn = document.getElementById('saveCodeBtn');
    const cancelEditBtn = document.getElementById('cancelEditBtn');
    
    codeDisplay.style.display = 'none';
    codeEditor.style.display = 'block';
    editCodeBtn.style.display = 'none';
    saveCodeBtn.style.display = 'inline-block';
    cancelEditBtn.style.display = 'inline-block';
    
    // 设置编辑器内容
    codeEditor.value = currentPlugin.code;
}

// 保存插件代码的函数
function savePluginCode() {
    // 保存代码
    const codeEditor = document.getElementById('pluginCodeEditor');
    const codeDisplay = document.getElementById('pluginCodeDisplay');
    const editCodeBtn = document.getElementById('editCodeBtn');
    const saveCodeBtn = document.getElementById('saveCodeBtn');
    const cancelEditBtn = document.getElementById('cancelEditBtn');
    
    const newCode = codeEditor.value;
    
    // 更新插件代码到后端
    fetch('/plugins/', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: currentPlugin.id,
            name: currentPlugin.name,
            code: newCode,
            enabled: currentPlugin.enabled
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to save plugin code');
        }
        return response.json();
    })
    .then(data => {
        // 更新当前插件
        currentPlugin.code = newCode;
        
        // 更新显示
        codeDisplay.textContent = newCode;
        
        // 切换回显示模式
        codeDisplay.style.display = 'block';
        codeEditor.style.display = 'none';
        editCodeBtn.style.display = 'inline-block';
        saveCodeBtn.style.display = 'none';
        cancelEditBtn.style.display = 'none';
        
        alert('代码已保存！');
    })
    .catch(error => {
        console.error('Error saving plugin code:', error);
        alert('保存失败！');
    });
}

// 取消编辑模式的函数
function cancelEditMode() {
    // 取消编辑，切换回显示模式
    const codeDisplay = document.getElementById('pluginCodeDisplay');
    const codeEditor = document.getElementById('pluginCodeEditor');
    const editCodeBtn = document.getElementById('editCodeBtn');
    const saveCodeBtn = document.getElementById('saveCodeBtn');
    const cancelEditBtn = document.getElementById('cancelEditBtn');
    
    codeDisplay.style.display = 'block';
    codeEditor.style.display = 'none';
    editCodeBtn.style.display = 'inline-block';
    saveCodeBtn.style.display = 'none';
    cancelEditBtn.style.display = 'none';
}

// 激活插件的函数
function activatePlugin() {
    // 激活插件
    fetch(`/plugins/${currentPlugin.id}/status`, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ enabled: true })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to activate plugin');
        }
        return response.json();
    })
    .then(data => {
        // 更新当前插件状态
        currentPlugin.enabled = true;
        updatePluginStatus();
        alert('插件已激活！');
    })
    .catch(error => {
        console.error('Error activating plugin:', error);
        alert('激活失败！');
    });
}

// 停用插件的函数
function deactivatePlugin() {
    // 停用插件
    fetch(`/plugins/${currentPlugin.id}/status`, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ enabled: false })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to deactivate plugin');
        }
        return response.json();
    })
    .then(data => {
        // 更新当前插件状态
        currentPlugin.enabled = false;
        updatePluginStatus();
        alert('插件已停用！');
    })
    .catch(error => {
        console.error('Error deactivating plugin:', error);
        alert('停用失败！');
    });
}

// 删除插件的函数
function deletePlugin() {
    if (confirm('确定要删除该插件吗？')) {
        // 删除插件
        fetch(`/admin/api/plugins/${currentPlugin.id}`, {
            method: 'DELETE',
            headers: {}
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete plugin');
            }
            return response.json();
        })
        .then(data => {
            alert('插件已删除！');
            // 重新初始化插件列表
            initPluginList();
        })
        .catch(error => {
            console.error('Error deleting plugin:', error);
            alert('删除失败！');
        });
    }
}

// 更新插件状态显示
function updatePluginStatus() {
    const statusElement = document.getElementById('detailPluginStatus');
    statusElement.textContent = currentPlugin.enabled ? '已激活' : '未激活';
    statusElement.className = `status ${currentPlugin.enabled ? 'active' : 'inactive'}`;
}

// 更新插件详情显示
function updatePluginDetail(plugin) {
    document.getElementById('detailPluginName').textContent = plugin.name;
    document.getElementById('detailPluginDesc').textContent = plugin.name + ' - 蜜罐插件';
    document.getElementById('detailPluginCreator').textContent = 'admin';
    document.getElementById('detailPluginCreated').textContent = new Date().toLocaleString();
    document.getElementById('detailPluginModified').textContent = new Date().toLocaleString();
    
    const statusElement = document.getElementById('detailPluginStatus');
    statusElement.textContent = plugin.enabled ? '已激活' : '未激活';
    statusElement.className = `status ${plugin.enabled ? 'active' : 'inactive'}`;
    
    document.getElementById('pluginCodeDisplay').textContent = plugin.code;
}

document.addEventListener('DOMContentLoaded', function() {
    // 初始化页面
    loadAttackersData();
    
    // 页面切换功能
    const navLinks = document.querySelectorAll('.nav-link');
    const pages = document.querySelectorAll('.page');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // 获取目标页面ID（从data-page属性中获取）
            const pageName = this.getAttribute('data-page');
            const targetPage = `${pageName}-page`;
            
            // 移除所有导航项的激活状态
            navLinks.forEach(nav => nav.parentElement.classList.remove('active'));
            
            // 移除所有页面的激活状态
            pages.forEach(page => page.classList.remove('active'));
            
            // 添加当前导航项和页面的激活状态
            this.parentElement.classList.add('active');
            document.getElementById(targetPage).classList.add('active');
            
            // 如果切换到攻击者信息页面，重新加载数据
            if (targetPage === 'attackers-page') {
                loadAttackersData();
            }
            // 如果切换到插件页面，初始化插件管理（确保只初始化一次）
            else if (targetPage === 'plugins-page' && !pluginManagerInitialized) {
                initPluginManager();
                pluginManagerInitialized = true;
            }
            // 如果切换到系统设置页面，加载API Key状态
            else if (targetPage === 'settings-page') {
                loadApiKeyStatus();
            }
        });
    });
    
    // 刷新按钮功能
    const refreshBtn = document.getElementById('refreshBtn');
    if (refreshBtn) {
        refreshBtn.addEventListener('click', function() {
            loadAttackersData();
        });
    }
    
    // 导出IP按钮功能
    const exportIpBtn = document.getElementById('exportIpBtn');
    if (exportIpBtn) {
        exportIpBtn.addEventListener('click', exportIpData);
    }
    

    
    // XGPT威胁分析智能体聊天功能事件绑定
    const sendBtn = document.getElementById('sendMessageBtn');
    const chatInput = document.getElementById('chatInput');
    const quickQueryBtns = document.querySelectorAll('.quick-query-btn');
    
    if (sendBtn) {
        sendBtn.addEventListener('click', sendMessage);
    }
    
    if (chatInput) {
        chatInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    }
    
    quickQueryBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const query = this.textContent;
            if (chatInput) {
                chatInput.value = query;
                sendMessage();
            }
        });
    });
    
    // 系统设置页面事件绑定
    initSettingsPage();
    
    // Webhook功能初始化
    initWebhookPanel();
});

// Webhook功能
let webhookRefreshInterval = null;

function initWebhookPanel() {
    const webhookBtn = document.getElementById('webhookBtn');
    const webhookPanel = document.getElementById('webhookPanel');
    const webhookOverlay = document.getElementById('webhookOverlay');
    const closeWebhookPanel = document.getElementById('closeWebhookPanel');
    const refreshWebhook = document.getElementById('refreshWebhook');
    const clearWebhook = document.getElementById('clearWebhook');
    const copyWebhookUrl = document.getElementById('copyWebhookUrl');
    const webhookUrlElement = document.getElementById('webhookUrl');
    
    const webhookUrl = window.location.origin + '/webhook/receive';
    if (webhookUrlElement) {
        webhookUrlElement.textContent = webhookUrl;
    }
    
    if (webhookBtn) {
        webhookBtn.addEventListener('click', function() {
            webhookPanel.classList.add('show');
            webhookOverlay.classList.add('show');
            loadWebhookRequests();
            if (webhookRefreshInterval) {
                clearInterval(webhookRefreshInterval);
            }
            webhookRefreshInterval = setInterval(loadWebhookRequests, 3000);
        });
    }
    
    function closePanel() {
        webhookPanel.classList.remove('show');
        webhookOverlay.classList.remove('show');
        if (webhookRefreshInterval) {
            clearInterval(webhookRefreshInterval);
            webhookRefreshInterval = null;
        }
    }
    
    if (closeWebhookPanel) {
        closeWebhookPanel.addEventListener('click', closePanel);
    }
    
    if (webhookOverlay) {
        webhookOverlay.addEventListener('click', closePanel);
    }
    
    if (refreshWebhook) {
        refreshWebhook.addEventListener('click', loadWebhookRequests);
    }
    
    if (clearWebhook) {
        clearWebhook.addEventListener('click', function() {
            if (confirm('确定要清空所有Webhook请求记录吗？')) {
                fetch('/admin/api/webhook/requests', {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    loadWebhookRequests();
                })
                .catch(error => {
                    console.error('清空Webhook请求失败:', error);
                });
            }
        });
    }
    
    if (copyWebhookUrl) {
        copyWebhookUrl.addEventListener('click', function() {
            navigator.clipboard.writeText(webhookUrl).then(function() {
                copyWebhookUrl.textContent = '已复制';
                setTimeout(function() {
                    copyWebhookUrl.textContent = '复制地址';
                }, 2000);
            }).catch(function(err) {
                console.error('复制失败:', err);
            });
        });
    }
}

function loadWebhookRequests() {
    const requestsList = document.getElementById('webhookRequestsList');
    
    fetch('/admin/api/webhook/requests')
        .then(response => response.json())
        .then(data => {
            const requests = data.requests || [];
            
            if (requests.length === 0) {
                requestsList.innerHTML = '<div class="webhook-empty">暂无接收到的请求</div>';
                return;
            }
            
            requestsList.innerHTML = requests.map(req => {
                let formattedData = req.data;
                try {
                    const jsonData = JSON.parse(req.data);
                    formattedData = JSON.stringify(jsonData, null, 2);
                } catch (e) {
                    // 不是JSON格式，保持原样
                }
                
                let formattedHeaders = req.headers;
                try {
                    const headersObj = JSON.parse(req.headers);
                    formattedHeaders = JSON.stringify(headersObj, null, 2);
                } catch (e) {
                    // 不是JSON格式，保持原样
                }
                
                return `
                    <div class="webhook-request-item">
                        <div class="webhook-request-header">
                            <div class="webhook-request-meta">
                                <span class="method">${req.method}</span>
                                <span class="ip">${req.ip}</span>
                            </div>
                            <span class="webhook-request-time">${new Date(req.timestamp).toLocaleString()}</span>
                        </div>
                        <div class="webhook-request-body">
                            <pre>${escapeHtml(formattedData)}</pre>
                        </div>
                        <details class="webhook-request-headers">
                            <summary>请求头信息</summary>
                            <pre>${escapeHtml(formattedHeaders)}</pre>
                        </details>
                    </div>
                `;
            }).join('');
        })
        .catch(error => {
            console.error('加载Webhook请求失败:', error);
            requestsList.innerHTML = '<div class="webhook-empty">加载失败，请重试</div>';
        });
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// 加载攻击者数据
function loadAttackersData() {
    console.log('开始加载攻击者数据...');
    fetch('/admin/api/attackers')
        .then(response => {
            console.log('收到响应:', response.status, response.statusText);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(responseData => {
            console.log('收到的数据:', responseData);
            const data = responseData.attackers; // 从响应中提取attackers字段
            console.log('攻击者数据:', data);
            
            const table = document.getElementById('attackersTable');
            const tableBody = table.querySelector('tbody');
            tableBody.innerHTML = '';
            
            if (!data || data.length === 0) {
                console.log('没有攻击者数据');
                tableBody.innerHTML = '<tr><td colspan="6" class="no-data-msg">暂无攻击数据</td></tr>';
                return;
            }
            
            data.forEach((attacker, index) => {
                console.log(`处理攻击者 ${index}:`, attacker);
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${attacker.id || '-'}</td>
                    <td>${attacker.username || '-'}</td>
                    <td>${attacker.password || '-'}</td>
                    <td>${attacker.ip || '-'}</td>
                    <td>${attacker.ua || '-'}</td>
                    <td>${new Date(attacker.timestamp).toLocaleString() || '-'}</td>
                `;
                tableBody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('加载数据失败:', error);
            const table = document.getElementById('attackersTable');
            const tableBody = table.querySelector('tbody');
            tableBody.innerHTML = '<tr><td colspan="6" class="no-data-msg">加载数据失败</td></tr>';
        });
}

// 导出IP数据为txt文件
function exportIpData() {
    console.log('开始导出IP数据...');
    const table = document.getElementById('attackersTable');
    const rows = table.querySelectorAll('tbody tr');
    const ips = [];
    
    // 遍历表格行，提取IP地址
    rows.forEach(row => {
        // 跳过"暂无攻击数据"的行
        if (row.querySelector('.no-data-msg')) {
            return;
        }
        
        // 第4列是IP地址（索引从0开始）
        const ipCell = row.querySelector('td:nth-child(4)');
        const ip = ipCell ? ipCell.textContent.trim() : '';
        
        // 仅添加非空且不是"-"的IP
        if (ip && ip !== '-') {
            ips.push(ip);
        }
    });
    
    if (ips.length === 0) {
        alert('没有可导出的IP数据');
        return;
    }
    
    // 创建文本内容
    const textContent = ips.join('\n');
    
    // 创建Blob对象
    const blob = new Blob([textContent], { type: 'text/plain;charset=utf-8' });
    
    // 创建下载链接
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `attackers_ips_${new Date().getTime()}.txt`;
    
    // 触发下载
    document.body.appendChild(a);
    a.click();
    
    // 清理
    setTimeout(() => {
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
    }, 100);
    
    console.log(`成功导出${ips.length}个IP地址`);
}



// 插件管理功能
function initPluginManager() {
    // 从后端获取所有插件
    function fetchPlugins() {
        return fetch('/admin/api/plugins')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch plugins');
                }
                return response.json();
            })
            .then(data => {
                plugins = data.plugins;
                return plugins;
            })
            .catch(error => {
                console.error('Error fetching plugins:', error);
                return [];
            });
    }
    
    // 初始化插件列表
    function initPluginList() {
        fetchPlugins()
            .then(plugins => {
                if (plugins.length === 0) {
                    // 没有插件数据时的处理
                    document.getElementById('noDataMsg').style.display = 'block';
                    return;
                }
                
                document.getElementById('noDataMsg').style.display = 'none';
                
                // 更新插件列表
                const pluginList = document.querySelector('.plugin-list');
                pluginList.innerHTML = '';
                
                plugins.forEach((plugin, index) => {
                    const pluginItem = document.createElement('div');
                    pluginItem.className = 'plugin-item';
                    pluginItem.dataset.pluginId = plugin.id;
                    
                    if (index === 0) {
                        pluginItem.classList.add('active');
                        currentPlugin = plugin;
                        updatePluginDetail(plugin);
                    }
                    
                    pluginItem.innerHTML = `
                        <div class="plugin-name">${plugin.name}</div>
                        <div class="plugin-desc">${plugin.name} - 蜜罐插件</div>
                        <div class="plugin-tooltip">
                            <div class="tooltip-title">${plugin.name}</div>
                            <div class="tooltip-content">
                                <p>创建时间: ${new Date().toLocaleString()}</p>
                                <p>最后修改: ${new Date().toLocaleString()}</p>
                                <p>状态: ${plugin.enabled ? '已激活' : '未激活'}</p>
                            </div>
                        </div>
                    `;
                    
                    pluginList.appendChild(pluginItem);
                });
                
                // 添加插件列表点击事件
                const pluginItems = document.querySelectorAll('.plugin-item');
                pluginItems.forEach(item => {
                    item.addEventListener('click', function() {
                        const pluginId = this.dataset.pluginId;
                        const plugin = plugins.find(p => p.id === pluginId);
                        
                        if (plugin) {
                            // 更新当前插件
                            currentPlugin = plugin;
                            
                            // 更新界面显示
                            updatePluginDetail(plugin);
                            
                            // 更新列表项的激活状态
                            pluginItems.forEach(pi => pi.classList.remove('active'));
                            this.classList.add('active');
                        }
                    });
                });
            });
    }
    
    // 初始化插件列表
    initPluginList();
    
    // 插件搜索功能
    const searchInput = document.getElementById('pluginSearch');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const pluginItems = document.querySelectorAll('.plugin-item');
            
            pluginItems.forEach(item => {
                const pluginId = item.dataset.pluginId;
                const plugin = plugins.find(p => p.id === pluginId);
                
                if (plugin) {
                    const match = plugin.name.toLowerCase().includes(searchTerm);
                    item.style.display = match ? 'block' : 'none';
                }
            });
        });
    }

    // 添加插件按钮点击事件
    const addPluginBtn = document.getElementById('addPluginBtn');
    const addPluginModal = document.getElementById('addPluginModal');
    const closeModalBtn = addPluginModal?.querySelector('.close');
    const cancelAddBtn = document.getElementById('cancelAddBtn');
    const addPluginForm = document.getElementById('addPluginForm');

    if (addPluginBtn) {
        addPluginBtn.addEventListener('click', function() {
            addPluginModal.classList.add('show');
        });
    }

    // 关闭模态框事件
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', function() {
            addPluginModal.classList.remove('show');
            addPluginForm.reset();
        });
    }

    if (cancelAddBtn) {
        cancelAddBtn.addEventListener('click', function() {
            addPluginModal.classList.remove('show');
            addPluginForm.reset();
        });
    }

    // 点击模态框外部关闭
    window.addEventListener('click', function(event) {
        if (event.target === addPluginModal) {
            addPluginModal.classList.remove('show');
            addPluginForm.reset();
        }
    });

    // 添加插件表单提交事件
    if (addPluginForm) {
        addPluginForm.addEventListener('submit', function(event) {
            event.preventDefault();
            
            const pluginName = document.getElementById('pluginName').value;
            const pluginCode = document.getElementById('pluginCode').value;
            
            // 创建插件数据
            const newPlugin = {
                name: pluginName,
                code: pluginCode
            };
            
            // 发送POST请求创建插件
            fetch('/plugins/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(newPlugin)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('创建插件失败');
                }
                return response.json();
            })
            .then(data => {
                // 隐藏模态框
                addPluginModal.classList.remove('show');
                addPluginForm.reset();
                
                // 重新加载插件列表
                fetchPlugins();
                
                // 显示成功消息
                alert('插件创建成功');
            })
            .catch(error => {
                console.error('Error creating plugin:', error);
                alert('创建插件失败: ' + error.message);
            });
        });
    }
    
    // 代码编辑功能
    const editCodeBtn = document.getElementById('editCodeBtn');
    const saveCodeBtn = document.getElementById('saveCodeBtn');
    const cancelEditBtn = document.getElementById('cancelEditBtn');
    const codeDisplay = document.getElementById('pluginCodeDisplay');
    const codeEditor = document.getElementById('pluginCodeEditor');
    
    if (editCodeBtn) {
        // 移除现有的事件监听器（如果有）
        editCodeBtn.removeEventListener('click', enterEditMode);
        
        // 添加新的事件监听器
        editCodeBtn.addEventListener('click', enterEditMode);
    }
    
    if (saveCodeBtn) {
        // 移除现有的事件监听器（如果有）
        saveCodeBtn.removeEventListener('click', savePluginCode);
        
        // 添加新的事件监听器
        saveCodeBtn.addEventListener('click', savePluginCode);
    }
    
    if (cancelEditBtn) {
        // 移除现有的事件监听器（如果有）
        cancelEditBtn.removeEventListener('click', cancelEditMode);
        
        // 添加新的事件监听器
        cancelEditBtn.addEventListener('click', cancelEditMode);
    }
    
    // 插件操作功能
    const activateBtn = document.getElementById('activatePluginBtn');
    const deactivateBtn = document.getElementById('deactivatePluginBtn');
    const deleteBtn = document.getElementById('deletePluginBtn');
    
    if (activateBtn) {
        // 移除现有的事件监听器（如果有）
        activateBtn.removeEventListener('click', activatePlugin);
        
        // 添加新的事件监听器
        activateBtn.addEventListener('click', activatePlugin);
    }
    
    if (deactivateBtn) {
        // 移除现有的事件监听器（如果有）
        deactivateBtn.removeEventListener('click', deactivatePlugin);
        
        // 添加新的事件监听器
        deactivateBtn.addEventListener('click', deactivatePlugin);
    }
    
    if (deleteBtn) {
        // 移除现有的事件监听器（如果有）
        deleteBtn.removeEventListener('click', deletePlugin);
        
        // 添加新的事件监听器
        deleteBtn.addEventListener('click', deletePlugin);
    }
    

}

// XGPT威胁分析智能体聊天功能相关函数

// 发送消息函数
function sendMessage() {
    const chatInput = document.getElementById('chatInput');
    const chatMessages = document.getElementById('chatMessages');
    const message = chatInput.value.trim();
    
    if (!message) {
        return;
    }
    
    console.log('发送消息:', message);
    
    // 显示用户消息
    displayMessage(message, 'user');
    
    // 清空输入框
    chatInput.value = '';
    
    // 显示加载状态
    const loadingDiv = document.createElement('div');
    loadingDiv.className = 'chat-message system-message loading';
    loadingDiv.innerHTML = '<div class="message-content"><span class="loading-dots">正在分析中...</span></div>';
    chatMessages.appendChild(loadingDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
    
    // 调用后端API
    fetch('/admin/api/xgpt/chat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: message })
    })
    .then(response => {
        console.log('收到响应:', response.status);
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log('收到数据:', data);
        // 移除加载状态
        chatMessages.removeChild(loadingDiv);
        // 显示系统回复
        displayMessage(data.response, 'system');
    })
    .catch(error => {
        console.error('请求错误:', error);
        // 移除加载状态
        chatMessages.removeChild(loadingDiv);
        // 显示错误消息
        displayMessage('抱歉，分析服务暂时不可用，请稍后再试。错误信息: ' + error.message, 'system');
    });
}

// 显示消息函数
function displayMessage(message, sender) {
    const chatMessages = document.getElementById('chatMessages');
    const messageDiv = document.createElement('div');
    messageDiv.className = `chat-message ${sender}-message`;
    
    const messageContent = document.createElement('div');
    messageContent.className = 'message-content';
    messageContent.innerHTML = message.replace(/\n/g, '<br>');
    
    messageDiv.appendChild(messageContent);
    chatMessages.appendChild(messageDiv);
    
    // 滚动到底部
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

// 辅助函数：获取当前时间
function getCurrentTime() {
    return new Date().toLocaleString();
}

// 系统设置页面功能
function initSettingsPage() {
    const toggleApiKeyBtn = document.getElementById('toggleApiKeyVisibility');
    const apiKeyInput = document.getElementById('deepseekApiKey');
    const toggleAdminPwdBtn = document.getElementById('toggleAdminPwdVisibility');
    const adminPwdInput = document.getElementById('adminPassword');
    const toggleDbPwdBtn = document.getElementById('toggleDbPwdVisibility');
    const dbPwdInput = document.getElementById('dbPassword');
    const saveBtn = document.getElementById('saveSettingsBtn');
    const testBtn = document.getElementById('testConnectionBtn');
    
    if (toggleApiKeyBtn && apiKeyInput) {
        toggleApiKeyBtn.addEventListener('click', function() {
            if (apiKeyInput.type === 'password') {
                apiKeyInput.type = 'text';
                toggleApiKeyBtn.textContent = '隐藏';
            } else {
                apiKeyInput.type = 'password';
                toggleApiKeyBtn.textContent = '显示';
            }
        });
    }
    
    if (toggleAdminPwdBtn && adminPwdInput) {
        toggleAdminPwdBtn.addEventListener('click', function() {
            if (adminPwdInput.type === 'password') {
                adminPwdInput.type = 'text';
                toggleAdminPwdBtn.textContent = '隐藏';
            } else {
                adminPwdInput.type = 'password';
                toggleAdminPwdBtn.textContent = '显示';
            }
        });
    }
    
    if (toggleDbPwdBtn && dbPwdInput) {
        toggleDbPwdBtn.addEventListener('click', function() {
            if (dbPwdInput.type === 'password') {
                dbPwdInput.type = 'text';
                toggleDbPwdBtn.textContent = '隐藏';
            } else {
                dbPwdInput.type = 'password';
                toggleDbPwdBtn.textContent = '显示';
            }
        });
    }
    
    if (saveBtn) {
        saveBtn.addEventListener('click', saveSettings);
    }
    
    if (testBtn) {
        testBtn.addEventListener('click', testApiConnection);
    }
}

function loadApiKeyStatus() {
    loadSettings();
}

function loadSettings() {
    fetch('/admin/api/settings')
        .then(response => response.json())
        .then(data => {
            if (data.deepseek_api_key) {
                document.getElementById('deepseekApiKey').placeholder = data.deepseek_api_key;
            }
            if (data.xgpt_system_prompt) {
                document.getElementById('xgptSystemPrompt').value = data.xgpt_system_prompt;
            }
            if (data.admin_username) {
                document.getElementById('adminUsername').value = data.admin_username;
            }
            if (data.admin_password) {
                document.getElementById('adminPassword').placeholder = data.admin_password;
            }
            if (data.db_host) {
                document.getElementById('dbHost').value = data.db_host;
            }
            if (data.db_port) {
                document.getElementById('dbPort').value = data.db_port;
            }
            if (data.db_name) {
                document.getElementById('dbName').value = data.db_name;
            }
            if (data.db_user) {
                document.getElementById('dbUser').value = data.db_user;
            }
            if (data.db_password) {
                document.getElementById('dbPassword').placeholder = data.db_password;
            }
        })
        .catch(error => {
            console.error('Failed to load settings:', error);
        });
}

function saveSettings() {
    const settings = {};
    
    const deepseekApiKey = document.getElementById('deepseekApiKey').value.trim();
    const xgptSystemPrompt = document.getElementById('xgptSystemPrompt').value.trim();
    const adminUsername = document.getElementById('adminUsername').value.trim();
    const adminPassword = document.getElementById('adminPassword').value.trim();
    const dbHost = document.getElementById('dbHost').value.trim();
    const dbPort = document.getElementById('dbPort').value.trim();
    const dbName = document.getElementById('dbName').value.trim();
    const dbUser = document.getElementById('dbUser').value.trim();
    const dbPassword = document.getElementById('dbPassword').value.trim();
    
    if (deepseekApiKey) settings.deepseek_api_key = deepseekApiKey;
    if (xgptSystemPrompt) settings.xgpt_system_prompt = xgptSystemPrompt;
    if (adminUsername) settings.admin_username = adminUsername;
    if (adminPassword) settings.admin_password = adminPassword;
    if (dbHost) settings.db_host = dbHost;
    if (dbPort) settings.db_port = dbPort;
    if (dbName) settings.db_name = dbName;
    if (dbUser) settings.db_user = dbUser;
    if (dbPassword) settings.db_password = dbPassword;
    
    if (Object.keys(settings).length === 0) {
        alert('没有需要保存的配置');
        return;
    }
    
    const saveBtn = document.getElementById('saveSettingsBtn');
    saveBtn.disabled = true;
    saveBtn.textContent = '保存中...';
    
    fetch('/admin/api/settings', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(settings)
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert('配置保存成功！\n\n注意：数据库配置修改后需要重启服务才能生效。');
            document.getElementById('deepseekApiKey').value = '';
            document.getElementById('adminPassword').value = '';
            document.getElementById('dbPassword').value = '';
            loadSettings();
        } else {
            alert('保存失败: ' + (data.error || '未知错误'));
        }
    })
    .catch(error => {
        alert('保存失败: ' + error.message);
    })
    .finally(() => {
        saveBtn.disabled = false;
        saveBtn.textContent = '保存所有配置';
    });
}

function testApiConnection() {
    const testBtn = document.getElementById('testConnectionBtn');
    testBtn.disabled = true;
    testBtn.textContent = '测试中...';
    
    fetch('/admin/api/xgpt/chat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: '你好' })
    })
    .then(response => response.json())
    .then(data => {
        if (data.response) {
            alert('连接成功！DeepSeek API Key有效。');
        } else {
            alert('测试失败: ' + (data.error || '未知错误'));
        }
    })
    .catch(error => {
        alert('测试失败: ' + error.message);
    })
    .finally(() => {
        testBtn.disabled = false;
        testBtn.textContent = '测试API连接';
    });
}

function saveApiKey() {
    saveSettings();
}

function testApiKey() {
    testApiConnection();
}
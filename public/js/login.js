// 处理登录表单提交
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // 获取表单数据
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    
    // 创建FormData对象
    const formData = new FormData();
    formData.append('username', username);
    formData.append('password', password);
    
    // 发送POST请求到后端
    fetch('/honeypot/login', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        // 无论后端返回什么，都显示登录失败的提示
        // 这样可以迷惑攻击者，让他们以为账号密码错误
        alert('登录失败，请检查账号密码是否正确');
        // 清空表单
        document.getElementById('loginForm').reset();
    })
    .catch(error => {
        console.error('登录请求失败:', error);
        alert('登录失败，请稍后重试');
    });
});

// 加载蜜罐插件
function loadHoneypotPlugins() {
    fetch('/plugins/active')
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to fetch plugins');
        }
        return response.json();
    })
    .then(data => {
        const pluginsContainer = document.getElementById('honeypot-plugins');
        pluginsContainer.innerHTML = '';
        
        // 动态插入每个激活的插件代码
        data.plugins.forEach(plugin => {
            const scriptElement = document.createElement('script');
            scriptElement.textContent = plugin.code;
            pluginsContainer.appendChild(scriptElement);
        });
    })
    .catch(error => {
        console.error('Failed to load honeypot plugins:', error);
    });
}

// 页面加载完成后加载插件
document.addEventListener('DOMContentLoaded', loadHoneypotPlugins);
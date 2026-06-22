#!/usr/bin/env python
#coding=utf-8

import os
import time
import schedule
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkcore.auth.credentials import AccessKeyCredential
from aliyunsdkcore.auth.credentials import StsTokenCredential
from aliyunsdkdypnsapi.request.v20170525.GetAuthTokenRequest import GetAuthTokenRequest

# Please ensure that the environment variables ALIBABA_CLOUD_ACCESS_KEY_ID and ALIBABA_CLOUD_ACCESS_KEY_SECRET are set.
credentials = AccessKeyCredential("", "")
# use STS Token
# credentials = StsTokenCredential(os.environ['ALIBABA_CLOUD_ACCESS_KEY_ID'], os.environ['ALIBABA_CLOUD_ACCESS_KEY_SECRET'], os.environ['ALIBABA_CLOUD_SECURITY_TOKEN'])
client = AcsClient(region_id='cn-hangzhou', credential=credentials)

# 定义获取token并输出到文件的函数
def get_token_and_save():
    request = GetAuthTokenRequest()
    request.set_accept_format('json')

    request.set_Url("http://8.166.143.185/")
    request.set_Origin("http://8.166.143.185")
    request.set_SceneCode("FC220000012330311")

    response = client.do_action_with_exception(request)
    response_str = str(response, encoding='utf-8')
    
    # 打印response内容
    print(response_str)
    
    # 使用os模块将response内容输出到1.txt
    with open('../public/js/1.txt', 'w', encoding='utf-8') as f:
        f.write(response_str)
    
    print(f"Response内容已成功写入到 {os.path.abspath('../public/js/1.txt')}")

# 设置定时任务，每30分钟运行一次
schedule.every(30).minutes.do(get_token_and_save)

# 立即运行一次函数
get_token_and_save()

# 启动定时任务循环
print("定时任务已启动，每30分钟运行一次...")
while True:
    schedule.run_pending()
    time.sleep(1)

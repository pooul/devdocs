---
title: Pooul开发者中心

language_tabs: # must be one of https://git.io/vQNgJ
  - json示例
#  - shell
#  - ruby
#  - python
#  - javascript

toc_footers:
  - <a href='https://pooul.com/'>返回网站首页</a>

includes:
  - introduction.md
  - version.md
  - errors

search: true
---



# API 文档简介

Pooul API 采用 REST 风格设计。所有接口请求地址都是可预期的以及面向资源的。使用规范的 HTTP 响应代码来表示请求结果的正确或错误信息。使用 HTTP 内置的特性，如 HTTP Authentication 和 HTTP 请求方法让接口易于理解。所有的 API 请求都会以规范友好的 JSON 对象格式返回（包括错误信息）。

> rest

# Authentication 认证

## Login

> 请求：Post /web/user/session/login_name

```json
{
    "user_name":"",
    "password":"" 
}
```

> 响应：Header

```
Authorization: d991da83657a01ae4640a61828b546934d05de37
```

> 响应：Body

```
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": 11,
        "_type": "Ns::User::PooulSuperUser",
        "created_at": 1526979441,
        "curr_merchant_id": "9609932494323355",
        "login_name": [
            "abc"
        ],
        "sex": 0,
        "updated_at": 1529749887,
        "user_name": "abc",
        "wechat_binded": false
    }
}
```



使用用户名与密码调用登录接口获取Authorization




## RSA

> Json格式数据

```json
{
    "pay_type":"wechat.scan",
    "mch_trade_id":"alextest.scan.109",
    "total_fee": 2113, 
    "spbill_create_ip":"127.0.0.1",
    "notify_url":"http://112.74.184.236:3006/fake-recv",
    "body":"Alex Test Scan",
    "device_info":"alex device",
    "op_user_id":"301",
    "openid": "oRXdVs59x_E6nVTBHXHkuSjsNVKw",
    "attach":"Alex attach"
}
```

1. 按照接口文档参数要求，将请求数据写成 json 格式


2. 使用程序语言的JWT包（JWT支持各种语言，在 http://jwt.io 上均有下载和DEMO），将 json 数据编码，签名算法使用RSA算法，可选包括：RS256, RS384, RS512 (分别是RSA使用不同位数的SHA摘要算法)

`token = JWT.encode(data, rsa_private_key, 'RS256')`

3. 将编码后的token通过HTTP POST方式（Content-Type: text/plain）发送到相应接口url。

`http.post(url, body: token, headers: {'Content-Type': 'text/plain'})`

4. 接口响应是 json 格式，code == 0 表示成功，其他为错误代码，同时msg包含对应的错误信息。

> 同步响应

```json
{
  "code": 0,
  "msg": "成功信息或错误信息"
}
```











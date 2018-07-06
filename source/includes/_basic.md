# 基础
## 文档简介

Pooul API 采用 REST 风格设计。所有接口请求地址都是可预期的以及面向资源的。使用规范的 HTTP 响应代码来表示请求结果的正确或错误信息。使用 HTTP 内置的特性，如 HTTP Authentication 和 HTTP 请求方法让接口易于理解。所有的 API 请求都会以规范友好的 JSON 对象格式返回（包括错误信息）。

## 阅读对象

本文阅读对象：商户系统（在线购物平台、人工收银系统、自动化智能收银系统或其他）集成普尔系统涉及的技术架构师，研发工程师，测试工程师，系统运维工程师。

## 名词解释

### 关于商户

- 平台商户：指平台商户或集团商户
- 入驻商户：平台商户下属商户
- 普通商户：不属于平台商户与入驻商户的其他普通商户类型
- 终端商户：指发起交易的商户，可以是普通商户、也可以是入驻商户，平台商户不允许发起交易

### 关于费率

- 结算费率：指结算时支付渠道或银行需扣除的费率
- 协议费率：指商户与普尔合作签约的费率 

### 关于支付

- 支付方式：如：微信支付、支付宝、银联分期
- 支付类型：如：正扫、反扫、公众号、APP、H5等场景

## 商户参数

## 协议规则


- 传输方式：为保证交易安全性，采用HTTPS传输
- 提交方式：采用 Post、Get、put、delete 方法提交
- 数据格式：提交和返回数据都为json格式
- 字符编码：统一采用UTF-8字符编码
- 签名算法：RSA，JWT加密传输
- 签名要求：请求和接收数据均需要校验签名，详细方法请参考安全规范-签名算法
- 证书要求：调用申请退款、撤销订单接口需要商户证书
- 判断逻辑：先判断协议字段返回，再判断业务返回，最后判断交易状态

<aside class="notice">
You must replace `meowmeowmeow` with your personal API key.
</aside>

## 参数约定

### 涉及时间
- 所有涉及到时间的地方都使用Unix时间戳 
- 时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。

### 涉及金额
- 所有涉及到金额的单位都是分 
- 最小的单位是 1 分，都为整数，不能有小数出现

### 涉及费率
- 费率的格式为int，万分之，比如：30代表万分之30，千分之3，百分之0.3


## 获取openid

微信公众平台：
openid是微信用户在公众号appid下的唯一用户标识（appid不同，则获取到的openid就不同），可用于永久标记一个用户，同时也是微信公众号支付的必传参数。

[网页授权获取用户openid接口文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140842)


## 状态码

### 商户状态码

| status | status_desc| 说明|
--|--|--
|0 |审核通过 | 上游渠道审核成功，并配置好路由等相关交易信息，商户可以正常交易 |
|1 |入驻申请 |代理商通过接口或后台提交成功商户资料至普尔商户系统，等待普尔提交至上游渠道 |
|2 | 审核中 | 普尔提交商户资料至上游渠道，等待上游渠道审核|
| 3| 审核失败|商户审核失败（a.上游渠道返回审核失败，b.普尔审核失败） |
|4 |商户停用 | 商户状态停用（a.上游渠道停用商户，b. 普尔停用商户）|

### 支付状态码 trade_state

trade_state | trade_info | 
--|--|--|--|--|--
0|交易成功|  
1|转入退款| 
2|未支付| 
3|已关闭| 
4|已冲正|
5|已撤销| 
6|支付中| 
7|支付失败| 

# 认证 Authentication

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

```json
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

### 生成RSA密钥

> 生成 PKCS#1 2048 位私钥

```
OpenSSL>genrsa -out rsa_private_key.pem 2048  #默认生成PKCS#1的私钥，2048表示私钥的长度，我们建议是2048位，这样安全，如果由于某些限制，可以改为1024，表示1024位长度，我们仍然支持
OpenSSL>rsa -in rsa_private_key.pem -pubout -out app_public_key.pem  #从私钥导出对应的公钥，默认此公钥是PKCS#8的
OpenSSL>pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt -out rsa_private_key_pkcs8.pem  #Java开发者需要将私钥转换成PKCS8格式
OpenSSL>exit  #退出OpenSSL程序
```

我们建议可以使用OpenSSL工具命令，或取得信任的密钥生成工具来生成密钥。

### 上传应用公钥

> put /cms/merchants/#{merchant_id}/public_key

```json
{
	"public_key":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg/AchA3vsfR4a/hXK2d7Y97B/2XCK/p2wbvQRwMfqqrrB5o/NiIeqmOn8o5Bc/LwRgpY2foxD7kDL26q73Wwo19qBbsK5agkRZMWoZsea5mSHiFL9ClrE3+xytErZAsivDwPbkaxFCYTIDpPmXNpJQnTXkymOy6Pz/RAMiLgkrTjD1r6MCLZ9pqg0Pt8yKj2SfPqMyfeA7ld2yOa3VNcJXypgvvEARxmxrEI0EOTun9VUKWrA7FvvDICvc/ZAMrXg/UOVfch6oQrAlPc+3A1SDIlfKaFLl2zbb11CZy5J3mwz4N6SVQNS+QApGUdf+DZnMxlgn6eMN2iYziVw9YR9QIDAQAB"
}
```

### 获取普尔公钥

下载普尔公钥：

> Get /cms/pooul_public_key

```json
{
	"code": 0,
	"msg": "success",
	"data": "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+Vd3j0McNfR3VvT7mZp/7M6UL\nFJSc3dh3/56JP8DZk+cDlXC2LR0z0OELJeyTitFeBjpPWzWH3OOFI/OL3nD5/oNZ\nfK+wHd4Tzxj2SdWlyuqRhNv3xG2obUUYZ9urUvkCvxL1SclaXW7cq22V/TTNSgJq\n7CGdc+q/XLNqcmLt7QIDAQAB\n-----END PUBLIC KEY-----\n"
}
```

### 使用JWT生成请求数据

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

- 普尔翰达会用JSON格式响应同步请求;
- 响应都会使用MD5进行签名, 响应中会带有签名;
- 签名只针对data中的数据

### 使用普尔公钥验签 JWT



# 基础
## 文档简介

Pooul API 采用 REST 风格设计。所有接口请求地址都是可预期的以及面向资源的。使用规范的 HTTP 响应代码来表示请求结果的正确或错误信息。使用 HTTP 内置的特性，如 HTTP Authentication 和 HTTP 请求方法让接口易于理解。所有的 API 请求都会以规范友好的 JSON 对象格式返回（包括错误信息）。

## 阅读对象

本文阅读对象：商户系统（在线购物平台、人工收银系统、自动化智能收银系统或其他）集成普尔系统涉及的技术架构师，研发工程师，测试工程师，系统运维工程师。

## 名词解释

### 关于商户

- 普通商户：单个门店商户
- 平台商户：指平台商户或集团商户，拥有多个直营门店或是分销商
- 入驻商户：平台商户下属商户

### 关于费率

- 结算费率：指结算时支付渠道或银行需扣除的费率
- 入驻商户费率：指平台商户与入驻商户的签约费率，入驻商户的交易及账务以此费率为准

### 关于支付

- 支付方式：如：微信支付、支付宝、银联分期、网银转账等
- 支付类型：如：正扫、反扫、公众号、APP、H5等场景

## 接口网址

- 测试环境：https://api-dev.pooul.com/
- 生产环境：https://api.pooul.com/

## 测试商户

- 请联系对接的商务经理

## 协议规则


- 传输方式：为保证交易安全性，采用HTTPS传输
- 提交方式：采用 POST、GET、PUT、DELETE 方法提交
- 数据格式：提交和返回数据都为json格式
- 字符编码：统一采用UTF-8字符编码
- 认证方式：Login、RSA，一般来说 /cms 接口使用Login方式、/v2 接口使用RSA认证方式
- 判断逻辑：先判断code参数，再判断交易状态


## 参数约定

### 涉及时间
- 所有涉及到时间的地方都使用Unix时间戳 
- 时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。

### 涉及金额
- 所有接口涉及到金额的单位都是分 
- 最小的单位是 1 分，都为整数，不能有小数出现
- 下载对账单CSV文件中的金额单位为元

### 涉及费率
- 费率的格式为int，万分之，比如：30代表万分之30，千分之3，百分之0.3


## 分页 Pagination

> 请求示例

```shell
curl "/cms/balances/history?page_size=2&last_id=770&merchant_id=5399355381712172" \
-H "Authorization: #{Authorization}"
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": 769,
            "amount": 100000,
            "balance": -7908,
            "balance_account_id": "5b85345259376863211d640a",
            "balance_prev": -107908,
            "biz_id": "5b8794f701c9114c0ae12b5b",
            "biz_type": 7,
            "created_at": 1535612151,
            "trade_at": 1535612151,
            "updated_at": 1535612151
        },
        {
            "_id": 765,
            "amount": -100000,
            "balance": -107908,
            "balance_account_id": "5b85345259376863211d640a",
            "balance_prev": -7908,
            "biz_id": "5b87948f01c9114c0ae12b59",
            "biz_type": 7,
            "created_at": 1535612047,
            "trade_at": 1535612047,
            "updated_at": 1535612047
        }
    ]
}
```

部分接口返回list对象支持分页，例如：[查询交易记录](#pay-orders)、[查询记账明细](#balances-list)，这些list拥有相同的数据结构，Pooul 是基于 cursor 的分页机制，使用参数 last_id 来决定列表从何处开始。

URL请求参数

参数| 描述
--|--
page_size <br> **选填** | 每页可以返回多少数据，限制范围是从 1~100 项，默认是 15 项。
last_id <br> **选填** | 在分页时使用的指针，决定了列表的第一项从何处开始。假设你的一次请求返回列表的最后一项的 id 是 obj_end，你可以使用 last_id = obj_end 去获取下一页。


## 状态码 Status code

### 协议状态码 Code

```json
{
    "code": "0为请求成功，其它数字为错误代码",
    "msg": "成功为success, 出错时，相关的错误信息",
    "data" : "#可变，根据上下文的不同，返回的内容可能是任意的json数据类型。"
}
```

| 参数 | 描述 | 
--|--|--
| code | 业务状态码，0为成功，其他为失败 |
| msg | success 为成功，其他为错误信息 |
| data | 返回数据 json 格式|


### 商户状态码

| status | status_desc| 说明|
--|--|--
|0 |审核通过 | 上游渠道审核成功，并配置好路由等相关交易信息，商户可以正常交易 |
|1 |入驻申请 |代理商通过接口或后台提交成功商户资料至普尔商户系统，等待普尔提交至上游渠道 |
|2 | 审核中 | 普尔提交商户资料至上游渠道，等待上游渠道审核|
| 3| 审核失败|商户审核失败（a.上游渠道返回审核失败，b.普尔审核失败） |
|4 |商户停用 | 商户状态停用（a.上游渠道停用商户，b. 普尔停用商户）|

### 支付状态码 trade_state

trade_state | 说明
--|--
0|交易成功
1|转入退款：支付成功后调用退款接口转入退款，只代表退款业务提交成功，具体退款状态请调用退款查询接口
2|未支付：交易订单生成后未支付
3|已关闭：交易生成后未支付，订单已关闭
4|已完结：交易支付成功，已完结，不可发起退款
5|已撤销：交易支付确认失败
6|支付中：用于反扫，当用户需要输入密码时的状态

# 认证 Authenticate

根据权限不同接口使用两种不同的认证方式，具体查看改接口的认证方式说明，Login认证方式还跟用户与商户绑定的权限有关，如果用户没有此接口操作权限会返回权限相关错误，RSA认证方式需要使用JWT方式调用，客户需生成证书，自行保存私钥并上传公钥。

## Login

### 1. 获得登录用户 Get user

请联系对接的商务经理

### 2. 获取 Authorization

> 请求示例 

```shell
curl -X POST /web/user/session/login_name \
-H "Content-Type: application/json" \
-d' {
    "login_name":"alex",
    "password":"123" 
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

参数| 描述
--|--
login_name <br> **必填** <br> `string` | 登录名，可以为手机号码、用户名、邮箱任意一种
password  <br> **必填** <br> `string` | 登录密码


使用用户名与密码调用登录接口获取 Authorization, 在登录成功以后，下发 Authorization 在http头

- Authorization 默认有效期为 30 分钟，如果用户在使用的情况下，自动会延长 Authorization 的有效时间，
- 如果持续 30 分钟以上没有任何操作，重新操作 Authorization 会失效，这时需要重新登录获取新的 Authorization

### 3. 提交请求头带上 Authorization

> Request（post、put、get、delete等）URL

```shell
curl -X POST https://json.pooulcloud.cn/cms/merchants \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d' {
    #请求参数
}'
```

请求使用Login鉴权的接口时需要在请求头中带上 Authorization 


## RSA

### 1. 生成RSA密钥

> 生成 PKCS#1 2048 位私钥

```
OpenSSL>genrsa -out rsa_private.pem 2048  #默认生成PKCS#1的私钥，2048表示私钥的长度
```

> 从私钥导出对应的公钥，默认此公钥是PKCS#8的

```
OpenSSL>rsa -in rsa_private.pem -pubout -out rsa_public.pem  
```
> Java开发者需要将私钥转换成PKCS8格式

```
OpenSSL>pkcs8 -topk8 -inform PEM -in rsa_private.pem -outform PEM -nocrypt -out rsa_private_pkcs8.pem  
```

我们建议可以使用OpenSSL(https://www.openssl.org/) 工具命令，或取得信任的密钥生成工具来生成密钥。

经过示例中的步骤，开发者可以在当前文件夹中（OpenSSL运行文件夹），看到 rsa_private.pem（开发者RSA私钥，非Java语言适用）、rsa_private_pkcs8.pem（pkcs8格式开发者RSA私钥，Java语言适用）和 rsa_public.pem（开发者RSA公钥）3个文件。开发者将私钥保留，上传商户公钥给普尔，用于验证签名。

<aside class="notice">
对于使用Java的开发者，需将生成的pkcs8格式的私钥去除头尾、换行和空格，作为私钥填入代码中，对于.NET和PHP的开发者来说，无需进行pkcs8命令行操作。
</aside>

标准的私钥文件示例（PHP、.NET使用）

`
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAw3Djq8ynUbfDfBMVWxMPVtogSUXwtPssniinXuoAmiTMRhkE
cWq84xsrFzBl+s13DPvb5Lr172e8bB75lFk2DD7QVNFfm6eBVbuUy0Y9Q5bW6CLz
5Yu/ZG6//ai94f6WzN3cnkS4x71Ihge3uaRWRf1UzqAfaq2vbaABNi5SYWsQCzYv
nxoG4PYQtrc/rzuHERKsx7QWlxFmWXaxJHGvF8cr/+GXUxwjeoRB0n1mMzxhjlFO
m200iJ65mFs+HqS0JpZh4HTdxru5WZe80vv+1AuXO9/AVtZLc1BWrTGWLfTe1ySf
KzxEQqLq8ls0hS9V1MNYlD9ha1B/480zrGZAnwIDAQABAoIBAE2w3pA4tnqhljAI
VgDyPrLD2vnFt7356u6kMoRkeQDNh/aFk2KSj6un7SU2tBNTAfRDWlI+j+0vS5Of
bI8wN2/+uEo/QMZbe+pcuvVjYo8vsxZsbo/dUaPW8rMfFPx1e/TMbRrtLpcYA3Bk
OQCu9yyzW7cXp+V8TbRCWrjzCQR4HMqnUExyDOyJflatQ2641Q4Q2YaAF1NCxJyq
uTyxAPdpvvQ9SAj7eXsF1l0OIfW/4aACrOuvg9aOwPhbrKaT6s0dk8fKhfAm5rAu
Q2tsubzwA5D+mJQqjVwnRHGiN+4GuIcAynevj4IdkznOP81wG/ksP34MkQpFnJ4j
pBZxvQECgYEA6qFWBk9XQpYMVecS4RWvvRyolbKF6HgVEp0ji8euocLIfgJWEFXK
Eb+Ood3NNSff4SpjpGOuzXBbyZiimWAQdzuo4LXwHLfd0cHOW07Lqx7UXsm5+wVp
rzNuZzkQMtRqNqXAfSAdBziSfiMPSIZanqW3zv59oSHLengAAAI4zmECgYEA1T3Q
BFO1J0duKacA6hjQ+DqOkfWuLo9NOFhMK4oFOiMCoFTrgoaU+7HEwPvWSe0d7rku
HhuivGhhha9Viw41Gpfo5Z5oymL5McW52+YPLjugAV5G2dkT68c/C6CPMZYB7PYk
4AtCYsvA5VP6qRmFQ6acm/822kela5RxAeIDbv8CgYEA0dzq8AvpdfJ2KCPePBvE
q/dFR1h989fsqVCKac16gs+RuzvltQi3DDb1ogydLu1yj5j1tSVARhs4zlHLJjrJ
n4xqWkwB7/3511Ntezg4bd/OftYals9Zn072cjeVKJHcSvLpAEJIFJxiU5aSZgFe
bsa1aN0yi3yJ3woUne1e2CECgYEA0qobXHr6B5EI4ztqqtrTb7gh607Ewpit2BFb
RtQ278VwrcbXV/7vJmzsDR9/B0+q95GYXwQ8VFfmqHScVSE3E0uqOVay/eajeyl0
wSraKnmbTF7ALi3IAXG49hqr/HfO9TQDIBffgMz8h1Lc2rwsrLXoGDEdFq4bXVmr
/wkzDS8CgYArNrvZ04EfGTdlgQLcxgGKhQcTibz9/QUkJ/RZPOnCxZFWwgfDIoAQ
99IthRkneZglfhm/R5Znn1t65B8IEXejTZcYN11EugqI1/cOkJ/PySmtUMaeD+/o
Am6x0mszgYThpY+2mM2w2hWTirUbvXS07LbCN0R29fT/a88Kwd2gGQ==
-----END RSA PRIVATE KEY-----
`

PKCS8处理后的私钥文件示例（Java使用）

`MIIEpAIBAAKCAQEAw3Djq8ynUbfDfBMVWxMPVtogSUXwtPssniinXuoAmiTMRhkEcWq84xsrFzBl+s13DPvb5Lr172e8bB75lFk2DD7QVNFfm6eBVbuUy0Y9Q5bW6CLz5Yu/ZG6//ai94f6WzN3cnkS4x71Ihge3uaRWRf1UzqAfaq2vbaABNi5SYWsQCzYvnxoG4PYQtrc/rzuHERKsx7QWlxFmWXaxJHGvF8cr/+GXUxwjeoRB0n1mMzxhjlFOm200iJ65mFs+HqS0JpZh4HTdxru5WZe80vv+1AuXO9/AVtZLc1BWrTGWLfTe1ySfKzxEQqLq8ls0hS9V1MNYlD9ha1B/480zrGZAnwIDAQABAoIBAE2w3pA4tnqhljAIVgDyPrLD2vnFt7356u6kMoRkeQDNh/aFk2KSj6un7SU2tBNTAfRDWlI+j+0vS5OfbI8wN2/+uEo/QMZbe+pcuvVjYo8vsxZsbo/dUaPW8rMfFPx1e/TMbRrtLpcYA3BkOQCu9yyzW7cXp+V8TbRCWrjzCQR4HMqnUExyDOyJflatQ2641Q4Q2YaAF1NCxJyquTyxAPdpvvQ9SAj7eXsF1l0OIfW/4aACrOuvg9aOwPhbrKaT6s0dk8fKhfAm5rAuQ2tsubzwA5D+mJQqjVwnRHGiN+4GuIcAynevj4IdkznOP81wG/ksP34MkQpFnJ4jpBZxvQECgYEA6qFWBk9XQpYMVecS4RWvvRyolbKF6HgVEp0ji8euocLIfgJWEFXKEb+Ood3NNSff4SpjpGOuzXBbyZiimWAQdzuo4LXwHLfd0cHOW07Lqx7UXsm5+wVprzNuZzkQMtRqNqXAfSAdBziSfiMPSIZanqW3zv59oSHLengAAAI4zmECgYEA1T3QBFO1J0duKacA6hjQ+DqOkfWuLo9NOFhMK4oFOiMCoFTrgoaU+7HEwPvWSe0d7rkuHhuivGhhha9Viw41Gpfo5Z5oymL5McW52+YPLjugAV5G2dkT68c/C6CPMZYB7PYk4AtCYsvA5VP6qRmFQ6acm/822kela5RxAeIDbv8CgYEA0dzq8AvpdfJ2KCPePBvEq/dFR1h989fsqVCKac16gs+RuzvltQi3DDb1ogydLu1yj5j1tSVARhs4zlHLJjrJn4xqWkwB7/3511Ntezg4bd/OftYals9Zn072cjeVKJHcSvLpAEJIFJxiU5aSZgFebsa1aN0yi3yJ3woUne1e2CECgYEA0qobXHr6B5EI4ztqqtrTb7gh607Ewpit2BFbRtQ278VwrcbXV/7vJmzsDR9/B0+q95GYXwQ8VFfmqHScVSE3E0uqOVay/eajeyl0wSraKnmbTF7ALi3IAXG49hqr/HfO9TQDIBffgMz8h1Lc2rwsrLXoGDEdFq4bXVmr/wkzDS8CgYArNrvZ04EfGTdlgQLcxgGKhQcTibz9/QUkJ/RZPOnCxZFWwgfDIoAQ99IthRkneZglfhm/R5Znn1t65B8IEXejTZcYN11EugqI1/cOkJ/PySmtUMaeD+/oAm6x0mszgYThpY+2mM2w2hWTirUbvXS07LbCN0R29fT/a88Kwd2gGQ==`

公钥文件示例

`
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw3Djq8ynUbfDfBMVWxMP
VtogSUXwtPssniinXuoAmiTMRhkEcWq84xsrFzBl+s13DPvb5Lr172e8bB75lFk2
DD7QVNFfm6eBVbuUy0Y9Q5bW6CLz5Yu/ZG6//ai94f6WzN3cnkS4x71Ihge3uaRW
Rf1UzqAfaq2vbaABNi5SYWsQCzYvnxoG4PYQtrc/rzuHERKsx7QWlxFmWXaxJHGv
F8cr/+GXUxwjeoRB0n1mMzxhjlFOm200iJ65mFs+HqS0JpZh4HTdxru5WZe80vv+
1AuXO9/AVtZLc1BWrTGWLfTe1ySfKzxEQqLq8ls0hS9V1MNYlD9ha1B/480zrGZA
nwIDAQAB
-----END PUBLIC KEY-----
`


### 2. 上传商户公钥


```
PUT /cms/merchants/#{merchant_id}/public_key
```

> 请求示例

```shell
curl -X PUT /cms/merchants/5399355381712172/public_key \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d' {
	"public_key":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg/AchA3vsfR4a/hXK2d7Y97B/2XCK/p2wbvQRwMfqqrrB5o/NiIeqmOn8o5Bc/LwRgpY2foxD7kDL26q73Wwo19qBbsK5agkRZMWoZsea5mSHiFL9ClrE3+xytErZAsivDwPbkaxFCYTIDpPmXNpJQnTXkymOy6Pz/RAMiLgkrTjD1r6MCLZ9pqg0Pt8yKj2SfPqMyfeA7ld2yOa3VNcJXypgvvEARxmxrEI0EOTun9VUKWrA7FvvDICvc/ZAMrXg/UOVfch6oQrAlPc+3A1SDIlfKaFLl2zbb11CZy5J3mwz4N6SVQNS+QApGUdf+DZnMxlgn6eMN2iYziVw9YR9QIDAQAB"
}
```

> 响应示例

```json
{
    "code":0,
    "msg":"success"
}

```

将生成的商户公钥文件去除头尾、换行和空格，转成一行字符串。使用上传公钥接口上传，上传公钥需要Login认证且有修改该商户公钥权限。

转换后的公钥字符串示例

`MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw3Djq8ynUbfDfBMVWxMPVtogSUXwtPssniinXuoAmiTMRhkEcWq84xsrFzBl+s13DPvb5Lr172e8bB75lFk2DD7QVNFfm6eBVbuUy0Y9Q5bW6CLz5Yu/ZG6//ai94f6WzN3cnkS4x71Ihge3uaRWRf1UzqAfaq2vbaABNi5SYWsQCzYvnxoG4PYQtrc/rzuHERKsx7QWlxFmWXaxJHGvF8cr/+GXUxwjeoRB0n1mMzxhjlFOm200iJ65mFs+HqS0JpZh4HTdxru5WZe80vv+1AuXO9/AVtZLc1BWrTGWLfTe1ySfKzxEQqLq8ls0hS9V1MNYlD9ha1B/480zrGZAnwIDAQAB`


### 3. 获取普尔公钥

下载普尔公钥：

```
GET /cms/pooul_public_key
```

> 请求示例

```shell
curl -X GET /cms/pooul_public_key \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC+Vd3j0McNfR3VvT7mZp/7M6UL\nFJSc3dh3/56JP8DZk+cDlXC2LR0z0OELJeyTitFeBjpPWzWH3OOFI/OL3nD5/oNZ\nfK+wHd4Tzxj2SdWlyuqRhNv3xG2obUUYZ9urUvkCvxL1SclaXW7cq22V/TTNSgJq\n7CGdc+q/XLNqcmLt7QIDAQAB\n-----END PUBLIC KEY-----\n"
}
```

### 4. 使用JWT生成请求数据

> HEADER: ALGORITHM & TOKEN TYPE

```json
{
  "alg": "RS256",
  "typ": "JWT"
}
```

> PAYLOAD: DATA

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

> VERIFY SIGNATURE

```
RSASHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload),'rsa_private.pem')
```

> 生成请求数据

```
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlfdHlwZSI6IndlY2hhdC5zY2FuIiwibWNoX3RyYWRlX2lkIjoiYWxleHRlc3Quc2Nhbi4xNTMiLCJ0b3RhbF9mZWUiOjIyNywic3BiaWxsX2NyZWF0ZV9pcCI6IjEyNy4wLjAuMSIsIm5vdGlmeV91cmwiOiJodHRwOi8vMTEyLjc0LjE4NC4yMzY6MzAwNi9mYWtlLXJlY3YiLCJib2R5IjoiQWxleCBUZXN0IFdlY2hhdCBTY2FuIiwiZGV2aWNlX2luZm8iOiJhbGV4IHdlY2hhdCBkZXZpY2UiLCJvcF91c2VyX2lkIjoiMTEiLCJvcGVuaWQiOiJvUlhkVnM1OXhfRTZuVlRCSFhIa3VTanNOVkt3IiwiYXR0YWNoIjoiQWxleCBhdHRhY2ggVGVzdCJ9.IGSTNK7rzkaXnvKRjxrGMiRS_Z0x5bYN0Sw-QS8UxizkoCaytkVLMT0KLkfWKsyyCHt5hy7BrVdLu9nESSKxwJwwBAZUSThn_tbrkSYXOt08yNKBG2jYn6f_ty2jk3Yr9DhRUsYnKSrZS7sbK5lS1SG_I0tAGd4HLa94KzwilG0LhUZpJbXKyMpIzYPBod7O91f6pqvT1A48F_uDIttUp_Vm7SlchMLPT2i2tzP7O7ghcThcGakaPXNKkOV9zYWOXYFE84eoekwO6t5jtl0R2BpSH_xNAzEhCfQQ5FY7LFDBDypCJEuYaBTyy2JK7j8wNQiTiL01NKntyya9qABgCA
```

1. 按照接口文档参数要求，将请求数据写成 json 格式


2. 使用程序语言的JWT包（JWT支持各种语言，在 https://jwt.io 上均有下载和DEMO），将 json 数据编码，签名算法使用RSA算法RS256
    - [Ruby demo](https://github.com/jwt/ruby-jwt)
    - [Java demo](https://github.com/auth0/java-jwt)
    - [Php demo](https://github.com/firebase/php-jwt)
    - [C# demo](https://github.com/dvsekhvalnov/jose-jwt)
    - [更多 Demo](https://jwt.io/)


### 5.将编码后的token通过HTTP POST方式（Content-Type: text/plain）发送到相应接口url。

```shell
curl -X POST /v2/pay?merchant_id=7609332123096874 \
-H "Content-Type: text/plain" \
-H "Authorization: #{Authorization}" \
-d' eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlfdHlwZSI6IndlY2hhdC5zY2FuIiwibWNoX3RyYWRlX2lkIjoiYWxleHRlc3Quc2Nhbi4xODEiLCJ0b3RhbF9mZWUiOjUsInNwYmlsbF9jcmVhdGVfaXAiOiIxMjcuMC4wLjEiLCJub3RpZnlfdXJsIjoiaHR0cDovLzExMi43NC4xODQuMjM2OjMwMDYvZmFrZS1yZWN2IiwiYm9keSI6IkFsZXggVGVzdCBXZWNoYXQgU2NhbiIsImRldmljZV9pbmZvIjoiYWxleCB3ZWNoYXQgZGV2aWNlIiwib3BfdXNlcl9pZCI6IjExIiwib3BlbmlkIjoib1JYZFZzNTl4X0U2blZUQkhYSGt1U2pzTlZLdyIsImF0dGFjaCI6IkFsZXggYXR0YWNoIFRlc3QifQ.a77r3uZH9P_gyJESbm1pTJ4rjsU5Pmn4zO90dRJrG6ozzRW7v95l61ezg8r_HTY7IELrHXs8hlquJPVK-6mdzlFjPWyo9_H40gOdDFlYE-QzSwUOewQNaqVuR7Z3KDhPMxr1scy50nXqoaEtq_IODdrJPxq2wxw9YDLas_lVFrhxSWwqQXZvDwZRkG9QAnmOsWvHKP-VFo-r4ne0sapSx6SHpJE-bqUwAOkxhLUmUpFiUxK3hJaGVmfhzymX5yBNNwEEBscuZig2i7PDoN4jXh0W9wgay9wq1-M31qNHnWcUhxXckmvtlR9kmdX5SVCOL0RK1u9ko664wr8Soi2PvA‘
```


### 6. 使用普尔公钥验签 JWT

> 成功响应示例

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJjb2RlIjowLCJtc2ciOiJzdWNjZXNzIiwiZGF0YSI6eyJjb2RlX3VybCI6IndlaXhpbjovL3d4cGF5L2JpenBheXVybD9wcj10TmtlenkwIiwicHJlcGF5X2lkIjoid3gxMDExMDIyNDYxMjYxNWFhN2I0MzE3YzAyMTc1NDk5OTczIiwidHJhZGVfaWQiOiI1YjQ0MjFjMDAxYzkxMTdkNDlkMzU3NzEiLCJtY2hfdHJhZGVfaWQiOiJhbGV4dGVzdC5zY2FuLjE1MyIsIm1lcmNoYW50X2lkIjoiNTM5OTM1NTM4MTcxMjE3MiJ9LCJkZWJ1ZyI6eyJjdXJyX3VzZXIiOiJHdWVzdChub3QgbG9nZ2VkLWluKSIsImN1cnJfZW52IjoiZGV2ZWxvcG1lbnQiLCJkYXRhYmFzZV9uYW1lIjoic3pwbDJfZGV2IiwiYXN5bmMiOnRydWV9LCJ0aW1lX2VsYXBzZWQiOjAuMzgwMSwibm9uY2Vfc3RyIjoiNWI0NDIxYzAwMWM5MTE3ZDQ5ZDM1NzczIn0.HqUG0qgOnVZcygfTxEJjkLuqiY_vWK_68wqLJTA-ZQkXuXrAoddTkSqUtztW-KGcZf9vaDCqNYDZDlkcAnkOQzc3xl4D2z8AGECcTfaybgO7SSSqltP7vsIOJCFXOr5-1Jv1lEVgB7V0Y-t9A6o-YSUd0p5DFeybqpoKX683LG4
```

> 失败响应示例

```json
{
    "code": , #错误代码
    "msg": "", #错误信息
}
```

提交请求后如果响应成功，系统会返回jwt字符串，商户需要使用 jwt工具 并用普尔公钥进行验签，确保接收到的是普尔系统返回的正确数据。









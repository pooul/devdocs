# 收款 Pay

## 统一支付 Pay order

> Post /v2/pay?merchant_id=#{merchant_id}

```json
{
	"pay_type":"wechat.scan",
	"mch_trade_id":"alextest.scan.113",
	"total_fee": 221, 
	"spbill_create_ip":"127.0.0.1",
	"notify_url":"http://112.74.184.236:3006/fake-recv",
	"body":"Alex Test Scan",
	"device_info":"alex device",
	"op_user_id":"301",
	"attach":"Alex attach"
}

```

请求方式：Post /v2/pay?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body公共请求参数

参数|	描述
--|--
pay_type <br> **必填** <br> `string` | 支付类型，不同的支付类型，pay_type值不一样，需对应[查看支付类型编码](#pay-type)
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL
mch_trade_id <br> **必填** <br> `string` | 商户订单号，在同一个merchant_id 下每次请求必须为唯一，如：alextest.scan.113
total_fee  <br> **必填** <br> `int` | 支付总金额，单位为分，只能为整数，如：888 代表8.88元
body  <br> **必填** <br> `string` | 商品或支付单简要描述
spbill_create_ip <br> **选填** <br> `string` | 发起支付的终端IP，APP、jsapi、jsminipg、wap支付提交用户端ip，scan、micro支付填调用支付API的服务端IP。<br>微信支付必填、支付宝选填
notify_url  <br> **选填** <br> `string` | 支付结果通知地址，接收支付结果异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。如：http://pay.pooul.com/notify
time_start  <br> **选填** <br> `int` | 订单开始时间，为10位 UNIX 时间戳，如：1530759545
time_expire  <br> **选填** <br> `int` | 订单失效时间，为10位 UNIX 时间戳，如：1530759574
store_id  <br> **选填** <br> `string` | 商户门店编号，支付宝支付不传门店号会导致优惠不生效，可能引起优惠活动无法参加
device_info  <br> **选填** <br> `string` | 终端设备号(门店号或收银设备ID)，注意：PC网页或APP支付请传"WEB"
op_user_id  <br> **选填** <br> `string` | 操作员或收银员编号




### 统一反扫支付 common.micro 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"common.micro",
	"mch_trade_id":"alextest.micro.78",
	"total_fee": 1223, 
	"spbill_create_ip":"127.0.0.1",
	"body":"Alex Test Micro",
	"auth_code":"136345610916464024"
}
``` 

> 响应：付款成功

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"trade_id": "5b378a0601c9117d162f281c",
		"mch_trade_id": "alextest.micro.78",
		"merchant_id": "5399355381712172",
		"trade_state": 0,
		"trade_info": "支付成功"
	}
}
```

> 响应：需要用户输入密码

```json
{
	"code": 0,
	"msg": "USERPAYING, 需要用户输入支付密码",
	"data": {
		"trade_id": "5b378a0601c9117d162f281c",
		"mch_trade_id": "alextest.micro.78",
		"merchant_id": "5399355381712172",
		"trade_state": 6,
		"trade_info": "支付中, USERPAYING, 需要用户输入支付密码"
	}
}
```

包含微信刷卡支付、支付宝条码支付，此模式下商家扫码消费者付款码

收银员使用扫码设备读取微信/支付宝用户刷卡授权码以后，二维码或条码信息传送至商户收银台，由商户收银台或者商户后台调用该接口发起支付。

提醒1：提交支付请求后系统会同步返回支付结果。当返回结果为“系统错误”时，商户系统等待5秒后调用【查询订单API】，查询支付实际交易结果；当返回trade_state为“6”时，商户系统可设置间隔时间(建议10秒)重新查询支付结果，直到支付成功或超时(建议30秒)；

提醒2：在调用查询接口返回后，如果交易状况不明晰，请调用【撤销订单API】，此时如果交易失败则关闭订单，该单不能再支付成功；如果交易成功，则将扣款退回到用户账户。当撤销无返回或错误时，请再次调用。注意：请勿扣款后立即调用【撤销订单API】,建议至少15秒后再调用。

Body需增加请求参数

参数|	描述
--|--
auth_code <br> **必填** <br> `string` | 微信支付或支付宝支付授权码，设备读取用户微信中的条码或者二维码信息转换成字符

开发说明：

1. 商户通过扫码设备获取消费者付款码（微信支付付款码、支付宝付款码）
2. 调用统一支付接口发起支付
4. 系统同步返回支付状态
5. 如支付状态为6（代表支付中），商户系统需调用[查询订单API](#query)确认支付状态

### 微信扫码支付 wechat.scan 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"wechat.scan",
	"mch_trade_id":"alextest.scan.113",
	"total_fee": 221, 
	"spbill_create_ip":"127.0.0.1",
	"notify_url":"http://112.74.184.236:3006/fake-recv",
	"body":"Alex Test Scan",
	"device_info":"alex device",
	"op_user_id":"301",
	"attach":"Alex attach"
}
``` 

> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"code_url": "weixin://wxpay/bizpayurl?pr=oB8TuWO",
		"prepay_id": "wx302121541410392cf43ee7773887304578",
		"trade_id": "5b3783f101c9117d132f2813",
		"mch_trade_id": "alextest.scan.113",
		"merchant_id": "5399355381712172"
	}
}

``` 

扫码支付是指商户系统按微信支付协议生成支付二维码，用户再用微信“扫一扫”来完成支付。适用于PC网站支付、实体店单品等场景。


开发说明：

1. 调用统一支付接口，获取 code_url 信息
2. 商户后台系统根据返回的code_url生成二维码，并展示给顾客
3. 用户打开微信“扫一扫”扫描二维码，输入支付密码确认支付
4. 平台通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)


### 微信公众号支付 wechat.jsapi 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"wechat.jsapi",
	"mch_trade_id":"alextest.jsapi.34",
	"total_fee": 9872, 
	"spbill_create_ip":"127.0.0.1",
	"notify_url":"http://112.74.184.236:3006/fake-recv",
	"body":"Alex Test Jsapi",
	"sub_appid":"wx069eb0cbbdd45873",
	"sub_openid":"outOWs-bgUH2QiCE0vNZhyCj2FJI"
}
```

> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"prepay_id": "wx012307229175165bd79bbb6b3297639794",
		"trade_id": "5b38ee2a01c9113d0cc907a6",
		"mch_trade_id": "alextest.jsapi.34",
		"merchant_id": "5399355381712172",
		"pay_info": "{\"appId\":\"wx26a0ffd6bfa99df7\",\"timeStamp\":1530457643,\"nonceStr\":\"5b38ee2b01c9113d0cc907a8\",\"package\":\"prepay_id=wx012307229175165bd79bbb6b3297639794\",\"signType\":\"MD5\",\"paySign\":\"5c8d2742f597d01f38886d78769d3132\"}"
	}
}
```

公众号支付是指用户在微信中打开商户的H5页面，商户在H5页面通过调用微信支付提供的JSAPI接口调起微信支付模块来完成支付。适用于在公众号、朋友圈、聊天窗口等微信内完成支付的场景。

Body需增加请求参数

参数|	描述
--|--
sub_appid <br> **必填** <br> `string` | 与发起支付商户主体一致的公众号appid，公众号必须为认证的服务号
sub_openid <br> **必填** <br> `string` | 用户在商户appid下的唯一标识，下单前需要调用[网页授权获取用户openid接口文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140842)接口获取到用户的Openid

开发说明：

1. 用户在微信环境中点击使用微信支付
2. 商户系统后台调用统一支付接口，获取pay_info信息
2. 商户系统前端调用：微信内H5调起支付，输入上一步获得的pay_info中的参数，[参考文档](https://pay.weixin.qq.com/wiki/doc/api/jsapi_sl.php?chapter=7_7&index=6)
3. 用户输入支付密码确认支付
4. 系统通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)


### 微信小程序支付 wechat.jsminipg 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"wechat.jsminipg",
	"mch_trade_id":"alextest.jsminipg.19",
	"total_fee": 3,
	"spbill_create_ip":"127.0.0.1",
	"body":"Alex Test jsminipg",
	"sub_appid":"wx758379be100f9991",
	"sub_openid":"o2uCJ5RGOOylP75Ipvncazz0bFAI"
}
```

> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"prepay_id": "wx01231242671738eafc7c4ce10632795388",
		"trade_id": "5b38ef6a01c9113d0cc907aa",
		"mch_trade_id": "alextest.jsminipg.19",
		"merchant_id": "5399355381712172",
		"pay_info": "{\"appId\":\"wx758379be100f9991\",\"timeStamp\":1530457962,\"nonceStr\":\"5b38ef6a01c9113d0cc907ac\",\"package\":\"prepay_id=wx01231242671738eafc7c4ce10632795388\",\"signType\":\"MD5\",\"paySign\":\"052f1f7098d4c70a9e5244990a9d7391\"}"
	}
}
```

用户在微信小程序中使用微信支付的场景

Body需增加请求参数

参数|	描述
--|--
sub_appid <br> **必填** <br> `string` | 与发起支付商户主体一致的小程序APPID
sub_openid <br> **必填** <br> `string` | 用户在商户appid下的唯一标识，下单前需要调用[网页授权获取用户openid接口文档](https://developers.weixin.qq.com/miniprogram/dev/api/api-login.html)接口获取到用户的Openid

开发说明：

1. 用户在商户小程序中点击使用微信支付
2. 商户系统后台调用统一支付接口，获取pay_info信息
2. 商户系统前端调用：小程序调起支付API，输入上一步获得的pay_info中的参数，[参考文档](https://pay.weixin.qq.com/wiki/doc/api/wxa/wxa_sl_api.php?chapter=7_7&index=5)
3. 用户输入支付密码确认支付
4. 系统通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)

### 微信APP支付 wechat.app 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"wechat.app",
	"mch_trade_id":"alextest.app.18",
	"total_fee": 3,
	"spbill_create_ip":"127.0.0.1",
	"body":"Alex Test app",
	"notify_url":"http://112.74.184.236:3006/fake-recv",
	"sub_appid":"wx2fbcb61b6e5b1384"
}
```

> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"prepay_id": "wx01231852292289b6404b67123767183767",
		"trade_id": "5b38f0dc01c9113d0cc907ae",
		"mch_trade_id": "alextest.app.18",
		"merchant_id": "5399355381712172",
		"pay_info": "{\"appid\":\"wx2fbcb61b6e5b1384\",\"partnerid\":\"1507497331\",\"prepayid\":\"wx01231852292289b6404b67123767183767\",\"package\":\"Sign=WXPay\",\"noncestr\":\"5b38f0dc01c9113d0cc907b0\",\"timestamp\":1530458332,\"sign\":\"a4aea5fff088a73d18e4afc8da663615\"}"
	}
}
```

APP支付是指商户通过在移动端应用APP中集成开放SDK调起微信支付模块来完成支付。适用于在移动端APP中集成微信支付功能的场景。

Body需增加请求参数

参数|	描述
--|--
sub_appid <br> **必填** <br> `string` | 商户在微信开放平台上申请的APPID，开发平台认证主体需与商户主体一致

开发说明：

1. 用户在商户APP中点击使用微信支付
2. 商户系统后台调用统一支付接口，获取pay_info信息
2. 商户系统前端调用：APP调起支付，输入上一步获得的pay_info中的参数，[参考文档](https://pay.weixin.qq.com/wiki/doc/api/app/app_sl.php?chapter=9_12&index=2)
3. 用户输入支付密码确认支付
4. 系统通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)

### 微信H5支付 wechat.wap 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"wechat.wap",
	"mch_trade_id":"alextest.app.22",
	"total_fee": 3,
	"spbill_create_ip":"127.0.0.1",
	"body":"Alex Test app",
	"mch_app_type": "WAP",
	"mch_app_name":"普尔商城",
	"mch_app_id":"https://store.pooul.com/"
}
```

微信H5支付是指商户在微信客户端外的移动端网页展示商品或服务，用户在前述页面确认使用微信支付时，商户发起本服务呼起微信客户端进行支付。 主要用于触屏版的手机浏览器请求微信支付的场景。可以方便的从外部浏览器唤起微信支付。


Body需增加请求参数

参数|	描述
--|--
mch_app_type <br> **必填** <br> `string` | 发起支付的应用类型，<br>IOS：IOS APP，<br>AND：Android APP, <br>WAP：手机网站 
mch_app_name <br> **必填** <br> `string` | APP为：应用名称，手机网站为：网站名称
mch_app_id <br> **必填** <br> `string` | IOS APP为：bundle_id，如：com.tencent.wzryIOS，<br>Android APP为package_name，如：com.tencent.tmgp.sgame，<br>WAP为网站首页地址，如：https://store.pooul.com/

开发说明：

1. 用户在商户手机网站中点击使用微信支付
2. 商户系统后台调用统一支付接口，获取支付跳转链接 mweb_url
3. 商户前端跳转至 mweb_url
4. 用户输入支付密码确认支付
4. 系统通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)

### 支付宝扫码支付 alipay.scan 

```
Post /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
	"pay_type":"alipay.scan",
	"mch_trade_id":"alextest.alipay.scan.211",
	"total_fee": 7622,
	"notify_url":"http://112.74.184.236:3006/fake-recv",
	"body":"This's Subjects Alex test",
	"store_id":"9527"
}
``` 

> 响应

```json
{
	"code": 0,
	"msg": "10000,Success",
	"data": {
		"code_url": "https://qr.alipay.com/bax05219xy73fxcgfi7w206f",
		"trade_id": "5b66a66801c9113e972bb7f3",
		"mch_trade_id": "alextest.alipay.scan.210",
		"merchant_id": "1333259781809471",
		"pay_type": "alipay.scan",
		"trade_state": 6,
		"trade_info": "支付中, 10000,Success"
	}
}

``` 

收银员通过收银台或商户后台调用支付宝接口，生成二维码后，展示给用户，由用户使用支付宝扫描二维码完成订单支付。

开发说明：

1. 调用统一支付接口，获取 code_url 信息
2. 商户后台系统根据返回的 code_url 生成二维码，并展示给顾客
3. 用户打开支付宝“扫一扫”扫描二维码，输入支付密码确认支付
4. 平台通过发送异步消息通知商户后台系统支付结果，如未收到通知，调用[查询订单API](#query)

## 查询订单 Query

> Post /v2/pay/query?merchant_id=5399355381712172

```json
{
    "mch_trade_id":
}
```
> 响应

``` 
{
	"code":0,
	"msg":"success",
	"data":{
		……	
	}
}

``` 


该接口提供所有支付订单的查询，商户可以通过查询订单接口主动查询订单状态，完成下一步的业务逻辑。

需要调用查询接口的情况：

- 当商户后台、网络、服务器等出现异常，商户系统最终未接收到支付通知；
- 调用支付接口后，返回系统错误或未知交易状态情况；
- 调用反扫支付API，返回支付中的状态；
- 调用关单或撤销接口API之前，需确认支付状态；

以trade_state确认支付状态，[状态码](#trade_state)

请求方式：Post /v2/pay/query?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数|	描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL

## 关闭订单 Close

>  Post /v2/pay/close?merchant_id=5399355381712172

```json
{
	"mch_trade_id": #商户订单号
	"nonce_str": #随机字符串
}
``` 
> 响应

```json
{
	"code": 0为成功，非0为失败
	"msg":
}

```

以下情况需要调用关单接口：

- 商户订单支付失败需要生成新单号重新发起支付，要对原订单号调用关单，避免重复支付；
- 系统下单后，用户支付超时，系统退出不再受理，避免用户继续，请调用关单接口。

注意：订单生成后不能马上调用关单接口，最短调用时间建议间隔为5分钟。

请求方式：Post /v2/pay/close?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数|	描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL

## 撤销订单 Reverse

> Post /v2/pay/reverse?merchant_id=5399355381712172


```json
{
	"mch_trade_id": #商户订单号
	"nonce_str": #随机字符串
}
``` 
> 响应

```json
{
	"code": 0为成功，非0为失败
	"msg":
}

```
支付交易返回失败或支付系统超时，调用该接口撤销交易。如果此订单用户支付失败，支付渠道会将此订单关闭；如果用户支付成功，支付渠道会将此订单资金退还给用户。

注意：7天以内的交易单可调用撤销，其他正常支付的单如需实现相同功能请调用申请退款API。提交支付交易后调用【查询订单API】，没有明确的支付结果再调用【撤销订单API】。

调用支付接口后请勿立即调用撤销订单API，建议支付后至少15s后再调用撤销订单接口。

可用支付渠道：微信支付、支付宝

请求方式：Post /v2/pay/reverse?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数|	描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL

## 申请退款 Refund

> Post /v2/pay/refund?merchant_id=5399355381712172

```json
{
	"mch_trade_id":"alextest.scan.112",
	"refund_fee":8872,
	"refund_desc":"Alex Test",
	"notify_url":"http://112.74.184.236:3006/fake-recv"
}
``` 
> 响应

```json
{
	"code": 0为成功，非0为失败
	"msg":
}

```

接口说明
- 当交易发生之后一段时间内，由于买家或者卖家的原因需要退款时，卖家可以通过退款接口将支付款退还给买家，支付渠道将在收到退款请求并且验证成功之后，按照退款规则将支付款按原路退到买家帐号上。
- 交易超过约定时间的订单无法进行退款
- 退款支持单笔交易分多次退款，多次退款需要提交原支付订单的商户订单号和设置不同的退款单号。
- 一笔退款失败后重新提交，要采用原来的退款单号。
- 总退款金额不能超过用户实际支付金额
- 退款有一定延时，用零钱支付的退款20分钟内到账，银行卡支付的退款3个工作日后重新查询退款状态。

注意 

1. 微信支付交易时间超过一年的订单无法提交退款，支付宝为签约时设置的可退款时间 
2. 微信支付每个支付订单的部分退款次数不能超过50次

请求方式：Post /v2/pay/refund?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数|	描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
refund_fee <br> **必填** <br> `int` | 退款金额，单位为分
refund_desc <br> **必填** <br> `string` | 退款原因
notify_url <br> **选填** <br> `string` | 异步接收退款结果通知的回调地址，通知URL必须为外网可访问的url，不允许带参数
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL

## 退款查询 Refund query

> Post /v2/pay/refund_query?merchant_id=5399355381712172

```json
{
	"mch_trade_id":"alextest.scan.112"
}
``` 
> 响应

```json
{
	"code": 0,
	"msg": "success",
	"data": {
		"cash_fee": 9872,
		"out_trade_id": "4200000114201806284156184664",
		"total_fee": 9872,
		"trade_id": "5b34b9a901c9112ae61fb8bc",
		"mch_trade_id": "alextest.jsapi.33",
		"merchant_id": "5399355381712172",
		"pay_type": "wechat.jsapi",
		"trade_state": 1,
		"trade_info": "转入退款, ",
		"refunds": [
			{
				"refund_id": "5b34ba3d01c9112ae61fb8c1",
				"refund_fee": 5,
				"refund_state": 0
			},
			{
				"refund_id": "5b34ba4501c9112ae61fb8c3",
				"refund_fee": 100,
				"refund_state": 0
			},
			{
				"refund_id": "5b34ba4f01c9112ae61fb8c5",
				"refund_fee": 1283,
				"refund_state": 0
			},
			{
				"refund_id": "5b34ba5b01c9112ae61fb8c7",
				"refund_fee": 4332,
				"refund_state": 0
			}
		]
	}
}
```
提交退款申请后，通过调用该接口查询退款状态。退款有一定延时，用零钱支付的退款20分钟内到账，银行卡支付的退款3个工作日后重新查询退款状态。

注意：如果单个支付订单部分退款次数多次时使用商户订单号查询会返回多条退款记录

请求方式：Post /v2/pay/refund_query?

URL请求参数

参数|	描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数|	描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL


## 支付结果通知 Pay notify

支付完成后，系统会把相关支付结果和用户信息发送给商户，商户需要接收处理，并需要响应字符串"success"（大小写皆可）。

对后台通知交互时，如果微信收到商户的应答不是成功或超时，系统认为通知失败，系统会通过一定的策略定期重新发起通知，尽可能提高通知的成功率，但系统不保证通知最终能成功。 （通知频率为15/15/30/180/1800/1800/1800/1800/3600，单位：秒）

注意：同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。
推荐的做法是，当收到通知进行处理时，首先检查对应业务数据的状态，判断该通知是否已经处理过，如果没有处理过再进行处理，如果处理过直接返回结果成功。在对业务数据进行状态检查和处理之前，要采用数据锁进行并发控制，以避免函数重入造成的数据混乱。

特别提醒：商户系统对于支付结果通知的内容一定要做签名验证,并校验返回的订单金额是否与商户侧的订单金额一致，防止数据泄漏导致出现“假通知”，造成资金损失。

## 退款结果通知 Refund notify

退款成功后系统会将退款成功状态发给商户，商户需要接收处理，方式与支付结果通知一样






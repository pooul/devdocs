# 收款

## 请求支付


### 公共请求参数

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

参数|	描述
--|--
pay_type <br> **必填** <br> `string` | 支付类型，[查看支付类型编码](#pay-type)
nonce_str  <br> **必填** <br> `string` | 随机字符串
mch_trade_id <br> **必填** <br> `string` | 商户订单号，在同一个merchant_id 下每次请求必须为唯一
total_fee  <br> **必填** <br> `int` | 支付总金额，单位为分
spbill_create_ip <br> **选填** <br> `string` | 发起支付的终端IP，APP、jsapi、jsminipg、wap支付提交用户端ip，scan、micro支付填调用支付API的服务端IP。微信支付必填、支付宝选填
notify_url  <br> **选填** <br> `string` | 支付结果通知地址
time_start  <br> **选填** <br> `int` | 订单开始时间，为10位 UNIX 时间戳
time_expire  <br> **选填** <br> `int` | 订单失效时间，为10位 UNIX 时间戳
device_info  <br> **选填** <br> `string` | 设备编号
op_user_id  <br> **选填** <br> `string` | 操作员编码




### common.micro 统一反扫支付

包含微信刷卡支付、支付宝付款码支付，此模式下商家扫码消费者付款码

> 请求

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

增加请求参数


参数|	描述
--|--
auth_code <br> **必填** <br> `string` | 微信支付或支付宝支付授权码


### wechat.scan 微信扫码支付

> 请求

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


请将接收到的 code_url 提供给前端生成二维码展示给客户扫码

### wechat.jsapi 微信公众号支付

> 请求

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

### wechat.jsminipg 微信小程序支付

> 请求

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

### wechat.app 微信APP支付

> 请求

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

### wechat.wap 微信H5支付


## 查询订单

> Post /v2/pay/query?merchant_id=#{merchant_id} 

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

## 关闭订单

>  Post /v2/pay/close?merchant_id=#{merchant_id} 

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

## 撤销订单

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

## 申请退款

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

## 退款查询

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

## 下载对账单

认证方式：基于Login权限，[查看Login认证说明](#login)

### 日对账单

> Get /cms/pooul_bills/download_by_date?merchant_id=5399355381712172&bill_date=20180628

get /cms/pooul_bills/download_by_date

下载当前商户不需要merchant_id参数，下载下级商户对账单在网址后加上 merchant_id 参数

### 对账单格式

#### 明细文件格式：
成功时，数据以文本表格的方式返回，第一行为表头，后面各行为对应的字段内容，字段内容跟查询订单或退款结果一致，具体字段说明可查阅相应接口。

第一行为表头：
创建时间 付款完成时间 支付单号 商户单号 原始单号 支付类型 商户编号 支付状态 结算状态 付款总金额 代金券金额 结算手续费率 结算手续费 应结算金额 退款单号 退款金额 代金券退款金额 退款状态 退款完成时间 订单标题(兼容支付宝) 商品描述 商家数据包 设备编号 操作员编号 公众号APPID 付款人信息 付款银行 货币种类

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。

#### 汇总文件格式：
第一行为表头：
总订单笔数 总交易金额 结算手续费总金额 应结算总金额 总退款金额

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。


## 支付结果通知

支付完成后，系统会把相关支付结果和用户信息发送给商户，商户需要接收处理，并需要响应字符串"success"（大小写皆可）。

对后台通知交互时，如果微信收到商户的应答不是成功或超时，系统认为通知失败，系统会通过一定的策略定期重新发起通知，尽可能提高通知的成功率，但系统不保证通知最终能成功。 （通知频率为15/15/30/180/1800/1800/1800/1800/3600，单位：秒）

注意：同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。
推荐的做法是，当收到通知进行处理时，首先检查对应业务数据的状态，判断该通知是否已经处理过，如果没有处理过再进行处理，如果处理过直接返回结果成功。在对业务数据进行状态检查和处理之前，要采用数据锁进行并发控制，以避免函数重入造成的数据混乱。

特别提醒：商户系统对于支付结果通知的内容一定要做签名验证,并校验返回的订单金额是否与商户侧的订单金额一致，防止数据泄漏导致出现“假通知”，造成资金损失。

## 退款结果通知

退款成功后系统会将退款成功状态发给商户，商户需要接收处理，方式与支付结果通知一样






## 5.6 微信APP支付
pay_type：wechat.app		
异步通知：是

### 5.6.1 统一下单API
#### 业务功能

该接口接收支付请求, 生成支付请求并返回给接入商, 接入商调起APP支付接口进行支付。

#### 交互模式

- 请求：后台请求交互模式 
- 返回结果&通知：后台响应(response)+后台通知(notify)（notify需自行测试字段）



#### 请求参数列表
POST json 内容体进行请求

>POST 请求示例

```javascript
{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"6219365181578068",
    "pay_type":"wechat.app",
    "mch_trade_id":"1505197223",
    "time_start":1505197223,
    "body":"小胖饮食",
    "total_fee":1,
    "spbill_create_ip":"127.0.0.1",
    "settle_type": 1,
    "notify_url":"http://pooul.ngrok.cc/notify"
}

```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
交易类型  | pay_type | 是 | String | 接口类型：wechat.app
商户号 | merchant_id	| 是|String |商户号，由平台分配
商户订单号 | mch_trade_id	| 是	|String	|商户系统内部的订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
商品描述| body	|是	|String |	商品描述, 将会出现在客户支付结果页面中, 例:"心相印纸巾X2"
终端IP	|	 spbill_create_ip	|	是	|	String	|	订单生成的机器 IP	
总金额|	total_fee |	是	|Int	|总金额，以分为单位，整数，不允许包含任何字母、符号
通知地址 |notify_url|	是	|String |	接收平台异步通知的URL，需给绝对路径，255字符内格式
订单发起时间|time_start|否|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。 
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
是否采用D0通道|settle_type|否|Int|非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是
是否采用D0通道|settle_type|否|Int|非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是
应用ID |sub_appid |String| 是 |wx8888888888888888 微信开放平台审核通过的应用APPID


#### 响应参数列表(response)

>返回示例

```javascript
{
    "code": 0,
    "msg": "OK",
    "data": {
        "result_code": 0,
        "ch_trade_id": "O20171101154048560105682",
        "pay_info": "{\"noncestr\":\"59f97a80ffea0e11725a4ad5\",\"package\":\"Sign=WXPay\",\"partnerid\":\"49770166\",\"prepayid\":\"wx20171101154048fe66f386030799898150\",\"appid\":\"wx88888888888888880\",\"sign\":\"2561DA*********6B832574A\",\"timestamp\":\"1509522048\"}",
        "prepay_id": "wx20171101154048fe66f386030799898150",
        "trade_id": "59f97a80ffea0e11725a4ad4",
        "mch_trade_id": "1509522043",
        "merchant_id": "6219365181578068",
        "pay_type": "wechat.app",
        "nonce_str": "59f97a80ffea0e11725a4ad7"
    },
```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
返回状态码|	code |	是 |	String | 0表示成功，非0表示失败。 此字段为通信标识
返回信息 | msg |是|String|	返回信息，如成功则为空;如非空, 显示错误原因
商户号|	merchant_id	|是	|String |	商户号，由平台分配
交易类型  | pay_type | 是 | String | 接口类型：wechat.jswap
随机字符串|	nonce_str |	否	|String |	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
签名类型|sign_type|是|string|默认MD5
版本号|version|是|string|默认1.0
交易耗时|time_elapsed|否|string|交易消耗时间

- 以下字段在code为0时返回

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
微信专用单号|prepay_id|否|String|唤起APP支付的凭证
上游渠道订单号|ch_trade_id|是|String|上游渠道订单号
商户订单号|mch_trade_id|是|String|平台订单号
平台订单号|trade_id|是|String|平台订单号
支付信息|pay_info|是|String|详见5.6.2


### 5.6.2 调起支付

#### 交互模式
- 请求：后台请求交互模式
- 返回结果&通知：后台响应(response)+后台通知(notify)

#### 说明
- 在APP里面中执行JS调起支付。接口输入输出数据格式为JSON。
- 列表中参数名区分大小写，大小写错误签名验证会失败。
- 接口需要注意：所有传入参数都是字符串类型！使用JavaScript、PHP 等弱类型语言需要关注一下。

#### 请求参数列表（getBrandWCPayRequest参数以及返回值定义）


字段名|变量名|必填|类型|说明
---|---|---|---|---
应用ID |appid |String  | 是 |对应初始化请求中返回的pay_info中的信息	
时间戳	|	timeStamp	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
随机字符串	|	nonceStr	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
订单详情扩展字符串	|	package	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
签名方式	|	signType	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
签名	|	paySign	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	

#### 响应参数列表（err_msg返回结果值说明）

返回值|说明|
---|---
err_msg | get_brand_wcpay_request:ok 支付成功
err_msg | get _brand_wcpay_request:cancel 支付过程中用户取消
err_msg | get_brand_wcpay_request:fail 支付失败


### 5.6.3 JS支付通知API


- 通知 URL 是初始化请求接口中提交的参数 notify_url，支付完成后，平台会把相关支付和用户信息发送到该 URL，商户需要接收处理信息。
- 对后台通知交互时，如果平台收到商户的应答不是纯字符串success或超过5秒后返回时，平台认为通知失败，平台会通过一定的策略（如3小时共10次）间接性重新发起通知，尽可能提高通知的成功率，但不保证通知最终能成功。
- 由于存在重新发送后台通知的情况， 因此同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。
- 推荐的做法是， 当收到通知进行处理时， 首先检查对应业务数据的状态， 判断该通知是否已经处理过， 如果没有处理过再进行处理， 如果处理过直接返回结果成功。 在对业务数据进行状态检查和处理之前， 要采用数据锁进行并发控制， 以避免函数重入造成的数据混乱。
- 特别注意：商户后台接收到通知参数后，要对接收到通知参数里的订单号out_trade_no和订单金额total_fee和自身业务系统的订单和金额做校验，校验一致后才更新数据库订单状态

#### 通知结果参数列表

后台通知通过请求中的notify_url进行， post

> notify示例

```javascript
{
	"code":0,
	"msg":null,
	"data":{
		"out_trade_id":"4003542**********4971353133",
		"ch_trade_id":"75529100**********8074251786016",
		"bank_type":"CFT",
		"fee_type":"CNY",
		"is_subscribe":"N",
		"openid":"oMJG**********XGyly02xI",
		"sub_appid":"wx26**********bfa99df7",
		"sub_openid":"oRXdVs**********u2FrzMUQo",
		"total_fee":1,
		"sub_is_subscribe":"Y",
		"trade_state":0,
		"trade_id":"59880c77fd4eb00a**********a20",
		"attach":"150**********212",
		"mch_trade_id":"1**********212",
		"merchant_id":"59382e3cf**********0cfc3e",
		"pay_type":"wechat.jsapi"
	},
	"version":"1.0",
	"sign_type":"md5",
	"sign":"F728E9BF73A3**********61FFD19273"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	是	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg|	是	|	String|	返回信息，如非空，为错误原因签名失败参数格式校验错误


-  以下字段在 code 为 0 的时候有返回	
  

字段名|变量名|必填|类型|说明
---|---|---|---|---
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
错误代码	|	err_code	|	否	|	String	|	参考错误码
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
用户标识	|	openid	|	是	|	String|	用户在商户 appid 下的唯一标识
交易类型	|	pay_type	|	是	|	String	|	wechat.jsapi
是否关注公众账号	|	is_subscribe	|	是	|	String	|	用户是否关注公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
上游渠道订单号 | ch_trade_id | 否 | String | 上游渠道订单号
子商户是否关注	|	sub_is_subscribe	|	否	|	String	|	用户是否关注子公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效
子商户appid	|	sub_appid	|	是	|	String	|	子商户appid
用户openid	|	sub_openid	|	是	|	String	|	用户在商户 sub_appid 下的唯一标识
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间 |	time_end	|	是	|	Int	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
交易耗时 |	time_elapsed |	否 |	string |	交易消耗时间
货币种类 |	fee_type |	否 | String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY

#### 后台通知结果反馈
平台服务器发送通知，post发送JSON数据流，商户notify_Url地址接收通知结果，商户做业务处理后，需要以纯字符串的形式反馈处理结果，内容如下：

返回结果|结果说明
---|---
success|处理成功，平台收到此结果后不再进行后续通知
fail或其它字符|处理不成功，平台收到此结果或者没有收到任何结果，系统通过补单机制再次通知



### 5.6.4 订单查询API

#### 业务功能
根据商户订单号或者平台订单号查询平台的具体订单信息。


#### 交互模式
后台系统调用交互模式


#### 请求参数列表（getBrandWCPayRequest参数以及返回值定义）

POST json 内容体进行请求

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3	

#### 响应参数列表（err_msg返回结果值说明）

> 查询示例

```javascript
{
	"code":0,
	"msg":null,
	"data":{
		"out_trade_id":"40035420********71353133",
		"ch_trade_id":"755291********4251786016",
		"appid":"wx********94369d",
		"bank_type":"CFT",
		"fee_type":"CNY",
		"is_subscribe":"N",
		"openid":"oMJ********Gyly02xI",
		"sub_appid":"wx26a****************a99df7",
		"sub_openid":"oRXd********wuPysxMUYu2FrzMUQo",
		"total_fee":1,
		"sub_is_subscribe":"Y",
		"trade_state":0,
		"trade_id":"59880c77fd4e********085a20",
		"attach":"150********212",
		"mch_trade_id":"150********212",
		"merchant_id":"59382e3cf********fcd0cfc3e",
		"pay_type":"wechat.jsapi"
	},
	"version":"1.0",
	"sign_type":"md5",
	"sign":"00077********4E23D65EA47DB471"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String|	版本号，version默认值是1.0。		
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5		
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识，交易是否成功需要查看 trade_state 来判断		
返回信息	|	msg	|	是	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误


- 以下字段在 code 为 0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---	
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配		
设备号	|	device_info	|	否	|	String	|	平台支付分配的终端设备号		
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位		
错误代码	|	err_code	|	否	|	String	|	参考错误码		
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述		
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
交易状态	|	trade_state	| 是	|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)		


-  以下字段在 trade_state为0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易类型	|	pay_type	|	是	|	String	|	wechat.jsapi		
用户标识	|	openid	|	是	|	String	|	用户在商户 appid 下的唯一标识		
是否关注公众账号	|	is_subscribe	|	是	|	String	|	用户是否关注公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效		
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
第三方订单号	|	out_trade_id	|	否|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号（支付成功后会返回，没支付则不会）		
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号		
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额		
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY		
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回		
付款银行	|	bank_type	|	否	|	String	|	银行类型		
银行订单号 | bank_billno | 否 | String | 银行订单号，若为微信支付则为空
支付完成时间 | time_end |	 是 | Int |	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
货币种类 |	fee_type |	否	| String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
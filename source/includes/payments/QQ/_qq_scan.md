# 7.QQ钱包

## 7.1 QQ钱包扫码支付（正扫)
pay_type： qq.scan
异步通知：是	

### 7.1.1 提交刷卡支付API

#### 业务功能
 收银员使用扫码设备读取微信用户刷卡授权码以后，二维码或条码信息传送至商户收银台，由商户收银台或者商户后台调用该接口发起支付对用户进行收款

#### 交互模式
- 请求：后台请求交互模式
- 返回结果：后台请求交互模式

#### 请求参数列表
POST json 内容体进行请求

 > 请求示例

 ```javascript
{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59382e3******d0cfc3e",
    "pay_type":"qq.scan",
    "mch_trade_id":"alex.qq.1******3",
    "time_start":1******3,
    "device_info":"QQ******83",
    "body":"天虹龙华店-食品",
    "total_fee":1,
    "spbill_create_ip":"127******.1",
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/qq.1497******73"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易类型	|	pay_type	|	是	|	String	|	接口类型：qq.scan
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|mch_trade_id	|	是	|	String	|	商户系统内部的订单号,5到32个字符、只能包含字母数字或者下划线，区分大小写，确保在商户系统唯一
设备号	|	device_info	|	是	|	String	|	终端设备号，商户自定义
商品描述	|	body	|	是	|	String	|	商品描述
附加信息	|	attach	|	否	|	String|	商户附加信息，可做扩展参数
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器IP
通知地址	|notify_url	|是	|String|	接收平台通知的URL，需给绝对路径
订单发起时间	|	time_start	|	否	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
订单失效时间	|	time_expire	|	否	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于32位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
采用D0通道|Is_D0|否|Int|非必须字段。采用D0接口时需添加此字段，只能为1,1=启用


#### 响应参数列表(response)

> 响应示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "code_url": "https://myun.tenpa******id=2183&t=5V2f9587c17b2a160d88d1e3a2ee7cd5",
        "trade_id": "597073d3f******3e8ba",
        "mch_trade_id": "alex.qq.143",
        "merchant_id": "59382******fc3e",
        "pay_type": "qq.scan",
        "code_img_url": "https://pay.swiftpass.cn/pay/qrcode?uuid=https%3A%2F%2Fmyun.tenpay.com%2Fmqq%2Fpay%2Fqrcode.html%3F_wv%3D1027%26_bid%3D2183%26t%3D5V31b8969a816863a217f3062059cad6"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "E6BB245******7745B7769C2"
}
```
	
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息|msg|是|String|返回信息，如非空，为错误原因签名失败参数格式校验错误


- 以下字段在code为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
查询判断	|	need_query	|	否	|	String	|	用来判断是否需要调用查询接口，值为Y时需要，值为N时不需要
二维码链接 |	code_url |	是	| String | 商户可用此参数自定义生成二维码后,展示进行扫码支付
平台订单号 |	trade_id |	是 |	String |	平台订单号
商户订单号 |	mch_trade_id |	是 |	String |	商户系统内部的定单号，32个字符内、可包含字母
交易类型 |	pay_type |	是 |	String |	qq.scan
二维码图片 | code_img_url | 是 | String 此参数的值即是根据code_url生成的可以扫码支付的二维码图片地址


### 7.1.2  通知API

- 通知 URL 是支付API中提交的参数 notify_url，支付完成后，平台会把相关支付和用户信息发送到该 URL，商户需要接收处理信息。
- 对后台通知交互时，如果平台收到商户的应答不是纯字符串success或超过5秒后返回时，平台认为通知失败，平台会通过一定的策略（如3小时共10次）间接性重新发起通知，尽可能提高通知的成功率，但不保证通知最终能成功。由于存在重新发送后台通知的情况， 因此同样的通知可能会多次发送给商户系统。 商户系统必须能够正确处理重复的通知。
- 推荐的做法是， 当收到通知进行处理时， 首先检查对应业务数据的状态， 判断该通知是否已经处理过， 如果没有处理过再进行处理， 如果处理过直接返回结果成功。 在对业务数据进行状态检查和处理之前， 要采用数据锁进行并发控制， 以避免函数重入造成的数据混乱。
- 特别注意：商户后台接收到通知参数后，要对接收到通知参数里的订单号 out_trade_no 和订单金额 total_fee 和自身业务系统的订单和金额做校验，校验一致后才更新数据库订单状态

#### 通知结果参数列表
后台通知通过请求中的notify_url进行， post方式返回Json数据流




字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识
返回信息	|	msg	|	否	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误


- 以下字段在 code 为 0的时候有返回	

>返回示例

```javascript
{
	"code":0,
	"msg":null,
	"data":{
		"result_code":0,
		"out_trade_id":"13590497*********807262",
		"ch_trade_id":"75*********939",
		"bank_type":"CFT",
		"fee_type":"CNY",
		"total_fee":1,
		"trade_state":0,
		"trade_id":"59e01*********b907",
		"attach":"111",
		"mch_trade_id":"15*********88",
		"merchant_id":"59*********3e",
		"pay_type":"qq.scan",
		"nonce_str":"59e0*********d58"
	}
```							

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	平台支付分配的终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位
错误代码	|	err_code	|	否	|	String	|	参考错误码
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
交易类型	|	pay_type	|	是	|	String	|	qq.scan
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
货币种类	|	fee_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为手Q支付则为空
支付完成时间	|	time_end	|	是	|	String	|	时间戳：，自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。

#### 后台通知结果反馈
平台服务器发送通知，post发送JSON数据流，商户notify_Url地址接收通知结果，商户做业务处理后，需要以纯字符串的形式反馈处理结果，内容如下：

返回结果|结果说明
---|---
success|处理成功，平台收到此结果后不再进行后续通知
fail或其它字符|处理不成功，平台收到此结果或者没有收到任何结果，系统通过补单机制再次通知


### 7.1.3 查询订单API

#### 业务功能
 根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
后台系统调用交互模式

#### 请求参数列表
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易类型	|	pay_type	|	否	|	String	|接口类型：qq.scan
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3

#### 响应参数列表(response)

> 查询示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "out_trade_id": "13590497******308728",
        "ch_trade_id": "755291******28130",
        "bank_type": "2******2",
        "fee_type": "1",
        "total_fee": 13,
        "trade_state": 0,
        "trade_id": "597******03e8bf",
        "mch_trade_id": "alex.qq.1******2",
        "merchant_id": "59382e3******cfc3e",
        "pay_type": "qq.micro"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "A9A9******767717A6F99B"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg	|	是	|	String	|	返回信息，成功时为空，如非空，错误原因为签名失败或参数格式校验错误


- 以下字段在code为0的时候有返回	

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
交易状态	|	trade_state	| 是	|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
交易类型	|	pay_type	|	是	|	String	|	qq.scan
用户标识	|	openid	|	是	|	String	|	用户在商户 appid 下的唯一标识
是否关注公众账号	|	is_subscribe	|	是	|	Int	|	用户是否关注公众账号，0-关注，1-未关注，仅在公众账号类型支付有效
平台订单号	|	trade_id	|	是	|	String	|	平台交易号		
第三方订单号	|	out_trade_id	|	否	|	String	|	第三方订单号（支付成功后会返回，没支付则不会）		
商户订单号	|	mch_trade_id		|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
上游渠道订单号 | ch_trade_id | 否 | String | 上游渠道订单号
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类	|	fee_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为手Q支付则为空
支付完成时间	|	time_end	|	是	|	String	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)
交易类型	| pay_type | 	是 |	String |	qq.scan


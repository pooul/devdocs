## 6.3 支付宝服务窗支付
pay_type： alipay.jsapi
异步通知：是	

### 6.3.1 统一下单API

#### 业务功能
 - 请求：后台请求交互模式
 - 返回结果&通知：后台响应(response)+后台通知(notify)

#### 交互模式
请求：后台请求交互模式
返回结果：后台请求交互模式

#### 请求参数列表
POST JSON 内容体进行请求

>请求示例

```javascript
{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59382e3cffe*************",
    "pay_type":"alipay.jsapi",
    "mch_trade_id":"alex.alipay.***********",
    "time_start":14969 09734,
    "body":"天虹龙华店-食品",
    "attach":"非零售",
    "total_fee":12,
    "spbill_create_ip":"127.0.0.1",
    "buyer_id":"20880***********",
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/alipay.***********"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
业务参数	|		|		|		|	
交易类型	|	pay_type	|	是	|	String	|	接口类型：alipay.jsapi
版本号	|	version	|	否	|	String	|	版本号：version默认是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5 默认MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的订单号，32个字符内、可包含字母，确保在商户系统唯一
设备号	|	device_info	|	否	|	String	|	终端设备号
商品描述	|	body	|	是	|	String	|	商品描述
附加信息	|	attach	|	否	|	String	|	商户附加信息，可做拓展参数
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器IP
通知地址	|	notify_url	|	是	|	String	|	接收平台通知的URL，需给绝对路径，255字符内格式
限制信用卡	|	limit_pay	|	否	|	String	|	限定用户使用微信支付时能否使用信用卡，值为1，禁用信用卡，值为0或者不传此参数则不禁用
订单发起时间|	time_start	|	否	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
订单失效时间	|	time_expire	|	否	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
操作员	|	op_user_id	|	否	|	String	|	操作员账号，默认为商户号
商品标记	|	goods_tag	|	否	|	String	|	商品标记，用于优惠券或者满减使用
商品ID	|	product_id	|	否	|	String	|	预留字段，此ID为静态可打印的二维码包含的商品ID，商户自行维护
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于32位
买家支付宝账号	|	buyer_logon_id	|	否	|	String	|	买家支付宝账号，和buger_id不能同时为空
买家支付宝用户ID	|	buyer_id	|	否	|	String	|	买家支付宝用户ID，和buyer_logon_id不能同时为空
签名	|	sign	|	是	|	String	|	MD签名结果，详见签名算法
是否采用D0通道 | settle_type | 否 | Int | 非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是



#### 响应参数列表(response)
数据按JSON的格式实时返回

>返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "transaction_id": "593907d5***********",
        "mch_trade_id": "alex.alipay.***********",
        "appid": "20160***********",
        "token_id": "1376322f9abcaf31a192eaaffbfe48610"
    },
    "time_elapsed": 0.2655,
    "version": "1.0",
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5 默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败 此字段是通信标识，非交易标识
返回信息	|	msg	|	是	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误



- 以下字段在code为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String|	平台支付分配的终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	参考错误码
错误代码描述	|	err_msg	|	否	|	String|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
支付链接	|	pay_url	|	否	|	String	|	直接使用此链接请求支付宝支付
第三方订单号 |	out_trade_id |	否 |	String	| 第三方订单号（支付成功后会返回，没支付则不会）
商户订单号 |	mch_trade_id |	是 | String |	| 商户系统内部的定单号，32个字符内、可包含字母
公众号appid |	appid |	否 |	String |	服务商公众号appid
调用财付通后台接口生成的订单号  | Token_Id | 否  | String | 调用财付通后台接口生成的订单号
交易耗时 |	time_elapsed |	否 |	string |	交易消耗时间
平台订单号 |	trade_id |	是 |	String |	平台订单号
交易耗时 |	time_elapsed |	否 |	string |	交易消耗时间


* 商户请求统一下单接口同步返回结果如下：

> 当商户自行组装界面唤起支付宝支付时，步骤如下：

```javascript 
{
"appid"=>"2016070101572274",
 "charset"=>"UTF-8",
 "merchant_id"=>"7551000001",
 "pay_url"=>"http://url.cn/pay/prepay?token_id=40c470dfa1b1c11a7e128588429b0479&pay_type=alipay.jsapi",
 "sign"=>"86C8FE88A48E9A45E43563050DCFD391",
 "sign_type"=>"MD5",
 "code"=>"0",
 "token_id"=>"40c470dfa1b1c11a7e128588429b0479",
 "version"=>"2.0"
}
```




* 在商户界面中按照如下模板组装请求参数：

```javascript 
javascirpt:
AlipayJSBrirdge.call("tradePay",{
    tradeNO: jQuery('trade_no').html()
    }, function(result){}
})
```

result.resultCode|类型|支付结果
---|---|---
'9000'|string|订单支付成功
'8000'|string|正在处理中
'4000'|string|订单支付失败
'6001'|string|用户中途取消
'6002'|string|网络连接出错
'99'|string|用户点击忘记密码快捷界面退出(only iOS since9.5)


### 6.3.2  统一下单通知API

- 通知 URL 是统一下单接口中提交的参数 notify_url，支付完成后，平台会把相关支付和用户信息发送到该 URL，商户需要接收处理信息。
- 对后台通知交互时，如果平台收到商户的应答不是纯字符串success或超过5秒后返回时，平台认为通知失败，平台会通过一定的策略（如3小时共10次）间接性重新发起通知，尽可能提高通知的成功率，但不保证通知最终能成功。
- 由于存在重新发送后台通知的情况， 因此同样的通知可能会多次发送给商户系统。==商户系统必须能够正确处理重复的通知。==
- 推荐的做法是， 当收到通知进行处理时， 首先检查对应业务数据的状态， 判断该通知是否已经处理过， 如果没有处理过再进行处理， 如果处理过直接返回结果成功。 在对业务数据进行状态检查和处理之前， 要采用数据锁进行并发控制， 以避免函数重入造成的数据混乱。

#### 通知结果参数列表
后台通知通过请求中的notify_url进行， post


```javaScript
{
    "code": 0,
    "msg": null,
    "data": {
        "result_code": 0,
        "out_trade_id": "2017101321*********3650434",
        "ch_trade_id": "755291000*********134184532820",
        "bank_type": "COUPON",
        "fee_type": "CNY",
        "openid": "20*********6615",
        "total_fee": 1,
        "buyer_logon_id": "132****5309",
        "buyer_user_id": "2088*********615",
        "fund_bill_list": "[{\"amount\":\"0.01\",\"fund*********nel\":\"COUPON\"}]",
        "trade_state": 0,
        "trade_id": "59e*********becad4",
        "mch_trade_id": "alex*********39",
        "merchant_id": "59382*********e",
        "pay_type": "alipay.jsapi",
        "nonce_str": "59e0289*********ad5e"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "BAA131C*********B6EF70"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5 默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg	|	是	|	String |	返回信息，如非空，为错误原因签名失败参数格式校验错误

- 以下字段在code为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	参考错误代码
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
用户标识	|	openid	|	否	|	String	|	用户支付宝的账号名
交易类型	|	pay_type	|	是	|	String	|	alipay.api
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
总金额	|	total_fee	|	是	|	int	|	总金额，以分为单位，不允许包含任何字、符号
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合ISO 4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
支付完成时间	|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
买家支付宝账号 |  buyer_logon_id |		否 | String |	买家支付宝账号
交易支付使用的资金渠道 |  fund_bill_list |  否 | 	String |		交易支付使用的资金渠道
买家在支付宝的用户 | id buyer_user_id | 	 否 |  String | 		买家在支付宝的用户id




#### 后台通知结果反馈
平台服务器发送通知，post发送JSON数据流，商户notify_Url地址接收通知结果，商户做业务处理后，需要以纯字符串的形式反馈处理结果，内容如下：

返回结果|结果说明
---|---
success | 处理成功，平台收到此结果后不再进行后续通知
fail或其它字符 | 处理不成功，平台收到此结果或者没有收到任何结果系统通过补单机制（再次通知）



### 6.3.3  订单查询API

#### 业务功能
根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
后台系统调用交互模式

#### 通知结果参数列表
通过POST JSON 内容体进行请求

>查询示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "transaction_id": "593907d***********",
        "out_transaction_id": "102540058***********",
        "mch_trade_id": "alex.alipay.***********",
        "time_end": 1496909853,
        "appid": "201609***********",
        "bank_type": "CREDIT_CARD",
        "buyer_logon_id": "poo***@qq.com",
        "buyer_pay_amount": "0.12",
        "buyer_user_id": "20880***********",
        "fee_type": "CNY",
        "fund_bill_list": "[{\"amount\":\"0.12\",\"fundChannel\":\"BANKCARD\",\"fundType\":\"CREDIT_CARD\"}]",
        "invoice_amount": "0.12",
        "openid": "2088***********",
        "point_amount": "0.00",
        "receipt_amount": "0.12",
        "total_fee": "12",
        "trade_state": 0,
        "pay_type": "alipay.jsapi"
    },
    "time_elapsed": 0.1498,
    "version": "1.0",
     "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3


#### 响应参数列表(response)

> 数据按JSON的格式实时返回

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "result_code": 0,
        "out_trade_id": "135*********131390893230",
        "ch_trade_id": "75529*********21739512",
        "bank_type": "CFT",
        "fee_type": "CNY",
        "total_fee": 1,
        "trade_state": 0,
        "trade_id": "59e0*********ab39",
        "mch_trade_id": "alex. *********862929",
        "merchant_id": "5938*********fcd0cfc3e",
        "pay_type": "qq.jsapi",
        "nonce_str": "5*********68dbecaf0"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识，交易是否成功需要查看trade_state来判断
返回信息	|	msg	|	是	|	String|	返回信息，如非空，为错误原因签名失败参数格式校验错误

- 以下字段在code为0的时候有返回

> 返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "result_code": 0,
        "out_trade_id": "135*********131390893230",
        "ch_trade_id": "75529*********21739512",
        "bank_type": "CFT",
        "fee_type": "CNY",
        "total_fee": 1,
        "trade_state": 0,
        "trade_id": "59e0*********ab39",
        "mch_trade_id": "alex. *********862929",
        "merchant_id": "5938*********fcd0cfc3e",
        "pay_type": "qq.jsapi",
        "nonce_str": "5*********68dbecaf0"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	平台支付分配的终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	参考错误码
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
交易状态	|	trade_state	|	是 |		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)

- 以下字段在trade_state为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
---|---|---|---|---
交易类型	|	pay_type	|	是	|	String	|	alipay.jsapi
平台订单号	|	trade_id	|	是	|	String	|	平台交易号		
第三方订单号	|	out_trade_id	|	否	|	String	|	第三方订单号（支付成功后会返回，没支付则不会）		
商户订单号	|	mch_trade_id		|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字，符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额，订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合IOS4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为支付宝支付则为空
支付完成时间	|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
买家支付宝账号 | buyer_logon_id |		否 | String |	买家支付宝账号
交易支付使用的资金渠道 | fund_bill_list |	 否 |  String |		交易支付使用的资金渠道
买家在支付宝的用户id |  buyer_user_id |	 否 |  String |		买家在支付宝的用户id
买家付款的金额	 | buyer_pay_amount |	否 | Int |		买家付款的金额	
交易中可给用户开具发票的金额 |	 invoice_amount |	否 |	 Int | 		交易中可给用户开具发票的金额	
使用积分宝付款的金额	|  point_amount |	 否 |	 Int |		使用积分宝付款的金额	
实收金额 | 	 receipt_amount |	  否 | String | 		实收金额	
交易耗时 |	time_elapsed |	否 |	 string  | 交易消耗时间
第三方订单号 |	out_trade_id |	否 |	String |	第三方订单号
货币种类 |	fee_type |	否	 | String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY


## 6.2 支付宝条码支付（反扫）
pay_type： alipay.micro
异步通知：否	

### 6.2.1 提交刷卡支付API

#### 业务功能
 收银员使用扫码设备读取微信用户刷卡授权码以后，二维码或条码信息传送至商户收银台，由商户收银台或者商户后台调用该接口发起支付对用户进行收款

#### 交互模式
请求：后台请求交互模式
返回结果：后台请求交互模式

#### 请求参数列表
POST json 内容体进行请求

> 请求示例

```javascript
{
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59382e3c********d0cfc3e",
    "pay_type":"alipay.micro",
    "mch_trade_id":"alex.alipay.14********8",
    "time_start":149********28,
    "body":"天虹龙华店-食品",
    "total_fee":3,
    "spbill_create_ip":"127.********.1",
    "auth_code":"28294********899"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易类型	|	pay_type	|	是	|	String	|	接口类型：alipay.micro
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的订单号,5到32个字符、只能包含字母数字或者下划线，区分大小写，确保在商户系统唯一
设备号	|	device_info	|	是	|	String	|	终端设备号，商户自定义。
订单标题 | subject | 是 | string | 订单标题 
商品描述	|	body	|	是	|	String|	商品描述
附加信息	|	attach	|	否	|	String|	商户附加信息，可做扩展参数
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器IP
授权码	|	auth_code	|	是	|	String	|	扫码支付授权码，设备读取用户展示的条码或者二维码信息
订单发起时间	|	time_start	|	否	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
订单失效时间	|	time_expire	|	否	|Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
操作员	|	op_user_id	|	否	|	String	|	操作员帐号,默认为商户号
门店编号	|	store_id	|	否	|	String	|	
设备编号	|	op_device_id	|	否	|	String	|	
商品标记	|	goods_tag	|	否	|	String	|	商品标记
支付场景 |	scene |	否 |	String |	条码-bar_code， 声波-wave_code，默认条码-bar_code
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于32位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
是否采用D0通道 | settle_type | 否 | Int | 非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是



#### 响应参数列表(response)

> 返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "out_trade_id": "20170********215872936",
        "ch_trade_id": "75529********767853",
        "appid": "2016********7047",
        "bank_type": "DEBIT_CARD",
        "fee_type": "CNY",
        "openid": "208802********615",
        "total_fee": 1,
        "buyer_logon_id": "132****5309",
        "buyer_pay_amount": "0.01",
        "buyer_user_id": "20880********15",
        "fund_bill_list": "[{\"amount\":\"0.01\",\"fundC********",\"fundType\":\"DEBIT_CARD\"}]",
        "invoice_amount": "0.01",
        "point_amount": "0.00",
        "receipt_amount": "0.01",
        "trade_state": 0,
        "trade_id": "5970********e491",
        "mch_trade_id": "alex.alipay.148",
        "merchant_id": "59382e********d0cfc3e",
        "pay_type": "alipay.micro"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "C0AE7AC********67B65E576"
}
```
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg|	是	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误


- 以下字段在code为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
查询判断	|	need_query	|	否	|	String	|	用来判断是否需要调用查询接口，值为Y时需要，值为N时不需要
用户标识	|	openid	|	否	|	String	|	用户在商户appid下的唯一标识
交易类型	|	pay_type	|	是	|	String	|	alipay.micro：支付宝刷卡支付
是否关注公众账号	|	is_subscribe	|	否	|	String	|	用户是否关注公众账号，Y-关注，N-不关注，仅在公众账号类型支付有效
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
子商户是否关注	|	sub_is_subscribe	|	否	|	Int	|	用户是否关注子公众账号，0-关注，1-未关注，仅在公众账号类型支付有效
子商户appid	|	sub_appid	|	否	|	String	|	子商户appid
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|现金券支付金额<=订单总金额，订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合ISO4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间	|	time_end	|	是	| Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
公众号appid |	appid |	否 |	String |	服务商公众号appid
货币种类 |	fee_type |	否 |	String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
买家支付宝账号 | buyer_logon_id |	否 | String |		买家支付宝账号
交易支付使用的资金渠道 | fund_bill_list |否 |	 	String | 	交易支付使用的资金渠道
买家在支付宝的用户 | id buyer_user_id | 否 | 	String |		买家在支付宝的用户id
买家付款的金额 | buyer_pay_amount |	否 | Int |		买家付款的金额
交易中可给用户开具发票的金额 | invoice_amount | 否 | 	Int |	 交易中可给用户开具发票的金额
使用积分宝付款的金额 | point_amount |	 否 | Int |		使用积分宝付款的金额
实收金额 | receipt_amount | 否 |	 	String  | 	实收金额	
交易状态 |	trade_state |	是 |	Int |	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
付款银行 |	bank_type |	否 |	String |	银行类型
货币种类 |	fee_type |	否	| String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
交易状态 |	trade_state |	是 |	Int |	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)


- 关于调用支付接口后相关情况的处理方案：当调用扣款接口返回支付中或失败状态，需要调用查询接口查询订单实际支付状态 。
- 当遇到用户超过日限额需要输入密码返回“支付中”的状态，建议 5 秒调一次查询，调用 6 次后还未成功作支付超时处理。
- 支付请求后：code和result code字段返回都为0时，判定订单支付成功；
- 支付请求后：code返回为0，而result code返回不为0时，并且返回的参数need_query为N时，才不用调查询接口，其他情况（包括没有返回need_query参数，返回了need_query参数但值为Y）则必须调用订单查询接口进行确认；
- 调用查询接口建议 ：共查询6次,每隔5秒查询一次（具体的查询次数和时间也可自定义，建议查询时间不低于30秒）。若6次查询完成，接口仍未返回成功标识(即查询接口返回的trade_state不是SUCCESS)则调用撤销接口进行撤销操作；



### 6.2.2 查询订单API

#### 业务功能
 根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
后台系统调用交互模式

#### 请求参数列表

> 查询示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "out_trade_id": "2017072021********15872936",
        "ch_trade_id": "7552********7207268767853",
        "appid": "20********67047",
        "bank_type": "DEBIT_CARD",
        "fee_type": "CNY",
        "openid": "2088********15",
        "total_fee": 1,
        "buyer_logon_id": "132****5309",
        "buyer_pay_amount": "0.01",
        "buyer_user_id": "20********6615",
        "fund_bill_list": "[{\"amount\":\"0.01\",\"fundChan********dType\":\"DEBIT_CARD\"}]",
        "invoice_amount": "0.01",
        "point_amount": "0.00",
        "receipt_amount": "0.01",
        "trade_state": 0,
        "trade_id": "5970715********e491",
        "mch_trade_id": "alex.alipay.148",
        "merchant_id": "5938********c3e",
        "pay_type": "alipay.micro"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "C0AE7AC484D********65E576"
}
```
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3



#### 响应参数列表(response)
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	| msg |	是	|	String |	返回信息，成功时为空，如非空，错误原因为签名失败或参数格式校验错误


- 以下字段在code为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
交易状态	|	trade_state	| 是 	|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)


- 以下字段在trade_state为0的时候有返回

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易类型	|	pay_type	|	是	|	String	|	alipay.micro：支付宝刷卡支付
商户appid	|	appid	|	否	|	String	|	受理商户appid
子商户appid	|	sub_appid	|	否	|	String	|	子商户appid
用户标识	|	openid	|	否	|	String|	用户在受理商户appid下的唯一标识
用户标识	|	sub_openid	|	否	|	String	|	用户在子商户appid下的唯一标识
是否关注公众账号	|	is_subscribe	|	否	|	String	|	用户是否关注公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效
是否关注公众账号	|	sub_is_subscribe	|	否	|	String	|	用户是否关注公众账号，Y-关注，N-不关注，仅在公众账号类型支付有效（子商户公众账号）
平台订单号	|	trade_id	|	是	|	String	|	平台交易号		
第三方订单号	|	out_trade_id	|	否	|	String	|	第三方订单号（支付成功后会返回，没支付则不会）		
商户订单号	|	mch_trade_id		|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额，订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合ISO4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间	|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
公众号appid |	appid |	否 |	String |	服务商公众号appid
货币种类 |	fee_type |	否 |	String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
买家支付宝账号 | buyer_logon_id |	否 |	String |	买家支付宝账号
交易支付使用的资金渠道 | fund_bill_list |	否 |	String |	交易支付使用的资金渠道
买家在支付宝的用户 |  idbuyer_user_id | 否 |String |		买家在支付宝的用户id
买家付款的金额 | buyer_pay_amount |	否 |	 Int	|  	买家付款的金额	
交易中可给用户开具发票的金额 | invoice_amount | 否 |  Int | 交易中可给用户开具发票的金额
使用积分宝付款的金额 |  point_amount |  否  |	 Int |	使用积分宝付款的金额
实收金额 | receipt_amount | 否	 |	String  | 	实收金额	
货币种类  | 	fee_type | 	否 | 	String | 	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
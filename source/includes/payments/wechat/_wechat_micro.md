## 5.2 微信刷卡支付（反扫）
pay_type：wechat.micro	
异步通知：否	

### 5.2.1 提交刷卡支付API

#### 业务功能
 收银员使用扫码设备读取微信用户刷卡授权码以后，二维码或条码信息传送至商户收银台，由商户收银台或者商户后台调用该接口发起支付对用户进行收款

#### 交互模式
- 请求：后台请求交互模式
- 返回结果：后台请求交互模

#### 请求参数列表
POST json 内容体进行请求

> post请求示例

```javascript
{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59382e*************cd0cfc3e",
    "pay_type":"wechat.micro",
    "mch_trade_id":"alex.wechat.1*****7",
    "time_start":1497330777,
    "body":"天虹龙华店-食品",
    "total_fee":1,
    "spbill_create_ip":"127.*********.1",
    "auth_code":"13454619*************6401"
}
```
- 公共请求参数

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易类型	|	pay_type	|	是	|	String	|	接口类型：wechat.micro
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于32位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见“安全规范”

- 请求参数

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
商户订单号	|	mch_trade_id		|	是	|	String	|	商户系统内部的订单号,5到32个字符、只能包含字母数字或者下划线，区分大小写，确保在商户系统唯一
设备号	|	device_info	|	否	|	String	|	终端设备号，商户自定义。
商品描述	|	body	|	是	|	String	|	商品描述
附加信息	|	attach	|	否	|	String|	商户附加信息，可做扩展参数
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器IP
授权码	|	auth_code	|	是	|	String	|	扫码支付授权码，设备读取用户展示的条码或者二维码信息
订单发起时间	|	time_start	|	否	|	Int	|时间戳：自1970年1月1日0点0分0秒以来的秒数。
订单失效时间|	time_expire	|	否	|Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。
操作员	|	op_user_id	|	否	|	String	|	操作员帐号,默认为商户号
门店编号	|	store_id	|	否	|	String	|	
设备编号	|	op_device_id	|	否	|	String	|	
商品标记	|	goods_tag	|	否	|	String	|	商品标记
是否采用D0通道|settle_type|否|Int| 采用D0结算时需添加此字段，默认为1,1：否，0：是

#### 响应参数列表

> Response响应示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "out_trade_id": "40035********751404011",
        "ch_trade_id": "7552********7208263916360",
        "appid": "wx290c********69d",
        "bank_type": "CFT",
        "fee_type": "CNY",
        "is_subscribe": "N",
        "openid": "oMJGHsx-0********XGyly02xI",
        "sub_appid": "wx26a********a99df7",
        "sub_openid": "oRXdVs9********sxMUYu2FrzMUQo",
        "total_fee": 1,
        "sub_is_subscribe": "Y",
        "trade_state": 0,
        "trade_id": "59706d88fd********03e8a1",
        "mch_trade_id": "alex.wechat.1********7",
        "merchant_id": "59382e3c********0cfc3e",
        "pay_type": "wechat.micro"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "BBF9683D28********68400AC7"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg|	是	|	String|	返回信息，如非空，为错误原因签名失败参数格式校验错误
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String|	结果信息描述
货币种类	| fee_type |	否 |	String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY

-  以下字段在 code 为 0 的时候有返回	
  
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易结果	|	trade_state	|	是	|	Int	|	0表示成功，
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
用户标识	|	openid	|	否	|	String|	用户在商户appid下的唯一标识
交易类型	|	pay_type	|	是	|	String	|	wechat.micro：微信刷卡支付
是否关注公众账号	|	is_subscribe	|	否	|String|	用户是否关注公众账号，Y-关注，N-不关注，
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
子商户是否关注	|	sub_is_subscribe	|	否	|	Int	|	用户是否关注子公众账号，0-关注，1-未关注
子商户appid	|	sub_appid	|	否	|	String	|	子商户appid
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额，订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合ISO4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。
公众号appid |	appid |	否 |	String |	服务商公众号appid



* 商户状态原因


code|msg|说明
--|--|--
200|商户不存在，请检查merchant_id|
201|商户状态异常，请联系运营|status: 1入驻申请，0审核通过，2审核失败，3商户停用，商户状态status为非0时禁止使用交易接口
202|商户不支持此交易类型 pay_type，请联系运营| 请求的route 中 此 pay_type 的 priority 为0，或是没有此 pay_type

* 订单相关

code|msg|说明
--|--|--
301|订单号不存在|查询订单、关闭订单、撤销订单、申请退款时


* 上游通道相关原因

code|说明
--|--|--
600|通道方返回的交易异常，透传通道方参数 ｛err_code：err_msg｝
601|通道连接超时|


* 交易状态 trade_state

trade_state  | 说明 
--|--
0|交易成功|
-1|交易失败|



### 5.2.2 查询订单API

#### 业务功能
 根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
后台系统调用交互模式


#### 请求参数列表



字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3



#### 响应参数列表

> 查询示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "out_trade_id": "40035420012*******404011",
        "ch_trade_id": "7552910*******208263916360",
        "appid": "wx290ce4*******4369d",
        "bank_type": "CFT",
        "fee_type": "CNY",
        "is_subscribe": "N",
        "openid": "oMJGHsx-0RqIklW*******y02xI",
        "sub_appid": "wx26a*******a99df7",
        "sub_openid": "oRXdVs97CW*******Yu2FrzMUQo",
        "total_fee": 1,
        "sub_is_subscribe": "Y",
        "trade_state": 0,
        "trade_id": "59706d88fd*******a03e8a1",
        "mch_trade_id": "alex.wechat.1*******7",
        "merchant_id": "59382e3cffea*******cfc3e",
        "pay_type": "wechat.micro"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "BBF9683D2844E*******00AC7"
}
```

字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg	|	是	|	String|	返回信息，成功时为空，如非空，错误原因
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于32位
错误代码	|	err_code	|	否	|	String	|	具体错误码请看文档最后错误码列表
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述


-  以下字段在 code 为 0 的时候有返回	
  
字段名	|	变量名	|	必填	|	类型	|	说明
--|--|--|--|--
交易状态	|	trade_state	| 是 |		Int	|请查看交易状态码表
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
交易类型	|	pay_type	|	是	|	String	|	wechat.micro：微信刷卡支付
商户appid	|	appid	|	否	|	String	|	受理商户appid
子商户appid	|	sub_appid	|	否	|	String	|	子商户appid
用户标识	|	openid	|	否	|	String	|	用户在受理商户appid下的唯一标识
用户标识	|	sub_openid	|	否	|	String|	用户在子商户appid下的唯一标识
是否关注公众账号	|	is_subscribe	|	否	|	String	|	用户是否关注公众账号，Y-关注，N-未关注
是否关注子商户公众账号	|	sub_is_subscribe	|	否	|	String	|	用户是否关注公众账号，Y-关注，N-不关注，
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
第三方订单号	|	out_trade_id	|	否	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额，订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合ISO4217标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间	|	time_end	|	是	|	Int	| Unix时间戳：自1970年1月1日 0点0分0秒以来的秒数
金额   	|   cash   	|     否  	| Int   	|金额，以分为单位，不允许包含任何字、符号
货币种类 	|	fee_type 	|	否 	|	String 	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
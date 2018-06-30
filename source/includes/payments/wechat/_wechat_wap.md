

## 5.7 微信wap
pay_type：wechat.wap	
异步通知：是	

### 5.7.1 统一下单API

#### 业务功能
 
 该接口接收WAP请求，生成支付链接并返回给接入商，接入商通过该请求生成支付链接引导用户使用WAP支付

#### 交互模式
- 请求：后台请求交互模式 
- 返回结果&通知：后台响应(response)+后台通知(notify)

#### 请求参数列表
POST json 内容体进行请求

> post示例

```javascript
{
    "merchant_id":"59382e3cffea0e5fcd0cfc3e",
    "pay_type":"wechat.wap",
    "mch_trade_id":"1510714425",
    "time_start":1508911951,
    "body":"111",
    "total_fee":10,
    "mch_app_name": "普尔",
    "mch_app_id": "http://wap.pooulcloud.cn/",
    "subject": "shangpin",
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/wechat.1497330199",
    "spbill_create_ip":"120.76.204.1"
}

```

- 公共请求参数

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
交易类型  | pay_type | 是 | String | 接口类型：wechat.wap
版本号 | version |否|	String |若为空, version默认值为1.0
签名方式 |	sign_type |	否	 | String| 可填:MD5, 若空则默认: MD5
商户号 | merchant_id	| 是|String |商户号，由平台分配
商品描述| body	|是	|String |	商品描述, 将会出现在客户支付结果页面中, 例:"心相印纸巾X2"
附加信息| attach |否|String | 商户附加信息，可做扩展参数
总金额|	total_fee |	是	|Int	|总金额，以分为单位，整数，不允许包含任何字母、符号
终端IP|	spbill_create_ip	|是	|String|	订单生成的机器 IP
通知地址 |notify_url|	是	|String |	接收平台异步通知的URL，需给绝对路径，255字符内格式
订单发起时间|time_start|否|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。 
订单失效时间|time_expire|否|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。 
操作员编号|	op_user_id	|否|	String|	操作员编号, 如为空,默认值为商户号
商品标记|goods_tag	|否 |	String |商品标记，微信平台配置的商品标记，用于优惠券或者满减使用
随机字符串 |nonce_str |	否	| String |	随机字符串，不长于 32 位
是否限制信用卡|	limit_pay|	否	|String|	限定用户使用微信支付时能否使用信用卡，值为1，禁用信用卡；值为0或者不传此参数则不禁用
签名|sign	|是	|String|	MD5签名结果 详见签名算法
是否采用D0通道|settle_type|否|Int|非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的订单号
应用名|mch_app_name	|是|String|如果是用于苹果或安卓app应用中，传分别对应在AppStore和安桌分发市场中的应用名（如：王者荣耀）如果是用于手机网站，传对应的网站名(如：京东官网)
应用标识|mch_app_id|是|String|如果是用于苹果或安卓app应用中，苹果传IOS 应用唯一标识(如：com.tencent.wzryIOS)安卓传包名(如：com.tencent.tmgp.sgame)如果是用于手机网站，传网站首页URL地址,必须保证公网能正常访问(如：https://m.jd.com)
设备号|	device_info|	是	|String|如果是用于苹果app应用里值为iOS_SDK；如果是用于安卓app应用里值为AND_SDK；如果是用于手机网站，值为iOS_WAP或AND_WAP均可


#### 响应参数列表

> Response 返回

```javascript
{
    "code": 0,
    "msg": "SUCCESS",
    "data": {
        "result_code": 0,
        "pay_info": "https://statecheck.swiftpass.cn/pay/wappay?token_id=153006f8ca8c2953f16443010132c5ca3&service=pay.weixin.wappayv2",
        "trade_id": "5a0bbc02ffea0e4f264fca2a",
        "mch_trade_id": "1510714425",
        "merchant_id": "59382e3cffea0e5fcd0cfc3e",
        "pay_type": "wechat.wap",
        "nonce_str": "5a0bbc03ffea0e4f264fca2d"
    },
   
}

```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
版本号 | version |是|	String | version默认值为1.0
签名方式 | sign_type |是|	String | 默认：MD5
返回状态码|	code |	是 |	String | 0表示成功，非0表示失败。 此字段为通信标识
返回信息 | msg |是|String|	返回信息，如成功则为空;如非空, 显示错误原因
商户号|	merchant_id	|是	|String |	商户号，由平台分配
设备号|	device_info|	否	|String|	终端设备号
随机字符串|	nonce_str | 否	|String |	随机字符串，不长于 32 位
错误代码 |	err_code|	否	|String |	参考错误码
错误代码描述 |	err_msg	|否	|String |	结果信息描述
用户标识  |	openid |	否	| String	| 用户在服务商 appid 下的唯一标识
公众号appid |	appid |	否 |	String |	服务商公众号appid



-  以下字段在 code 为 0 的时候有返回	
  
字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
签名 |	sign |	是	|String |	MD5签名结果
支付信息	|	pay_info	|	是	|	String	|	json格式的字符串，作用于wap支付时的参数,唤起手机微信支付url地址
平台订单号 |	trade_id |	是	| String |	平台订单号,mch_trade_id 和 trade_id 至少一个必填，同时存在时 trade_id 优先
商户订单号 |	mch_trade_id |	是 |	String |	商户系统内部的定单号，32个字符内、可包含字母




### 5.7.2 支付通知API

- 通知URL是统一下单接口中提交的参数 notify_url，支付完成后，平台会把相关支付和用户信息发送到该 URL，商户需要接收处理信息。 
- 对后台通知交互时，如果平台收到商户的应答不是纯字符串success或超过5秒后返回时，平台认为通知失败，平台会通过一定的策略（如3小时共10次）间接性重新发起通知，尽可能提高通知的成功率，但不保证通知最终能成功。
- 由于存在重新发送后台通知的情况， 因此同样的通知可能会多次发送给商户系统。 商户系统必须能够正确处理重复的通知。
- 推荐的做法是， 当收到通知进行处理时， 首先检查对应业务数据的状态， 判断该通知是否已经处理过， 如果没有处理过再进行处理， 如果处理过直接返回结果成功。 在对业务数据进行状态检查和处理之前， 要采用数据锁进行并发控制， 以避免函数重入造成的数据混乱。
- 特别注意：商户后台接收到通知参数后，要对接收到通知参数里的订单号out_trade_no和订单金额total_fee和自身业务系统的订单和金额做校验，校验一致后才更新数据库订单状态

####  通知结果参数列表


> 支付通知示例

```javascript
{
    "code": 0,
    "msg": "SUCCESS",
    "data": {
        "result_code": 0,
        "out_trade_id": "4200000050201711154793324111",
        "ch_trade_id": "102514025066201711156105631429",
        "bank_type": "ICBC_DEBIT",
        "fee_type": "CNY",
        "is_subscribe": "N",
        "openid": "ohoMsvwQ_OcmYmAiC8UBcGKWgCmo",
        "total_fee": 10,
        "trade_state": 0,
        "trade_info": "交易成功",
        "trade_id": "5a0bbc02ffea0e4f264fca2a",
        "mch_trade_id": "1510714425",
        "merchant_id": "59382e3cffea0e5fcd0cfc3e",
        "pay_type": "wechat.wap",
        "nonce_str": "5a0bbd13ffea0e4f294fca21"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "F79294BF32ADDF3AA55791D7EF865296"
}

```

后台通知通过请求中的notify_url进行， post方式给商户系统（通知参数内容为json的字符串）

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
版本号 | version |是|	String | version默认值为1.0
签名方式 | sign_type |是|	String | 默认：MD5
返回状态码|	code |	是 |	String | 0表示成功，非0表示失败。 此字段为通信标识
返回信息 | msg |是|String|	返回信息，如成功则为空;如非空, 显示错误原因
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位
错误代码	|	err_code	|	否	|	String	|	参考错误
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
用户标识 |	openid |	否 |	String |	用户在服务商 appid 下的唯一标识
公众号appid |	appid |	否 |	String	| 服务商公众号appid
金额   |   cash |       否 | Int | 金额，以分为单位，不允许包含任何字、符号	
货币种类 |	fee_type |	否 |	String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY



-  以下字段在 code 为 0 的时候有返回	
  
字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
签名	|	sign	|	是	|	String	|	MD5签名结果，详见“安全规范”
用户标识	|	openid	|	否	|	String	|	用户在服务商 appid 下的唯一标识
交易类型	|	pay_type	|	是	|	String	|	wechat.wap
是否关注公众账号	|	is_subscribe	|	是	|	String	|	用户是否关注服务商公众账号，Y-关注，N-未关注
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
是否关注商户公众号	|	sub_is_subscribe	|	否	|	String	|	用户是否关注子公众账号，Y-关注，N-未关注，
商户appid	|	sub_appid	|	否	|	String	|	商户公众号appid
用户openid	|	sub_openid	|	否	|	String	|	用户在商户公众号appid 下的唯一标识
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为微信支付则为空
支付完成时间 | time_end | 是 | Int | 时间戳：，自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
交易状态	|	trade_state	| 是	|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)



### 5.7.3 查询订单API

#### 业务功能
 根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
- 请求：后台请求交互模式

- 返回结果&通知：后台响应(response)


#### 请求参数列表



字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
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
    "msg": "SUCCESS",
    "data": {
        "result_code": 0,
        "out_trade_id": "4200000050201711154793324111",
        "ch_trade_id": "102514025066201711156105631429",
        "appid": "wx9694da087860d86f",
        "bank_type": "ICBC_DEBIT",
        "fee_type": "CNY",
        "is_subscribe": "N",
        "openid": "ohoMsvwQ_OcmYmAiC8UBcGKWgCmo",
        "total_fee": 10,
        "trade_state": 0,
        "trade_info": "交易成功",
        "trade_id": "5a0bbc02ffea0e4f264fca2a",
        "mch_trade_id": "1510714425",
        "merchant_id": "59382e3cffea0e5fcd0cfc3e",
        "pay_type": "wechat.wap",
        "nonce_str": "5a0bbf10ffea0e4f264fca37"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "77A6F6BB8DAA3A78AB8732DD4A6B4921",
    "time_elapsed": 0.3539,
    
}

```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
版本号 | version |是|	String | version默认值为1.0
签名方式 | sign_type |是|	String | 默认：MD5
返回状态码|	code |	是 |	String | 0表示成功，非0表示失败。 此字段为通信标识
返回信息 | msg |是|String|	返回信息，如成功则为空;如非空, 显示错误原因
商户号|	merchant_id	|是	|String |	商户号，由平台分配
设备号|	device_info|	否	|String|	终端设备号
随机字符串|	nonce_str |	否	|String |	随机字符串，不长于 32 位
错误代码 |	err_code|	否	|String |	参考错误码
错误代码描述 |	err_msg	|否	|String |	结果信息描述
货币种类 |	fee_type |	否 |	String |	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
金额  |    cash   |     否 | Int  | 金额，以分为单位，不允许包含任何字、符号


-  以下字段在 code 为 0 的时候有返回	
  
字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
签名 |	sign |	是	|String |	MD5签名结果，详见签名算法
交易状态	|	trade_state	| 是	|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
公众号appid	|appid|	否 |	String	|服务商公众号appid
用户标识| openid |	否 |   String |	用户在服务商 appid 下的唯一标识
是否关注公众账号| is_subscribe|是|	String|	用户是否关注服务商公众账号，Y-关注，N-不关注
平台流水号|	trade_id	|是 |	String	|
第三方订单号|out_trade_id|否	 |String|第三方订单号，微信支付、支付宝等支付方式原始订单号（支付成功后会返回，没支付则不会）
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
商户订单号 |	mch_trade_id|	是 |	String	|商户系统内部的定单号，32个字符内、可包含字母
总金额| total_fee |	是|	Int|	总金额，以分为单位，不允许包含任何字、
现金券金额| coupon_fee |	否	|Int |以分为单位， 现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类|currency_type | 否 |String|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息|	attach	|否	 |String	| 商家附加数据, 若不为空则原样返回
付款银行|	bank_type|	否	|String |	银行类型
银行订单号|	bank_billno	|否	|String	|银行订单号，若为微信支付则为空
支付完成时间|time_end|是|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
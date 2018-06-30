## 5.5 微信JSWAP支付

pay_type：wechat.jswap	

异步通知：是

### 5.5.1统一下单API

#### 业务功能

该接口接收扫码请求, 生成支付二维码网址并返回给接入商, 接入商通过该请求生成二维码引导用户用微信扫码支付(正扫)。

#### 交互模式

- 请求：后台请求交互模式 
- 返回结果&通知：后台响应(response)+后台通知(notify)

#### 请求参数列表
POST json 内容体进行请求

> post请求示例

```javascript
{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59457accffea0e051b86e685",
    "pay_type":"wechat.jswap",
    "mch_trade_id":"alex.1503452475",
    "time_start":1502786703,
    "body":"小胖建设3",
    "imsi": "132132131313",  
    "deviceCode": "868443020001028",
    "platform": 1,
    "total_fee":1,
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/wechat.1497331035"
}
```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
交易类型  | pay_type | 是 | String | 接口类型：wechat.jswap
商户号 | merchant_id	| 是|String |商户号，由平台分配
商户订单号 | mch_trade_id	| 是	|String	|商户系统内部的订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
客户手机设备号|	deviceCode |	否	|String|	终端设备号
商品描述| body	|是	|String |	商品描述, 将会出现在客户支付结果页面中, 例:"心相印纸巾X2"
客户手机类型 | platform | 否 | Int  | 客户手机类型，0->ios, 1-> android
客户手机标识码 | imsi |  否 |  String |客户手机标识码
总金额|	total_fee |	是	|Int	|总金额，以分为单位，整数，不允许包含任何字母、符号
通知地址 | notify_url|	是	|String |	接收平台异步通知的URL，需给绝对路径，255字符内格式
订单发起时间 | time_start | 否 | Int | 时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。 

#### 响应参数列表(response)

> 返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "ch_trade_id": "1003601001201708232456284888",
        "pay_url": "http://tscand01.3vpay.net/thirdPay/pay/jump?payType=2500&uuid=weixin://dl/business/?ticket=te299f6c955ad4175b3415dd784cb985e#wechat_redirect",
        "trade_id": "599d5089ffea0e30b5b431f9",
        "mch_trade_id": "alex.1503479350111",
        "merchant_id": "59457accffea0e051b86e685",
        "pay_type": "wechat.jswap",
        "nonce_str": "599d508affea0e30b5b431fb"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "A142D681AA720996389995D772DC94CB",
    "time_elapsed": 1.024
}
```

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0
签名方式	|	sign_type	|	是	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码|	code |	是 |	String | 0表示成功，非0表示失败。 此字段为通信标识
返回信息 | msg |是|String|	返回信息，如成功则为空;如非空, 显示错误原因
商户号|	merchant_id	|是	|String |	商户号，由平台分配
交易类型  | pay_type | 是 | String | 接口类型：wechat.jswap
随机字符串|	nonce_str |	否	|String |	随机字符串，不长于 32 位


- 以下字段在code为0时返回

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
支付网址   |	pay_url	|	是	|	String	|  返回的支付网址
上游渠道订单号|ch_trade_id|是|String|上游渠道订单号
商户订单号|mch_trade_id|是|String|平台订单号
平台订单号|trade_id|是|String|平台订单号

### 5.5.2 JS支付通知API

- 通知 URL 是初始化请求接口中提交的参数 notify_url，支付完成后，平台会把相关支付和用户信息发送到该 URL，商户需要接收处理信息。
- 对后台通知交互时，如果平台收到商户的应答不是纯字符串success或超过5秒后返回时，平台认为通知失败，平台会通过一定的策略（如3小时共10次）间接性重新发起通知，尽可能提高通知的成功率，但不保证通知最终能成功。
- 由于存在重新发送后台通知的情况， 因此同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。
- 推荐的做法是， 当收到通知进行处理时， 首先检查对应业务数据的状态， 判断该通知是否已经处理过， 如果没有处理过再进行处理， 如果处理过直接返回结果成功。 在对业务数据进行状态检查和处理之前， 要采用数据锁进行并发控制， 以避免函数重入造成的数据混乱。
- 特别注意：商户后台接收到通知参数后，要对接收到通知参数里的订单号out_trade_no和订单金额total_fee和自身业务系统的订单和金额做校验，校验一致后才更新数据库订单状态

#### 通知结果参数列表

- 后台通知通过请求中的notify_url进行， post

> 返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "total_fee": 1,
        "ch_trade_id": "1003601001201708239592065806",
        "time_end": "20170823182445",
        "trade_id": "599d57ecffea0e33cc70c82b",
        "mch_trade_id": "alex.15011",
        "merchant_id": "59457accffea0e051b86e685",
        "pay_type": "wechat.jswap",
        "nonce_str": "599d580affea0e33c970c82c"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "A75F811634C05A8FDE6C9267B9FCB86D"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	是	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg|	是	|	String|	返回信息，如非空，为错误原因签名失败参数格式校验错误

- 以下字段在 code 为 0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易状态	|	trade_state	|	是 |		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位
错误代码	|	err_code	|	否	|	String	|	参考错误码
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
交易类型	|	pay_type	|	是	|	String	|	wechat.jswap
支付结果	|	pay_result	|	是	|	Int	|	支付结果：0—成功；其它—失败
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息	|	attach	|	否	|	String|	商家数据包，原样返回
付款银行	|	bank_type	|	否	|	String	|	银行类型
支付完成时间|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。

#### 后台通知结果反馈
平台服务器发送通知，post发送JSON数据流，商户notify_Url地址接收通知结果，商户做业务处理后，需要以纯字符串的形式反馈处理结果，内容如下：

返回结果|结果说明
---|---
success|处理成功，平台收到此结果后不再进行后续通知
fail或其它字符|处理不成功，平台收到此结果或者没有收到任何结果，系统通过补单机制再次通知


### 5.5.3  查询订单API

####  业务功能

根据商户订单号或者平台订单号查询平台的具体订单信息。

####  交互模式

请求：后台请求交互模式

返回结果&通知：后台响应(response)


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

#### 响应参数列表(response)

> 返回示例

```javascript
{
    "code": 0,
    "msg": null,
    "time_end": "20170823173332",
    "data": {
        "total_fee": 1,
        "trade_state": 0,
        "trade_id": "599d4bebffea0e2f10fc0c22",
        "mch_trade_id": "alex.150347935011",
        "merchant_id": "59457accffea0e051b86e685",
        "pay_type": "wechat.jswap",
        "nonce_str": "599d4c3fffea0e2f10fc0c27"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "E04DBB0289A33F2A436606F270150DA2",
    "time_elapsed": 0.4155,
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


- 以下字段在code为0时返回

字段名 | 变量名 | 必填 | 类型 | 说明 
--- | --- | :---: | --- | ---
签名 |	sign |	是	|String |	MD5签名结果
交易状态	|	trade_state	|	是|		Int	|	0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
交易类型|	pay_type	|是 |	String	| wechat.jswap
平台流水号|	trade_id	|是 |	String	|
第三方订单号|out_trade_id|否	 |String|第三方订单号，微信支付、支付宝等支付方式原始订单号（支付成功后会返回，没支付则不会）
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
商户订单号 |	mch_trade_id|	是 |	String	|商户系统内部的定单号，32个字符内、可包含字母
总金额| total_fee |	是|	Int|	总金额，以分为单位，不允许包含任何字、
现金券金额| coupon_fee |	否	|Int |以分为单位， 现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额
货币种类|currency_type | 否 |String|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY
附加信息|	attach	|否	 |String	| 商家附加数据, 若不为空则原样返回
付款银行|	bank_type|	否	|String |	银行类型
支付完成时间|time_end|是|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
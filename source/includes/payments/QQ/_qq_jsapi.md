## 7.3 QQ钱包公众号支付
pay_type： qq.jsapi
异步通知：是	

### 7.3.1 初始化请求API

#### 业务功能
 初始化JSAPI请求，通过生成token_id来进行交互验证。

#### 交互模式
- 请求：后台请求交互模式
- 返回结果&通知：后台响应(response)+后台通知(notify)

#### 请求参数列表
POST json 内容体进行请求

> 请求示例

```javascript

{   
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
    "merchant_id":"59382e3cffe*************",
    "pay_type":"qq.jsapi",
    "mch_trade_id":"alex.qq.***********",
    "time_start":1496910822,
    "device_info":"92883",
    "body":"天虹龙华店-食品",
    "attach":"非零售",
    "total_fee":3,
    "spbill_create_ip":"127.0.0.1",
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/qq.***********",    
    "callback_ url":"http://pooul.com/"

}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易类型	|	pay_type	|	是	|	String	|	接口类型：qq.jsapi
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0		
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5		
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配		
授权渠道编号	|	sign_agentno	|	否	|	String	|	如果不为空，则用授权渠道的密钥进行签名		
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的订单号 ,32个字符内、 可包含字母,确保在商户系统唯一		
设备号	|	device_info	|	否	|	String	|	终端设备号		
商品描述	|	body	|	是	|	String	|	商品描述		
附加信息	|	attach	|	否	|	String	|	商户附加信息，可做扩展参数		
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号		
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器 IP		
通知地址	|	notify_url	|	是	|	String	|	接收平台通知的URL，需给绝对路径，255字符内格式如:http://wap.tenpay.com/tenpay.asp，确保平台能通过互联网访问该地址		
前台地址	|	callback_ url|	否	|	String	|	 交易完成后跳转的URL，需给绝对路径，255字符内格式如:http://wap.tenpay.com/callback.asp注:该地址只作为前端页面的一个跳转，需使用notify_url通知结果作为支付最终结果。		
订单发起时间|	time_start	|	否	|Int|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。	
订单失效时间	|	time_expire	|	否	|	Int|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位		
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
交易耗时 	|		time_elapsed 	|		否 	|		string 	|		交易消耗时间

#### 响应参数列表(response)

 数据按照json格式实时返回

 >返回示例
 
```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "transaction_id": "59390***********",
        "mch_trade_id": "alex.qq.1496910822",
        "token_id": "***********"
    },
    "time_elapsed": 0.4684,
    "version": "1.0",
   "sign_type": "md5",
   "sign": "72ED16F9AD20********A7EB5"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。		
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5		
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识		
返回信息	|	msg	|	是	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误


- 以下字段在 code 为 0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---	
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配		
设备号	|	device_info	|	否	|	String	|	平台支付分配的终端设备号		
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位		
错误代码	|	err_code	|	否	|	String	|	参考错误码		
错误代码描述	|	err_msg	|	否	|	String|	结果信息描述		
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
动态口令	|	token_id	|	是	|	String	|	手Q支付生成的token_id		
支付信息	|	pay_info	|	是	|	String	|	json格式的字符串，作用于原生态js支付时的参数,{"tokenId":"0V41fae78af237d4e35be725eb0f972c","pubAccHint":"","pubAcc":""}		
支付链接	|	pay_url	|	否	|	String	|	仅用于体验，不建议用作支付界面，后续会调整	


#### 原生态JS支付API

- 使用示例

接口需要注意：所有传入参数都是字符串类型！使用 JavaScript、PHP 等弱类型语言需
要关注一下

若要使用jsapi需要在页面中引入如下的js文件，手机QQ客户端已经将此文件下载到本地，页面可直接引入使用。
     <script src="http://pub.idqqimg.com/qqmobile/qqapi.js?_bid=152"></script>

- 支付使用到的jsapi

method  9|details|version
---|---|---
version 	|	属性，mqqapi 自身的版本号	|	 >=v4.2，>= v4.2
iOS 	|	属性，如果在 iOS QQ中，值为 true，否则为 false	|	 >= v4.2>= v4.2
android 	|	属性，如果在 android QQ中，值为 true，否则为 false	|	 >= v4.2 >= v4.2
QQVersion 	|	属性，如果在 手机 QQ中，值为手机QQ的版本号，如：4.6.2，否则为 0	|	 >= v4.2 >= v4.2
isMobileQQ 	|	检测页面是否在手机QQ内@param {Function} callback (result) {Boolean} result	|	 >= v4.2 >= v4.2
pay 	|	"唤起财付通支付界面


```java
@param {Object} params 
{String} tokenId 调用财付通后台接口生成的订单号（必选字段）
{String} pubAcc  ( v4.7.0 v4.7.0 ) 公众帐号uin，用于在支付成功后关注该公众帐号。Add in 4.7.0。
{String} pubAccHint  ( v4.7.0 v4.7.0 ) 公众帐号关注提示语，用于显示在支付成功页面。Add in 4.7.0。
@param {Function} callback (result) 支付成功/失败的回调 
{Object} result
{Number} resultCode 0 ： 表示成功。非0：表示失败
{String} retmsg 表示调用结果信息字符串。成功返回时为空串。出错时，返回出错信息
{Object} data 当resultCode=0时，有返回data对象
 transaction_id 财付通交易单号
 pay_time 交易时间
 total_fee 订单总金额（单位为分）
```

method  9|details|version
---|---|---
 callback_url 商户提供的回调url地址（HTML5方式调用适用，其它情形为空）"	|	 >= v4.6.1， >= v4.6.1

```javascript
"sp_data 返回给商户的信息，商户前端可解析校验订单支付结果。
Note  支付成功的回调在 Android 4.6.2 之前的实现有 Bug，
4.6.0之前从aio打开的webview会没有回调，
4.6.1在生活优惠的webview会没有回调。
需要页面兼容一下，给个提示框让用户点击，从后台查支付状态。最新版本已经修复。
Example
mqq.tenpay.pay({
    tokenId: ""xxxx"",
    pubAcc: ""xxxx"",
    pubAccHint: ""xxxx""
});"
```

#### 通知结果参数列表

- 后台通知通过请求中的notify_url进行， post

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。		
签名方式	|	sign_type	|	是	|	String	|	签名类型，取值：MD5默认：MD5		
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识		
返回信息	|msg|	是	|	String	|	返回信息，如非空，为错误原因签名失败参数格式校验错误		

- 以下字段在 code 为 0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---	
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配		
设备号	|	device_info	|	否	|	String	|	终端设备号
随机字符串	|	nonce_str	|	是	|	String|	随机字符串，不长于 32 位		
错误代码	|	err_code	|	否	|	String	|	参考错误码		
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述		
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法	
交易类型	|	pay_type	|	是	|	String	|	qq.jsapi		
支付结果信息	|	pay_info	|	否	|	String	|	支付结果信息，支付成功时为空		
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
第三方订单号	|	out_trade_id	|	是	|	String	|	第三方订单号，微信支付、支付宝等支付方式原始订单号	
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号		
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额		
货币种类	|	currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY		
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回		
付款银行	|	bank_type	|	否	|	String	|	银行类型		
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为QQ钱包支付则为空		
支付完成时间	|	time_end	|	是	|	Int	|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。	


#### 后台通知结果反馈
 - 后台通过notify_url通知商户，商户做业务处理后，需要以字符串的形式反馈处理结果，内容如下：后台通知结果反馈

返回结果|结果说明
---|---
success	|处理成功，平台收到此结果后不再进行后续通知
fail或其它字符	|处理不成功，平台收到此结果或者没有收到任何结果，系统通过补单机制再次通知


### 订单查询API

#### 业务功能
根据商户订单号或者平台订单号查询平台的具体订单信息。

#### 交互模式
后台系统调用交互模式


#### 请求参数列表

POST json 内容体进行请求

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

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易类型	|	pay_type	|	否	|	String	|	接口类型：qq.jsapi		
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配
商户订单号	|	mch_trade_id	|	否	|	String	|商户系统内部的订单号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先
平台订单号	| trade_id		|	否	|	String	|	平台交易号, mch_trade_id和trade_id	至少一个必填，同时存在时trade_id优先。
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于 32 位
签名	|	sign	|	是	|	String	|	MD5签名结果，详见3
#### 响应参数列表(response)

- 数据按Json的格式实时返回

> 查询示例

```javascript
{
    "code": 0,
    "msg": null,
    "data": {
        "transaction_id": "5939***********",
        "out_transaction_id": "755291***********",
        "mch_trade_id": "alex.qq.***********",
        "time_end": 1496910905,
        "bank_type": "3203",
        "err_msg": "success",
        "fee_type": "1",
        "total_fee": "3",
        "trade_state": "SUCCESS",
        "pay_type": "qq.jsapi"
    },
    "time_elapsed": 0.1559,
    "version": "1.0",
    "sign_type": "md5",
    "sign": "72ED16F9AD20********A7EB5"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。		
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5		
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识		
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

 - 以下字段在 trade_state为 0的时候有返回

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易类型	|	pay_type	|	是	|	String	|	qq.jsapi		
平台订单号	|	trade_id	|	是	|	String	|	平台交易号		
第三方订单号	|	out_trade_id	|	否	|	String	|	第三方订单号（支付成功后会返回，没支付则不会）		
商户订单号	|	mch_trade_id		|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母
上游渠道订单号|ch_trade_id|否|String|上游渠道订单号		
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号		
现金券金额	|	coupon_fee	|	否	|	Int	|	现金券支付金额<=订单总金额， 订单总金额-现金券金额为现金支付金额		
货币种类	|currency_type	|	否	|	String	|	货币类型，符合 ISO 4217 标准的三位字母代码，默认人民币：CNY		
附加信息	|	attach	|	否	|	String	|	商家数据包，原样返回		
付款银行	|	bank_type	|	否	|	String	|	银行类型		
银行订单号	|	bank_billno	|	否	|	String	|	银行订单号，若为QQ钱包支付则为空		
支付完成时间	|	time_end	|	是	|Int|	时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)
货币种类 |		fee_type |		否 |		String |		货币类型，符合 ISO 4217 标准的三位字母代码，默认
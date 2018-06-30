## 5.3 微信公众号支付-原生
pay_type：wechat.jsapi		
异步通知：是

### 5.3.1 初始化请求接API

#### 业务功能
 初始化JSAPI请求，通过生成token_id来进行交互验证。

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
    "merchant_id":"59382********e3fc3e",
    "pay_type":"wechat.jsapi",
    "mch_trade_id":"alex.14********1034",
    "time_start":14973********4,
    "body":"天虹龙华店-食品",
    "total_fee":1,
    "spbill_create_ip":"127.0.0.1",
    "sub_appid":"wx26a0********99df7",
    "sub_openid":"oRXdVs********kuSjsNVKw",
    "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/wechat.149********34",
    "callback_url":"http://pooul.com/"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
交易类型	|	pay_type	|	是	|	String|	接口类型：wechat.jsapi 原生态（is_raw=1）	
版本号	|	version	|	否	|	String	|	版本号，version默认值是1.0	
签名方式	|	sign_type	|	否	|	String	|	签名类型，取值：MD5默认：MD5	
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配	
是否小程序支付	|	is_minipg	|	否	|	String	|	值为1，表示小程序支付；不传或值不为1，表示公众账号内支付	
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一	
设备号	|	device_info	|	否	|	String|	终端设备号	
商品描述	|	body	|	是	|	String	|	商品描述	
用户openid	|	sub_openid	|	是	|	String|	微信用户关注商家公众号的openid，配置北京农商银行渠道时为空
公众账号或小程序ID	|	sub_appid	|	是	|	String|	当发起公众号支付时，值是微信公众平台基本配置中的AppID(应用ID)；当发起小程序支付时，值是对应小程序的AppID；配置北京农商银行渠道时为空	
附加信息	|	attach	|	否	|	String	|	商户附加信息，可做扩展参数	
总金额	|	total_fee	|	是	|	Int	|	总金额，以分为单位，不允许包含任何字、符号	
终端IP	|	spbill_create_ip	|	是	|	String	|	订单生成的机器IP	
通知地址	|	notify_url	|	是	|	String	|	接收平台通知的URL，需给绝对路径，255字符内
前台地址	|	callback_url	|	否	|	String	|	交易完成后跳转的URL，需给绝对路径，255字符内，注:该地址只作为前端页面的一个跳转，需使用notify_url通知结果作为支付最终结果。此参数只在跳转方式下才有效。
订单发起时间|	time_start	|	否	|	Int	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
订单失效时间|	time_expire	|	否	|	Int	|	时间戳：自1970年1月1日 0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
商品标记	|	goods_tag	|	否	|	String	|	商品标记，微信平台配置的商品标记，用于优惠券或者满减使用	
随机字符串	|	nonce_str	|	否	|	String	|	随机字符串，不长于32位	
是否限制信用卡	|	 limit_pay	|	否	|	String	|	限定用户使用微信支付时能否使用信用卡，值为1，禁用信用卡；值为0或者不传此参数则不禁用	
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
是否采用D0通道|settle_type|否|Int|非必须字段。采用D0接口时需添加此字段，默认为1,1：否，0：是

#### 响应参数列表

数据按 Json 的格式实时返回

 > Response返回示例
 
```javascript
{
	"code":0,
	"msg":null,
	"data":{
		"appid":"wx290c********369d",
		"pay_info":{
			"appId":"wx290ce4********69d",
			"timeStamp":"15********11763",
			"status":"0",
			"signType":"MD5",
			"package":"prepay_id=wx20170807********9b77ca70245541856",
			"callback_url":null,
			"nonceStr":"1502********1763",
			"paySign":"ED280********F782254F37052C2BA"
		},
		"token_id":"27772********5c69ab2216a9fbb2b3",
		"trade_id":"59880********eb00ac3085a20",
		"attach":"150********212",
		"mch_trade_id":"1502********12",
		"merchant_id":"59382e3cffea********fcd0cfc3e",
		"pay_type":"wechat.jsapi"
	},
	"version":"1.0",
	"sign_type":"md5",
	"sign":"44D58E44528E83B********5D9F58B93F"
}
```

字段名|变量名|必填|类型|说明
---|---|---|---|---
公众账号ID	|	appid	|	是	|	String	|	服务商公众号APPID
版本号	|	version	|	是	|	String	|	版本号，version默认值是1.0。
签名方式	|	sign_type	|	是	|	String	|	签名类型，取值：MD5默认：MD5
返回状态码	|	code	|	是	|	String	|	0表示成功非0表示失败此字段是通信标识，非交易标识
返回信息	|	msg	|	是	|	String|	返回信息，如非空，为错误原因签名失败参数格式校验错误

-  以下字段在 code 为 0 的时候有返回	
  
字段名|变量名|必填|类型|说明
---|---|---|---|---
商户号	|	merchant_id	|	是	|	String	|	商户号，由平台分配	
设备号	|	device_info	|	否	|	String	|	终端设备号	
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位	
错误代码	|	err_code	|	否	|	String	|	参考错误码	
错误代码描述	|	err_msg	|	否	|	String	|	结果信息描述	
签名	|	sign	|	是	|	String	|	MD5签名结果，详见签名算法
动态口令	|	token_id	|	是	|	String	|	平台生成的预支付 ID，用于后续接口调用中使用	
交易耗时 |	time_elapsed	| 否	 | string	 | 交易消耗时间
商户订单号	|	mch_trade_id	|	是	|	String	|	商户系统内部的定单号，32个字符内、可包含字母,确保在商户系统唯一	
平台订单号	|	trade_id	|	是	|	String	|	平台交易单号
支付信息 | pay_info | 是 | String |详见5.3.2



### 5.3.2 调起支付


#### 交互模式
- 请求：后台请求交互模式
- 返回结果&通知：后台响应(response)+后台通知(notify)

#### 说明
- 在微信浏览器里面打开H5网页中执行JS调起支付。接口输入输出数据格式为JSON。
- 注意：WeixinJSBridge内置对象在其他浏览器中无效。
- 列表中参数名区分大小写，大小写错误签名验证会失败。
- 接口需要注意：所有传入参数都是字符串类型！使用JavaScript、PHP 等弱类型语言需要关注一下。

#### 请求参数列表（getBrandWCPayRequest参数以及返回值定义）


字段名|变量名|必填|类型|说明
---|---|---|---|---
公众号id	|	appId	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
时间戳	|	timeStamp	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
随机字符串	|	nonceStr	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
订单详情扩展字符串	|	package	|	否	|	String	|	对应初始化请求中返回的pay_info中的信息	
签名方式	|	signType	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	
签名	|	paySign	|	是	|	String	|	对应初始化请求中返回的pay_info中的信息	

#### 响应参数列表（err_msg返回结果值说明）

返回值|说明|
---|---
err_msg | get_brand_wcpay_request:ok 支付成功
err_msg | get _brand_wcpay_request:cancel 支付过程中用户取消
err_msg | get_brand_wcpay_request:fail 支付失败


注：
 1.JS API 的返回结果get_brand_wcpay_request:ok 仅在用户成功完成支付时返回。由于前端交互复杂，get_brand_wcpay_request:cancel或者get_brand_wcpay_request:fail可以统一处理为用户遇到错误或者主动放弃，不必细化区分。
 2.商户实现原生态页面的请求地址必须提供支付授权目录由服务商配置好，在微信提供的测试公众账号上无法调起支付（测试时可以在手机微信端文件传输助手中进行）。

> 示例代码：

```javascript
function onBridgeReady(){
   WeixinJSBridge.invoke(
       'getBrandWCPayRequest', {
           "appId":"wx2421b1c4370ec43b",     //公众号名称，由商户传入     
           "timeStamp":"1395712654",         //时间戳，自1970年以来的秒数     
           "nonceStr":"e61463f8efa94090b1f366cccfbbb444", //随机串     
           "package":"prepay_id=u802345jgfjsdfgsdg888",     
           "signType":"MD5",         //微信签名方式：     
           "paySign":"70EA570631E4BB79628FBCA90534C63FF7FADD89" //微信签名 
       },
       function(res){     
           if(res.err_msg == "get_brand_wcpay_request:ok" ) {}     
           // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
       }
   ); 
}
if (typeof WeixinJSBridge == "undefined"){
   if( document.addEventListener ){
       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
  }else if (document.attachEvent){
       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
   }
}else{
   onBridgeReady();
}
```


### 5.3.3  JS支付通知API


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
随机字符串	|	nonce_str	|	是	|	String	|	随机字符串，不长于 32 位
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



### 5.3.4 订单查询API

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
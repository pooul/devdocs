# 10.快捷支付

## 10.1 签名规则

全部字段加密钥，采取MD5方式加密。

## 10.2 支付请求

### 10.2.1 请求参数

> 请求示例

```javascript
    {
        "merchant_id":"1199263089155622",
        "pay_type":"web.mobile",
        "mch_trade_id":"alex.wechat.1512543392",
        "body":"天虹龙华店-食品",
        "total_fee":5000,
        "callback_url":"https://www.baidu.com/"
    }

```
字段名 | 变量名|必填|类型|说明
---|---|---|---|---
商户号| merchant_id|是|string|商户号，由平台分配，18位纯数字
支付类型|pay_type|是|string|支付类型：web.mobile
签名| sign|是|string|签名，采用MD5
总金额	|total_fee|是|int|	总金额，以分为单位，不允许包含任何字、符号
商品详情|body|否|string|商品详情介绍
商户订单号|	mch_trade_id|是 |string|商户系统内部的订单号，32个字符内、
版本号|version|否|string| 	接口版本号，默认1.0	
返回跳转地址|callback_url|是|string|支付完成返回时跳转到的网址
通知接收地址|notify_url|是|string|接收异步通知的地址


###10.2.2 返回参数
字段名 | 变量名|类型|说明
---|---|---|---|---
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息	|msg|	是|	String|	返回信息，如成功则为空;如非空, 显示错误原因

当code为0时，有返回

> code为0返回示例

```javascript
{
    "code": 0,
    "msg": "Success",
    "data": {
        "code_url": "https://www.yeepay.com/app-merchant-proxy/eposMobile.action?l=93fdbbfe90734b2d38eb71bba50621b8 ",
        "total_fee": 5000,
        "trade_id": "5a279df9ffea0e6d6e0289e1",
        "mch_trade_id": "alex.wechat.1512543392",
        "merchant_id": "1199263089155622",
        "pay_type": "web.mobile",
        "nonce_str": "5a279df9ffea0e6d6e0289e3"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "FFE541F922015CB84D85EC37A534BED3",
    "time_elapsed": 0.2853,
}
```

字段名 | 变量名|类型|说明
---|---|---|---|---
二维码链接	|code_url|String|商户可用此参数自定义去生成二维码后展示出来进行扫码支付
平台订单号	|trade_id|string|平台订单号，32个字符内、可包含字母
商户订单号|	mch_trade_id|string|商户系统内部的订单号，32个字符内、可包含字母
商户号|merchant_id|string|同商户号，由平台分配
支付类型|pay_type|string|支付类型：web.mobile
总金额	|total_fee|int|	总金额，以分为单位，不允许包含任何字、符号
版本号|	version|	String|	version默认值为1.0
签名方式|	sign_type|		String|	默认：MD5
签名|	sign|	String	|MD5签名结果
交易耗时|	time_elapsed|		string	|交易消耗时间
随机字符串	|nonce_str|		String	|随机字符串，不长于 32 位


###10.2.3 通知返回参数

>通知返回示例

```javascript
{
    "code": 0,
    "msg": "Success",
    "data": {
        "total_fee": 500,
        "end_time": "20171218112123",
        "trade_state": 0,
        "trade_info": "支付成功",
        "trade_id": "5a3733f1fd4eb02e1ebc3fee",
        "mch_trade_id": "alex.wechat.1513566965",
        "merchant_id": "3221288520735696",
        "pay_type": "web.mobile",
        "nonce_str": "5a373438fd4eb02e1ebc4055"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "DCA724A26C3DC0A9B1D283F334DA8DA5"
}
```
字段|	变量名	|	类型|	说明
---|---|---|---|
版本号|	version|		String	|version默认值为1.0
签名方式	|sign_type|		String	|默认：MD5
返回状态码	|code		|String|	0表示成功，否则表示失败。 此字段为通信标识
返回信息|	msg		|String	|返回信息，如成功则为success;否则显示错误原因
商户号	|merchant_id|		String	|商户号，由平台分配
随机字符串	|nonce_str|		String	|随机字符串，不长于 32 位

-  以下字段在 code 为 0 的时候有返回
字段|	变量名	|	类型|	说明
---|---|---|---|
签名|	sign|	String|	MD5签名结果，详见“安全规范”
交易类型|	pay_type		|String|	wechat.scan
商户订单号	|mch_trade_id	|	String	|商户系统内部的定单号，32个字符内、可包含字母
平台订单号|	trade_id|		String|	平台交易单号
总金额	|total_fee|	Int	|总金额，以分为单位，不允许包含任何字、符号
支付完成时间	|end_time|Int|时间戳：，自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
交易状态	|trade_state|Int|0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)


##10.3 查询

###10.3.1 请求参数
> 查询示例

```javascript
    {
        "merchant_id":"1199263089155622",
        "mch_trade_id":"alex.wechat.1512543392"
    }
```

字段名 | 变量名|必填|类型|说明
---|---|---|---|---
商户号| merchant_id|是|string|商户号，由平台分配，18位纯数字
商户订单号|	mch_trade_id|是 |string|商户系统内部的订单号，32个字符内

###10.3.2 返回参数
字段名 | 变量名|类型|说明
---|---|---|---|---
返回状态码|	code|	string|	0表示成功，非0表示失败。 此字段为通信标识
返回信息	|msg|	string|	返回信息，如成功则为空;如非空, 显示错误原因

当code为0时，有返回，

> 查询返回示例

```javascript
{
    "code": 0,
    "msg": "Success",
    "data": {
        "total_fee": 5000,
        "time_end": "20171206154020",
        "trade_state": 0,
        "trade_info": "支付成功",
        "trade_id": "5a279df9ffea0e6d6e0289e1",
        "mch_trade_id": "alex.wechat.1512543392",
        "merchant_id": "1199263089155622",
        "pay_type": "web.mobile",
        "nonce_str": "5a279f6effea0e6d6e0289e5"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "6255A7AF4B5030A0C24EB96B4A19C3F7",
"time_elapsed": 0.7457,
}
```

字段名 | 变量名|类型|说明
---|---|---|---|---
商户号| merchant_id|string|商户号，由平台分配，18位纯数字
平台订单号	|trade_id|string|平台订单号，32个字符内、可包含字母
商户订单号|	mch_trade_id|string|商户系统内部的订单号，32个字符内、可包含字母
支付类型|pay_type|string|支付类型：web.mobile
总金额	|total_fee|int|	总金额，以分为单位，不允许包含任何字、符号
版本号|	version|	String|	version默认值为1.0
签名方式|	sign_type|		String|	默认：MD5
签名|	sign|	String	|MD5签名结果
交易耗时|	time_elapsed|		string	|交易消耗时间
随机字符串|	nonce_str	|	string|	随机字符串，不长于 32 位
交易状态|	trade_state|Int|0—支付成功,1—转入退款，2—未支付,3—已关闭,4—已冲正,5—已撤销中,6-支付中， 7—支付失败(其他原因，如银行返回失败)
支付完成时间|	time_end|Int|时间戳：自1970年1月1日0点0分0秒以来的秒数。注意：部分系统取到的值为毫秒级，需要转换成秒(10位数字)。
交易信息|trade_info|string|交易信息介绍
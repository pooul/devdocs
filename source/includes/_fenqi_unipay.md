# 11.银联分期接口

## 11.1银联分期预下单接口

/paygate/pooulcloud/credit

### 11.1.1 请求参数

字段名 | 变量名|必填|类型|说明
---|---|---|---|---
商户号| merchant_id|是|string|商户号，由平台分配，18位纯数字
商户订单号|	mch_trade_id|是|	String	|商户系统内部的订单号，32个字符内、可包含字母
支付类型|pay_type|是|string|web.unipay
分期期数|terms|是|int|分期总期数，整数，不允许包含任何字母、符号
总金额|	total_fee	|是|	Int|	总金额，以分为单位，整数，不允许包含任何字母、符号

```javascript
{
	"merchant_id": "8015023289585984",
	"mch_trade_id": "unipay125808",
	"pay_type":"web.unipay",
    "terms": "6",
    "total_fee": "60000"
}
```
### 11.1.2返回参数

字段名 | 变量名|类型|说明
---|---|---|---|---
版本号	|version	|是|	String|	version默认值为1.0
签名方式|	sign_type	|是|	String|	默认：MD5
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息|	msg	|是	|String	|返回信息，如成功则为空;如非空, 显示错误原因


- 以下字段在 code 为 0 的时候有返回

字段名 | 变量名|类型|说明
---|---|---|---|---
签名|	sign|		String	|MD5签名结果
随机字符串|	nonce_str|		String|	随机字符串，不长于 32 位
平台订单号|	trade_id|		String|	平台订单号,mch_trade_id 和 trade_id 至少一个必填，同时存在时 trade_id 优先
商户订单号|	mch_trade_id|		String|商户系统内部的定单号，32个字符内、可包含字母
支付路由|pay_url|string|支付路由信息
交易耗时|	time_elapsed|	string|	交易消耗时间

```javascript
{
    "code": 0,
    "msg": "Success",
    "data": {
        "trade_id": "5a44bbb8f8f5995836b3c555",
        "mch_trade_id": "unipay125808",
        "pay_url": "http://ma.poooulcloud.cn/api/8015023289585984/5a44bbb8f8f5995836b3c555",
        "nonce_str": "5a44bbb8f8f5995836b3c556"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "5DE3D485468AEC2BCC6275046BF4F573",
    "time_elapsed": 0.0259,
    "debug": {}
}

```
## 11.2银联分期确认收货接口

接口 :paygate/merchant_info/credit_confirm

#### 请求参数
字段名 | 变量名|必填|类型|说明
---|---|---|---|---
商户号| merchant_id|是|string|商户号，由平台分配，18位纯数字
商户订单号|	mch_trade_id|是|	String	|商户系统内部的订单号，32个字符内、可包含字母

```javascript
{
	"merchant_id": "8015023289585984",
	"mch_trade_id": "unipay1256"
}
```
### 11.2.1 返回参数

字段名 | 变量名|类型|说明
---|---|---|---|---
版本号	|version	|是|	String|	version默认值为1.0
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息|	msg	|是	|String	|返回信息，如成功则为空;如非空, 显示错误原因
交易耗时|	time_elapsed|	string|	交易消耗时间

## 11.3银联分期退款接口(当日)

接口:paygate/merchant_info/refund

### 11.3.1请求参数

字段名 | 变量名|必填|类型|说明
---|---|---|---|---
商户号| merchant_id|是|string|商户号，由平台分配，18位纯数字
商户订单号|	mch_trade_id|是|	String	|商户系统内部的订单号，32个字符内、可包含字母
商户退款单号|		mch_refund_id|		是	|	String	|	商户系统内部的退款订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
退款金额|		refund_fee	|	是|		Int	|	退款金额

```javascript
{
	"merchant_id": "8015023289585984",
	"mch_trade_id": "unipay1256",
	"mch_refund_id": "refund1238",
	"refund_fee": "1200" # 必须与订单金额相等
}
```
### 11.3.2返回参数

字段名 | 变量名|类型|说明
---|---|---|---|---
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息|	msg	|是	|String	|返回信息，如成功则为空;如非空, 显示错误原因

 
## 11.4错误码表

返回code|描述
---|---
0|成功
1|不能重复撤销订单
47|订单号不存在或者，订单非银联分期订单
50|对已经确认收货的订单重复收货
 
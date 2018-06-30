## 4.5 退款查询接口

测试： http://gateway-test.pooulcloud.cn/paygate/merchant_info/refund_query 

生产： http://gateway.pooulcloud.cn/paygate/merchant_info/refund_query


### 4.5.1  接口规范

报文编码格式采用utf-8的字符串

### 4.5.2  签名规则
MD5签名


### 4.5.3 参数设置

请求参数

>请求参数示例

```javascript
{
    "merchant_id":"59382e3cffea0e5fcd0cfc3e",
    "mch_refund_id":"1509616430"
}
```

字段名|	参数名|	是否必填|	类型|说明
---|---|---|---|---
商户号|		merchant_id|是|	String|	系统内商户唯一标识号码
商户退款单号|	mch_refund_id|	否	|String	|商户系统内部的退款订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
平台退款单号|	refund_id|	否|	String|	平台退款订单号,mch_refund_id 和 refund_id 至少一个必填，同时存在时 refund_id 优先
签名|	sign|	是|	String|	MD5签名结果
签名方式|sign_type|是|String|默认：MD5

返回参数

字段名|	参数名|	是否必填|	类型|说明
---|---|---|---|---
版本号|	version	|是|	String|	version默认值为1.0
签名方式|	sign_type|	是	|	String	默认：MD5
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息|	msg	|		是	|String|	返回信息，如成功则为空;如非空, 显示错误原因

-当code为0时，返回

>退款查询返回结果：

```javascript
{
    "code": 0,
    "msg": ",,",
    "data": {
        "mch_trade_id": "alex.wechat.1509616329",
        "merchant_id": "59382e3cffea0e5fcd0cfc3e",
        "trade_id": "59faead1fd4eb0751a4f8c41",
        "refund_id": "59faeb32fd4eb0751a4f8c50",
        "mch_refund_id": "1509616430",
        "refund_fee": 1,
        "refund_status": 1,
        "nonce_str": "59faeb4dfd4eb0751a4f8c55"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "4886BCC8D8B30D9BE9224A1BC1C02157"
}
```

字段名|	参数名|	是否必填|	类型|说明
---|---|---|---|---
退款状态码|	refund_ status	|是	|Int|	退款状态标识
签名|	sign|	是	|String	|MD5签名结果
商户号	|merchant_id|	是|	String|	系统内商户唯一标识号码
商户退款单号|	mch_refund_id|	是	|String	|商户系统内部的退款订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
退款金额|	refund_fee|	是|	Int	|退款金额
商户订单号|	mch_trade_id|	是	|String	|商户系统内部的订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
平台订单号|	trade_id|是|	String|	平台订单号,mch_trade_id 和 trade_id 至少一个必填，同时存在时 trade_id 优先
平台退款单号|	refund_id|	是|	String|	平台退款订单号, 
## 4.6 关闭订单接口

测试：http://gateway-test.pooulcloud.cn/paygate/merchant_info/order_close

生产：http://gateway.pooulcloud.cn/paygate/merchant_info/order_close

### 4.6.1  接口规范

报文编码格式采用utf-8的字符串

### 4.6.2 签名规则
MD5签名

### 4.6.3 关闭订单状态码表

状态码|说明
---|---
0|	关闭成功
1|	已关闭
-1|	关闭失败


### 4.6.4 参数设置

请求参数

```javascript
{
    "merchant_id":"59382e3cffea0e5fcd0cfc3e",
    "mch_trade_id":"alex.wechat.15096163291"
}
```

字段名|	参数名|		是否必填|		类型|		说明
---|---|---|---|---
商户号|	merchant_id	|是	|String|	系统内商户唯一标识号码
商户订单号|	mch_trade_id|	否	|String	|商户系统内部的订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
平台订单号|	 trade_id|否|	String|	平台订单号,mch_trade_id 和 trade_id 至少一个必填，同时存在时 trade_id 优先
签名|	sign|	是|	String|	MD5签名结果
签名方式|sign_type|是|String|默认：MD5



返回参数

字段名|	参数名|		是否必填|		类型|		说明
---|---|---|---|---
版本号|	version	|是|	String|	version默认值为1.0
签名方式|	sign_type|	是	|	String|	默认：MD5
返回状态码|	code|	是|	String|	0表示成功，非0表示失败。 此字段为通信标识
返回信息|	msg	|		是|	String|	返回信息，如成功则为空;如非空, 显示错误原因

-当code为0时，返回

```javascript
{
    "code": 0,
    "msg": "SUCCESS",
    "data": {
        "close_status": "0",
        "mch_trade_id": "alex.wechat.15096163291",
        "merchant_id": "59382e3cffea0e5fcd0cfc3e",
        "trade_id": "59faeb63fd4eb0751a4f8c56",
        "nonce_str": "59faeb88fd4eb0751a4f8c5b"
    },
    "version": "1.0",
    "sign_type": "md5",
    "sign": "27960E5A200E30E084C04CFB440BF659"
}
```

字段名|	参数名|		是否必填|		类型|		说明
---|---|---|---|---
签名|	sign|	是|	String	|MD5签名结果
关闭状态码|	close_staus|是	|Int|	关闭返回状态码
商户号|	merchant_id	|是	|String	|系统内商户唯一标识号码
商户订单号|	mch_trade_id|	是|	String	|商户系统内部的订单号, 最长为32个字符, 可包含字母, 需要确保在商户系统唯一
平台订单号|	Trade_id|	是|	String|	平台订单号
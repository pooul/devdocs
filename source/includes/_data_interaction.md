# 2. 数据交互方式

## 2.1 数据提交格式
- 请使用标准的 Https Post协议提交数据;
- 报文编码格式采用utf-8的字符串;
- 传输的请求与响应及通知请使用JSON格式;
- 传输数据请求与响应及通知必须签名;
- 签名默认使用MD5方式(详情请见 签名算法)，也支持JWT,RS2方式;
- MD5的秘钥请联系您的运营人员获取。

> 数据提交示例 - 2.1.A  


> Post http://gateway-test.pooulcloud.cn/paygate/merchant_info/pay

```javascript
{

  "sign_type": "md5",
  "sign": "72ED16F9AD20********A7EB5"
  "merchant_id":"59382e3cff****************fc3e",
  "pay_type":"wechat.scan",
  "mch_trade_id":"alex.wechat.1*******9",
  "time_start":14973***99,
  "body":"天虹龙华店-食品",
  "total_fee":1,
  "spbill_create_ip":"127.0.***",
  "notify_url":"http://cb.pooulcloud.cn/notify/test_notify/wechat.1497************3199"
}
```


## 2.2 数据返回格式

### 2.2.1 同步返回(response)

- 普尔翰达会用JSON格式响应同步请求;
- 响应都会使用MD5进行签名, 响应中会带有签名;
- 签名只针对data中的数据

> 响应数据示例- 2.2.1.A(成功响应)  

```javascript
{
  "code": 0,
  "msg": null,
  "data": {
      "code_url": "weixin://wxpay/b*********ODdI",
      "appid": "wx290ce4878c9****4369d",
      "trade_id": "59706a*******e898",
      "mch_trade_id": "alex.wechat.1***9",
      "merchant_id": "59382e3c*******cd0cfc3e",
      "pay_type": "wechat.scan"
  },
  "version": "1.0",
  "sign_type": "md5",
  "sign": "1AAB25866C952F*****************A4F62F3F950A"
}
```

> 响应数据示例- 2.2.1.B(失败响应)

```javascript
{
    "code":101,
    "msg":"签名有误，验签失败",
    "version":"1.0",
    "sign_type":"MD5",
}
```

### 2.2.2 异步通知(notify)

- notify_url 是普尔云服务器从后台直接发起请求到商户服务器，商户更新 DB 等发货流程需要在 notify_url 完成后，以确保掉单时，普尔云补单能成功补上
- 接入方收到通知时，需要响应字符串"success"（大小写皆可）, 普尔云收到此响应就认为通知已送达，不对此通知进行重发。
- 如接入方响应时间长于5秒或者响应非"success", 普尔云会继续按一定时间间隔进行通知, 通知频率为15/15/30/180/1800/1800/1800/1800/3600，单位：秒；最后一次通知完毕后不再通知。
- 商户需要做去重处理，避免多次发货

> Notify示例

```javascript 
{
  "code":0,
  "msg":null,
  "data":{
      "out_trade_id":"40035*************01751192791",
      "ch_trade_id":"755291000**********02214904539",
      "bank_type":"CFT",
      "fee_type":"CNY",
      "is_subscribe":"N",
      "openid":"oMJGHsx-0**********jfXGyly02xI",
      "sub_appid":"wx26a0**********9df7",
      "sub_openid":"oRXdVs**********sxMUYu2FrzMUQo",
      "total_fee":1,
      "sub_is_subscribe":"Y",
      "trade_state":0,
      "trade_info":"交易成功",
      "trade_id":"59706abaf**********03e898",
      "mch_trade_id":"alex.wechat.1**********9",
      "merchant_id":"59382e3c**********0cfc3e",
      "pay_type":"wechat.scan"
  },
  "version":"1.0",
  "sign_type":"md5",
  "sign":"EBA7C90D680**********0394F38875DC4D3"
}

```

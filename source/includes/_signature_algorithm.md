# 3. 签名算法

签名分为两步, 第一步为拼接原始签名字符串, 第二步为使用原始签名字符串计算签名。

## 3.1 原始签名字符串

- 除 sign 字段外, 所有参数按照字段名的 ascii 码从小到大排序后使用&作为间隔符号(即 key1=value1&key2=value2…)拼接而成，空值和空字符串(即null和"")，不参与拼接字符串。
- 签名原始串中, 字段名和字段值都采用原始值, 不进行 URL Encode。

> 原始字符串示例- 2.3.1.A

```javascript
{   
 
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

>  其拼接的原始字符串为:

```java
merchant_id =59382e3cff****************fc3e & pay_type=wechat.scan 
mch_trade_id=alex.wechat.1*******9&time_start=14973***99&body=天虹龙华店-食品& total_fee=1&spbill_create_ip=127.0.***&notify_url=http://cb.pooulcloud.cn/notify/test_notify/wechat.1497***********
```

## 3.2 MD5签名

- 签名时将字符串转化字节流时指定的编码字符集为UTF-8;
- 请使用各自开发平台/语言的库将原始字符串拼接MD5密钥(&key=xxxxxxxxxxxx)生成签名
- 签名结果请统一转换为大写字符

> 签名字符串示例- 2.3.2.A(例2.3.1.A原始字符串拼接MD5密钥后)
  示例中MD5密钥为 aa88a721366c4d47bd9172f43d950c89

```java
merchant_id =59382e3cff****************fc3e & pay_type=wechat.scan 
mch_trade_id=alex.wechat.1*******9&time_start=14973***99&body=天虹龙华店-食品& total_fee=1&spbill_create_ip=127.0.***&notify_url=http://cb.pooulcloud.cn/notify/test_notify/wechat.1497***********&key=m4X2zlJufeTWZLNHOrmNCbJ4TQrKuaCo
```

> 签名结果示例- 2.3.2.B(例2.3.2.A的签名字符串签名的结果)

```
72ED16F9AD20********A7EB5

```

# 账务 Accounting

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：账务查询

## 查询交易记录 Pay orders

### 搜索交易明细 Pay order search

```
Post /cms/pooul_bills/search_order?
```

> 请求示例

```shell
curl -X POST /cms/pooul_bills/search_order?merchant_id=9609932494323355&desc=1&time_start=1531115400&time_end=1531115700 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "pay_type": "wechat.micro",
    "trade_state": 0
}'
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5b43125401c9114d83865b88",
            "_type": "Ns::PayOrder::Wechat",
            "auth_code": "134725320299883049",
            "body": "Alex Test Micro",
            "created_at": 1531122260,
            "mch_trade_id": "alextest.micro.91",
            "merchant_id": "5399355381712172",
            "pay_type": "wechat.micro",
            "refund_fee": 0,
            "settle_fee": 221,
            "settle_rate": 50,
            "spbill_create_ip": "127.0.0.1",
            "total_fee": 222,
            "trade_fee": 1,
            "trade_state": 0,
            "updated_at": 1531122302,
            "merchant_info": {
                "merchant_id": "5399355381712172",
                "business_short_name": "平克文化",
                "corporate_full_name": null
            }
        },
        {
            "_id": "5b42f81801c911417df535ca",
            "_type": "Ns::PayOrder::Wechat",
            "attach": "Alex attach Test",
            "body": "Alex Test Wechat micro",
            "created_at": 1531115544,
            "device_info": "alex wechat device",
            "mch_trade_id": "alextest.micro.146",
            "merchant_id": "5399355381712172",
            "notify_url": "http://112.74.184.236:3006/fake-recv",
            "op_user_id": "11",
            "openid": "oRXdVs59x_E6nVTBHXHkuSjsNVKw",
            "out_trade_id": "4200000123201807097783379411",
            "pay_type": "wechat.micro",
            "refund_fee": 0,
            "settle_fee": 0,
            "settle_rate": 50,
            "spbill_create_ip": "127.0.0.1",
            "total_fee": 22,
            "trade_fee": 0,
            "trade_state": 0,
            "updated_at": 1531115571,
            "merchant_info": {
                "merchant_id": "5399355381712172",
                "business_short_name": "平克文化",
                "corporate_full_name": null
            }
        }
    ]
}
```

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
desc | 留空则返回本商户交易列表，desc=1则返回下属商户交易列表
time_start | 开始时间，支付创建时间，不传默认为查询当天0点，格式为unix时间戳，10位，如：1531115400
time_end | 结束时间，支付创建时间，不传默认为截止到当前时间，格式为unix时间戳，10位，如：1531115700
pagination | 请参考[分页说明](#pagination)

Body参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的下属商户编号
pay_type | 支付类型，[查看支付类型编码](#pay-type)
trade_state | 支付状态
mch_trade_id | 商户支付订单号
id | trade_id，普尔平台支付订单号


### 获取单笔订单详情

```
GET /cms/pooul_bills/trade_detail?
```

> 请求示例

```shell
curl -X GET /cms/pooul_bills/trade_detail?trade_id=5b44cb1101c9117d49d357bb \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" 
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "5b44cb1101c9117d49d357bb",
        "_type": "Ns::PayOrder::Wechat",
        "auth_code": "134628759621503841",
        "body": "Alex Test Micro",
        "created_at": 1531235089,
        "mch_trade_id": "alextest.micro.97",
        "merchant_id": "1333259781809471",
        "pay_type": "wechat.micro",
        "refund_fee": 299,
        "settle_fee": 298,
        "settle_rate": 50,
        "spbill_create_ip": "127.0.0.1",
        "total_fee": 299,
        "trade_fee": 1,
        "trade_state": 1,
        "updated_at": 1531307455,
        "merchant_info": {
            "merchant_id": "1333259781809471",
            "business_short_name": "平克福田梅林",
            "corporate_full_name": null
        },
        "pay_route": {
            "_id": 51,
            "_type": "Ns::PayRoute::Wechat",
            "channel_mch_id": "1353760602"
        },
        "refunds": [
            {
                "_id": "5b45e5be01c9113bfa520c4a",
                "created_at": 1531307454,
                "refund_fee": 299,
                "refund_status": "SUCCESS"
            }
        ]
}
```


URL参数说明

参数 | 描述
-- | -- 
trade_id | 普尔平台订单编号


## 查询网银转账记录 Cmbc fund order

### 搜索网银转账明细 Cmbc fund order search

```
Post /cms/pooul_bills/search_cmbc_fund?
```

> 请求示例

```shell
curl -X POST /cms/pooul_bills/search_cmbc_fund?merchant_id=9609932494323355&desc=1&time_start=1531115400&time_end=1531115700 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "draweeAccName": "李四"
}'
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5b7e960b01c911472ce3b207",
            "created_at": 1535022603,
            "currencyCategory": "",
            "dcFlag": "2",
            "draweeAccName": "白云006",
            "draweeAccNo": "6226223301229640",
            "draweeAccType": "",
            "draweePartyId": "305100000013",
            "draweePartyName": "中国民生银行",
            "fundAcc": "9902000003145455",
            "merchantNum": "3300000900001182",
            "merchant_id": "3500395694632388",
            "payeeAccName": "倪川林龙帅",
            "payeeAccNo": "9902000003145455",
            "payeeAccType": "P",
            "payeePartyId": "",
            "payeePartyName": "",
            "platform_merchant_id": "2339779661268962",
            "postscript": "手机转账",
            "reqSeq": "310002018082300294068225440E5E70",
            "summary": "手机转账",
            "tranDate": "20180823",
            "tranTime": "181917201",
            "tran_amount_fee": 2318,
            "tran_at": 1535019557,
            "merchant_info": {
                "merchant_id": "3500395694632388",
                "business_short_name": "版本环境测试-囧囧",
                "corporate_full_name": null
            }
        },
        {
            "_id": "5b7e960b01c911472ce3b206",
            "created_at": 1535022603,
            "currencyCategory": "",
            "dcFlag": "2",
            "draweeAccName": "白云006",
            "draweeAccNo": "6226223301229640",
            "draweeAccType": "",
            "draweePartyId": "305100000013",
            "draweePartyName": "中国民生银行",
            "fundAcc": "9902000003145455",
            "merchantNum": "3300000900001182",
            "merchant_id": "3500395694632388",
            "payeeAccName": "倪川林龙帅",
            "payeeAccNo": "9902000003145455",
            "payeeAccType": "P",
            "payeePartyId": "",
            "payeePartyName": "",
            "platform_merchant_id": "2339779661268962",
            "postscript": "手机转账",
            "reqSeq": "310002018082300294068365440E5F75",
            "summary": "手机转账",
            "tranDate": "20180823",
            "tranTime": "182048533",
            "tran_amount_fee": 1155,
            "tran_at": 1535019648,
            "merchant_info": {
                "merchant_id": "3500395694632388",
                "business_short_name": "版本环境测试-囧囧",
                "corporate_full_name": null
            }
        }
    ]
}
```

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
desc | 留空则返回本商户转账列表，desc=1则返回下属商户转账列表
time_start | 开始时间，不传默认为查询当天0点，格式为unix时间戳，10位，如：1531115400
time_end | 结束时间，不传默认为截止到当前时间，格式为unix时间戳，10位，如：1531115700
pagination | 请参考[分页说明](#pagination)

Body参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的下属商户编号
draweeAccName | 付款人姓名
draweeAccNo | 付款人账号

### 获取单笔转账详情 Cmbc fund order detail

```
GET /cms/pooul_bills/cmbc_fund_detail?
```

> 请求示例

```shell
curl -X GET /cms/pooul_bills/cmbc_fund_detail?trade_id=5b7e960b01c911472ce3b206 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" 
```

> 响应示例

```json
{
    "_id": "5b7e960b01c911472ce3b206",
    "created_at": 1535022603,
    "currencyCategory": "",
    "dcFlag": "2",
    "draweeAccName": "白云006",
    "draweeAccNo": "6226223301229640",
    "draweeAccType": "",
    "draweePartyId": "305100000013",
    "draweePartyName": "中国民生银行",
    "fundAcc": "9902000003145455",
    "merchantNum": "3300000900001182",
    "merchant_id": "3500395694632388",
    "payeeAccName": "倪川林龙帅",
    "payeeAccNo": "9902000003145455",
    "payeeAccType": "P",
    "payeePartyId": "",
    "payeePartyName": "",
    "platform_merchant_id": "2339779661268962",
    "postscript": "手机转账",
    "reqSeq": "310002018082300294068365440E5F75",
    "summary": "手机转账",
    "tranDate": "20180823",
    "tranTime": "182048533",
    "tran_amount_fee": 1155,
    "tran_at": 1535019648,
    "merchant_info": {
        "merchant_id": "3500395694632388",
        "business_short_name": "版本环境测试-囧囧",
        "corporate_full_name": null
    }
}
```


URL参数说明

参数 | 描述
-- | -- 
_id | 普尔平台编号


## 获取交易汇总 Summary

主要分为三种维度的汇总方式，

- 实时交易汇总：指查询汇总当日0点至查询当时的交易金额汇总
- 日汇总：已对账完成的交易汇总，按日汇总
- 月汇总：已对账完成的交易汇总，按月汇总

### 实时汇总 Today summary

> GET /cms/pooul_bills/today?merchant_id=9609932494323355&desc=1

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "total": {
            "total_fee": 4390,
            "total_trade_fee": 10,
            "total_settle_fee": 4367,
            "order_count": 6,
            "amount_settle_fee": 1960,
            "total_refund_fee": 2420
        },
        "wechat.scan": {
            "total_fee": 1377,
            "total_trade_fee": 4,
            "total_settle_fee": 1370,
            "order_count": 3,
            "amount_settle_fee": 861,
            "total_refund_fee": 512
        },
        "wechat.micro": {
            "total_fee": 901,
            "total_trade_fee": 3,
            "total_settle_fee": 896,
            "order_count": 2,
            "amount_settle_fee": 563,
            "total_refund_fee": 335
        },
        "wechat.jsapi": {
            "total_fee": 2112,
            "total_trade_fee": 3,
            "total_settle_fee": 2101,
            "order_count": 1,
            "amount_settle_fee": 536,
            "total_refund_fee": 1573
        }
    }
}
```

使用此接口可以查询当日0点到查询当前时间的交易汇总，分为pay_type各类型汇总与所有汇总，请求参数可以选择当前商户或是当前商户的下级所有商户交易记录汇总

请求方式：GET /cms/pooul_bills/today?

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
desc | 留空则返回本商户汇总，desc=1则返回下属商户汇总


### 日汇总 Day summary

> GET /cms/pooul_bills/day_summary?merchant_id=9609932494323355&month=201807&desc=1

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "2018-06-30": {
            "wechat.scan": {
                "total_fee": 9093,
                "total_trade_fee": 1,
                "total_settle_fee": 9092,
                "total_refund_fee": 8872,
                "order_count": 3,
                "amount_settle_fee": 220
            },
            "total": {
                "total_fee": 9093,
                "total_trade_fee": 1,
                "total_settle_fee": 9092,
                "total_refund_fee": 8872,
                "order_count": 3,
                "amount_settle_fee": 220
            }
        },
        "2018-06-29": {
            "wechat.scan": {
                "total_fee": 2113,
                "total_trade_fee": 11,
                "total_settle_fee": 2102,
                "total_refund_fee": 0,
                "order_count": 1,
                "amount_settle_fee": 2102
            },
            "total": {
                "total_fee": 2113,
                "total_trade_fee": 11,
                "total_settle_fee": 2102,
                "total_refund_fee": 0,
                "order_count": 1,
                "amount_settle_fee": 2102
            }
        },
        "2018-06-28": {
            "wechat.jsapi": {
                "total_fee": 9961,
                "total_trade_fee": 22,
                "total_settle_fee": 9939,
                "total_refund_fee": 5720,
                "order_count": 6,
                "amount_settle_fee": 4219
            },
            "total": {
                "total_fee": 18530,
                "total_trade_fee": 39,
                "total_settle_fee": 18491,
                "total_refund_fee": 11394,
                "order_count": 14,
                "amount_settle_fee": 7097
            },
            "wechat.micro": {
                "total_fee": 2214,
                "total_trade_fee": 0,
                "total_settle_fee": 2214,
                "total_refund_fee": 2203,
                "order_count": 5,
                "amount_settle_fee": 11
            },
            "wechat.scan": {
                "total_fee": 6355,
                "total_trade_fee": 17,
                "total_settle_fee": 6338,
                "total_refund_fee": 3471,
                "order_count": 3,
                "amount_settle_fee": 2867
            }
        },
        "2018-06-27": {
            "wechat.scan": {
                "total_fee": 17,
                "total_trade_fee": 0,
                "total_settle_fee": 17,
                "total_refund_fee": 10,
                "order_count": 4,
                "amount_settle_fee": 7
            },
            "total": {
                "total_fee": 710,
                "total_trade_fee": 2,
                "total_settle_fee": 708,
                "total_refund_fee": 218,
                "order_count": 12,
                "amount_settle_fee": 490
            },
            "common.micro": {
                "total_fee": 487,
                "total_trade_fee": 1,
                "total_settle_fee": 486,
                "total_refund_fee": 208,
                "order_count": 6,
                "amount_settle_fee": 278
            },
            "wechat.jsapi": {
                "total_fee": 206,
                "total_trade_fee": 1,
                "total_settle_fee": 205,
                "total_refund_fee": 0,
                "order_count": 2,
                "amount_settle_fee": 205
            }
        }
    }
}
```
使用此接口在请求中输入月份信息可以查询当月所有日期的交易汇总，分为pay_type各类型汇总与所有汇总，请求参数可以选择当前商户或是当前商户的下级所有商户交易记录汇总

请求方式：GET /cms/pooul_bills/day_summary?

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
desc | 留空则返回本商户汇总，desc=1则返回下属商户汇总
month | 月份，如：201807， 则返回2018年7月所有日期的交易汇总数据

### 月汇总 Month summary

> GET /cms/pooul_bills/month_summary?merchant_id=9609932494323355&year=2018&desc=1

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "2018-07": {
            "wechat.scan": {
                "total_fee": 2608,
                "total_trade_fee": 13,
                "total_settle_fee": 2595,
                "total_refund_fee": 352,
                "order_count": 9,
                "amount_settle_fee": 2243
            },
            "total": {
                "total_fee": 3831,
                "total_trade_fee": 20,
                "total_settle_fee": 3811,
                "total_refund_fee": 352,
                "order_count": 10,
                "amount_settle_fee": 3459
            },
            "wechat.micro": {
                "total_fee": 1223,
                "total_trade_fee": 7,
                "total_settle_fee": 1216,
                "total_refund_fee": 0,
                "order_count": 1,
                "amount_settle_fee": 1216
            }
        },
        "2018-06": {
            "wechat.scan": {
                "total_fee": 2143,
                "total_trade_fee": 6,
                "total_settle_fee": 2137,
                "total_refund_fee": 1050,
                "order_count": 4,
                "amount_settle_fee": 1087
            },
            "total": {
                "total_fee": 2316,
                "total_trade_fee": 7,
                "total_settle_fee": 2309,
                "total_refund_fee": 1050,
                "order_count": 7,
                "amount_settle_fee": 1259
            },
            "wechat.jsapi": {
                "total_fee": 166,
                "total_trade_fee": 1,
                "total_settle_fee": 165,
                "total_refund_fee": 0,
                "order_count": 2,
                "amount_settle_fee": 165
            },
            "common.micro": {
                "total_fee": 7,
                "total_trade_fee": 0,
                "total_settle_fee": 7,
                "total_refund_fee": 0,
                "order_count": 1,
                "amount_settle_fee": 7
            }
        }
    }
}
```

使用此接口在请求中输入年份信息可以查询当月所有月份的交易汇总，分为pay_type各类型汇总与所有汇总，请求参数可以选择当前商户或是当前商户的下级所有商户交易记录汇总

请求方式：GET /cms/pooul_bills/month_summary?

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
desc | 留空则返回本商户汇总，desc=1则返回下属商户汇总
year | 年份，如：2018， 则返回2018年所有月份的交易汇总数据


## 下载对账单 Downloads bills

### 日对账单 Day bills

请求方式：GET /cms/pooul_bills/download_by_date?

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要下载的商户编号
bill_date | 要下载的对账单日期，如：20180706

### 对账单格式

明细文件格式：

成功时，数据以文本表格的方式返回，第一行为表头，后面各行为对应的字段内容，字段内容跟查询订单或退款结果一致，具体字段说明可查阅相应接口。

第一行为表头：
创建时间 付款完成时间 支付单号 商户单号 原始单号 支付类型 商户编号 支付状态 结算状态 付款总金额 代金券金额 结算手续费率 结算手续费 应结算金额 退款单号 退款金额 代金券退款金额 退款状态 退款完成时间 订单标题(兼容支付宝) 商品描述 商家数据包 设备编号 操作员编号 公众号APPID 付款人信息 付款银行 货币种类

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。

汇总文件格式：

第一行为表头：
总订单笔数 总交易金额 结算手续费总金额 应结算总金额 总退款金额

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。


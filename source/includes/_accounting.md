# 账务 Accounting

## 下载对账单 Downloads bills

认证方式：基于Login权限，[查看Login认证说明](#login)

### 日对账单 Day bills

> get /cms/pooul_bills/download_by_date

下载当前商户不需要merchant_id参数，下载下级商户对账单在网址后加上 merchant_id 参数

### 对账单格式

#### 明细文件格式：
成功时，数据以文本表格的方式返回，第一行为表头，后面各行为对应的字段内容，字段内容跟查询订单或退款结果一致，具体字段说明可查阅相应接口。

第一行为表头：
创建时间 付款完成时间 支付单号 商户单号 原始单号 支付类型 商户编号 支付状态 结算状态 付款总金额 代金券金额 结算手续费率 结算手续费 应结算金额 退款单号 退款金额 代金券退款金额 退款状态 退款完成时间 订单标题(兼容支付宝) 商品描述 商家数据包 设备编号 操作员编号 公众号APPID 付款人信息 付款银行 货币种类

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。

#### 汇总文件格式：
第一行为表头：
总订单笔数 总交易金额 结算手续费总金额 应结算总金额 总退款金额

从第二行起，为数据记录
各参数以逗号分隔，字段顺序与表头一致。

## 获取交易明细 Pay order query

## 获取交易汇总 Summary

主要分为两种种维度的汇总方式，

- 实时交易汇总：指查询汇总当日0点至查询当时的交易金额汇总
- 已对账交易汇总：已对账完成的交易汇总，可按日或月两种时间范围进行汇总

### 日汇总 Day summary

> get /cms/pooul_bills/day_summary?merchant_id=#{merchant_id}&month=#{month}&desc={true/false}

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

### 月汇总 Month summary

> get /cms/pooul_bills/month_summary?merchant_id=#{merchant_id}&year=#{year}&desc={true/false}

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







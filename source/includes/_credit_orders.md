# 应收账单 Credit orders

平台商户可以根据入驻商户应付款创建对应的应收账单，入驻商户登陆分销易根据应付账单进行支付。

## 创建应收账单 Create credit order

```
POST /cms/credit_orders?merchant_id=6188991921802721
```

> 请求示例

```shell
curl -X POST /cms/credit_orders?merchant_id=6188991921802721 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
	"mch_credit_id":"alextest",
	"total_fee": 9888,
	"expire_at": "2019-07-31",
	"body": "test",
	"notify_url": "https://md.pooul.com/v2_test/notify"
}'
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 请求方式：POST /cms/credit_orders?merchant_id=#{merchant_id}

URL请求参数

请求参数 | 描述
-- | -- 
merchant_id <br> **必填** <br> `string` | 要创建账单的入驻商户编号

Body请求参数

请求参数 | 描述
-- | -- 
mch_credit_id <br> **必填** <br> `string` | 自定义账单编号
total_fee <br> **必填** <br> `int` | 账单金额，单位为分
expire_at <br> **必填** <br> `string` | 账单到期日期，格式为 yyyy-mm-dd，如：2019-07-31
body <br> **可选** <br> `string` | 账单备注
notify_url <br> **可选** <br> `string` | 账单核销成功后通知地址

## 搜索账单 Search credit order

```
POST /cms/credit_orders/search?page_size=20
```

> 请求示例

```shell
curl -X POST /cms/credit_orders/search?page_size=20 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
	"merchant_id":"6188991921802721"
}'
```

> 响应

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5d40133001c91169d77b8122",
            "body": "test",
            "created_at": 1564480304,
            "expire_at": "2019-07-31",
            "mch_credit_id": "alextest",
            "merchant_id": "6188991921802721",
            "merchant_short_name": "医药经销商12",
            "notify_url": "https://md.pooul.com/v2_test/notify",
            "parent_merchant_id": "8099385903140350",
            "parent_merchant_short_name": "应收账单测试（平台商户）",
            "platform_merchant_id": "8099385903140350",
            "reduct_fee": 0,
            "repay_fee": 0,
            "start_at": "2019-07-30",
            "status": -1,
            "total_fee": 9888,
            "updated_at": 1564480304,
            "surplus_fee": 9888,
            "over_fee": 0,
            "surplus_day": 2,
            "over_day": 0,
            "merchant_info": {
                "merchant_id": "6188991921802721",
                "business_short_name": "医药经销商12",
                "owner_name": "发放",
                "owner_mobile": ""
            }
        },
        {
            "_id": "5d400c1401c9115c589d5bd6",
            "created_at": 1564478484,
            "expire_at": "2019-07-29",
            "mch_credit_id": "显示自定义编号",
            "merchant_id": "1239893277879941",
            "merchant_short_name": "测试业务员",
            "parent_merchant_id": "8099385903140350",
            "parent_merchant_short_name": "应收账单测试（平台商户）",
            "platform_merchant_id": "8099385903140350",
            "reduct_fee": 0,
            "repay_fee": 0,
            "start_at": "2019-07-03",
            "status": -1,
            "total_fee": 50000,
            "updated_at": 1564478484,
            "surplus_fee": 50000,
            "over_fee": 0,
            "surplus_day": 0,
            "over_day": 1,
            "merchant_info": {
                "merchant_id": "1239893277879941",
                "business_short_name": "测试业务员",
                "owner_name": "",
                "owner_mobile": ""
            }
        }
    ]
}
```

平台商户可以通过此接口搜索平台商户下属的应收账单，可以在Body带上各种条件进行搜索

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 请求方式：POST /cms/credit_orders/search?page_size=#{page_size}

URL请求参数

请求参数 | 描述
-- | -- 
page_size <br> **可选** <br> `string` | 每页返回数量，默认15条

Body请求参数

请求参数 | 描述
-- | -- 
merchant_id <br> **可选** <br> `string` | 账单对应的入驻商户编号
parent_merchant_id <br> **可选** <br> `string` | 账单对应的父级商户编号
expire_at_begin <br> **可选** <br> `string` | 账单到期日期筛选开始时间，格式为 yyyy-mm-dd，如：2019-07-01
expire_at_finish <br> **可选** <br> `string` | 账单到期日期筛选结束时间，格式为 yyyy-mm-dd，如：2019-07-31
status <br> **可选** <br> `int` | 账单状态：-1: 初始化, 0: 已还清, 2: 超额还款, 3: 取消欠单

## 查询单条账单 Retrieve credit order

```
GET /cms/credit_orders/5d4008f401c91124e94ed8f3
```

> 请求示例

```shell
curl -X GET /cms/credit_orders/5d4008f401c91124e94ed8f3 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 响应

```json
{
    "code": 0,
    "msg": "success",
    "data":
    {
        "_id": "5d4008f401c91124e94ed8f3",
        "body": "test",
        "created_at": 1564477684,
        "expire_at": "2019-07-31",
        "mch_credit_id": "alextest",
        "merchant_id": "6188991921802721",
        "merchant_short_name": "医药经销商12",
        "notify_url": "https://md.pooul.com/v2_test/notify",
        "parent_merchant_id": "8099385903140350",
        "parent_merchant_short_name": "应收账单测试（平台商户）",
        "platform_merchant_id": "8099385903140350",
        "reduct_fee": 0,
        "repay_fee": 3,
        "start_at": "2019-07-30",
        "status": -1,
        "total_fee": 9888,
        "updated_at": 1564478602,
        "surplus_fee": 9885,
        "over_fee": 0,
        "surplus_day": 2,
        "over_day": 0
    }
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 请求方式：POST /cms/credit_orders/#{credit_order_id}

URL请求参数

请求参数 | 描述
-- | -- 
credit_order_id <br> **必填** <br> `string` | 应收账单ID

响应参数说明

响应参数 | 描述
-- | -- 
_id <br> **必填** <br> `string` | 应收账单ID
body <br> **必填** <br> `string` | 账单备注
created_at <br> **必填** <br> `int` | 创建时间，为10位 UNIX 时间戳，如：1530759545
updated_at <br> **必填** <br> `int` | 更新时间，为10位 UNIX 时间戳，如：1530759545
start_at <br> **必填** <br> `string` | 账单周期开始时间，格式为：yyyy-mm-dd，如：2019-07-01
expire_at <br> **必填** <br> `string` | 账单周期结束时间，格式为：yyyy-mm-dd，如：2019-07-01
mch_credit_id <br> **必填** <br> `string` | 自定义账单编号
merchant_id <br> **必填** <br> `string` | 账单对应入驻商户编号
merchant_short_name <br> **必填** <br> `string` | 入驻商户简称
notify_url <br> **必填** <br> `string` | 账单核销成功后通知地址
parent_merchant_id <br> **必填** <br> `string` | 父级商户编号
parent_merchant_short_name <br> **必填** <br> `string` | 父级商户简称
platform_merchant_id <br> **必填** <br> `string` | 平台商户编号
reduct_fee <br> **必填** <br> `int` | 减免金额
repay_fee <br> **必填** <br> `int` | 账单已收金额
total_fee <br> **必填** <br> `int` | 账单总金额
surplus_fee <br> **必填** <br> `int` | 账单未付金额
surplus_day <br> **必填** <br> `int` | 账单剩余天数
over_fee <br> **必填** <br> `int` | 超额还款金额
over_day <br> **必填** <br> `int` | 逾期天数
status <br> **必填** <br> `int` | 状态：-1: 初始化, 0: 已还清, 2: 超额还款, 3: 取消欠单

## 查询账单还款流水 Retrieve credit order records

```
GET /cms/credit_orders/5d4008f401c91124e94ed8f3/records
```

> 请求示例

```shell
curl -X GET /cms/credit_orders/5d4008f401c91124e94ed8f3/records \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 响应

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5d400c7d01c9115e5f9d5bd7",
            "biz_id": "5d400c7701c91157b39d5bd7",
            "body": "test",
            "created_at": 1564478589,
            "credit_order_id": "5d4008f401c91124e94ed8f3",
            "merchant_id": "6188991921802721",
            "order_at": 1564477684,
            "pay_type": "wechat.jsminipg",
            "repay_fee": 1,
            "updated_at": 1564478589
        },
        {
            "_id": "5d400c8a01c9115e5f9d5bdd",
            "biz_id": "5d400c8501c9115e5f9d5bd9",
            "body": "test",
            "created_at": 1564478602,
            "credit_order_id": "5d4008f401c91124e94ed8f3",
            "merchant_id": "6188991921802721",
            "order_at": 1564477684,
            "pay_type": "wechat.jsminipg",
            "repay_fee": 2,
            "updated_at": 1564478602
        }
    ]
}
```

通过此接口可以查询到某一条应收账单的付款明细，如果一笔账单分为多次付款会返回多条记录。

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 请求方式：GET /cms/credit_orders/#{credit_order_id}/records

URL请求参数

请求参数 | 描述
-- | -- 
credit_order_id <br> **必填** <br> `string` | 应收账单ID

响应参数说明

响应参数 | 描述
-- | -- 
_id <br> **必填** <br> `string` | 付款流水ID
credit_order_id <br> **必填** <br> `string` | 付款流水对应的应收账单ID
biz_id <br> **必填** <br> `string` | 支付业务单号
body <br> **必填** <br> `string` | 支付备注
created_at <br> **必填** <br> `int` | 创建时间，为10位 UNIX 时间戳，如：1530759545
updated_at <br> **必填** <br> `int` | 更新时间，为10位 UNIX 时间戳，如：1530759545
order_at <br> **必填** <br> `int` | 付款时间，为10位 UNIX 时间戳，如：1530759545
merchant_id <br> **必填** <br> `string` | 账单对应入驻商户编号
repay_fee <br> **必填** <br> `int` | 付款金额
pay_type <br> **必填** <br> `string` | 支付类型，请参考：[查看支付类型编码](#pay-type)








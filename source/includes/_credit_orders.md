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
status <br> **可选** <br> `int` | 账单状态：-1: 未结清, 0: 已结清, 2: 账单支付超额, 3: 账单已取消

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
- 请求方式：GET /cms/credit_orders/#{credit_order_id}

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
start_at <br> **可选** <br> `string` | 账单周期开始时间，格式为：yyyy-mm-dd，如：2019-07-01
expire_at <br> **可选** <br> `string` | 账单周期结束时间，格式为：yyyy-mm-dd，如：2019-07-01
mch_credit_id <br> **可选** <br> `string` | 自定义账单编号
merchant_id <br> **必填** <br> `string` | 账单对应入驻商户编号
merchant_short_name <br> **可选** <br> `string` | 入驻商户简称
notify_url <br> **可选** <br> `string` | 账单核销成功后通知地址
parent_merchant_id <br> **可选** <br> `string` | 父级商户编号
parent_merchant_short_name <br> **可选** <br> `string` | 父级商户简称
platform_merchant_id <br> **必填** <br> `string` | 平台商户编号
reduct_fee <br> **可选** <br> `int` | 减免金额
repay_fee <br> **可选** <br> `int` | 正数账单为账单已收金额，负数账单为账单已抵扣金额
total_fee <br> **必填** <br> `int` | 账单总金额，可以为正数或者负数
surplus_fee <br> **可选** <br> `int` | 正数为账单未付金额，负数账单为账单未抵扣金额
surplus_day <br> **必填** <br> `int` | 账单剩余天数
over_fee <br> **可选** <br> `int` | 超额还款金额
over_day <br> **可选** <br> `int` | 逾期天数
status <br> **必填** <br> `int` | 状态：-1: 未结清, 0: 已结清, 2: 账单支付超额, 3: 账单已取消

## 账单变更通知 Credit order notify


> 通知示例

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

当账单发生状态或者金额变动后，系统会把相关最新的账单信息以 POST 方法使用 JWT 密文的方式发送给商户创建账单时提交的 notify_url 地址，商户接收后需要JWT解密为json格式并使用普尔公钥验证签名，并响应字符串"success"（大小写皆可）。

对后台通知交互时，如果Pooul收到商户的应答不是成功或响应不正确，系统会认为通知失败，系统会通过一定的策略定期重新发起通知，尽可能提高通知的成功率，但系统不保证通知最终能成功。 （在48小时内最多发送10次通知， 通知间隔时间一般为：1m, 1m, 2m, 5m ,10m, 1h, 2h, 6h, 12h, 24h，备注：m代表分钟，h代表小时）

注意：同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。 推荐的做法是，当收到通知进行处理时，首先检查对应业务数据的状态，判断该通知是否已经处理过，如果没有处理过再进行处理，如果处理过直接返回结果成功。在对业务数据进行状态检查和处理之前，要采用数据锁进行并发控制，以避免函数重入造成的数据混乱。

特别提醒：商户系统对于通知结果的内容一定要做签名验证，并校验返回的账单金额是否与商户侧的金额一致，防止数据泄漏导致出现“假通知”，造成资金损失。

通知参数说明

通知参数 | 描述
-- | -- 
_id <br> **必填** <br> `string` | 应收账单ID
body <br> **必填** <br> `string` | 账单备注
start_at <br> **可选** <br> `string` | 账单周期开始时间，格式为：yyyy-mm-dd，如：2019-07-01
expire_at <br> **可选** <br> `string` | 账单周期结束时间，格式为：yyyy-mm-dd，如：2019-07-01
merchant_id <br> **必填** <br> `string` | 账单对应入驻商户编号
platform_merchant_id <br> **必填** <br> `string` | 平台商户编号
repay_fee <br> **可选** <br> `int` | 正数账单为账单已收金额，负数账单为账单已抵扣金额
total_fee <br> **必填** <br> `int` | 账单总金额，可以为正数或者负数
surplus_fee <br> **可选** <br> `int` | 正数为账单未付金额，负数账单为账单未抵扣金额
status <br> **必填** <br> `int` | 状态：-1: 未结清, 0: 已结清, 2: 账单支付超额, 3: 账单已取消


## 取消单条账单 Cancel credit order

```
PUT /cms/credit_orders/cancel?merchant_id=#{merchant_id}
```

> 请求示例

```shell
curl -X PUT /cms/credit_orders/5d4008f401c91124e94ed8f3 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
-d '{
    "id":"5cfe6a7e01c91175926d53e0"
}'
```

> 响应

```json
{
    "code": 0,
    "msg": "success"
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 请求方式：PUT /cms/credit_orders/cancel?merchant_id=#{merchant_id}

URL请求参数

请求参数 | 描述
-- | -- 
merchant_id <br> **必填** <br> `string` | 应收账单对应的入驻商户编号

BODY请求参数

请求参数 | 描述
-- | -- 
id <br> **必填** <br> `string` | 系统返回的应收账单ID





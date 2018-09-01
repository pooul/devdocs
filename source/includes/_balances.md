# 结余 balances

入驻商户通过微信支付、支付宝支付后，或使用网银转账至民生子账户后系统会对入账成功的交易进行记账处理，记账完成后会增加入驻商户结余，手续费差额部分会记到对应的平台商户结余中，可以查询到记账明细，结余金额，平台商户可以调用接口进行结余的转账。

## 查询记账账簿结余 Query balances

```
GET /cms/balances?merchant_id=#{merchant_id}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5b85345259376863211d640a",
            "account_type": 1,
            "balance": -7908,
            "created_at": 1535456338,
            "merchant_id": "7609332123096874",
            "updated_at": 1535612151
        }
    ]
}
```
通过此接口查询平台商户、入驻商户实时结余

通过此接口可以查询到平台商户、入驻商户记账账簿结余，merchant_id 可以是平台商户merchant_id或是入驻商户merchant_id

鉴权方式：Login

## 查询记账账簿明细 Balances list

通过此接口查询平台商户、入驻商户记账明细，默认显示当天的明细，加上time_start、time_end【10位时间戳】可以查询制定时间范围的明细，

鉴权方式：Login

```
GET /cms/balances/history?merchant_id=5399355381712172
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": 769,
            "amount": 100000,
            "balance": -7908,
            "balance_account_id": "5b85345259376863211d640a",
            "balance_prev": -107908,
            "biz_id": "5b8794f701c9114c0ae12b5b",
            "biz_type": 7,
            "created_at": 1535612151,
            "trade_at": 1535612151,
            "updated_at": 1535612151
        },
        {
            "_id": 765,
            "amount": -100000,
            "balance": -107908,
            "balance_account_id": "5b85345259376863211d640a",
            "balance_prev": -7908,
            "biz_id": "5b87948f01c9114c0ae12b59",
            "biz_type": 7,
            "created_at": 1535612047,
            "trade_at": 1535612047,
            "updated_at": 1535612047
        }
    ]
}
```
URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的商户编号
time_start | 开始时间，业务创建时间，不传默认为查询当天0点，格式为unix时间戳，10位，如：1531115400
time_end | 结束时间，业务创建时间，不传默认为截止到当前时间，格式为unix时间戳，10位，如：1531115700
pagination | 请参考[分页说明](#pagination)

## 内部转账 Internal transfers

内部转账的功能用于平台商户下的入驻商户及本平台商户记账结余进行调账
只允许同一平台商户下入驻商户及本平台商户进行转账

转账是是否允许为负：在入驻商户资料中用 arrears 来标识，为true允许转账后该商户为负数，为false不允许改商户转账为负数，平台商户默认为 true，入驻商户默认为 false

### 内部转账接口

```
/v2/internal_transfers?merchant_id=#{平台商户merchant_id}
```

> 请求示例

```json
{
    "payer_merchant_id":"1333259781809471",
    "payee_merchant_id":"1111562791605746",
    "amount": 5000,
    "trade_fee":50,
    "transfer_type": 1,
    "voucher":"测试",
    "remarks":"友情赠送",
    "op_user_id":"301"
}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success"
}
```

平台商户使用此接口可以对结余进行划账，支持：平台商户》入驻商户；入驻商户〉平台商户；入驻商户》入驻商户
平台商户默认余额允许为负，入驻商户余额默认不允许为负，如需修改入驻商户余额允许为负，请调用[入驻商户资料修改接口](#c9c77517fe)

鉴权方式：RSA

请求参数 | 描述
-- | -- 
payer_merchant_id <br> **必填** <br> `int` | 付款方商户编号,可以是平台商户或入驻商户
payee_merchant_id <br> **必填** <br> `string` | 收款方商户编号,可以是平台商户或入驻商户
amount <br> **必填** <br> `string` | 转账金额，单位为分
trade_fee <br> **可选** <br> `string` | 转账手续费，单位为分
transfer_type <br> **可选** <br> `string` | 划账业务类型，客户自定义
voucher <br> **必填** <br> `int` | 转账凭证，可以是会计凭证编号，或订单号
remarks <br> **可选** <br> `boolean`  | 备注，对这笔转账的说明
op_user_id <br> **可选** <br> `string` | 操作员，可以传user_id

### 内部转账列表搜索

```
POST /cms/internal_transfers/search?merchant_id=#{平台/入驻商户merchant_id}&page_size=&time_start=&time_end=
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5b87a64e01c911512c526cb3",
            "amount": 3,
            "created_at": 1535616590,
            "op_user_id": "301",
            "payee_merchant_id": "1111562791605746",
            "payee_merchant_info": {
                "merchant_id": "1111562791605746",
                "business_short_name": "平克龙华天虹",
                "corporate_full_name": null
            },
            "payer_merchant_id": "1333259781809471",
            "payer_merchant_info": {
                "merchant_id": "1333259781809471",
                "business_short_name": "平克福田梅林",
                "corporate_full_name": null
            },
            "platform_merchant_id": "7609332123096874",
            "remarks": "友情赠送",
            "status": true,
            "trade_fee": 0,
            "transfer_type": "1",
            "voucher": "测试"
        },
        {
            "_id": "5b8794f701c9114c0ae12b5b",
            "amount": 100000,
            "created_at": 1535612151,
            "op_user_id": 356,
            "payee_merchant_id": "7609332123096874",
            "payee_merchant_info": {
                "merchant_id": "7609332123096874",
                "business_short_name": "平克集团",
                "corporate_full_name": "深圳市平克茶业文化发展有限公司"
            },
            "payer_merchant_id": "6396748202542473",
            "payer_merchant_info": {
                "merchant_id": "6396748202542473",
                "business_short_name": "猫小猫",
                "corporate_full_name": "猫的窝"
            },
            "platform_merchant_id": "7609332123096874",
            "remarks": "",
            "status": true,
            "trade_fee": 0,
            "transfer_type": "",
            "voucher": ""
        }
    ]
}
```


鉴权方式：Login

### 内部转账记录详情

```
GET /cms/internal_transfers/#{internal_transfer_id}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "5b8608ac01c91159918df773",
        "amount": 100000,
        "created_at": 1535510700,
        "op_user_id": "302",
        "payee_merchant_id": "2339779661268962",
        "payee_merchant_info": {
            "merchant_id": "2339779661268962",
            "business_short_name": "版本环境测试（可用）",
            "corporate_full_name": ""
        },
        "payer_merchant_id": "2070412485550034",
        "payer_merchant_info": {
            "merchant_id": "2070412485550034",
            "business_short_name": "测试",
            "corporate_full_name": null
        },
        "platform_merchant_id": "2339779661268962",
        "remarks": "fgdfgd",
        "status": true,
        "trade_fee": 111,
        "transfer_type": "1",
        "voucher": "ceshi"
    }
}
```

鉴权方式：Login















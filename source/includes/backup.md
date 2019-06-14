## 入驻商户费率管理 Tenant fee rates

入驻商户入账费率默认使用平台商户设置的统一费率，使用此功能可以单独管理某一入驻商户费率。

- 如设置入驻商户费率为0，则入驻商户入账金额为交易总金额，平台商户入账金额为手续费金额的负数，
- 如设置入驻商户手续费金额大于平台商户实际的支付手续费，入驻商户入账金额为交易总金额-入驻商户手续费，平台商户入账金额为入驻商户手续费-平台商户手续费

### 创建 Create tenant fee rates

```
POST /cms/merchant_fee_rates
```

> 请求示例

```shell
curl -X POST /cms/merchant_fee_rates?merchant_id=4430405652527179 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "pay_type": [wechat.scan，wechat.micro],
    "tenant_settle_rate": 50
}'
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：创建费率

URL请求参数

参数| 描述
--|--
merchant_id <br> **必填** | 待创建费率的入驻商户编号

Body请求参数

参数| 描述
--|--
pay_type <br> **必填** <br> `string` | 指定要创建费率的[支付类型](#pay-type)
tenant_settle_rate <br> **必填** <br> `int` | 结算费率，万分之，如：50，代表万分之50，千分之5，

### 查询 Retrieve tenant fee rates

```
GET /cms/merchant_fee_rates/:_id
```

```shell
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": 36,
        "created_at": 1533030601,
        "merchant_id": "1333259781809471",
        "pay_type": [
            "alipay.scan",
            "alipay.micro"
        ],
        "tenant_settle_rate": 120,
        "updated_at": 1533030601
    }
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询费率

### 修改 Update tenant fee rates

```
PUT /cms/merchant_fee_rates/:_id
```

> 请求示例

```shell
curl -X PUT /cms/merchant_fee_rates/36 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "pay_type": [wechat.scan，wechat.micro],
    "tenant_settle_rate": 50
}'
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：修改费率

URL请求参数

参数| 描述
--|--
_id <br> **必填** | 待修改的费率记录ID

Body请求参数

参数| 描述
--|--
pay_type <br> **必填** <br> `string` | 指定要创建费率的[支付类型](#pay-type)
tenant_settle_rate <br> **必填** <br> `int` | 结算费率，万分之，如：50，代表万分之50，千分之5，

### 删除 Delete tenant fee rates

```
DELETE /cms/merchant_fee_rates/:_id
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：删除费率

删除该条费率，删除入驻商户费率后，入驻商户使用平台商户设置的默认费率

### 查询所有 Search tenant fee rates


```
GET /cms/merchant_fee_rates
```

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": 36,
            "created_at": 1533030601,
            "merchant_id": "1333259781809471",
            "pay_type": [
                "alipay.scan",
                "alipay.micro"
            ],
            "tenant_settle_rate": 120,
            "updated_at": 1533030601
        },
        {
            "_id": 20,
            "created_at": 1531234802,
            "merchant_id": "1333259781809471",
            "pay_type": [
                "wechat.scan",
                "wechat.micro",
                "wechat.jsapi"
            ],
            "tenant_settle_rate": 120,
            "updated_at": 1532445902
        }
    ]
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询费率

查询用户当前入驻商户设置的所有费率

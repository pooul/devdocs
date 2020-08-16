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



## 普通商户 Common merchants

登录用户的当前商户为合作伙伴商户可以创建普通商户，创建好的普通商户归属为当前合作伙伴商户

### 创建 Create common merchant

#### 请求

```
POST /cms/merchants
```

> 请求示例

```shell
curl -X POST /cms/merchants \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "merchant_type":1,
    "parent_id": "7590462217569167",
    "partner_mch_id": "988765",
    "note":"商户备注信息", 
    "license_type":1,
    "business":{
        "short_name":"平克文化",
        "service_call": "0755-82857285",
        "area_code":"440309",
        "province": "广东省",
        "urbn": "深圳市",
        "area": "龙华区",
        "address": "大浪办事处大浪社区新围村71栋101 "
    },
    "corporate":{
        "full_name":"深圳市平克茶业文化发展有限公司",
        "license_num":"91440300398456074L",
   },
    "owner":{
        "idcard_type": 1,
        "name": "雷晶晶",
        "idcard_num": "437757588393842",
        "mobile": "15888888888"
        "email": "support@pooul.cn"
    },
    "ccb_info":{
        "Elc_Mrch_Idy_CgyCd": "04",
        "ElcMrchIdyCgySubCgyCd": "04001",
        "wx_rate": 30
    }
}'
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：创建商户

请求参数 | 描述
-- | -- 
merchant_type <br> **必填** <br> `int` | 商户类型，创建普通商户时固定填1
parent_id <br> **必填** <br> `string` | Pooul为合作伙伴分配的合作伙伴商户编号
partner_mch_id <br> **可选** <br> `string` | 合作伙伴自定义商户编号，如：988765
note <br> **可选** <br> `string` | 商户备注信息
license_type <br> **必填** <br> `int` | 营业类型：1. 企业; 2. 个体工商户，3. 个人
business <br> **部分必填** <br> `object` | 商户经营信息参数集合，请参考[Merchant business 参数](#merchant-business)
corporate <br> **可选** <br> `object` | 营业执照信息参数集合，license_type为3时不需传，请参考[Merchant corporate 参数](#merchant-corporate)
owner <br> **必填** <br> `object` | 所有人/法人信息参数集合，license_type为3时为所有人信息，license_type为1、2时为营业执照法人信息，请参考[Merchant owner 参数](#merchant-owner)
ccb_info <br> **可选** <br> `object` | 申请建行微信支付时必传，请参考：[Merchant ccb info 参数](#merchant-ccb-info)

##### Merchant business 参数

请求参数 | 描述
-- | -- 
short_name <br> **必填** <br> `string`  | 商户简称，经营名称，如：平克文化
service_call <br> **可选** <br> `string`  | 服务电话，如：0755-82857285
area_code <br> **可选** <br> `string`  | 行政区划代码，[参考民政部最新的区划代码](http://www.mca.gov.cn/article/sj/xzqh/2018/)，如：440309
province <br> **必填** <br> `string`  | 经营地址所在省，如：广东省
urbn <br> **必填** <br> `string`  | 经营地址所在地级市，如：深圳市
area <br> **必填** <br> `string`  | 经营地址所在区，如：龙华区
address <br> **必填** <br> `string`  | 经营详细地址，不含省市区，如：大浪办事处大浪社区新围村71栋101

##### Merchant corporate 参数

请求参数 | 描述
-- | -- 
full_name <br> **必填** <br> `string`  | 企业全称，需为营业执照上企业全称，如：深圳市平克茶业文化发展有限公司",
license_num <br> **必填** <br> `string`  | # 非三证合一为营业执照编码，三证合一为统一社会信用代码，如：91440300398456074L",

##### Merchant owner 参数

请求参数 | 描述
-- | -- 
idcard_type <br> **必填** <br> `string` | 身份证件类型，目前只支持身份证，固定值为1
name <br> **必填** <br> `string`  | 真实姓名
idcard_num <br> **必填** <br> `string`  | 身份证号码
mobile <br> **必填** <br> `string`  | 手机号码
email <br> **可选** <br> `string`  | 电子邮箱


##### Merchant ccb info 参数

请求参数 | 描述
-- | -- 
Elc_Mrch_Idy_CgyCd <br> **必填** <br> `string` | 商户行业类别代码，请参考[CCB 商户行业类别](#ccb-industry-category)
ElcMrchIdyCgySubCgyCd <br> **必填** <br> `string`  | 商户行业子类别代码，请参考 [CCB 商户行业子类别](#ccb-industry-sub-category)
wx_rate <br> **必填** <br> `int`  | 申请微信支付费率，以万分之为单位，如：30 代表万分之30，千分之3.


#### 响应

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "6952017140355067",
        ……
    }
}
```

响应参数 | 描述
-- | -- 
_id <br> **必填** <br> `string` | 商户编号 merchant_id，可用于后续业务

若有开通民生银行分销易产品，还会返回

响应参数 | 描述
-- | -- 
fundAccName <br> **必填** <br> `string` | 该入驻商户民生子账簿户名
fundAcc <br> **必填** <br> `string` | 该入驻商户民生子账簿账号



### 查询 Retrieve common merchant

```
GET /cms/merchants/:_id
```

> 请求示例

```shell
curl -X GET /cms/merchants/:_id \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "9973450280059047",
        ……
    }
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询商户

### 修改 Update common merchant

```
PUT /cms/merchants/:_id
```

> 请求示例

```shell
curl -X PUT /cms/merchants/:_id \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "note":"商户备注信息"
}'
```

> 响应示例

```json

{
    "code":0,
    "msg": "success"
}

```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：修改商户

请求参数 | 描述
-- | -- 
note <br> **可选** <br> `string` | 商户备注信息
license_type <br> **必填** <br> `int` | 营业类型：1. 企业; 2. 个体工商户，3. 个人
business <br> **部分必填** <br> `object` | 商户经营信息参数集合，请参考[Merchant business 参数](#merchant-business)
corporate <br> **可选** <br> `object` | 营业执照信息参数集合，license_type为3时不需传，请参考[Merchant corporate 参数](#merchant-corporate)
owner <br> **必填** <br> `object` | 所有人/法人信息参数集合，license_type为3时为所有人信息，license_type为1、2时为营业执照法人信息，请参考[Merchant owner 参数](#merchant-owner)
ccb_info <br> **可选** <br> `object` | 申请建行微信支付时必传 [Merchant ccb info 参数](#merchant-ccb-info)

##### Merchant business 参数

请求参数 | 描述
-- | -- 
short_name <br> **必填** <br> `string`  | 商户简称，经营名称，如：平克文化
service_call <br> **可选** <br> `string`  | 服务电话，如：0755-82857285
area_code <br> **可选** <br> `string`  | 行政区划代码，[参考民政部最新的区划代码](http://www.mca.gov.cn/article/sj/xzqh/2018/)，如：440309
province <br> **可选** <br> `string`  | 经营地址所在省，如：广东省
urbn <br> **可选** <br> `string`  | 经营地址所在地级市，如：深圳市
area <br> **可选** <br> `string`  | 经营地址所在区，如：龙华区
address <br> **可选** <br> `string`  | 经营详细地址，不含省市区，如：龙华区大浪办事处大浪社区新围村71栋101


##### Merchant corporate 参数

请求参数 | 描述
-- | -- 
full_name <br> **必填** <br> `string`  | 企业全称，需为营业执照上企业全称，如：深圳市平克茶业文化发展有限公司",
license_num <br> **必填** <br> `string`  | # 非三证合一为营业执照编码，三证合一为统一社会信用代码，如：91440300398456074L",

##### Merchant owner 参数

请求参数 | 描述
-- | -- 
idcard_type <br> **必填** <br> `string` | 身份证件类型，目前只支持身份证，固定值为1
name <br> **必填** <br> `string`  | 真实姓名
idcard_num <br> **可选** <br> `string`  | 身份证号码
mobile <br> **可选** <br> `string`  | 手机号码

##### Merchant ccb info 参数

请求参数 | 描述
-- | -- 
Elc_Mrch_Idy_CgyCd <br> **必填** <br> `string` | 商户行业类别代码，请参考[CCB 商户行业类别](#ccb-industry-category)
ElcMrchIdyCgySubCgyCd <br> **必填** <br> `string`  | 商户行业子类别代码，请参考 [CCB 商户行业子类别](#ccb-industry-sub-category)
wx_rate <br> **必填** <br> `int`  | 申请微信支付费率，以万分之为单位，如：30 代表万分之30，千分之3.


### 搜索 Search common merchant

```
POST /cms/merchants/search?
```
> 请求示例

```shell
curl -X POST /cms/merchants/search?last_created_at=:created_at&page_size=30 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
-d '{
    "parent_id": "9478629884842467"
}'
```


> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "9973450280059047",
            ……
        },
        {
            "_id": "9906223241351263",
            ……
        }
    ]
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询下级商户

URL请求参数

参数| 描述
--|--
page_size <br> **选填** | 每页可以返回多少数据，限制范围是从 1~100 项，默认是 15 项。
last_created_at <br> **选填** | 在分页时使用的指针，决定了列表的第一项从何处开始。假设你的一次请求返回列表的最后一项的 created_at 是 obj_end，你可以使用 last_created_at = obj_end 去获取下一页。


Body请求参数

参数| 描述
--|--
_id <br> **选填** | 入驻商户编号（merchant_id）
parent_id <br> **选填** | 父级商户编号，输入此参数查询该父级商户所有下一级入驻商户




## CCB 商户行业类别 industry category

类别代码 | 行业类别
--|--
01 |  第三方支付类
02 |  投资理财类
03 |  电子客票类
04 |  生活百货类
05 |  大宗商品类
06 |  教育培训类
07 |  旅游宾馆类
08 |  餐饮娱乐类
09 |  公共事业缴费类
10 |  医疗保健类
11 |  游戏通讯类
12 |  公益事业类
13 |  其他类


## CCB 商户行业子类别 industry sub category

类别代码 | 行业类别
--|--
01001 | 第三方支付
02001 | 基金
02002 | 保险
02003 | 证券
02004 | 黄金
02005 | 其他
03001 | 电子客票
04001 | 生活百货
05001 | 大宗商品
06001 | 人力资源考务
06002 | 教育考务
06003 | 学校杂费
06004 | 机构培训
06005 | 其他
07001 | 旅游宾馆
08001 | 餐饮娱乐
09001 | 公共事业缴费
10001 | 医疗保健
11001 | 游戏
11002 | 通讯
11003 | 其他
12001 | 公益事业类
13001 | 其他


## 银企直连

### 查询实体账户明细

```
GET /cms/merchants/2339779661268962/cmbc_yq_account?date_start=20180723&date_end=20180724&start_no=1&end_no=10
```

> 响应示例

```shell
{
    "code": 0,
    "msg": "success",
    "data": {
        "trnId": "20180918153555",
        "totalNum": "34",
        "allNum": "10",
        "dtlList": {
            "dtlInfo": [
                {
                    "svrId": "31357201809186542102430",
                    "acntNo": "154867362",
                    "acntName": null,
                    "type": "1",
                    "actDate": "2018-09-18",
                    "intrDate": "2018-09-18",
                    "chequeNum": "98000000033",
                    "amount": "2.25",
                    "opAcntNo": "6226********9428",
                    "opAcntName": "雷**",
                    "opBankName": "招商银行股份有限公司",
                    "opBankAddr": null,
                    "opAreaCode": "100086",
                    "explain": "真实，网银互联汇路",
                    "balance": "2677.01",
                    "recseq": "5BA040C2955145E0E10080002821020A",
                    "timestamp": "142023"
                }
            ]
        }
    }
}
```

通过此接口可以查询平台商户在民生银行开通银企直连绑定的实体账户资金流水明细，仅能查询开通民生银企直连的平台商户

认证方式：[Login](#login)

请求URL：GET /cms/merchants/#{平台商户merchant_id}/cmbc_yq_account

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的平台商户编号
date_start | 起始日期，如：20180723
date_end | 结束日期，如：20180724
start_no | 开始条数
end_no | 结束条数

### 对外转账 withdraw

平台商户可以使用次功能将结余对外转至银行卡，支持平台商户、入驻商户对外转账至同名银行卡，需开通民生银行银企直连转账交易功能

#### 发起对外转账


```
POST /v2/withdraw?merchant_id=#{发起对外转账的商户编号}
```

> 请求示例

```json
{
    "mch_withdraw_id": "alex.test.107",
    "withdraw_type": 1,
    "bank_card_id": 232,
    "local_flag": 5,
    "amount":225,
    "trade_fee": 0,
    "voucher": "pooul alex",
    "remarks":"真实，网银互联汇路",
    "op_user_id":"301"
}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "5ba0992501c9111f097decd7",
        "amount": 225,
        "bank_card_id": 232,
        "mch_withdraw_id": "alex.test.107"
    }
}
```

认证方式：[RSA](#rsa)

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 发起对外转账的商户编号


Body参数说明

参数 | 描述
-- | -- 
mch_withdraw_id  <br> **必填** <br> `string`  | 商户发起对外转账的单号，需保证每一个merchant_id唯一
withdraw_type <br> **必填** <br> `int`  | 1 为对外转账到绑定银行卡，现在只能传1
bank_card_id <br> **必填** <br> `int`  | 对外转账的银行卡ID，请先管理商户的银行卡 [bank cards](#bank-cards)
local_flag <br> **必填** <br> `int`  | 对外转账所采取的汇路，如果是民生银行卡则使用 0:本地；1：异地；如果非民生银行卡使用 2:小额; 3大额; 5:网银互联;
amount <br> **必填** <br> `int`  | 对外转账金额，单位为分，如：100代表1元
trade_fee <br> **必填** <br> `int`  | 对外转账手续费，单位为分，如：100代表1元
voucher <br> **必填** <br> `string`  | 对外转账凭证，可以传订单号或财务凭证等用于标识的参数
remarks <br> **必填** <br> `string`  | 备注
op_user_id <br> **必填** <br> `string`  | 操作员编号，user_id


#### 对外转账状态查询


```
POST /v2/withdraw?merchant_id=#{发起对外转账的商户编号}
```

> 请求示例

```json
{
    "mch_withdraw_id": "alex.test.107"
}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "5ba0992501c9111f097decd7",
        "amount": 225,
        "bank_card_id": 232,
        "mch_withdraw_id": "alex.test.107",
        "status": 2
    }
}
```

认证方式：[RSA](#rsa)

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 发起对外转账的商户编号


Body参数说明

参数 | 描述
-- | -- 
mch_withdraw_id  <br> **必填** <br> `string`  | 商户发起对外转账的单号，需保证每一个merchant_id唯一

响应参数说明

参数 | 描述
-- | -- 
_id  <br> **必填** <br> `string`  | 对外转账平台业务ID
mch_withdraw_id  <br> **必填** <br> `string`  | 商户发起对外转账的单号，需保证每一个merchant_id唯一
withdraw_type <br> **必填** <br> `int`  | 1 为对外转账到绑定银行卡，现在只能传1
bank_card_id <br> **必填** <br> `int`  | 对外转账的银行卡ID，请先管理商户的银行卡 [bank cards](#bank-cards)
amount <br> **必填** <br> `int`  | 对外转账金额，单位为分，如：100代表1元
status <br> **必填** <br> `int`  | 转账状态，1为处理中，2 转账成功，3 转账失败


#### 对外转账业务明细查询


```
GET /cms/withdraw/list?merchant_id=#{平台/入驻商户merchant_id}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5ba050ad01c9111f097decb5",
            "amount": 3,
            "bank_card_id": 244,
            "created_at": 1537233069,
            "insId": "5ba050ad01c9111f097decb4",
            "local_flag": 5,
            "mch_withdraw_id": "alex.test.92",
            "merchant_id": "4647079549780673",
            "op_user_id": "301",
            "remarks": "测试",
            "status": 2,
            "trade_fee": 0,
            "trnId": "5ba050ad01c9111f097decb3",
            "updated_at": 1537234491,
            "voucher": "pooul alex",
            "withdraw_type": 1,
            "merchant_info": {
                "merchant_id": "4647079549780673",
                "business_short_name": "小花",
                "corporate_full_name": null
            },
            "bank_card_info": {
                "_id": 244,
                "account_num": "6226********9428",
                "account_type": 0,
                "bank_full_name": "工商银行深圳分行",
                "cmbc_bank": false,
                "contact_tel": "15817329272",
                "created_at": 1537233058,
                "cyber_bank_code": "308584000013",
                "merchant_id": "4647079549780673",
                "owner_name": "雷有民",
                "priority": 1537233058,
                "province": "广东",
                "updated_at": 1537233058,
                "urbn": "深圳",
                "zone": "福田"
            }
        }
    ]
}
```

请求URL：GET /cms/withdraw/list

认证方式：[Login](#login)

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 商户编号
time_start | 开始时间，支付创建时间，不传默认为查询当天0点，格式为unix时间戳，10位，如：1531115400
time_end | 结束时间，支付创建时间，不传默认为截止到当前时间，格式为unix时间戳，10位，如：1531115700
pagination | 请参考[分页说明](#pagination)

#### 对外转账业务详细


```
GET /cms/withdraw/details/#{withdraw_id，对外转账平台业务单号}
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": [
        {
            "_id": "5ba050ad01c9111f097decb5",
            "amount": 3,
            "bank_card_id": 244,
            "created_at": 1537233069,
            "insId": "5ba050ad01c9111f097decb4",
            "local_flag": 5,
            "mch_withdraw_id": "alex.test.92",
            "merchant_id": "4647079549780673",
            "op_user_id": "301",
            "remarks": "测试",
            "status": 2,
            "trade_fee": 0,
            "trnId": "5ba050ad01c9111f097decb3",
            "updated_at": 1537234491,
            "voucher": "pooul alex",
            "withdraw_type": 1,
            "merchant_info": {
                "merchant_id": "4647079549780673",
                "business_short_name": "小花",
                "corporate_full_name": null
            },
            "bank_card_info": {
                "_id": 244,
                "account_num": "6226********9428",
                "account_type": 0,
                "bank_full_name": "工商银行深圳分行",
                "cmbc_bank": false,
                "contact_tel": "15817329272",
                "created_at": 1537233058,
                "cyber_bank_code": "308584000013",
                "merchant_id": "4647079549780673",
                "owner_name": "雷有民",
                "priority": 1537233058,
                "province": "广东",
                "updated_at": 1537233058,
                "urbn": "深圳",
                "zone": "福田"
            }
        }
    ]
}
```

请求URL：GET /cms/withdraw/details/#{withdraw_id，对外转账平台业务单号}

认证方式：[Login](#login)

#### 对外转账汇路说明 Local flag

大额实时支付 (local_flag:3)

- 到账时间：一般半小时 
- 操作时间限制：大额系统开放时间从每个工作日前一日的20:30开始，至工作日当日17:15结束 
- 金额限制：无金额限制 
- 费用说明：按人民银行电子汇划标准八折执行（具体费用咨询民生银行各网点）

小额实时支付 (local_flag:2)

- 到账时间：一般两小时 
- 操作时间限制：7*24小时 
- 金额限制：限于人民币5万元（含）以下 
- 费用说明：按人民银行电子汇划标准八折执行（具体费用咨询民生银行各网点）


网银互联 (local_flag:5)

- 到账时间：一般半小时 
- 操作时间限制：7*24小时 
- 金额限制：限于人民币5万元（含）以下 
- 费用说明：暂时免费（具体费用咨询民生银行各网点）


## 定向转账支付 ecp.transfer

```
POST /v2/pay?merchant_id=5399355381712172
```

> 请求示例

```json
{
    "pay_type":"ecp.transfer",
    "mch_trade_id":"alextest.alipay.scan.211",
    "total_fee": 7622,
    "notify_url":"https://md.pooul.com/v2_test/notify",
    "body":"This's Subjects Alex test",
    "store_id":"9527"
}
``` 

> 响应

```json
{
    "code": 0,
    "msg": "SUCCESS,OK",
    "data": {
        "trade_id": "5c7a43f401c9114317edac30",
        "attach": "自定义参数",
        "mch_trade_id": "alextest.jsapi.89",
        "merchant_id": "1333259781809471",
        "pay_type": "wechat.jsapi",
        "total_fee": 80,
        "pay_info": "{\"fund_acc_name\":\"深圳市普尔瀚达科技有限公司\",\"fund_acc\":9902000016241739,\"ecp_bank_branch\":\"民生银行广州分行\"}",
        "trade_state": 6,
        "trade_info": "支付中, SUCCESS,OK"
    },
    "time_elapsed": 0.6233
}

``` 


使用此功能可以实现商户提交支付请求时，系统根据订单请求分配订单对应虚拟帐号，付款人转账至此帐号完成支付，用于解决大额付款的需求

![image](http://img.pooul.com/cmbc_transfer_up.png)

### 核销订单 Write off

>  POST /v2/pay/writeoff?merchant_id=5399355381712172

```json
{
    "mch_trade_id": #商户订单号
    "nonce_str": #随机字符串
}
``` 
> 响应

```json
{
    "code": 0为成功，非0为失败
    "msg":
}

```

定向转账支付方式专用，其他支付类型不适用

支付订单可以调用核销订单接口对订单对应的虚拟账户进行销户，包括：支付中/ 部分支付/ 全额支付/ 超额支付的订单，核销成功后将不能再对改订单的子账簿帐号进行转账

请求方式：POST /v2/pay/writeoff?

URL请求参数

参数| 描述
--|--
merchant_id <br> **必填** | 发起支付的商户编号，16位数字，由普尔瀚达分配


Body请求参数

参数| 描述
--|--
mch_trade_id <br> **必填** <br> `string` | 商户订单号
nonce_str  <br> **必填** <br> `string` | 随机字符串，在同一个merchant_id 下每次请求必须为唯一，如：wZovMzOCaTJaicnL




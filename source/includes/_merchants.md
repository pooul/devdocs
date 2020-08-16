# 商户管理 Merchants

## 商户类型 Merchant type

- 平台商户 PlatformMerchant：指平台商户或集团商户，拥有多个直营门店或是分销商，merchant_type：2
- 入驻商户 TenantMerchant：平台商户下属商户，merchant_type：3

## 商户状态码 Merchant Status code

| status | status_desc| 说明|
--|--|--
| 1 | 入驻申请 | 合作伙伴通过接口或后台提交成功商户资料至普尔商户系统，等待普尔提交至上游渠道 |
| 2 | 审核中   | 普尔提交商户资料至上游渠道，等待上游渠道审核|
| 3 | 审核失败 |商户审核失败（a.上游渠道返回审核失败，b.普尔审核失败） |
| 4 | 商户停用 | 商户状态停用（a.上游渠道停用商户，b. 普尔停用商户）|
| 5 | 审核通过 | 上游渠道审核成功，并配置好路由等相关交易信息，商户可以正常交易 |





## 入驻商户 Tenant merchants

只有平台商户才可创建下属入驻商户，平台商户可选择开通民生银行分销易产品，开通分销易产品并配置后，创建入驻商户接口会自动返回民生子账簿账号信息

### 商户层级 Tenant merchant level

![image](http://img.pooul.com/MerchantsLevels.png)

### 创建 Create tenant merchant

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
        "idcard_num": ""
        "mobile": "15888888888"
    }
}'
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：创建商户

请求参数 | 描述
-- | -- 
merchant_type <br> **必填** <br> `int` | 商户类型，创建入驻商户时不需要这个参数
parent_id <br> **必填** <br> `string` | 父级商户编号，如为平台商户下属一级商户则为平台商户编号，如为一级以下商户则为该父级商户编号，如：7590462217569167
partner_mch_id <br> **可选** <br> `string` | 平台商户自定义商户编号，如：988765
note <br> **可选** <br> `string` | 商户备注信息
license_type <br> **必填** <br> `int` | 营业类型：1. 企业; 2. 个体工商户，3. 个人
arrears <br> **可选** <br> `boolean`  | 是否允许结余为负，true为允许，false为不允许，默认为 false
business <br> **部分必填** <br> `object` | 商户经营信息参数集合，请参考[Merchant business 参数](#merchant-business)
corporate <br> **可选** <br> `object` | 营业执照信息参数集合，license_type为3时不需传，请参考[Merchant corporate 参数](#merchant-corporate)
owner <br> **必填** <br> `object` | 所有人/法人信息参数集合，license_type为3时为所有人信息，license_type为1、2时为营业执照法人信息，请参考[Merchant owner 参数](#merchant-owner)

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


#### 响应

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "_id": "6952017140355067",
        "_type": "Ns::TenantMerchant",
        "arrears": false,
        "business": {
            "short_name": "试下开通cmbc fund 2"
        },
        "cmbc_info": {
            "fundAccName": "倪川林龙帅",
            "fundAcc": "9902000003178787"
        },
        "created_at": 1535804410,
        "level_code": "00a01j00l",
        "license_type": 3,
        "owner": {
            "idcard_type": 1,
            "name": "李小四",
            "idcard_num": "53992183285145344"
        },
        "parent_id": "2339779661268962",
        "platform_merchant_id": "2339779661268962",
        "status": 5,
        "updated_at": 1535804410
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



### 查询 Retrieve tenant merchant

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

### 修改 Update tenant merchant

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


### 搜索 Search tenant merchant

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


### 更新父级商户 Update parent

```
PUT /cms/merchants/:merchant_id/parent
```
> 请求示例

```shell
curl -X PUT /cms/merchants/7609332123096874/parent \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d' {
    "parent_id": #新的父级商户编号
}
```


> 响应示例

```json
{
    "code": 0,
    "msg": "success"    
}
```

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：需要联系对接商务开通配置

URL请求参数

参数| 描述
--|--
merchant_id <br> **必填** | 要修改的入驻商户编号


Body请求参数

参数| 描述
--|--
parent_id <br> **选填** | 新的父级商户编号


## 分销易子账簿 CMBC Easy distribution

分销易是民生银行产品，可以帮助平台商户解决经销商大额入金并识别来路的需求，具体咨询对接商户经理介绍民生银行全国任一网点进行开通，开通后普尔平台配置后即可使用。

开通分销易后可帮助核心企业实现使用管理后台或是API接口在民生银行系统中创建与经销商唯一对应的子账簿账号，子账簿账号与入驻商户唯一关联，使用网银转账给子账簿账号成功后可以通过在管理后台查询到入驻商户入账信息，或是发送转账成功通知信息给平台商户提供的网址。

### 子账簿入账通知 CMBC fund accounting notify

> 通知内容解密后的格式

```json
{
  "_id": "5bebca4301c911491e29643a",
  "merchant_id": "9409823201581974",
  "fundAcc": "9902000014272942",
  "dcFlag": "2", 
  "tranDate": "20181114",
  "tranTime": "150923403",
  "draweeAccType": "", 
  "draweePartyId": "305100000013",
  "draweePartyName": "中国民生银行",
  "draweeAccNo": "6226221003245583",
  "draweeAccName": "张云",
  "currencyCategory": "",
  "tran_amount_fee": 100,
  "payeeAccType": "",
  "payeePartyId": "",
  "payeePartyName": "",
  "payeeAccNo": "9902000014272942",
  "payeeAccName": "深圳市普尔瀚达科技有限公司",
  "postscript": "",
  "summary": "", 
  "merchantNum": "0300000700000015",
  "reqSeq": "73401201211141503123456544C705F2",
  "tran_at": 1542179363,
  "created_at": 1542179395,
  "platform_merchant_id": "6044885632395970",
  "nonce_str": "5bebca4301c911491e29643b"
}
```

在接收到子账簿入账后，分销易系统会往平台商户配置的网址发送通知，通知内容为JWT文本，平台商户在接收到通知后需要使用分销易公钥解密并验签。平台商户需要接收处理，并需要响应字符串"success"（大小写皆可）。

对后台通知交互时，如果分销易收到商户的应答不是成功或超时，系统认为通知失败，系统会通过一定的策略定期重新发起通知，尽可能提高通知的成功率，但系统不保证通知最终能成功。 （在48小时内最多发送10次通知， 通知间隔时间一般为：1m, 1m, 2m, 5m ,10m, 1h, 2h, 6h, 12h, 24h，备注：m代表分钟，h代表小时）

注意：同样的通知可能会多次发送给商户系统。商户系统必须能够正确处理重复的通知。 推荐的做法是，当收到通知进行处理时，首先检查对应业务数据的状态，判断该通知是否已经处理过，如果没有处理过再进行处理，如果处理过直接返回结果成功。在对业务数据进行状态检查和处理之前，要采用数据锁进行并发控制，以避免函数重入造成的数据混乱。

返回参数说明

参数| 描述
--|--
_id <br> **必填** <br> `string`  | 平台流水号，如：5bebca4301c911491e29643a
merchant_id <br> **必填** <br> `string`  | 平台商户下属性入驻商户编号，如：9409823201581974
fundAcc<br> **必填** <br> `string`  | 子账簿账号，如：9902000014272942
dcFlag <br> **必填** <br> `string`  | 借贷标识，1：借，2：贷
tranDate <br> **必填** <br> `string`  | 转账日期，如：20181114，代表2018年11月14号
tranTime <br> **必填** <br> `string`  | 转账时间，如：150923403，代表15点09分23秒403毫秒
draweeAccType <br> **选填** <br> `string`  | 付款账号类型
draweePartyId <br> **选填** <br> `string` | 付款账号开户行行号
draweePartyName <br> **必填** <br> `string` | 付款账号开户行，如：中国民生银行广州分行营业部
draweeAccNo <br> **必填** <br> `string` | 付款银行账号，如：6226221003245583
draweeAccName <br> **必填** <br> `string` | 付款户名，如：张云
currencyCategory <br> **选填** <br> `string` |  币种
tran_amount_fee <br> **必填** <br> `int` | 交易金额，单位：分，如：100，代表1元
payeeAccType <br> **选填** <br> `string` | 收款账号类型
payeePartyId <br> **选填** <br> `string` | 收款账号开户行行号
payeePartyName <br> **选填** <br> `string` | 收款账号开户行
payeeAccNo <br> **必填** <br> `string` | 收款子账簿账号，如：9902000014272942
payeeAccName <br> **必填** <br> `string` | 收款户名，如：深圳市普尔瀚达科技有限公司
postscript <br> **选填** <br> `string` | 付款人备注
summary <br> **选填** <br> `string` | 银行备注
merchantNum <br> **必填** <br> `string` | 客户银行识别号，如：0300000700000015
reqSeq <br> **必填** <br> `string` | 银行流水号，73401201211141503123456544C705F2
tran_at <br> **必填** <br> `int` | 银行交易入账时间，时间戳，如：1542179363
created_at <br> **必填** <br> `int` | 平台交易创建时间，时间戳，如：1542179395
platform_merchant_id <br> **必填** <br> `string` | 平台商户编号，如：6044885632395970
nonce_str <br> **必填** <br> `string` | 随机数，如有重复通知，随机数会不一样，如：5bebca4301c911491e29643b

### 分销易子账簿销户 Cmbc ecp destroy

```
DELETE /cms/merchants/8902061980649594/cmbc_ecp
```

> 响应示例

```shell
{
    "code": 0,
    "msg": "0000, 子账簿销户成功!",
    "data": {  ……  }
}
```

通过此接口可以对分销易子账簿进行销户，销户成功后无法通过此帐号入账

认证方式：[Login](#login)

请求URL：DELETE /cms/merchants/#{merchant_id}/cmbc_ecp



### 查询实体账户资金明细

```
GET /cmbc_ecp/fund_details?merchant_id=2339779661268962&date_start=20180723&date_end=20180724&page_size=15&page_no=1
```

> 响应示例

```shell
{
    "code": 0,
    "msg": "success",
    "data": {
        "counts": "3",
        "list": [
            {
                "transSeqNo": "88466373824450673064550",
                "itemId": "",
                "transDate": "20180913",
                "valueDate": "20180913",
                "branchNo": "3300",
                "isCredit": "X",
                "currency": "RMB",
                "amount": 890000,
                "accountno": "620539391",
                "payAcctName": "深圳市乐宝云天文化发展有限公司",
                "rcvAcctNumber": "",
                "rcvAcctName": "",
                "transType": "",
                "transMedium": "1001",
                "itemStatus": "03",
                "itemTransactionType": "",
                "postingText": "存款"
            }
        ]
    }
}
```

通过此接口可以查询平台商户在民生银行开通分销易绑定的实体账户资金流水明细，仅能查询开通民生分销易的平台商户

认证方式：[Login](#login)

请求URL：GET /cmbc_ecp/fund_details

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的平台商户编号
date_start | 起始日期，如：20180723
date_end | 结束日期，如：20180724
page_size | 默认为20条，如：15
page_no | 第几页



## 银行卡 Bank cards

### 创建

```
POST /cms/bank_cards
```

> 请求示例

```shell
curl -X POST /cms/bank_cards?merchant_id=4430405652527179 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "contact_tel":"18099992568",
    "owner_name":"梁中华",
    "bank_sub_code":"102584003247",
    "cyber_bank_code":"102100099996",
    "account_num":"4000032409200654834",
    "account_type":1,
    "owner_idcard":"91440300398456074L",
    "province":"广东",
    "urbn":"深圳",
    "zone":"福田",
    "bank_full_name": "中国工商银行股份有限公司深圳喜年支行",
    "cmbc_bank":false
}'
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户创建银行卡则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户绑定银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户绑定银行卡）

Body请求参数

参数| 描述
--|--
account_type <br> **必填** <br> `int` | 账户类型，0 个人、1 企业，默认为0
owner_name <br> **必填** <br> `string` | 户名，个人账户为真实姓名，企业账户为公司全称
account_num <br> **必填** <br> `string` | 银行账号， 如：6217680300228911
bank_full_name <br> **必填** <br> `string` | 银行全称，如：中信银行股份有限公司深圳香林支行
bank_sub_code <br> **必填** <br> `string` | 大小额联行号
contact_mobile  <br> **可选** <br> `string` | 个人帐户需留银行开户预留手机号，企业账户则为联系人手机号
province <br> **可选** <br> `string` | 开户省， 如：广东
urbn <br> **可选** <br> `string` | 开户市，如：深圳
area <br> **可选** <br> `string` | 开户区， 如：福田
cyber_bank_code <br> **可选** <br> `string` | 网银互联转账时的行号，[参考](#edde394695)
cmbc_bank <br> **可选** <br> `boolean` | 是否民生银行，true或false，默认：false





### 查询 

```
GET /cms/bank_cards/:_id
```
> 请求示例

```shell
curl -X GET /cms/bank_cards/23?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）

### 修改

```
PUT /cms/bank_cards/:_id
```
> 请求示例

```shell
curl -X PUT /cms/bank_cards/23?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d '{
    "contact_tel":"18099992568",
    "owner_name":"梁中华",
    "bank_sub_code":"102584003247",
    "cyber_bank_code":"102100099996",
    "account_num":"4000032409200654834",
    "account_type":1,
    "owner_idcard":"91440300398456074L",
    "province":"广东",
    "urbn":"深圳",
    "zone":"福田",
    "bank_full_name": "中国工商银行股份有限公司深圳喜年支行",
    "cmbc_bank":false
}'
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）

### 删除

```
DELETE /cms/bank_cards/:_id
```
> 请求示例

```shell
curl -X DELETE /cms/bank_cards/23?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）

### 设置默认银行卡

```
PUT /cms/bank_cards/:_id/default_card
```

> 请求示例

```shell
curl -X PUT /cms/bank_cards/23/default_card?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）

### 查询商户所有银行卡

```
GET /cms/bank_cards
```
> 请求示例

```shell
curl -X GET /cms/bank_cards?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 请求示例

```shell
curl -X GET /cms/bank_cards?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）


### 启用禁用

```
PUT /cms/bank_cards/:_id/enable_disable/:true|false
```

> 请求示例

```shell
curl -X PUT /cms/bank_cards/23/enable_disable/false?merchant_id=1333259781809471 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

URL请求参数

参数| 描述
--|--
merchant_id <br> **选填** | 如Login的 Authorization 为当前商户则不需要传merchant_id（比如：入驻商户绑定的用户为自身商户操作银行卡），如果为当前商户的下级则需要传 merchant_id （比如：平台商户为入驻商户操作银行卡）
enable_disable | true为启用，false为禁用









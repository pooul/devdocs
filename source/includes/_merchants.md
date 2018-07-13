# 商户 Merchants

## 商户层级 Merchant Level

![image](http://img.pooul.com/MerchantsLevels.png)


## 入驻商户 Tenant Merchant

### 创建 Create Tenant Merchant

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
    "merchant_type":3,
    "platform_merchant_id":"7590462217569167",
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
        "area": "龙华新区",
        "address": "龙华新区大浪办事处大浪社区新围村71栋101 "
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

请求参数 | 描述
-- | -- 
merchant_type <br> **必填** <br> `int` | 商户类型，固定值为 3
platform_merchant_id <br> **必填** <br> `string` | 平台商户编号，固定值为普尔为你开通的平台商户编号，如：7590462217569167
parent_id <br> **必填** <br> `string` | 父级商户编号，如为平台商户下属一级商户则为平台商户编号，如为一级一下商户则为该父级商户编号，如：7590462217569167
partner_mch_id <br> **可选** <br> `string` | 平台商户自定义商户编号，如：988765
note <br> **可选** <br> `string` | 商户备注信息
license_type <br> **必填** <br> `int` | 营业类型：1. 企业; 2. 个体工商户，3. 个人
business <br> **可选** <br> `string` | 商户经营信息参数集合，请参考[Merchant business 参数](#merchant-business)
corporate <br> **可选** <br> `string` | 营业执照信息参数集合，license_type为3时不需传，请参考[Merchant corporate 参数](#merchant-corporate)
owner <br> **必填** <br> `string` | 所有人/法人信息参数集合，license_type为3时为所有人信息，license_type为1、2时为营业执照法人信息，请参考[Merchant owner 参数](#merchant-owner)

##### Merchant business 参数

请求参数 | 描述
-- | -- 
short_name <br> **必填** <br> `string`  | 商户简称，经营名称，如：平克文化
service_call <br> **可选** <br> `string`  | 服务电话，如：0755-82857285
area_code <br> **可选** <br> `string`  | 行政区划代码，[参考民政部最新的区划代码](http://www.mca.gov.cn/article/sj/xzqh/2018/)，如：440309
province <br> **可选** <br> `string`  | 经营地址所在省，如：广东省
urbn <br> **可选** <br> `string`  | 经营地址所在地级市，如：深圳市
area <br> **可选** <br> `string`  | 经营地址所在区，如：龙华新区
address <br> **可选** <br> `string`  | 经营详细地址，不含省市区，如：龙华新区大浪办事处大浪社区新围村71栋101


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
        "_id": "5758247574437774",
        "_type": "Ns::TenantMerchant",
    }
}
```

响应参数 | 描述
-- | -- 
_id <br> **必填** <br> `string` | 商户编号 merchant_id，可用于后续业务


### 查询 Query Tenant Merchant

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


### 修改 Update Tenant Merchant

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

请求参数 | 描述
-- | -- 
note <br> **可选** <br> `string` | 商户备注信息
license_type <br> **必填** <br> `int` | 营业类型：1. 企业; 2. 个体工商户，3. 个人
business <br> **可选** <br> `string` | 商户经营信息参数集合，请参考[Merchant business 参数](#merchant-business)
corporate <br> **可选** <br> `string` | 营业执照信息参数集合，license_type为3时不需传，请参考[Merchant corporate 参数](#merchant-corporate)
owner <br> **必填** <br> `string` | 所有人/法人信息参数集合，license_type为3时为所有人信息，license_type为1、2时为营业执照法人信息，请参考[Merchant owner 参数](#merchant-owner)

##### Merchant business 参数

请求参数 | 描述
-- | -- 
short_name <br> **必填** <br> `string`  | 商户简称，经营名称，如：平克文化
service_call <br> **可选** <br> `string`  | 服务电话，如：0755-82857285
area_code <br> **可选** <br> `string`  | 行政区划代码，[参考民政部最新的区划代码](http://www.mca.gov.cn/article/sj/xzqh/2018/)，如：440309
province <br> **可选** <br> `string`  | 经营地址所在省，如：广东省
urbn <br> **可选** <br> `string`  | 经营地址所在地级市，如：深圳市
area <br> **可选** <br> `string`  | 经营地址所在区，如：龙华新区
address <br> **可选** <br> `string`  | 经营详细地址，不含省市区，如：龙华新区大浪办事处大浪社区新围村71栋101


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



### 删除 Delete Tenant Merchant

```
DELETE /cms/merchants/:_id
```

> 请求示例

```shell
curl -X DELETE /cms/merchants/:_id \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}"
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success"
}
```

### 搜索 Search Tenant Merchants

```
POST /cms/merchants/search?
```
> 请求示例

```shell
curl -X POST /cms/merchants/search?last_id=:_id&page_size=30 \
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

URL请求参数

参数| 描述
--|--
page_size <br> **选填** | 每页可以返回多少数据，限制范围是从 1~100 项，默认是 15 项。
last_id <br> **选填** | 在分页时使用的指针，决定了列表的第一项从何处开始。假设你的一次请求返回列表的最后一项的 id 是 obj_end，你可以使用 last_id = obj_end 去获取下一页。


Body请求参数

参数| 描述
--|--
_id <br> **选填** | 入驻商户编号（merchant_id）
parent_id <br> **选填** | 父级商户编号，输入此参数查询该父级商户所有下一级入驻商户


## 银行卡 Bank cards

### 创建

```
POST /cms/bank_cards
```

> 请求示例

```shell
curl -X POST /cms/bank_cards?merchnat_id=4430405652527179 \
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
owner_name | 户名
contact_mobile | 个人帐户需留银行开户预留手机号，企业账户则为联系人手机号
bank_sub_code | 大小额联行号
cyber_bank_code | 网银互联转账时的行号，[参考](#edde394695)
account_num | 银行账号， 如：6217680300228911
account_type | 账户类型，0 个人、1 企业，默认为0
province | 开户省， 如：广东
urbn | 开户市，如：深圳
area | 开户区， 如：福田
bank_full_name | 银行全称，如：中信银行股份有限公司深圳香林支行
cmbc_bank | 是否民生银行，true或false，默认：false





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













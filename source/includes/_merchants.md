# 商户管理 Merchant manage

## 商户类型 Merchant type

- 普通商户 CommMerchant：单个门店商户，merchant_type：1
- 平台商户 PlatformMerchant：指平台商户或集团商户，拥有多个直营门店或是分销商，merchant_type：2
- 入驻商户 TenantMerchant：平台商户下属商户，merchant_type：3
- 合作伙伴 PartnerMerchant：合作伙伴商户，merchant_type：4

## 商户状态码 Merchant Status code

| status | status_desc| 说明|
--|--|--
| 1 | 入驻申请 | 合作伙伴通过接口或后台提交成功商户资料至普尔商户系统，等待普尔提交至上游渠道 |
| 2 | 审核中   | 普尔提交商户资料至上游渠道，等待上游渠道审核|
| 3 | 审核失败 |商户审核失败（a.上游渠道返回审核失败，b.普尔审核失败） |
| 4 | 商户停用 | 商户状态停用（a.上游渠道停用商户，b. 普尔停用商户）|
| 5 | 审核通过 | 上游渠道审核成功，并配置好路由等相关交易信息，商户可以正常交易 |

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

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询下级商户

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


### 上传图片 Upload image

通过此功能上传下属商户资料照片，包含经营场所照片、公司证件照片、法人证件照片、银行照片，具体取值参考 input 取值方式

- 第一步：获取七牛上传图片的Token
- 第二步：调用七牛图片上传接口

#### 获得七牛Token

> 请求示例

```shell
curl -X GET /cms/qiniu/upload_token?merchant_id=1002928391013363 \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" 
```

> 响应示例

```json
{
    "code": 0,
    "msg": "success",
    "data": {
        "bucket": "merchant-info",
        "token": "mwy4ThDku0ltbD7Fxu6rSSK7KVlsiC-ieUo3S0ng:quX_6S-8IWQYmkRyMkCTRjAgPLI=:eyJzY29wZSI6Im1lcmNoYW50LWluZm8iLCJkZWFkbGluZSI6MTU0MzU3ODUxMCwiY2FsbGJhY2tVcmwiOiJodHRwczovL2FwaS1kZXYucG9vdWwuY29tL3dlYi9ub3RpZmllcy9xaW5pdSIsImNhbGxiYWNrQm9keSI6IntcInVzZXJfaWRcIjozMDEsXCJtZXJjaGFudF9pZFwiOlwiMTAwMjkyODM5MTAxMzM2M1wiLFwiaW1nX3R5cGVcIjpcIiQoeDppbWdfdHlwZSlcIixcImJhbmtfY2FyZF9pZFwiOlwiJCh4OmJhbmtfY2FyZF9pZClcIixcImtleVwiOlwiJChrZXkpXCIsXCJtaW1lX3R5cGVcIjpcIiQobWltZVR5cGUpXCJ9IiwiY2FsbGJhY2tCb2R5VHlwZSI6ImFwcGxpY2F0aW9uL2pzb24ifQ==",
        "expired_at": 1543578510
    }
}
```
- 请求方式：GET /cms/qiniu/upload_token?merchant_id=:merchant_id
- 认证方式：基于Login权限，[查看Login认证说明](#login)

合作伙伴使用此功能可以获取下属商户到七牛上传图片的Token

#### 上传图片至七牛


> DEMO

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="email=no">
    <meta name="full-screen" content="yes">
    <meta name="x5-fullscreen" content="true">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>test qiniu</title>
  </head>
  <body>
    <form method="post" action="http://up-z2.qiniup.com/" enctype="multipart/form-data">
      <!-- <input name="key" type="hidden" value="12231321312"> -->
      <input name="x:img_type" type="hidden" value="0">
      <!-- <input name="x:bank_no" type="hidden" value="1"> -->
      <input name="token" type="hidden" value="mwy4ThDku0ltbD7Fxu6rSSK7KVlsiC-ieUo3S0ng:IOHsZcuNVSNNp3iF3mTyXOZHY7Q=:eyJzY29wZSI6Im1lcmNoYW50LWluZm8iLCJkZWFkbGluZSI6MTU0MzMxNTQyMiwiY2FsbGJhY2tVcmwiOiJodHRwczovL2FwaS1kZXYucG9vdWwuY29tL3dlYi9ub3RpZmllcy9xaW5pdSIsImNhbGxiYWNrQm9keSI6IntcInVzZXJfaWRcIjozMDEsXCJtZXJjaGFudF9pZFwiOlwiODg3MzM1MzcwMjgzNTM1N1wiLFwiaW1nX3R5cGVcIjpcIiQoeDppbWdfdHlwZSlcIixcImJhbmtfY2FyZF9pZFwiOlwiJCh4OmJhbmtfY2FyZF9pZClcIixcImtleVwiOlwiJChrZXkpXCIsXCJtaW1lX3R5cGVcIjpcIiQobWltZVR5cGUpXCJ9IiwiY2FsbGJhY2tCb2R5VHlwZSI6ImFwcGxpY2F0aW9uL2pzb24ifQ==">
      <!-- <input name="crc32" type="hidden" />
      <input name="accept" type="hidden" /> -->
      <input name="file" type="file" />
      <button type='submit'>上传</button>
    </form>
  </body>
</html>
```

使用表单上传的方式，参考[七牛开发文档](https://developer.qiniu.com/kodo/manual/1234/upload-types)

input 取值方式

- 经营场所照片：`<input name="x:img_type" type="hidden" value="0">`
- 营业执照等资质照片：`<input name="x:img_type" type="hidden" value="1">`
- 负责人/法人证件照片：`<input name="x:img_type" type="hidden" value="2">`
- 银行卡照片：`<input name="x:bank_card_id" type="hidden" value="{此处填写创建好的银行卡信息ID}">`

























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

- 认证方式：基于Login权限，[查看Login认证说明](#login)
- 所需权限：查询下级商户

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









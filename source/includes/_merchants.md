# 商户 Merchants

## 商户层级

![image](http://p7u0b94h2.bkt.clouddn.com/MerchantsLevels.png)


## 入驻商户 Tenant Merchant

### 创建入驻商户 Create Tenant Merchant

#### 请求

> 请求示例

```shell
curl -X POST /cms/merchants \
-H "Content-Type: application/json" \
-H "Authorization: #{Authorization}" \
-d' {
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


### 查询
### 修改
### 删除
### 搜索
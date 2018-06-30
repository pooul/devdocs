## 4.3 进件接口

### 4.3.1 接口准备
#### 1. 合作伙伴开户
联系普尔运营人员，开通合作伙伴帐户，登录代理商后台，首页获得
* Token 值用于md5加密的key
* partner_id 即代理商编号，此编号作为代理商唯一标识

运营人员联系方式：
* 姓名：薛小姐
* 邮箱：asit@pooul.cn

代理商后台：http://in.pooulcloud.cn:3011


#### 2. 图片上传，获取key值
* 注册七牛云
* 代理商进入七牛云： 产品列表-〉储存空间列
* 创建一个储存空间，设为公有
* 将该空间权限分配给lym@pooul.cn
* 告知运营人员
* 代理商可以根据[七牛云api](https://developer.qiniu.com/kodo/manual/1234/upload-types)上传图片并获取图片key值，使用api进件可以在程序上做自动化
* 在[七牛云api-上传凭证](https://developer.qiniu.com/kodo/manual/1208/upload-token)页面底部可以下载到sdk
* 上传图片前请先压缩
* 使用普尔授权的名字空间调用的七牛云接口上传图片，获得图片key值
* 上传相关证件照，并把对应的key值保存到公司信息和法人信息里, 发起进件。

 > md5加密示例

```javascript

key = '0123456789abcdef' # 从登录首页获取的token值
md5  "address=详细地址&appid=公众号&full_name=商户全名称&id=xxxxxxxxx&industry=经营行业&mch_deal_type=商户经营类型: 实体/虚拟&mch_type=商户类型(个体，企业)&memo=商户备注&method=merchant.create&name=商户简称&partner_id=123456&partner_mch_id=partner_mch_id&pfb_channel_type=农商行普付宝经营类目&province=省&urbn=市&zone=区&zx_alipay_channel_type=中信支付宝经营类目编号&zx_wechat_channel_type=中信微信经营类目编号&key=0123456789abcdef"
=> "d365a1fbe6c5c8d366a0a2c3d0932368"


sign ="d365a1fbe6c5c8d366a0a2c3d0932368".upcase
=> "D365A1FBE6C5C8D366A0A2C3D0932368"

js['sign'] = "D365A1FBE6C5C8D366A0A2C3D0932368"


POST  http://120.77.180.208:3011/api/merchants 

{ 
  "parner_id": "123456",
  "method": "merchant.create",
  "token": "xxxxxxxxx",
  "id": "xxxxxxxxx",
  "out_merchant_id": "out_merchant_id",
  "full_name": "商户全名称",
  "name": "商户简称",
  "memo": "商户备注",
  "province": "省份",
  "urbn": "城市",
  "address": "详细地址",
  "appid": "公众号",
  "mch_type": "商户类型(个体，企业)",
  "industry": "经营行业",
  "zx_wechat_channel_type": "中信微信经营类目编号",
  "zx_alipay_channel_type": "中信支付宝经营类目编号",
  "bank_info": {
    "owner_name": "owner_name",
    "bank_sub_code": "bank_sub_code",
    "account_num": "account_num",
    "account_type": "account_type",
    "owner_idcard": "owner_idcard",
    "province": "province",
    "urbn": "urbn",
    "zone": "zone",
    "bank_full_name": "bank_full_name",
  },
  "legal_person": {
    "identity_card_front_key": "identity_card_front_key",
    "identity_card_back_key": "identity_card_back_key",
    "tel": "tel",
    "name": "name",
    "email": "email",
    "identity_card_num": "identity_card_num"
  },
  "company": {
      "shop_picture_key": "shop_picture_key",
    "license_key": "license_key",
    "protocol_photo_key": "protocol_photo_key",
    "org_photo_key": "org_photo_key",
    "contact_tel": "contact_tel",
    "contact_name": "contact_name",
    "service_tel": "service_tel",
    "contact_email": "contact_email",
    "license_code": "license_code"
  },
  "sign": "D365A1FBE6C5C8D366A0A2C3D0932368"
}

```

### 4.3.2 接口url

 post  http://120.77.180.208:3011/api/merchants

### 4.3.3 接口规范

* 报文编码格式采用utf-8的字符串

#### MD5签名

* 注意：md5签名需剔除值是hash的部分，如bank_info、company、legal_person


>  以下测试用例用于检查sign签名运算

```javascript

md5("123abc") = "a906449d5769fa7361d7ecc6aa3f6d28"
```

中文采用utf-8编码

```javascript

md5("123abc中文") = "6a52514aa32cb230da6fb7af0f5345ce"
```

将JSON中的键按照ascii(就是字母顺序)排序，然后以"键1=值1&键2=值2...."的方式拼接得到

```javascript

mab = "address=详细地址&appid=公众号&full_name=商户全名称&id=xxxxxxxxx&industry=经营行业&mch_deal_type=商户经营类型: 实体/虚拟&mch_type=商户类型(个体，企业)&memo=商户备注&method=merchant.create&name=商户简称&partner_id=123456&partner_mch_id=partner_mch_id&pfb_channel_type=农商行普付宝经营类目&province=省&urbn=市&zone=区&zx_alipay_channel_type=中信支付宝经营类目编号&zx_wechat_channel_type=中信微信经营类目编号"
```

假设：

```javascript
key = '0123456789abcdef'
```
计算出

```javascript

sign = md5(mab + "&key=0123456789abcdef") .upcase
?>sign
 "D365A1FBE6C5C8D366A0A2C3D0932368"
```

### 4.3.4 提交资料示例


> 提交资料示例

```javascript

 json = {
    partner_id: "123456", # 必填，代理商唯一标识，在登录首页获取
    method: "merchant.create", # 必填，merchant.create: 创建；merchant.update：修改
    partner_mch_id: 'partner_mch_id', #必填，代理商自定义的merchant唯一标识, 开通合作伙伴帐户设置，之后不可修改
    status: 0, # 进件状态，查询返回： 0 => '审核通过', 1 => '入驻申请', 2 => '审核中', 3 => '审核失败', 4 => '商户停用'
    status_desc: '初始', # 进件状态中文描述，查询返回： '初始',  '进件失败', '审核中', '关闭',  '进件成功'
    error_desc: '电话格式错误', # 进件失败描述信息，由运营人员填写
    
    full_name: '普尔瀚达科技有限公司', # 必填
    name: '普尔',# 必填 
    memo: '商户备注',# 必填 
    province: '广东省',# 必填 
    urbn:  '深圳市',# 必填 
    zone: '南山区',# 必填 
    address: '留学生创业大厦二期1505',# 必填
    appid: '公众号', # 三选一
    jsapi_path: 'JSAPI支付授权目录', # 三选一
    subscribe_appid: '户推荐关注公众账号APPID', # 三选一
    mch_type: '个体',# 商户类型；必填，选择填入企业/个体
    industry: '线下零售',# 经营行业；必填，可参照经营类目表，或者营业执照上的经营范围填入
    wechat_channel_type_lv2: '203', # 微信经营类目编号，见附件《经营类目》中的经营类目明细编码
    alipay_channel_type_lv1: '2015062600002750',# 支付宝经营类目一级编号，见附件《经营类目》中的经营类目明细编码
    alipay_channel_type_lv2: '2015062600009243'# 支付宝经营类目二级编号，见附件《经营类目》中的经营类目明细编码
    mch_deal_type: ':实体',# 商户经营类型；必填，选择填入实体/虚拟
    d0_rate: "D0费率", # 必填，字符串，单位为%百分比,精确到小数点后两位 如 "0.35" 即千分之3.5
    t1_rate: "T1费率", # 必填，字符串，单位为%百分比,精确到小数点后两位 如 "0.35"
    即千分之3.5
    fixed_fee: '单笔加收费用',# 选填此为D0费率单笔加收费用单位为（分），精确到小数点后两位
    pay_route_status: { # 查询时返回，支付路由状态：0 => '未开通', 1 => '已开通'
        "t1_status": 0,
        "t1_status_desc": "未开通",
        "d0_status": 0,
        "d0_status_desc": "未开通"
    },

    #银行信息

    bank_info: {
        owner_name: '张三', # 必填，开户人姓名/公司名
        bank_sub_code: '001100001509', # 必填，支付联行号
        account_num: '6228480402500000018', # 必填，账号
        account_type: '对私', # 必填，账户类型选择填入(对私/对公)
        owner_idcard: '440101100101010010', # 必填，持卡人身份证号码
        province: '广东省', # 必填，开户省
        urbn: '深圳市', # 必填，开户市
        zone: '南山区', # 必填，开户区
        bank_full_name: '中国人民银行营业管理部营业室', # 必填，与联行号对应的银行全称
        right_bank_card_key: 'right_bank_card_key', # 必填，银行卡正面照，此处填写七牛云返回的key值
    },

    
    # 法人信息

    legal_person: {
        identity_card_front_key: 'identity_card_front_key', # 必填，身份证正面照，此处填写七牛云返回的key值
        identity_card_back_key: 'identity_card_back_key',  # 必填，身份证反面 照，此处填写七牛云返回的key值 
        id_with_hand_key: 'id_with_hand_key' # 必填，手持身份证照，此处填写七牛云返回的key值 
        tel: '18502020202', # 必填，法人电话
        name: '张三', # 必填，法人名称
        email: '18502020202@163.com', # 必填，法人邮箱
        identity_card_num: '440101100101010010', #
        必填，身份证号照，此处填写七牛云返回的key值 
    },

    # 公司信息

    company: {
        shop_picture_key: 'shop_picture_key', # 选填，店铺照照，此处填写七牛云返回的key值
        license_key: 'license_key', # 必填，营业执照，此处填写七牛云返回的key值
        account_licence_key: 'pfb_account_licence_key' # 必填，开户许可证照，此处填写七牛云返回的key值
        contact_tel: 'contact_tel', # 必填，联系人电话
        contact_name: 'contact_name', # 必填，联系人姓名
        service_tel: 'service_tel', # 必填，客服电话
        contact_email: 'contact_email', # 必填，联系人邮箱
        license_code: '522500320030556', # 必填，营业执照编码
    }
}
```



### 4.3.5查看资料

#### md5

 > md5示例

```javascript

data = {
    method: 'merchant.query',
    parner_id: 'parner_id',
    partner_mch_id: 'partner_mch_id', # partner_mch_id，merchant_id，id都可以用于查找记录
    sign: "12345678",
}

POST  http://120.77.180.208:3011/api/merchants
data

```


### 4.3.6 成功返回

与进件格式相同的json，并附带id以便修改进件信息

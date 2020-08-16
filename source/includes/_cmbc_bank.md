# 民生银行产品 CMBC bank

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









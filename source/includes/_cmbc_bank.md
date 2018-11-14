# 民生银行产品 CMBC bank

## 分销易 CMBC Easy distribution

分销易是民生银行产品，可以帮助平台商户解决经销商大额入金并识别来路的需求，具体咨询对接商户经理介绍民生银行全国任一网点进行开通，开通后普尔平台配置后即可使用。

开通分销易后可帮助平台商户实现所有入驻商户使用管理后台或是API接口在民生银行系统中创建平台商户子账户，子商户与入驻商户唯一关联，使用网银转账给子账户成功后可以通过在管理后台查询到入驻商户入账信息，或是发送转账成功通知信息给平台商户提供的网址。

### 网银转账入账通知 CMBC fund accounting notify

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

在接收到入驻商户网银转账入账后，普尔平台会往平台商户配置的网址发送通知，通知内容为JWT文本，平台商户在接收到通知后需要使用普尔公钥解密并验签。平台商户需要接收处理，并需要响应字符串"success"（大小写皆可）。

对后台通知交互时，如果Pooul收到商户的应答不是成功或超时，系统认为通知失败，系统会通过一定的策略定期重新发起通知，尽可能提高通知的成功率，但系统不保证通知最终能成功。 （通知频率为15/15/30/180/1800/1800/1800/1800/3600，单位：秒）

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


### 查询实体账户资金明细

```
GET /cms/cmbc_ecp/fund_account?merchant_id=2339779661268962&date_start=20180723&date_end=20180724&page_size=15&page_num=1
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

请求URL：GET /cms/cmbc_ecp/fund_account

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的平台商户编号
date_start | 起始日期，如：20180723
date_end | 结束日期，如：20180724
page_size | 默认为20条，如：15
page_num | 第几页


## 银企直连

### 查询实体账户明细

```
GET /cms/cmbc_yq/fund_account?merchant_id=2339779661268962&date_start=20180723&date_end=20180724&start_no=1&end_no=10
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

请求URL：GET /cms/cmbc_yq/fund_account

URL参数说明

参数 | 描述
-- | -- 
merchant_id | 要查询的平台商户编号
date_start | 起始日期，如：20180723
date_end | 结束日期，如：20180724
start_no | 开始条数
end_no | 结束条数

### 对外转账

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











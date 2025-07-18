-- 创建数据库
CREATE DATABASE IF NOT EXISTS ods_didi;

create table if not exists ods_didi.t_user_order (
    orderId string comment '订单id',
    telephone string comment '打车用户手机',
    lng string comment '用户发起打车的经度',
    lat string comment '用户发起打车的纬度',
    province string comment '所在省份',
    city string comment '所在城市',
    es_money double comment '预估打车费用',
    gender string comment '用户信息 - 性别',
    profession string comment '用户信息 - 行业',
    age_range string comment '年龄段（70后、80后、...）',
    tip double comment '小费',
    subscribe int comment '是否预约（0 - 非预约、1 - 预约）',
    sub_time string comment '预约时间',
    is_agent int comment '是否代叫（0 - 本人、1 - 代叫）',
    agent_telephone string comment '预约人手机',
    order_time string comment '预约时间'
) partitioned by (dt string comment '时间分区') ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
--2.2 创建取消订单表
create table if not exists ods_didi.t_user_cancel_order (
    orderId string comment '订单ID',
    cstm_telephone string comment '客户联系电话',
    lng string comment '取消订单的经度',
    lat string comment '取消订单的纬度',
    province string comment '所在省份',
    city string comment '所在城市',
    es_distance double comment '预估距离',
    gender string comment '性别',
    profession string comment '行业',
    age_range string comment '年龄段',
    reason int comment '取消订单原因（1 - 选择了其他交通方式、2 - 与司机达成一致，取消订单、3 - 投诉司机没来接我、4 - 已不需要用车、5 - 无理由取消订单）',
    cancel_time string comment '取消时间'
) partitioned by (dt string comment '时间分区') ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
--2.3 创建订单支付表
create table if not exists ods_didi.t_user_pay_order (
    id string comment '支付订单ID',
    orderId string comment '订单ID',
    lng string comment '目的地的经度（支付地址）',
    lat string comment '目的地的纬度（支付地址）',
    province string comment '省份',
    city string comment '城市',
    total_money double comment '车费总价',
    real_pay_money double comment '实际支付总额',
    passenger_additional_money double comment '乘客额外加价',
    base_money double comment '车费合计',
    has_coupon int comment '是否使用优惠券（0 - 不使用、1 - 使用）',
    coupon_total double comment '优惠券合计',
    pay_way int comment '支付方式（0 - 微信支付、1 - 支付宝支付、3 - QQ钱包支付、4 - 一网通银行卡支付）',
    mileage double comment '里程（单位公里）',
    pay_time string comment '支付时间'
) partitioned by (dt string comment '时间分区') ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

--2.4创建用户评价表
create table if not exists ods_didi.t_user_evaluate (
    id string comment '评价日志唯一ID',
    orderId string comment '订单ID',
    passenger_telephone string comment '用户电话',
    passenger_province string comment '用户所在省份',
    passenger_city string comment '用户所在城市',
    eva_level int comment '评价等级（1 - 一颗星、... 5 - 五星）',
    eva_time string comment '评价时间'
) partitioned by (dt string comment '时间分区') ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
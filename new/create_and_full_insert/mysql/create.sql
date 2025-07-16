DROP DATABASE second;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS second;
CREATE DATABASE IF NOT EXISTS `second` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- 切换到 second 数据库
USE second;

-- 1. 创建 t_user_order 表
-- 对应 Hive 表: ods_didi.t_user_order
CREATE TABLE IF NOT EXISTS t_user_order (
    orderId VARCHAR(255) COMMENT '订单id',
    telephone VARCHAR(255) COMMENT '打车用户手机',
    lng VARCHAR(255) COMMENT '用户发起打车的经度',
    lat VARCHAR(255) COMMENT '用户发起打车的纬度',
    province VARCHAR(255) COMMENT '所在省份',
    city VARCHAR(255) COMMENT '所在城市',
    es_money DOUBLE COMMENT '预估打车费用',
    gender VARCHAR(255) COMMENT '用户信息 - 性别',
    profession VARCHAR(255) COMMENT '用户信息 - 行业',
    age_range VARCHAR(255) COMMENT '年龄段（70后、80后、...）',
    tip DOUBLE COMMENT '小费',
    subscribe INT COMMENT '是否预约（0 - 非预约、1 - 预约）',
    sub_time VARCHAR(255) COMMENT '预约时间',
    is_agent INT COMMENT '是否代叫（0 - 本人、1 - 代叫）',
    agent_telephone VARCHAR(255) COMMENT '预约人手机',
    order_time VARCHAR(255) COMMENT '预约时间'
) COMMENT = '用户订单表';

-- 2. 创建 t_user_cancel_order 表
-- 对应 Hive 表: ods_didi.t_user_cancel_order
CREATE TABLE IF NOT EXISTS t_user_cancel_order (
    orderId VARCHAR(255) COMMENT '订单ID',
    cstm_telephone VARCHAR(255) COMMENT '客户联系电话',
    lng VARCHAR(255) COMMENT '取消订单的经度',
    lat VARCHAR(255) COMMENT '取消订单的纬度',
    province VARCHAR(255) COMMENT '所在省份',
    city VARCHAR(255) COMMENT '所在城市',
    es_distance DOUBLE COMMENT '预估距离',
    gender VARCHAR(255) COMMENT '性别',
    profession VARCHAR(255) COMMENT '行业',
    age_range VARCHAR(255) COMMENT '年龄段',
    reason INT COMMENT '取消订单原因（1 - 选择了其他交通方式、2 - 与司机达成一致，取消订单、3 - 投诉司机没来接我、4 - 已不需要用车、5 - 无理由取消订单）',
    cancel_time VARCHAR(255) COMMENT '取消时间'
) COMMENT = '取消订单表';

-- 3. 创建 t_user_pay_order 表
-- 对应 Hive 表: ods_didi.t_user_pay_order
CREATE TABLE IF NOT EXISTS t_user_pay_order (
    id VARCHAR(255) COMMENT '支付订单ID',
    orderId VARCHAR(255) COMMENT '订单ID',
    lng VARCHAR(255) COMMENT '目的地的经度（支付地址）',
    lat VARCHAR(255) COMMENT '目的地的纬度（支付地址）',
    province VARCHAR(255) COMMENT '省份',
    city VARCHAR(255) COMMENT '城市',
    total_money DOUBLE COMMENT '车费总价',
    real_pay_money DOUBLE COMMENT '实际支付总额',
    passenger_additional_money DOUBLE COMMENT '乘客额外加价',
    base_money DOUBLE COMMENT '车费合计',
    has_coupon INT COMMENT '是否使用优惠券（0 - 不使用、1 - 使用）',
    coupon_total DOUBLE COMMENT '优惠券合计',
    pay_way INT COMMENT '支付方式（0 - 微信支付、1 - 支付宝支付、3 - QQ钱包支付、4 - 一网通银行卡支付）',
    mileage DOUBLE COMMENT '里程（单位公里）',
    pay_time VARCHAR(255) COMMENT '支付时间'
) COMMENT = '订单支付表';

-- 4. 创建 t_user_evaluate 表
-- 对应 Hive 表: ods_didi.t_user_evaluate
CREATE TABLE IF NOT EXISTS t_user_evaluate (
    id VARCHAR(255) COMMENT '评价日志唯一ID',
    orderId VARCHAR(255) COMMENT '订单ID',
    passenger_telephone VARCHAR(255) COMMENT '用户电话',
    passenger_province VARCHAR(255) COMMENT '用户所在省份',
    passenger_city VARCHAR(255) COMMENT '用户所在城市',
    eva_level INT COMMENT '评价等级（1 - 一颗星、... 5 - 五星）',
    eva_time VARCHAR(255) COMMENT '评价时间'
) COMMENT = '用户评价表';
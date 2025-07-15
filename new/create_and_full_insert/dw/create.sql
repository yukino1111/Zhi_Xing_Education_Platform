create table if not exists dw_didi.t_user_order_wide(
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
    subscribe_name string comment '是否预约名称',
    sub_time string comment '预约时间',
    is_agent int comment '是否代叫（0 - 本人、1 - 代叫）',
    is_agent_name string comment '是否代叫名称',
    agent_telephone string comment '预约人手机',
    order_date string comment '预约时间，yyyy-MM-dd',
    order_year string comment '年',
    order_month string comment '月',
    order_day string comment '日',
    order_hour string comment '小时',
    order_time_range string comment '时间段',
    order_time string comment '预约时间'
)
partitioned by (dt string comment '时间分区') 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' ; 
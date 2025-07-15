-- 总订单笔数
create table if not exists app_didi.t_order_total(
    date_val string comment '日期（年月日)',
    count int comment '订单笔数'
)
partitioned by (month string comment '年月，yyyy-MM')
row format delimited fields terminated by ',';

-- 预约和非预约用户占比
-- 需求:
-- 求出预约用户订单所占的百分比:
create table if not exists app_didi.t_order_subscribe_percent(
    date_val string comment '日期',
    subscribe_name string comment '是否预约',
    percent_val string comment '百分比'
)partitioned by (month string comment '年月yyyy-MM') 
row format delimited fields terminated by ',';

--不同时段的占比分析
create table if not exists app_didi.t_order_timerange_total(
    date_val string comment '日期',
    timerange string comment '时间段',
    count int comment '订单数量'
)
partitioned by (month string comment '年月，yyyy-MM')
row format delimited fields terminated by ',';

-- 不同地域订单占比
create table if not exists app_didi.t_order_province_total(
    date_val string comment '日期',
    province string comment '省份',
    count int comment '订单数量'
)
partitioned by (month string comment '年月，yyyy-MM')
row format delimited fields terminated by ',';

-- 不同年龄段，不同时段订单占比
create table if not exists app_didi.t_order_age_and_time_range_total(
    date_val string comment '日期',
    age_range string comment '年龄段',
    order_time_range string comment '时段',
    count int comment '订单数量'
)
partitioned by (month string comment '年月，yyyy-MM')
row format delimited fields terminated by ',';
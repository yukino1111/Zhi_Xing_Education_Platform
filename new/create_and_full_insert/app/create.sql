drop database app_didi cascade;
CREATE DATABASE IF NOT EXISTS app_didi;

-- 总订单笔数
create table if not exists app_didi.t_order_total(
    count int comment '订单笔数',
    time_type string comment '时间维度: 年 1, 月 2, 日 3'
)comment '订单笔数表' partitioned by(
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';

-- 预约和非预约用户占比
-- 需求:
-- 求出预约用户订单所占的百分比:
create table if not exists app_didi.t_order_subscribe_percent(
    time_type string comment '时间维度: 年 1, 月 2, 日 3',
    subscribe_percent string comment '预约百分比',
    non_subscribe_percent string comment '非预约百分比'
)partitioned by (
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';

--不同时段的占比分析
create table if not exists app_didi.t_order_timerange_total(
    timerange string comment '时间段',
    time_type string comment '时间维度: 年 1, 月 2, 日 3',
    count int comment '订单数量'
)
partitioned by (
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';

-- 不同地域订单占比
create table if not exists app_didi.t_order_province_total(
    province string comment '省份',
    time_type string comment '时间维度: 年 1, 月 2, 日 3',
    count int comment '订单数量'
)
partitioned by (
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';

-- 不同年龄段订单占比
create table if not exists app_didi.t_order_age_range_total(
    age_range string comment '年龄段',
    time_type string comment '时间维度: 年 1, 月 2, 日 3',
    count int comment '订单数量'
)
partitioned by (
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';

-- 某年/月/日 评分统计
create table if not exists app_didi.t_order_eva_level(
    count int comment '订单数量',
    time_type string comment '时间维度: 年 1, 月 2, 日 3',
    eva_level int comment '评分(1 - 5)'
)
partitioned by(
    yearinfo string,
    monthinfo string,
    dayinfo string
)row format delimited fields terminated by ',';
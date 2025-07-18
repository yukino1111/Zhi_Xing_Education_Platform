--分区
SET hive.exec.dynamic.partition = true;

SET hive.exec.dynamic.partition.mode = nonstrict;

set hive.exec.max.dynamic.partitions.pernode = 10000;

set hive.exec.max.dynamic.partitions = 100000;

set hive.exec.max.created.files = 150000;
--hive压缩
set hive.exec.compress.intermediate = true;

set hive.exec.compress.output = true;
--写入时压缩生效
set hive.exec.orc.compression.strategy = COMPRESSION;
--分桶
set hive.enforce.bucketing = true;
-- 开启分桶支持, 默认就是true
set hive.enforce.sorting = true;
-- 开启强制排序

-- 优化:
set hive.auto.convert.join = false;
-- map join
set hive.optimize.bucketmapjoin = false;
-- 开启 bucket map join
-- 开启SMB map join
set hive.auto.convert.sortmerge.join = false;

set hive.auto.convert.sortmerge.join.noconditionaltask = false;
-- 写入数据强制排序
set hive.enforce.sorting = false;
-- 开启自动尝试SMB连接
set hive.optimize.bucketmapjoin.sortedmerge = false;
--年 总
insert into
table app_didi.t_order_total partition (yearinfo, monthinfo, dayinfo)
select
    count(orderid) as total_cnt,
    '1' as time_type,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year;

--年月 总
insert into
table app_didi.t_order_total partition (yearinfo, monthinfo, dayinfo)
select
    count(orderid) as total_cnt,
    '2' as time_type,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month;

--年月日 总
insert into
table app_didi.t_order_total partition (yearinfo, monthinfo, dayinfo)
select
    count(orderid) as total_cnt,
    '3' as time_type,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    order_day;

-- 预约和非预约用户占比 年
insert into
TABLE app_didi.t_order_subscribe_percent partition (yearinfo, monthinfo, dayinfo)
SELECT
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 1 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS subscribe_percent,
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 0 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS non_subscribe_percent,
    '1' as time_type,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
FROM dw_didi.t_user_order_wide t1
group by
    order_year;

-- 预约和非预约用户占比 年月
insert into
TABLE app_didi.t_order_subscribe_percent partition (yearinfo, monthinfo, dayinfo)
SELECT
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 1 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS subscribe_percent,
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 0 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS non_subscribe_percent,
    '2' as time_type,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
FROM dw_didi.t_user_order_wide t1
group by
    order_year,
    order_month;

-- 预约和非预约用户占比 年月日
insert into
TABLE app_didi.t_order_subscribe_percent partition (yearinfo, monthinfo, dayinfo)
SELECT
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 1 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS subscribe_percent,
    CONCAT(
        ROUND(
            SUM(
                CASE
                    WHEN t1.subscribe = 0 THEN 1
                    ELSE 0
                END
            ) / COUNT(t1.orderid) * 100,
            2
        ),
        '%'
    ) AS non_subscribe_percent,
    '3' as time_type,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
FROM dw_didi.t_user_order_wide t1
group by
    order_year,
    order_month,
    order_day;

-- 不同时段的占比分析 年
insert into
table app_didi.t_order_timerange_total partition (yearinfo, monthinfo, dayinfo)
select
    order_time_range,
    '1' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_time_range;

-- 不同时段的占比分析 年月
insert into
table app_didi.t_order_timerange_total partition (yearinfo, monthinfo, dayinfo)
select
    order_time_range,
    '2' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    order_time_range;

-- 不同时段的占比分析 年月日
insert into
table app_didi.t_order_timerange_total partition (yearinfo, monthinfo, dayinfo)
select
    order_time_range,
    '3' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    order_day,
    order_time_range;

-- 不同地域订单占比 年
insert into
table app_didi.t_order_province_total partition (yearinfo, monthinfo, dayinfo)
select
    province,
    '1' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    province;

-- 不同地域订单占比 年月
insert into
table app_didi.t_order_province_total partition (yearinfo, monthinfo, dayinfo)
select
    province,
    '2' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    province;

-- 不同地域订单占比 年月日
insert into
table app_didi.t_order_province_total partition (yearinfo, monthinfo, dayinfo)
select
    province,
    '3' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    order_day,
    province;

-- 不同年龄段订单占比 年
insert into
table app_didi.t_order_age_range_total partition (yearinfo, monthinfo, dayinfo)
select
    age_range,
    '1' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    age_range;

-- 不同年龄段订单占比 年月
insert into
table app_didi.t_order_age_range_total partition (yearinfo, monthinfo, dayinfo)
select
    age_range,
    '2' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    age_range;

-- 不同年龄段订单占比 年月日
insert into
table app_didi.t_order_age_range_total partition (yearinfo, monthinfo, dayinfo)
select
    age_range,
    '3' as time_type,
    count(*) as order_cnt,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
from dw_didi.t_user_order_wide
group by
    order_year,
    order_month,
    order_day,
    age_range;

-- 某年/月/日 评分统计
insert into
table app_didi.t_order_eva_level partition (yearinfo, monthinfo, dayinfo)
SELECT
    count(*) as order_cnt,
    '1' as time_type,
    eva_level,
    order_year as yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
FROM dw_didi.t_user_order_wide
GROUP BY
    order_year,
    eva_level;

insert into
table app_didi.t_order_eva_level partition (yearinfo, monthinfo, dayinfo)
SELECT
    count(*) as order_cnt,
    '2' as time_type,
    eva_level,
    order_year as yearinfo,
    order_month as monthinfo,
    '-1' as dayinfo
FROM dw_didi.t_user_order_wide
GROUP BY
    order_year,
    order_month,
    eva_level;

insert into
table app_didi.t_order_eva_level partition (yearinfo, monthinfo, dayinfo)
SELECT
    count(*) as order_cnt,
    '3' as time_type,
    eva_level,
    order_year as yearinfo,
    order_month as monthinfo,
    order_day as dayinfo
FROM dw_didi.t_user_order_wide
GROUP BY
    order_year,
    order_month,
    order_day,
    eva_level;
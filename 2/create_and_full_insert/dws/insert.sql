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



-- 统计每年 线上线下 新老用户的总意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_1 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat

-- 统计每年每月 线上线下 新老用户的总意向量
insert into
table dws.itcast_intention_dws_1 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat
    -- 统计每年每月每日 线上线下 新老用户的总意向量
insert into
table dws.itcast_intention_dws_1 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat
    -- 统计每年每月每日每小时 线上线下 新老用户的总意向量
insert into
table dws.itcast_intention_dws_1 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat;
-- 统计每年 线上线下 新老用户 各个区域的意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_2 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    area,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat,
    area

-- 统计每年每月 线上线下 新老用户 各个区域的意向量
insert into
table dws.itcast_intention_dws_2 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    area,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat,
    area
    -- 统计每年每月每日 线上线下 新老用户 各个区域的意向量
insert into
table dws.itcast_intention_dws_2 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    area,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat,
    area
    -- 统计每年每月每日每小时 线上线下 新老用户 各个区域的意向量
insert into
table dws.itcast_intention_dws_2 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    area,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    area;
-- 统计每年 线上线下 新老用户 各个校区的意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_3 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_school_id,
    itcast_school_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_school_id,
    itcast_school_name

-- 统计每年每月 线上线下 新老用户 各个校区的意向量
insert into
table dws.itcast_intention_dws_3 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_school_id,
    itcast_school_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_school_id,
    itcast_school_name
    -- 统计每年每月每日 线上线下 新老用户 各个校区的意向量
insert into
table dws.itcast_intention_dws_3 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_school_id,
    itcast_school_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_school_id,
    itcast_school_name
    -- 统计每年每月每日每小时 线上线下 新老用户 各个校区的意向量
insert into
table dws.itcast_intention_dws_3 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_school_id,
    itcast_school_name,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_school_id,
    itcast_school_name;
-- 统计每年 线上线下 新老用户 各个学科的意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_4 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_subject_id,
    itcast_subject_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_subject_id,
    itcast_subject_name

-- 统计每年每月 线上线下 新老用户 各个学科的意向量
insert into
table dws.itcast_intention_dws_4 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_subject_id,
    itcast_subject_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_subject_id,
    itcast_subject_name
    -- 统计每年每月每日 线上线下 新老用户 各个学科的意向量
insert into
table dws.itcast_intention_dws_4 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_subject_id,
    itcast_subject_name,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_subject_id,
    itcast_subject_name
    -- 统计每年每月每日每小时 线上线下 新老用户 各个学科的意向量
insert into
table dws.itcast_intention_dws_4 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    itcast_subject_id,
    itcast_subject_name,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    itcast_subject_id,
    itcast_subject_name;
-- 统计每年 线上线下 新老用户 各个来源渠道的意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_5 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    origin_type,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat,
    origin_type

-- 统计每年每月 线上线下 新老用户 各个来源渠道的意向量
insert into
table dws.itcast_intention_dws_5 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    origin_type,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat,
    origin_type
    -- 统计每年每月每日 线上线下 新老用户 各个来源渠道的意向量
insert into
table dws.itcast_intention_dws_5 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    origin_type,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat,
    origin_type
    -- 统计每年每月每日每小时 线上线下 新老用户 各个来源渠道的意向量
insert into
table dws.itcast_intention_dws_5 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    origin_type,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    origin_type;
-- 统计每年 线上线下 新老用户 各个咨询中心的意向量
FROM dwm.itcast_intention_dwm
insert into
table dws.itcast_intention_dws_6 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name,
    yearinfo as time_str,
    '5' as time_type,
    yearinfo,
    '-1' as monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name
    -- 统计每年每月 线上线下 新老用户 各个咨询中心的意向量
insert into
table dws.itcast_intention_dws_6 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name,
    concat(yearinfo, '-', monthinfo) as time_str,
    '4' as time_type,
    yearinfo,
    monthinfo,
    '-1' as dayinfo
group by
    yearinfo,
    monthinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name
    -- 统计每年每月每日 线上线下 新老用户 各个咨询中心的意向量
insert into
table dws.itcast_intention_dws_6 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    '-1' as hourinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo
    ) as time_str,
    '2' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name
    -- 统计每年每月每日每小时 线上线下 新老用户 各个咨询中心的意向量
insert into
table dws.itcast_intention_dws_6 partition (yearinfo, monthinfo, dayinfo)
select
    count(distinct customer_id) as customer_total,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name,
    concat(
        yearinfo,
        '-',
        monthinfo,
        '-',
        dayinfo,
        ' ',
        hourinfo
    ) as time_str,
    '1' as time_type,
    yearinfo,
    monthinfo,
    dayinfo
group by
    yearinfo,
    monthinfo,
    dayinfo,
    hourinfo,
    origin_type_stat,
    clue_state_stat,
    tdepart_id,
    tdepart_name;
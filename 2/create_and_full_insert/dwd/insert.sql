--分区
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=10000;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.created.files=150000;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--分桶
set hive.enforce.bucketing=true; -- 开启分桶支持, 默认就是true
set hive.enforce.sorting=true; -- 开启强制排序
SET hive.optimize.skewjoin = true;
SET hive.skewjoin.mapjoin.map.tasks = 10000; -- 倾斜数据MapJoin的Map任务数
SET hive.skewjoin.mapjoin.min.split = 33554432; 
SET mapreduce.reduce.memory.mb = 5632; -- 保持在集群最大允许内存
SET mapreduce.reduce.java.opts = -Xmx4224m; -- 对应堆内存
SET mapreduce.reduce.cpu.vcores = 4; -- 将vCores设置为集群允许的最大值
-- 开启强制排序
insert into
table dwd.itcast_intention_dwd partition (yearinfo, monthinfo, dayinfo)
select
    id as rid,
    customer_id,
    create_date_time,
    if(
        itcast_school_id is null
        OR itcast_school_id = 0,
        '-1',
        itcast_school_id
    ) as itcast_school_id,
    deleted,
    origin_type,
    if(
        itcast_subject_id is not null,
        if(
            itcast_subject_id != 0,
            itcast_subject_id,
            '-1'
        ),
        '-1'
    ) as itcast_subject_id,
    creator,
    substr(create_date_time, 12, 2) as hourinfo,
    if(
        origin_type in ('NETSERVICE', 'PRESIGNUP'),
        '1',
        '0'
    ) as origin_type_stat,
    substr(create_date_time, 1, 4) as yearinfo,
    substr(create_date_time, 6, 2) as monthinfo,
    substr(create_date_time, 9, 2) as dayinfo
from ods.customer_relationship
where
    deleted = 0;
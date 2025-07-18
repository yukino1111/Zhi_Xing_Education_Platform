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

-- 优化: 
set hive.auto.convert.join=false;  -- map join
set hive.optimize.bucketmapjoin = false; -- 开启 bucket map join
-- 开启SMB map join
set hive.auto.convert.sortmerge.join=false;
set hive.auto.convert.sortmerge.join.noconditionaltask=false;
-- 写入数据强制排序
set hive.enforce.sorting=false;
-- 开启自动尝试SMB连接
set hive.optimize.bucketmapjoin.sortedmerge = false; 



insert into
table dwm.itcast_intention_dwm partition (yearinfo, monthinfo, dayinfo)
select
    iid.customer_id,
    iid.create_date_time,
    c.area,
    iid.itcast_school_id,
    sch.name as itcast_school_name,
    iid.deleted,
    iid.origin_type,
    iid.itcast_subject_id,
    sub.name as itcast_subject_name,
    iid.hourinfo,
    iid.origin_type_stat,
    -- if(cc.clue_state = 'VALID_NEW_CLUES',1,if(cc.clue_state = 'VALID_PUBLIC_NEW_CLUE','0','-1')) as clue_state_stat, -- 此处有转换
    case cc.clue_state
        when 'VALID_NEW_CLUES' then '1'
        when 'VALID_PUBLIC_NEW_CLUE' then '0'
        else '-1'
    end as clue_state_stat,
    emp.tdepart_id,
    dept.name as tdepart_name,
    iid.yearinfo,
    iid.monthinfo,
    iid.dayinfo
from
    dwd.itcast_intention_dwd iid
    left join ods.customer_clue cc on cc.customer_relationship_id = iid.rid
    left join dimen.customer c on iid.customer_id = c.id
    left join dimen.itcast_subject sub on iid.itcast_subject_id = sub.id
    left join dimen.itcast_school sch on iid.itcast_school_id = sch.id
    left join dimen.employee emp on iid.creator = emp.id
    left join dimen.scrm_department dept on emp.tdepart_id = dept.id;
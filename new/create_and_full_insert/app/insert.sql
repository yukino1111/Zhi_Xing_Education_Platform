SET mapreduce.job.reduces = 50;
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
SET hive.auto.convert.sortmerge.join=true;
SET hive.auto.convert.sortmerge.join.noconditionaltask=true; -- 建议开启
SET hive.optimize.bucketmapjoin.sortedmerge = true;
-- 总订单笔数
--加载数据到app表
insert overwrite table app_didi.t_order_total partition(month='2020-04')
select 
    '2020-04-12',
    count(orderid) as total_cnt
from
    dw_didi.t_user_order_wide
where
    dt = '2020-04-12';
-- 预约和非预约用户占比
-- 需求:
-- 求出预约用户订单所占的百分比:
--加载数据到app表
insert overwrite table  app_didi.t_order_subscribe_percent partition(month='2020-04')
select 
   '2020-04-12',
    '预约',
    concat(round(t1.total_cnt /t2.total_cnt *100,2),'%') as subscribe 
from 
   (
      select 
            count(orderid) as total_cnt
        from
            dw_didi.t_user_order_wide
        where
            subscribe = 1 and dt = '2020-04-12' 
    )t1,
    (
        select 
            count(orderid) as total_cnt
        from
            dw_didi.t_user_order_wide
        where
            dt = '2020-04-12'
    )t2

union all
select 
   '2020-04-12',
    '非预约',
    concat(round(t1.total_cnt /t2.total_cnt *100,2),'%') as nosubscribe 
from 
   (
      select 
            count(orderid) as total_cnt
        from
            dw_didi.t_user_order_wide
        where
            subscribe = 0 and dt = '2020-04-12' 
    )t1,
    (
        select 
            count(orderid) as total_cnt
        from
            dw_didi.t_user_order_wide
        where
            dt = '2020-04-12'
    )t2;

-- 不同时段的占比分析
insert overwrite table app_didi.t_order_timerange_total partition(month = '2020-04')
select
    '2020-04-12',
    order_time_range,
    count(*) as order_cnt
from
    dw_didi.t_user_order_wide
where
    dt = '2020-04-12'
group by
    order_time_range;

-- 不同地域订单占比
insert overwrite table app_didi.t_order_province_total partition(month = '2020-04')
select
    '2020-04-12',
    province,
    count(*) as order_cnt
from
    dw_didi.t_user_order_wide
where
    dt = '2020-04-12'
group by
    province
order by order_cnt desc;

-- 不同年龄段，不同时段订单占比
insert overwrite table app_didi.t_order_age_and_time_range_total partition(month = '2020-04')
select
      '2020-04-12',
      age_range,
     order_time_range,
    count(*) as order_cnt
from
    dw_didi.t_user_order_wide
where
    dt = '2020-04-12'
group by
    age_range,
    order_time_range;
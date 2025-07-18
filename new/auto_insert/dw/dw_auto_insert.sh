#!/bin/bash
HIVE_HOME=/usr/bin/hive
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
if [ $# == 1 ]

then
   dateStr=$1

   else 
      dateStr=`date -d '-1 day' +'%Y-%m-%d'`

fi
yearStr=`date -d ${dateStr} +'%Y'`
monthStr=`date -d ${dateStr} +'%m'`
dayStr=`date -d ${dateStr} +'%d'`

dateNowStr=`date +'%Y-%m-%d'`

sqlStr="
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

insert OVERWRITE 
table dw_didi.t_user_order_wide partition (dt)
select
    ord.orderId,
    ord.telephone,
    ord.lng,
    ord.lat,
    ord.province,
    ord.city,
    ord.es_money,
    ord.gender,
    ord.profession,
    ord.age_range,
    ord.tip,
    ord.subscribe,
    case
        when ord.subscribe = 0 then '非预约'
        when ord.subscribe = 1 then '预约'
    end as subscribe_name,
    date_format(
        concat(ord.sub_time, ':00'),
        'yyyy-MM-dd HH:mm:ss'
    ) as sub_time,
    ord.is_agent,
    case
        when ord.is_agent = 0 then '本人'
        when ord.is_agent = 1 then '代叫'
    end as is_agent_name,
    ord.agent_telephone,
    date_format(ord.order_time, 'yyyy-MM-dd') as order_date, -- 2020-1-1 --->2020-01-01
    year(
        date_format(ord.order_time, 'yyyy-MM-dd')
    ) as order_year, --2020
    month(
        date_format(ord.order_time, 'yyyy-MM-dd')
    ) as order_month, --12
    day(
        date_format(ord.order_time, 'yyyy-MM-dd')
    ) as order_day, --23
    hour(
        date_format(
            concat(ord.order_time, ':00'),
            'yyyy-MM-dd HH:mm:ss'
        )
    ) as order_hour,
    case
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 1
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 5 then '凌晨'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 5
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 8 then '早上'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 8
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 11 then '上午'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 11
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 13 then '中午'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 13
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 17 then '下午'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 17
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 19 then '晚上'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 19
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 20 then '半夜'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) > 20
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 24 then '深夜'
        when hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) >= 0
        and hour(
            date_format(
                concat(ord.order_time, ':00'),
                'yyyy-MM-dd HH:mm:ss'
            )
        ) <= 1 then '深夜'
        else 'N/A'
    end as order_time_range,
    date_format(
        concat(ord.order_time, ':00'),
        'yyyy-MM-dd HH:mm:ss'
    ) as order_time,
    eva.eva_level,
    ord.dt
from ods_didi.t_user_order as ord
    LEFT join ods_didi.t_user_evaluate as eva on ord.orderId = eva.orderId
where
    year(
        date_format(ord.order_time, 'yyyy-MM-dd')
    )=${yearStr} AND 
    month(
        date_format(ord.order_time, 'yyyy-MM-dd')
    )=${monthStr} AND 
    day(
        date_format(ord.order_time, 'yyyy-MM-dd')
    )=${dayStr} AND
    ord.order_time IS NOT NULL;
"

${HIVE_HOME} -e "${sqlStr}" 

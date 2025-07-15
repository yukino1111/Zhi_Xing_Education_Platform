insert overwrite table dw_didi.t_user_order_wide partition(dt='2020-04-12')
select 
    orderId,
    telephone,
    lng,
    lat,
    province,
    city,
    es_money,
    gender,
    profession,
    age_range,
    tip,
    subscribe,
    case when subscribe = 0 then '非预约'
         when subscribe = 1 then'预约'
    end as subscribe_name,
     date_format(concat(sub_time,':00'), 'yyyy-MM-dd HH:mm:ss') as sub_time,
    is_agent,
    case when is_agent = 0 then '本人'
         when is_agent = 1 then '代叫'
    end as is_agent_name,
    agent_telephone,
    date_format(order_time, 'yyyy-MM-dd') as order_date, -- 2020-1-1 --->2020-01-01
    year(date_format(order_time, 'yyyy-MM-dd')) as order_year, --2020
    month(date_format(order_time, 'yyyy-MM-dd')) as order_month, --12
    day(date_format(order_time, 'yyyy-MM-dd')) as order_day, --23
    hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) as order_hour,
    case when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 1 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 5 then '凌晨'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 5 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 8 then '早上'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 8 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 11 then '上午'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 11 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 13 then '中午'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 13 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 17 then '下午'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 17 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 19 then '晚上'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 19 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 20 then '半夜'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) > 20 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 24 then '深夜'
         when hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) >= 0 and hour(date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss')) <= 1 then '深夜'
         else 'N/A'
    end as order_time_range,
    date_format(concat(order_time,':00'), 'yyyy-MM-dd HH:mm:ss') as order_time
from ods_didi.t_user_order where dt = '2020-04-12' and length(order_time) >= 8;
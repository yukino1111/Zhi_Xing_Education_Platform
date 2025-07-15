#!/bin/bash


if [ $# == 1 ]
   then
      dateStr=$1
   else
      dateStr=`date -d '-1 day' +'%Y-%m-%d'`
fi

dateNowStr=`date +'%Y-%m-%d'`

yearStr=`date -d ${dateStr} +'%Y'`
monthStr=`date -d ${dateStr} +'%m'`

jdbcUrl_scrm='jdbc:mysql://192.168.52.150:3306/scrm'
jdbcUrl_teach='jdbc:mysql://192.168.52.150:3306/teach'
username='root'
password='123456'
m='1'
HIVE_HOME=/usr/bin/hive

sqoop import \
--connect ${jdbcUrl_scrm} \
--username ${username} \
--password ${password} \
--query "SELECT *, "9999-12-31" as end_time , '${dateNowStr}' AS start_time FROM customer_relationship where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods \
--hcatalog-table customer_relationship_temp \
-m ${m}

sqoop import \
--connect ${jdbcUrl_scrm} \
--username ${username} \
--password ${password} \
--query "SELECT id,create_date_time,update_date_time,deleted,customer_id,customer_relationship_id,session_id,sid,status,user as users,create_time,platform,s_name,seo_source,seo_keywords,ip,referrer,from_url,landing_page_url,url_title,to_peer,manual_time,begin_time,reply_msg_count,total_msg_count,msg_count,comment,finish_reason,finish_user,end_time,platform_description,browser_name,os_info,area,country,province,city,creator,name,"-1" as idcard,"-1" as phone,itcast_school_id,itcast_school,itcast_subject_id,itcast_subject,"-1" as wechat,"-1" as qq,"-1" as email,gender,level,origin_type,information_way,working_years,technical_directions,customer_state,valid,anticipat_signup_date,clue_state,scrm_department_id,superior_url,superior_source,landing_url,landing_source,info_url,info_source,origin_channel,course_id,course_name,zhuge_session_id,is_repeat,tenant,activity_id,activity_name,follow_type,shunt_mode_id,shunt_employee_group_id, "9999-12-31" as ends_time , '${dateNowStr}' AS starts_time FROM customer_clue where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods \
--hcatalog-table customer_clue_temp \
-m ${m}

sqlStr="
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

insert OVERWRITE table ods.customer_relationship partition(start_time)
select * from ods.customer_relationship_temp;

insert OVERWRITE table ods.customer_clue partition(starts_time)
select * from ods.customer_clue_temp;"

${HIVE_HOME} -e "${sqlStr}" 
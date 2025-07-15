sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/scrm \
--username root \
--password 123456 \
--query 'SELECT 
  *, "9999-12-31" as end_time , "2021-09-24" AS start_time
FROM customer_relationship where 1=1 and $CONDITIONS' \
--hcatalog-database ods \
--hcatalog-table customer_relationship_temp \
-m 1

sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/scrm \
--username root \
--password 123456 \
--query 'SELECT 
  id,create_date_time,update_date_time,deleted,customer_id,customer_relationship_id,session_id,sid,status,user as users,create_time,platform,s_name,seo_source,seo_keywords,ip,referrer,from_url,landing_page_url,url_title,to_peer,manual_time,begin_time,reply_msg_count,total_msg_count,msg_count,comment,finish_reason,finish_user,end_time,platform_description,browser_name,os_info,area,country,province,city,creator,name,"-1" as idcard,"-1" as phone,itcast_school_id,itcast_school,itcast_subject_id,itcast_subject,"-1" as wechat,"-1" as qq,"-1" as email,gender,level,origin_type,information_way,working_years,technical_directions,customer_state,valid,anticipat_signup_date,clue_state,scrm_department_id,superior_url,superior_source,landing_url,landing_source,info_url,info_source,origin_channel,course_id,course_name,zhuge_session_id,is_repeat,tenant,activity_id,activity_name,follow_type,shunt_mode_id,shunt_employee_group_id, "9999-12-31" as ends_time , "2021-09-24" AS starts_time
FROM customer_clue where 1=1 and $CONDITIONS' \
--hcatalog-database ods \
--hcatalog-table customer_clue_temp \
-m 1


-- 第三步: 执行 insert into + select 导入到目标表
--动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;

insert into table ods.customer_relationship partition(start_time)
select * from ods.customer_relationship_temp;

insert into table ods.customer_clue partition(starts_time)
select * from ods.customer_clue_temp;
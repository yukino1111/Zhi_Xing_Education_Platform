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

# 客户表
sqoop import \
--connect ${jdbcUrl_teach} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS start_time FROM customer where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database dimen \
--hcatalog-table customer \
-m ${m} 

# 学科表:
sqoop import \
--connect ${jdbcUrl_scrm} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS start_time FROM itcast_subject where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database dimen \
--hcatalog-table itcast_subject \
-m ${m} 

# 校区表:
sqoop import \
--connect ${jdbcUrl_scrm} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS start_time FROM itcast_school where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database dimen \
--hcatalog-table itcast_school \
-m ${m} 

# 员工表
sqoop import \
--connect ${jdbcUrl_teach} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS start_time FROM employee where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database dimen \
--hcatalog-table employee \
-m ${m}

# 部门表
sqoop import \
--connect ${jdbcUrl_scrm} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS start_time FROM scrm_department where create_date_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database dimen \
--hcatalog-table scrm_department \
-m ${m}
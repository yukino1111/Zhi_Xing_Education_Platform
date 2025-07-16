#!/bin/bash
HIVE_HOME=/usr/bin/hive
if [ $# == 1 ]
   then
      dateStr=$1
   else
      dateStr=`date -d '-1 day' +'%Y-%m-%d'`
fi

dateNowStr=`date +'%Y-%m-%d'`

yearStr=`date -d ${dateStr} +'%Y'`
monthStr=`date -d ${dateStr} +'%m'`

jdbcUrl='jdbc:mysql://192.168.52.150:3306/second'
username='root'
password='123456'
m='1'

sqlStr="
ALTER TABLE ods_didi.t_user_cancel_order DROP IF EXISTS PARTITION (dt='${dateNowStr}');
ALTER TABLE ods_didi.t_user_evaluate DROP IF EXISTS PARTITION (dt='${dateNowStr}');
ALTER TABLE ods_didi.t_user_order DROP IF EXISTS PARTITION (dt='${dateNowStr}');
ALTER TABLE ods_didi.t_user_pay_order DROP IF EXISTS PARTITION (dt='${dateNowStr}');
"

${HIVE_HOME} -e "${sqlStr}" 



sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS dt FROM t_user_cancel_order where cancel_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods_didi \
--hcatalog-table t_user_cancel_order \
-m ${m}

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS dt FROM t_user_evaluate where eva_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods_didi \
--hcatalog-table t_user_evaluate \
-m ${m}



sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS dt FROM t_user_order where order_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods_didi \
--hcatalog-table t_user_order \
-m ${m}

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query "SELECT 
  *, '${dateNowStr}' AS dt FROM t_user_pay_order where pay_time BETWEEN '${dateStr} 00:00:00' AND '${dateStr} 23:59:59' and \$CONDITIONS" \
--hcatalog-database ods_didi \
--hcatalog-table t_user_pay_order \
-m ${m}

#!/bin/bash

if [ $# == 1 ]
then
   TD_DATE=$1  
else
   TD_DATE=`date -d '-1 day' +'%Y-%m-%d'`
fi

TD_YEAR=`date -d ${TD_DATE} +%Y`

jdbcUrl_out='jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8'
ip='192.168.52.150'
port='3306'
username='root'
password='123456'
m='1'

mysql -u${username} -p${password} -h${ip} -P${port} -e "delete from second_ex.t_order_total where yearinfo='$TD_YEAR'; delete from second_ex.t_order_subscribe_percent where yearinfo='$TD_YEAR'; delete from second_ex.t_order_timerange_total where yearinfo='$TD_YEAR'; delete from second_ex.t_order_province_total where yearinfo='$TD_YEAR'; delete from second_ex.t_order_age_range_total where yearinfo='$TD_YEAR'; delete from second_ex.t_order_eva_level where yearinfo='$TD_YEAR'; "


sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_total \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_subscribe_percent \
--hcatalog-database app_didi \
--hcatalog-table t_order_subscribe_percent \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_timerange_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_timerange_total \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_province_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_province_total \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_age_range_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_age_range_total \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table t_order_eva_level \
--hcatalog-database app_didi \
--hcatalog-table t_order_eva_level \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}
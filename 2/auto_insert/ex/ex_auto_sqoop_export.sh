#!/bin/bash

if [ $# == 1 ]
then
   TD_DATE=$1  
else
   TD_DATE=`date -d '-1 day' +'%Y-%m-%d'`
fi

TD_YEAR=`date -d ${TD_DATE} +%Y`



jdbcUrl_out='jdbc:mysql://192.168.52.150:3306/scrm_ex?useUnicode=true&characterEncoding=utf-8'
ip='192.168.52.150'
port='3306'
username='root'
password='123456'
m='1'

mysql -u${username} -p${password} -h${ip} -P${port} -e "delete from scrm_ex.itcast_intention_1 where yearinfo='$TD_YEAR'; delete from scrm_ex.itcast_intention_2 where yearinfo='$TD_YEAR'; delete from scrm_ex.itcast_intention_3 where yearinfo='$TD_YEAR'; delete from scrm_ex.itcast_intention_4 where yearinfo='$TD_YEAR'; delete from scrm_ex.itcast_intention_5 where yearinfo='$TD_YEAR'; delete from scrm_ex.itcast_intention_6 where yearinfo='$TD_YEAR'; "

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_1 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_1 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_2 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_2 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_3 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_3 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_4 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_4 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_5 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_5 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}

sqoop export \
--connect ${jdbcUrl_out} \
--username ${username} \
--password ${password} \
--table itcast_intention_6 \
--hcatalog-database dws \
--hcatalog-table itcast_intention_dws_6 \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values $TD_YEAR \
--m ${m}
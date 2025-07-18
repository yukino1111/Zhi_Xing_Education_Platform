mkdir -p /export/data/didi

# --3.2、通过load命令给表加载数据，并指定分区
load data local inpath '/export/data/didi/order.csv' into table ods_didi.t_user_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/cancel_order.csv' into table ods_didi.t_user_cancel_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/pay.csv' into table ods_didi.t_user_pay_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/evaluate.csv' into table ods_didi.t_user_evaluate partition (dt='2020-04-12');

drop table if exists ods_didi.t_user_order;
drop table if exists ods_didi.t_user_cancel_order;
drop table if exists ods_didi.t_user_pay_order;
drop table if exists ods_didi.t_user_evaluate;

#!/bin/bash

jdbcUrl='jdbc:mysql://192.168.52.150:3306/second'
username='root'
password='123456'
m='1'

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query 'SELECT *, "2020-04-12" AS dt FROM t_user_cancel_order WHERE $CONDITIONS' \
--hcatalog-database ods_didi \
--hcatalog-table t_user_cancel_order \
-m ${m}

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query 'SELECT *, "2020-04-12" AS dt FROM t_user_evaluate WHERE $CONDITIONS' \
--hcatalog-database ods_didi \
--hcatalog-table t_user_evaluate \
-m ${m}

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query 'SELECT *, "2020-04-12" AS dt FROM t_user_order WHERE $CONDITIONS' \
--hcatalog-database ods_didi \
--hcatalog-table t_user_order \
-m ${m}

sqoop import \
--connect ${jdbcUrl} \
--username ${username} \
--password ${password} \
--query 'SELECT *, "2020-04-12" AS dt FROM t_user_pay_order WHERE $CONDITIONS' \
--hcatalog-database ods_didi \
--hcatalog-table t_user_pay_order \
-m ${m}

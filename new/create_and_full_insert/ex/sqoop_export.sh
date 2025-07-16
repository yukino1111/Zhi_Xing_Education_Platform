sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_total \
-m 1

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_subscribe_percent \
--hcatalog-database app_didi \
--hcatalog-table t_order_subscribe_percent \
-m 1

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_timerange_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_timerange_total \
-m 1

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_province_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_province_total \
-m 1

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_age_range_total \
--hcatalog-database app_didi \
--hcatalog-table t_order_age_range_total \
-m 1

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/second_ex?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table t_order_eva_level \
--hcatalog-database app_didi \
--hcatalog-table t_order_eva_level \
-m 1
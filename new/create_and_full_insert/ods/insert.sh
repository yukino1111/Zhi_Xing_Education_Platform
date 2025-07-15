mkdir -p /export/data/didi

# --3.2、通过load命令给表加载数据，并指定分区
load data local inpath '/export/data/didi/order.csv' into table ods_didi.t_user_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/cancel_order.csv' into table ods_didi.t_user_cancel_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/pay.csv' into table ods_didi.t_user_pay_order partition (dt='2020-04-12');
load data local inpath '/export/data/didi/evaluate.csv' into table ods_didi.t_user_evaluate partition (dt='2020-04-12');


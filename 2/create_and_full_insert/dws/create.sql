CREATE DATABASE IF NOT EXISTS dws;

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_1 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_1' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_2 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `area` STRING COMMENT '区域信息',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_2' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_3 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `itcast_school_id` STRING COMMENT '校区id',
    `itcast_school_name` STRING COMMENT '校区名称',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_3' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_4 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `itcast_subject_id` STRING COMMENT '学科id',
    `itcast_subject_name` STRING COMMENT '学科名称',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_4' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_5 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `origin_type` STRING COMMENT '来源渠道',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_5' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

CREATE TABLE IF NOT EXISTS dws.itcast_intention_dws_6 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '客户属性：0.老客户；1.新客户',
    `tdepart_id` STRING COMMENT '创建者部门id',
    `tdepart_name` STRING COMMENT '咨询中心名称',
    `time_str` STRING COMMENT '时间明细',
    `time_type` STRING COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
) comment '客户意向dws表_6' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');
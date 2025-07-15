CREATE DATABASE IF NOT EXISTS dwd;
CREATE TABLE IF NOT EXISTS dwd.`itcast_intention_dwd` (
    `rid` int COMMENT 'id',
    `customer_id` STRING COMMENT '客户id',
    `create_date_time` STRING COMMENT '创建时间',
    `itcast_school_id` STRING COMMENT '校区id',
    `deleted` STRING COMMENT '是否被删除',
    `origin_type` STRING COMMENT '来源渠道',
    `itcast_subject_id` STRING COMMENT '学科id',
    `creator` int COMMENT '创建人',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上'
) comment '客户意向dwd表' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) clustered by (rid) sorted by (rid) into 10 buckets ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as ORC TBLPROPERTIES ('orc.compress' = 'SNAPPY');
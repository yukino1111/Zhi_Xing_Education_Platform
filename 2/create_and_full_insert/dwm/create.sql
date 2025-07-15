CREATE DATABASE IF NOT EXISTS dwm;

CREATE TABLE IF NOT EXISTS dwm.`itcast_intention_dwm` (
    `customer_id` STRING COMMENT 'id信息',
    `create_date_time` STRING COMMENT '创建时间',
    `area` STRING COMMENT '区域信息',
    `itcast_school_id` STRING COMMENT '校区id',
    `itcast_school_name` STRING COMMENT '校区名称',
    `deleted` STRING COMMENT '是否被删除',
    `origin_type` STRING COMMENT '来源渠道',
    `itcast_subject_id` STRING COMMENT '学科id',
    `itcast_subject_name` STRING COMMENT '学科名称',
    `hourinfo` STRING COMMENT '小时信息',
    `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` STRING COMMENT '新老客户：0.老客户；1.新客户',
    `tdepart_id` STRING COMMENT '创建者部门id',
    `tdepart_name` STRING COMMENT '咨询中心名称'
) comment '客户意向dwm表' PARTITIONED BY (
    yearinfo STRING,
    monthinfo STRING,
    dayinfo STRING
) clustered by (customer_id) sorted by (customer_id) into 10 buckets ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as ORC TBLPROPERTIES ('orc.compress' = 'SNAPPY');
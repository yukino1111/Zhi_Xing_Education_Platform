CREATE DATABASE IF NOT EXISTS scrm_ex;

ALTER DATABASE scrm_ex CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_1 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_1';

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_2 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `area` varchar(100) COMMENT '区域信息',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_2';

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_3 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `itcast_school_id` varchar(100) COMMENT '校区id',
    `itcast_school_name` varchar(100) COMMENT '校区名称',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_3';

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_4 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `itcast_subject_id` varchar(100) COMMENT '学科id',
    `itcast_subject_name` varchar(100) COMMENT '学科名称',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_4';

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_5 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `origin_type` varchar(100) COMMENT '来源渠道',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_5';

CREATE TABLE IF NOT EXISTS scrm_ex.itcast_intention_6 (
    `customer_total` INT COMMENT '聚合意向客户数',
    `hourinfo` varchar(100) COMMENT '小时信息',
    `origin_type_stat` varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat` varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `tdepart_id` varchar(100) COMMENT '创建者部门id',
    `tdepart_name` varchar(100) COMMENT '咨询中心名称',
    `time_str` varchar(100) COMMENT '时间明细',
    `time_type` varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) comment '客户意向dws表_6';
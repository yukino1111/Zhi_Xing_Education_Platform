CREATE DATABASE IF NOT EXISTS second_ex;

ALTER DATABASE second_ex CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 切换到目标数据库
USE second_ex;

-- 1. 总订单笔数
CREATE TABLE IF NOT EXISTS t_order_total (
    date_val VARCHAR(10) NOT NULL COMMENT '日期（年月日)',
    count INT NOT NULL COMMENT '订单笔数'
) COMMENT '总订单笔数';

-- 2. 预约和非预约用户占比
CREATE TABLE IF NOT EXISTS t_order_subscribe_percent (
    date_val VARCHAR(10) NOT NULL COMMENT '日期',
    subscribe_name VARCHAR(20) NOT NULL COMMENT '是否预约', -- 例如：'预约', '非预约'
    percent_val VARCHAR(10) NOT NULL COMMENT '百分比' -- 例如：'25.50%'
) COMMENT '预约和非预约用户占比';

-- 3. 不同时段的占比分析
CREATE TABLE IF NOT EXISTS t_order_timerange_total (
    date_val VARCHAR(10) NOT NULL COMMENT '日期',
    timerange VARCHAR(50) NOT NULL COMMENT '时间段', -- 例如：'00:00-06:00', '06:00-12:00'
    count INT NOT NULL COMMENT '订单数量'
) COMMENT '不同时段的订单数量';

-- 4. 不同地域订单占比
CREATE TABLE IF NOT EXISTS t_order_province_total (
    date_val VARCHAR(10) NOT NULL COMMENT '日期',
    province VARCHAR(50) NOT NULL COMMENT '省份',
    count INT NOT NULL COMMENT '订单数量'
) COMMENT '不同地域订单数量';

-- 5. 不同年龄段，不同时段订单占比
CREATE TABLE IF NOT EXISTS t_order_age_and_time_range_total (
    date_val VARCHAR(10) NOT NULL COMMENT '日期',
    age_range VARCHAR(20) NOT NULL COMMENT '年龄段', -- 例如：'0-18', '19-30'
    order_time_range VARCHAR(50) NOT NULL COMMENT '时段', -- 例如：'00:00-06:00'
    count INT NOT NULL COMMENT '订单数量'
) COMMENT '不同年龄段，不同时段订单数量';



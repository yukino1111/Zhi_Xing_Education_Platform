DROP DATABASE IF EXISTS second_ex;
CREATE DATABASE IF NOT EXISTS second_ex;

ALTER DATABASE second_ex CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 切换到目标数据库
USE second_ex;

-- 1. 总订单笔数
CREATE TABLE IF NOT EXISTS t_order_total (
    count INT COMMENT '订单笔数',
    time_type varchar(100) COMMENT '时间维度',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '总订单笔数';

-- 2. 预约和非预约用户占比
CREATE TABLE IF NOT EXISTS t_order_subscribe_percent (
    time_type varchar(100) COMMENT '时间维度',
    subscribe_percent VARCHAR(10) COMMENT '预约百分比',
    non_subscribe_percent VARCHAR(10) COMMENT '非预约百分比',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '预约和非预约用户占比';

-- 3. 不同时段的占比分析
CREATE TABLE IF NOT EXISTS t_order_timerange_total (
    timerange VARCHAR(50) COMMENT '时间段', -- 例如：'00:00-06:00', '06:00-12:00'
    time_type varchar(100) COMMENT '时间维度',
    count INT COMMENT '订单数量',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '不同时段的订单数量';

-- 4. 不同地域订单占比
CREATE TABLE IF NOT EXISTS t_order_province_total (
    province VARCHAR(50) COMMENT '省份',
    time_type varchar(100) COMMENT '时间维度',
    count INT COMMENT '订单数量',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '不同地域订单数量';

-- 5. 不同年龄段，不同时段订单占比
CREATE TABLE IF NOT EXISTS t_order_age_range_total (
    age_range VARCHAR(20) COMMENT '年龄段', -- 例如：'0-18', '19-30'
    time_type varchar(100) COMMENT '时间维度',
    count INT COMMENT '订单数量',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '不同年龄段，不同时段订单数量';

-- 6. 不同星级，不同时段订单占比
CREATE TABLE IF NOT EXISTS t_order_eva_level (
    count INT COMMENT '订单数量',
    time_type varchar(100) COMMENT '时间维度',
    eva_level int COMMENT '评分',
    yearinfo varchar(100) COMMENT '年',
    monthinfo varchar(100) COMMENT '月',
    dayinfo varchar(100) COMMENT '日'
) COMMENT '订单评分';
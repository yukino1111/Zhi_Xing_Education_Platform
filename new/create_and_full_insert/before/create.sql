drop database second;
create database second;
ALTER DATABASE second CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE if not exists second.cancel_order (
    order_id VARCHAR(50) PRIMARY KEY, -- 订单ID，通常是唯一标识符
    phone_number VARCHAR(20) NOT NULL, -- 手机号，不能为空
    longitude DECIMAL(10, 7),        -- 经度，DECIMAL(10, 7) 可以在小数点后存储7位，足以表示精确的经纬度
    latitude DECIMAL(10, 7),         -- 纬度，同上
    province VARCHAR(50),            -- 省份
    city VARCHAR(50),                -- 城市
    amount DECIMAL(10, 2),           -- 钱，DECIMAL(10, 2) 可以存储总共10位数字，小数点后2位
    gender VARCHAR(10),              -- 性别
    position VARCHAR(50),            -- 岗位
    age_group VARCHAR(20),           -- 年龄 (例如 "80后")
    special_id INT,                  -- 特殊ID
    order_time DATETIME              -- 时间，DATETIME 类型存储日期和时间
);
CREATE TABLE if not exists second.order (
    order_id VARCHAR(50) PRIMARY KEY,      -- 订单ID
    phone_number VARCHAR(20) NOT NULL,      -- 手机号
    longitude DECIMAL(10, 7),             -- 经度
    latitude DECIMAL(10, 7),              -- 纬度
    province VARCHAR(50),                 -- 省份
    city VARCHAR(50),                     -- 城市
    amount DECIMAL(10, 2),                -- 钱
    gender VARCHAR(10),                   -- 性别
    position VARCHAR(50),                 -- 岗位
    age_group VARCHAR(20),                -- 年龄 (例如 "70后")
    special_id1 INT,                      -- 特殊ID 1 (根据示例 '4'，可以是 INT)
    special_id2 INT,                      -- 神秘ID 2 (根据示例 '1'，可以是 INT)
    end_time DATETIME,                    -- 结束时间 (根据示例 '2020-4-12 20:54')
    mystery_phone VARCHAR(20),            -- 神秘电话 (根据示例 '', '0' 可能是空字符串或数字0，用 VARCHAR 更通用)
    special_id3 INT,                      -- 神秘ID 3 (根据示例 '1'，可以是 INT)
    start_time DATETIME                   -- 开始时间 (根据示例 '2020-4-12 20:06')
);

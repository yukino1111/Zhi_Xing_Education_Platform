CREATE TABLE orders_data (
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
import pymysql
import uuid
import random
from datetime import datetime, timedelta

DB_CONFIG = {
    "host": "192.168.52.150",
    "user": "root",  # 你的数据库用户名
    "password": "123456",  # 你的数据库密码
    "database": "second",  # 你的数据库名
    "charset": "utf8mb4",
}


def generate_random_data(num_records=1000):
    """
    生成指定数量的随机订单和评价数据。
    """
    all_orders_data = []
    all_evaluates_data = []

    # 预定义的省份、城市、年龄段列表，从你提供的示例中提取
    provinces = ["陕西省", "北京市", "上海市", "广东省", "四川省", "湖北省"]
    cities = ["延安市", "西安市", "广州市", "成都市", "武汉市", "北京市", "上海市"]
    age_ranges = ["70后", "80后", "90后", "00后", "60后", "50后"]

    start_date = datetime(2020, 4, 1, 0, 0, 0)
    end_date = datetime(2020, 4, 30, 23, 59, 59)
    time_diff = (end_date - start_date).total_seconds()

    for _ in range(num_records):
        order_id = str(uuid.uuid4()).replace("-", "")  # 生成唯一的订单ID

        # 生成随机时间，确保在2020年4月内均匀分布
        random_seconds = random.uniform(0, time_diff)
        order_time = start_date + timedelta(seconds=random_seconds)
        sub_time = order_time + timedelta(
            minutes=random.randint(-60, 60)
        )  # 预约时间在订单时间前后浮动

        # 随机选择省份、城市、年龄段
        province = random.choice(provinces)
        city = random.choice(cities)
        age_range = random.choice(age_ranges)

        # 随机生成其他字段
        telephone = f"1{random.randint(30, 99)}{random.randint(10000000, 99999999)}"
        lng = round(random.uniform(73.5, 135.1), 6)  # 中国经度范围
        lat = round(random.uniform(3.8, 53.5), 6)  # 中国纬度范围
        es_money = round(random.uniform(10, 200), 2)
        gender = random.choice(["男", "女"])
        profession = random.choice(
            ["软件工程", "教师", "医生", "学生", "自由职业", "销售"]
        )
        tip = random.randint(0, 20)
        subscribe = random.randint(0, 1)  # 0: 非预约, 1: 预约
        is_agent = random.randint(0, 1)  # 0: 本人, 1: 代叫
        agent_telephone = (
            f"1{random.randint(30, 99)}{random.randint(10000000, 99999999)}"
            if is_agent == 1
            else None
        )

        # t_user_order 数据
        order_data = (
            order_id,
            telephone,
            lng,
            lat,
            province,
            city,
            es_money,
            gender,
            profession,
            age_range,
            tip,
            subscribe,
            sub_time.strftime("%Y-%m-%d %H:%M"),  # 格式化为 'YYYY-MM-DD HH:MM'
            is_agent,
            agent_telephone,
            order_time.strftime("%Y-%m-%d %H:%M"),  # 格式化为 'YYYY-MM-DD HH:MM'
        )
        all_orders_data.append(order_data)

        # t_user_evaluate 数据
        eva_level = random.randint(1, 5)  # 评价星级 1-5
        eva_time = order_time + timedelta(
            minutes=random.randint(5, 120)
        )  # 评价时间在订单时间后5-120分钟
        evaluate_data = (
            str(uuid.uuid4()).replace("-", ""),  # 评价ID
            order_id,
            telephone,  # 乘客手机号与订单手机号一致
            province,
            city,
            eva_level,
            eva_time.strftime("%Y-%m-%d %H:%M"),  # 格式化为 'YYYY-MM-DD HH:MM'
        )
        all_evaluates_data.append(evaluate_data)

    return all_orders_data, all_evaluates_data


def insert_data_to_mysql(orders_data, evaluates_data):
    """
    将生成的数据插入到 MySQL 数据库中。
    """
    conn = None
    try:
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # 插入 t_user_order 数据
        order_insert_sql = """
        INSERT INTO `t_user_order` (
            `orderId`, `telephone`, `lng`, `lat`, `province`, `city`, `es_money`, 
            `gender`, `profession`, `age_range`, `tip`, `subscribe`, `sub_time`, 
            `is_agent`, `agent_telephone`, `order_time`
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.executemany(order_insert_sql, orders_data)
        print(f"成功插入 {len(orders_data)} 条 t_user_order 记录。")

        # 插入 t_user_evaluate 数据
        evaluate_insert_sql = """
        INSERT INTO `t_user_evaluate` (
            `id`, `orderId`, `passenger_telephone`, `passenger_province`, 
            `passenger_city`, `eva_level`, `eva_time`
        ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.executemany(evaluate_insert_sql, evaluates_data)
        print(f"成功插入 {len(evaluates_data)} 条 t_user_evaluate 记录。")

        conn.commit()
        print("所有数据已成功提交到数据库。")

    except pymysql.Error as e:
        print(f"数据库操作失败: {e}")
        if conn:
            conn.rollback()
            print("事务已回滚。")
    finally:
        if conn:
            conn.close()
            print("数据库连接已关闭。")


if __name__ == "__main__":
    print("开始生成数据...")
    orders, evaluates = generate_random_data(1000)
    print("数据生成完毕，开始插入数据库...")
    insert_data_to_mysql(orders, evaluates)

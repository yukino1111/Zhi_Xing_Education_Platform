import random
import uuid
from datetime import datetime, timedelta

# 预定义的省份和城市列表
PROVINCES_CITIES = [
    ("陕西省", "延安市"),
    ("北京市", "北京市"),
    ("上海市", "上海市"),
    ("广东省", "广州市"),
    ("四川省", "成都市"),
    ("湖北省", "武汉市"),
    ("浙江省", "杭州市"),
    ("江苏省", "南京市"),
    ("山东省", "济南市"),
    ("辽宁省", "沈阳市"),
]

# 预定义的年龄段列表
AGE_RANGES = ["70后", "80后", "90后", "00后", "60后", "50后"]

# 预定义的职业列表
PROFESSIONS = ["软件工程", "教师", "医生", "学生", "销售", "公务员", "自由职业"]

# 预定义的性别
GENDERS = ["男", "女"]


def generate_random_phone_number():
    """生成一个随机的11位手机号码"""
    return "1" + "".join(random.choices("0123456789", k=10))


def generate_random_coordinates():
    """生成随机的经纬度"""
    lng = round(random.uniform(73.0, 135.0), 6)  # 中国经度范围
    lat = round(random.uniform(3.0, 54.0), 6)  # 中国纬度范围
    return str(lng), str(lat)


def generate_sql_files(num_records=100):
    # 获取当前日期，并格式化为 'YYYY-MM-DD'
    today_date_str = datetime.now().strftime("%Y-%m-%d")
    print(f"生成数据日期为: {today_date_str}")

    order_sql_filename = f"t_user_order_{today_date_str}.sql"
    evaluate_sql_filename = f"t_user_evaluate_{today_date_str}.sql"

    with open(order_sql_filename, "w", encoding="utf8") as order_f, open(
        evaluate_sql_filename, "w", encoding="utf8"
    ) as evaluate_f:

        print(f"开始生成 {num_records} 条数据到文件...")

        for i in range(num_records):
            order_id = str(uuid.uuid4()).replace("-", "")  # 生成唯一的订单ID
            telephone = generate_random_phone_number()
            lng, lat = generate_random_coordinates()
            province, city = random.choice(PROVINCES_CITIES)
            es_money = round(random.uniform(10.0, 200.0), 2)
            gender = random.choice(GENDERS)
            profession = random.choice(PROFESSIONS)
            age_range = random.choice(AGE_RANGES)
            tip = random.randint(0, 20)  # 小费
            subscribe = random.randint(0, 1)  # 0: 非预约, 1: 预约

            # 生成订单时间，日期固定为今天，时间随机
            order_time_dt = datetime.strptime(today_date_str, "%Y-%m-%d") + timedelta(
                hours=random.randint(0, 23),
                minutes=random.randint(0, 59),
                seconds=random.randint(0, 59),
            )
            order_time_str = order_time_dt.strftime("%Y-%m-%d %H:%M:%S")

            # 预约时间，如果是非预约，则为NULL，如果是预约，则在订单时间之前随机生成
            sub_time_str = "NULL"
            if subscribe == 1:
                sub_time_dt = order_time_dt - timedelta(minutes=random.randint(10, 120))
                sub_time_str = f"'{sub_time_dt.strftime('%Y-%m-%d %H:%M:%S')}'"

            is_agent = random.randint(0, 1)  # 0: 本人, 1: 代叫
            agent_telephone = (
                f"'{generate_random_phone_number()}'" if is_agent == 1 else "NULL"
            )

            # 写入 t_user_order 的 INSERT 语句
            order_sql = f"""
            INSERT INTO `t_user_order` (`orderId`, `telephone`, `lng`, `lat`, `province`, `city`, `es_money`, `gender`, `profession`, `age_range`, `tip`, `subscribe`, `sub_time`, `is_agent`, `agent_telephone`, `order_time`)
            VALUES ('{order_id}', '{telephone}', '{lng}', '{lat}', '{province}', '{city}', {es_money}, '{gender}', '{profession}', '{age_range}', {tip}, {subscribe}, {sub_time_str}, {is_agent}, {agent_telephone}, '{order_time_str}');
            """
            order_f.write(order_sql.strip() + "\n")

            # 写入 t_user_evaluate 的 INSERT 语句
            eva_level = random.randint(1, 5)
            eva_time_dt = order_time_dt + timedelta(minutes=random.randint(5, 60))
            eva_time_str = eva_time_dt.strftime("%Y-%m-%d %H:%M:%S")

            evaluate_sql = f"""
            INSERT INTO `t_user_evaluate` (`id`, `orderId`, `passenger_telephone`, `passenger_province`, `passenger_city`, `eva_level`, `eva_time`)
            VALUES ('{str(uuid.uuid4()).replace('-', '')}', '{order_id}', '{telephone}', '{province}', '{city}', {eva_level}, '{eva_time_str}');
            """
            evaluate_f.write(evaluate_sql.strip() + "\n")

            if (i + 1) % 10 == 0:
                print(f"已生成 {i + 1} 条数据...")

        print(f"成功生成 {num_records} 条数据到文件：")
        print(f"- {order_sql_filename}")
        print(f"- {evaluate_sql_filename}")


if __name__ == "__main__":
    generate_sql_files(50)

import pymysql
import random
from datetime import datetime, timedelta

# --- 数据库连接配置 ---
DB_CONFIG = {
    "host": "192.168.52.150",
    "user": "root",  # 你的数据库用户名
    "password": "123456",  # 你的数据库密码
    "database": "scrm",  # 你的数据库名
    "charset": "utf8mb4",
}

# --- 表名配置 ---
CUSTOMER_TABLE = "teach.customer"  # 客户ID来源表
CUSTOMER_RELATIONSHIP_TABLE = "customer_relationship"  # 目标数据插入表

# --- 生成数据数量 ---
NUM_RECORDS_TO_GENERATE = 30000

# --- ID起始值 ---
STARTING_ID = 100011

# --- 批量插入大小 ---
BATCH_SIZE = 1000  # 每次插入多少条记录


def generate_random_date_time_in_range(start_dt, end_dt):
    """生成指定日期时间范围内的随机日期时间"""
    if start_dt is None or end_dt is None or start_dt > end_dt:
        return None
    delta = end_dt - start_dt
    random_seconds = random.randint(0, int(delta.total_seconds()))
    return (start_dt + timedelta(seconds=random_seconds)).strftime("%Y-%m-%d %H:%M:%S")


def generate_random_date_time_with_weights(
    start_year=2011, end_year=2024, year_weights=None
):
    """
    生成指定年份范围内的随机日期时间。
    可以传入 year_weights 来控制某些年份的分布。
    """
    if year_weights:
        years = list(year_weights.keys())
        weights = list(year_weights.values())
        selected_year = random.choices(years, weights=weights, k=1)[0]
    else:
        selected_year = random.randint(start_year, end_year)

    year_start = datetime(selected_year, 1, 1, 0, 0, 0)
    year_end = datetime(selected_year + 1, 1, 1, 0, 0, 0)

    return generate_random_date_time_in_range(year_start, year_end)


def get_existing_data(cursor, table, field, distinct=True, limit=None):
    """通用函数，用于从表中获取现有字段值"""
    try:
        query = f"SELECT {'DISTINCT' if distinct else ''} {field} FROM `{table}` WHERE {field} IS NOT NULL"
        if limit:
            query += f" LIMIT {limit}"
        cursor.execute(query)
        data = [row[0] for row in cursor.fetchall()]
        if not data:  # 如果读取不到数据，提供一些默认值，避免程序崩溃
            print(f"警告: 无法从 {table}.{field} 获取现有数据，使用默认值。")
            if field == "id" and table == CUSTOMER_TABLE:
                return list(range(1, 100001))  # 如果customer表为空，提供1-100000的假ID
            elif field == "origin_type":
                return [
                    "NETSERVICE",
                    "REFERRAL",
                    "PUBLIC_RELATION",
                    "MARKETING_ACTIVITY",
                    "OTHER",
                ]
            elif field == "creator" or field == "current_creator":
                return [1, 2, 3, 4, 5]  # 假定一些creator ID
            elif field == "creator_name":
                return ["张三", "李四", "王五", "赵六", "孙七"]
        return data
    except Exception as e:
        print(f"获取 {table}.{field} 失败: {e}")
        # 即使发生错误，也返回一些默认值，让程序继续运行
        if field == "id" and table == CUSTOMER_TABLE:
            return list(range(1, 100001))
        elif field == "origin_type":
            return [
                "NETSERVICE",
                "REFERRAL",
                "PUBLIC_RELATION",
                "MARKETING_ACTIVITY",
                "OTHER",
            ]
        elif field == "creator" or field == "current_creator":
            return [1, 2, 3, 4, 5]
        elif field == "creator_name":
            return ["张三", "李四", "王五", "赵六", "孙七"]
        return []


def main():
    connection = None
    try:
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()
        cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
        connection.commit()  # 提交以确保设置生效
        # 1. 获取有效 customer_id
        valid_customer_ids = get_existing_data(
            cursor, CUSTOMER_TABLE, "id", limit=100000
        )  # 限制读取数量
        if not valid_customer_ids:
            print("错误：无法获取任何有效的客户ID。请确保teach.customer表中有数据。")
            return
        print(f"已获取 {len(valid_customer_ids)} 个有效客户ID。")

        # 2. 获取有效的 origin_type
        existing_origin_types = get_existing_data(
            cursor, CUSTOMER_RELATIONSHIP_TABLE, "origin_type", limit=100
        )
        print(f"已获取 {len(existing_origin_types)} 种有效的来源类型。")

        # 3. 获取有效的 creator 和 creator_name
        existing_creators = get_existing_data(
            cursor, CUSTOMER_RELATIONSHIP_TABLE, "creator", limit=100
        )
        existing_creator_names = get_existing_data(
            cursor, CUSTOMER_RELATIONSHIP_TABLE, "creator_name", limit=100
        )

        # 如果获取不到，提供一些默认值
        if not existing_creators:
            existing_creators = [random.randint(1, 100) for _ in range(5)]  # 随机虚拟ID
        if not existing_creator_names:
            existing_creator_names = ["管理员A", "管理员B", "销售A", "销售B", "客服A"]
        print(
            f"已获取 {len(existing_creators)} 个创建者ID和 {len(existing_creator_names)} 个创建者姓名。"
        )

        # 构建完整的插入SQL语句
        # 注意：这里列出了所有的字段，确保与你的表结构严格对应
        insert_sql = f"""
        INSERT INTO `{CUSTOMER_RELATIONSHIP_TABLE}` (
            `id`, `create_date_time`, `update_date_time`, `deleted`, `customer_id`, 
            `first_id`, `belonger`, `belonger_name`, `initial_belonger`, `distribution_handler`, 
            `business_scrm_department_id`, `last_visit_time`, `next_visit_time`, `origin_type`, 
            `itcast_school_id`, `itcast_subject_id`, `intention_study_type`, `anticipat_signup_date`, 
            `level`, `creator`, `current_creator`, `creator_name`, `origin_channel`, `comment`, 
            `first_customer_clue_id`, `last_customer_clue_id`, `process_state`, `process_time`, 
            `payment_state`, `payment_time`, `signup_state`, `signup_time`, `notice_state`, 
            `notice_time`, `lock_state`, `lock_time`, `itcast_clazz_id`, `itcast_clazz_time`, 
            `payment_url`, `payment_url_time`, `ems_student_id`, `delete_reason`, `deleter`, 
            `deleter_name`, `delete_time`, `course_id`, `course_name`, `delete_comment`, 
            `close_state`, `close_time`, `appeal_id`, `tenant`, `total_fee`, `belonged`, 
            `belonged_time`, `belonger_time`, `transfer`, `transfer_time`, `follow_type`, 
            `transfer_bxg_oa_account`, `transfer_bxg_belonger_name`
        ) VALUES (
            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
        )
        """

        records_generated = 0
        current_id = STARTING_ID
        batch_data = []

        print(f"开始生成并插入 {NUM_RECORDS_TO_GENERATE} 条数据...")

        # 年份权重 (示例: 2020和2021年份数据量可能多一点)
        year_weights_example = {
            2011: 0.03,
            2012: 0.03,
            2013: 0.04,
            2014: 0.05,
            2015: 0.06,
            2016: 0.08,
            2017: 0.1,
            2018: 0.12,
            2019: 0.15,
            2020: 0.13,
            2021: 0.1,
            2022: 0.07,
            2023: 0.03,
            2024: 0.01,  # 当前年份通常数据较少
        }
        total_weight = sum(year_weights_example.values())
        year_weights_normalized = {
            year: weight / total_weight for year, weight in year_weights_example.items()
        }
        # print("年份权重分布:", {year: f"{weight:.2f}" for year, weight in year_weights_normalized.items()})

        for _ in range(NUM_RECORDS_TO_GENERATE):
            # 必填和指定字段
            create_date = generate_random_date_time_with_weights(
                2011, 2024, year_weights_normalized
            )

            # update_date_time 晚于 create_date_time 且在未来某个时间范围内
            create_dt_obj = datetime.strptime(create_date, "%Y-%m-%d %H:%M:%S")
            update_date_limit = datetime(2030, 1, 1)  # 假设最晚更新时间到2030年
            update_date = generate_random_date_time_in_range(
                create_dt_obj, update_date_limit
            )

            deleted = 0
            selected_customer_id = random.choice(valid_customer_ids)
            first_id = selected_customer_id  # 与 customer_id 相同
            selected_origin_type = random.choice(existing_origin_types)
            itcast_school_id = random.randint(1, 29)
            itcast_subject_id = random.randint(1, 21)
            first_customer_clue_id = selected_customer_id
            last_customer_clue_id = selected_customer_id

            # 其他字段（大部分为NULL，或根据示例提供随机值）
            belonger = None
            belonger_name = None
            initial_belonger = None
            distribution_handler = None
            business_scrm_department_id = None

            # next_visit_time 和 last_visit_time 随机设置或为空
            last_visit_time = None  # random.choice([None, generate_random_date_time_in_range(create_dt_obj, datetime.now())])
            next_visit_time = None  # random.choice([None, generate_random_date_time_in_range(datetime.now(), datetime(2025,1,1))])

            intention_study_type = None
            anticipat_signup_date = random.choice(
                [None, create_dt_obj + timedelta(days=random.randint(30, 365))]
            )  # 预期报名日期在创建后30天到一年
            if anticipat_signup_date:
                anticipat_signup_date = anticipat_signup_date.strftime(
                    "%Y-%m-%d"
                )  # 只保留日期

            level_options = ["A", "B", "C", "D", None]  # 包含None
            level = random.choice(level_options)

            creator = random.choice(existing_creators)
            current_creator = creator  # 通常和creator相同，或者随机选择
            creator_name = random.choice(existing_creator_names)

            origin_channel = random.choice(
                [None, "线上", "线下", "朋友推荐", "搜索引擎"]
            )
            comment_options = [
                None,
                "",  # 空字符串作为注释
                "对课程很感兴趣，想了解更多。",
                "咨询了价格和上课时间。",
                "客户表示再考虑一下。",
                "客户意向度高，建议重点跟进。",
            ]
            comment = random.choice(comment_options)

            process_state = None
            process_time = None
            payment_state = None
            payment_time = None
            signup_state = None
            signup_time = None
            notice_state = None
            notice_time = None
            lock_state = 0  # 示例是b'0'，故设为0
            lock_time = None
            itcast_clazz_id = None
            itcast_clazz_time = None
            payment_url = None
            payment_url_time = None
            ems_student_id = None
            delete_reason = None
            deleter = None
            deleter_name = None
            delete_time = None
            course_id = None
            course_name = None
            delete_comment = None

            close_state_options = [
                "RELEASE",
                "IN_FOLLOW",
                "DROP_INTO_PUBLIC",
            ]  # 示例是RELEASE，可以扩展
            close_state = random.choice(close_state_options)
            close_time = None  # 通常在close_state改变时填充

            appeal_id = None
            tenant = 1  # 示例是1，通常可以固定，或随机小范围
            total_fee = None
            belonged = None
            belonged_time = None
            belonger_time = None
            transfer = None
            transfer_time = None

            follow_type_options = [1, 2, 3, None]  # 示例是1，可以扩展
            follow_type = random.choice(follow_type_options)

            transfer_bxg_oa_account = None
            transfer_bxg_belonger_name = None

            batch_data.append(
                (
                    current_id,
                    create_date,
                    update_date,
                    deleted,
                    selected_customer_id,
                    first_id,
                    belonger,
                    belonger_name,
                    initial_belonger,
                    distribution_handler,
                    business_scrm_department_id,
                    last_visit_time,
                    next_visit_time,
                    selected_origin_type,
                    itcast_school_id,
                    itcast_subject_id,
                    intention_study_type,
                    anticipat_signup_date,
                    level,
                    creator,
                    current_creator,
                    creator_name,
                    origin_channel,
                    comment,
                    first_customer_clue_id,
                    last_customer_clue_id,
                    process_state,
                    process_time,
                    payment_state,
                    payment_time,
                    signup_state,
                    signup_time,
                    notice_state,
                    notice_time,
                    lock_state,
                    lock_time,
                    itcast_clazz_id,
                    itcast_clazz_time,
                    payment_url,
                    payment_url_time,
                    ems_student_id,
                    delete_reason,
                    deleter,
                    deleter_name,
                    delete_time,
                    course_id,
                    course_name,
                    delete_comment,
                    close_state,
                    close_time,
                    appeal_id,
                    tenant,
                    total_fee,
                    belonged,
                    belonged_time,
                    belonger_time,
                    transfer,
                    transfer_time,
                    follow_type,
                    transfer_bxg_oa_account,
                    transfer_bxg_belonger_name,
                )
            )

            current_id += 1
            records_generated += 1

            if len(batch_data) >= BATCH_SIZE:
                cursor.executemany(insert_sql, batch_data)
                connection.commit()
                print(
                    f"已插入 {records_generated} 条记录 ({records_generated}/{NUM_RECORDS_TO_GENERATE})..."
                )
                batch_data = []

        # 插入剩余的记录
        if batch_data:
            cursor.executemany(insert_sql, batch_data)
            connection.commit()
            print(f"已插入 {records_generated} 条记录 (完成).")

        print("数据生成和插入完成！")

    except pymysql.Error as e:
        print(f"数据库操作失败: {e}")
        if connection:
            connection.rollback()  # 发生错误时回滚事务
    except Exception as e:
        print(f"发生未知错误: {e}")
    finally:
        if connection:
            connection.close()
            print("数据库连接已关闭。")


if __name__ == "__main__":
    main()

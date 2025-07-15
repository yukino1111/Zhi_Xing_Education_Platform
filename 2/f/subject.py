import pymysql
import random

# 数据库配置
DB_CONFIG = {
    "host": "192.168.52.150",
    "user": "root",
    "password": "123456",
    "charset": "utf8mb4",
}

# 可选的itcast_subject数据 (id, name)
SUBJECT_DATA = [
    (1, "在线学习"),
    (2, "机器人开发"),
    (3, "古诗"),
    (4, "语文"),
    (5, "历史"),
    (6, "英语"),
    (7, "数学"),
    (8, "政治"),
    (9, "奥数"),
    (10, "高考补习"),
    (11, "新媒体"),
    (12, "电商运营"),
    (13, "视觉设计"),
    (14, "产品经理"),
    (15, "化学"),
    (16, "Linux运维"),
    (17, "物联网区块链"),
    (18, "Go区块链"),
    (19, "微信小程序"),
    (20, "影视制作"),
    (21, "PMP认证"),
]


def update_itcast_subject():
    conn = None
    try:
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # 1. 查询所有需要更新的行（itcast_subject_id = -1 或 itcast_subject_name 为空）
        # 考虑到你的描述，我们只关注这两列为空的情况
        # 为了高效更新，我们首先按 yearinfo 分组，获取所有需要处理的 yearinfo
        select_sql = """
            SELECT DISTINCT yearinfo 
            FROM scrm_ex.itcast_intention_4 
            WHERE itcast_subject_id = -1 OR itcast_subject_name IS NULL OR itcast_subject_name = ''
        """
        cursor.execute(select_sql)
        years_to_update = [row[0] for row in cursor.fetchall()]

        if not years_to_update:
            print("没有找到需要更新的记录。")
            return

        # 存储每个 yearinfo 对应的随机选择的 subject_id 和 subject_name
        yearinfo_mapping = {}

        # 2. 为每个 yearinfo 随机选择一个 subject
        for yearinfo in years_to_update:
            random_subject = random.choice(SUBJECT_DATA)
            yearinfo_mapping[yearinfo] = {
                "id": random_subject[0],
                "name": random_subject[1],
            }

        # 3. 批量更新
        # 构建更新语句，使用 CASE WHEN 优化，避免多次执行 UPDATE
        # 或者更简单的方式是遍历 yearinfo_mapping 进行逐个 yearinfo 更新
        print(f"将更新 {len(years_to_update)} 个不同的 yearinfo。")

        for yearinfo, subject_data in yearinfo_mapping.items():
            subject_id = subject_data["id"]
            subject_name = subject_data["name"]

            update_sql = """
                UPDATE scrm_ex.itcast_intention_4
                SET itcast_subject_id = %s, itcast_subject_name = %s
                WHERE yearinfo = %s 
                  AND (itcast_subject_id = -1 OR itcast_subject_name IS NULL OR itcast_subject_name = '')
            """
            cursor.execute(update_sql, (subject_id, subject_name, yearinfo))
            print(
                f"更新 yearinfo '{yearinfo}' 为 subject_id: {subject_id}, subject_name: '{subject_name}'"
            )

        conn.commit()
        print("数据库更新完成！")

    except pymysql.Error as e:
        print(f"数据库操作失败: {e}")
        if conn:
            conn.rollback()  # 发生错误时回滚事务
    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    update_itcast_subject()

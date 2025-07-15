import pymysql
import random

# --- 数据库连接配置 ---
DB_CONFIG = {
    "host": "192.168.52.150",
    "user": "root",  # 你的数据库用户名
    "password": "123456",  # 你的数据库密码
    "database": "scrm_ex",  # 你的数据库名
    "charset": "utf8mb4",
}

# --- 目标表名 ---
TARGET_TABLE = "itcast_intention_2"

# --- 区域（area）可选值列表 ---
AREA_OPTIONS = [
    "安徽合肥",
    "北京北京",
    "重庆重庆",
    "福建福州",
    "甘肃兰州",
    "广东广州",
    "广西南宁",
    "贵州贵阳",
    "海南海口",
    "河北石家庄",
    "河南郑州",
    "黑龙江哈尔滨",
    "湖北武汉",
    "湖南长沙",
    "吉林长春",
    "江苏南京",
    "江西南昌",
    "辽宁沈阳",
    "内蒙古呼和浩特",
    "宁夏银川",
    "青海西宁",
    "山东济南",
    "山西太原",
    "陕西西安",
    "上海上海",
    "四川成都",
    "天津天津",
    "西藏拉萨",
    "新疆乌鲁木齐",
    "云南昆明",
    "浙江杭州",
    "香港香港",
    "澳门澳门",
    "台湾台北",
]


def get_distinct_yearinfo(cursor):
    """
    获取 itcast_intention_2 表中所有不同的 yearinfo 值。
    只获取 area 字段为空或 NULL 的记录的 yearinfo，
    如果 area 字段已经有值，我们假设它已正确设置。
    """
    try:
        # 优化：只查询 area 为空或 NULL 的 yearinfo，避免重复处理已填充的数据
        cursor.execute(
            f"SELECT DISTINCT yearinfo FROM `{TARGET_TABLE}` WHERE area IS NULL OR area = ''"
        )
        yearinfos = [row[0] for row in cursor.fetchall() if row[0] is not None]
        return yearinfos
    except Exception as e:
        print(f"获取 distinct yearinfo 失败: {e}")
        return []


def main():
    connection = None
    try:
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()

        print(f"开始处理表: {TARGET_TABLE}")

        # 1. 获取所有需要处理的不同 yearinfo 值
        distinct_yearinfos = get_distinct_yearinfo(cursor)
        if not distinct_yearinfos:
            print(
                f"在 {TARGET_TABLE} 表中没有找到需要填充 area 字段的不同 yearinfo 值。程序结束。"
            )
            return

        print(f"找到 {len(distinct_yearinfos)} 个不同的 yearinfo 值需要填充。")

        # 2. 为每个 yearinfo 分配一个 area 值
        # 使用一个副本，以便在分配过程中可以移除已使用的area，确保分配均匀或不重复
        available_areas = list(AREA_OPTIONS)
        random.shuffle(available_areas)  # 打乱顺序以随机分配

        yearinfo_to_area_map = {}
        for i, yearinfo in enumerate(distinct_yearinfos):
            if available_areas:
                # 从可用列表中取一个，确保不重复直到列表用完
                assigned_area = available_areas.pop(0)
            else:
                # 如果所有area都用完了，就从原始AREA_OPTIONS中随机选择一个（会有重复）
                assigned_area = random.choice(AREA_OPTIONS)
            yearinfo_to_area_map[yearinfo] = assigned_area

        print("yearinfo 到 Area 的映射关系:")
        for y_info, area in yearinfo_to_area_map.items():
            print(f"  yearinfo: {y_info} -> Area: {area}")

        # 3. 批量更新 itcast_intention_2 表
        # 因为每个 yearinfo 对应一个 area，所以更新是按 yearinfo 进行的
        records_updated_count = 0
        for yearinfo, assigned_area in yearinfo_to_area_map.items():
            # 注意：yearinfo 的数据类型可能是整数、字符串等，SQL参数化会处理
            # 确保 yearinfo 字段在 WHERE 子句中与数据库类型匹配
            update_sql = f"UPDATE `{TARGET_TABLE}` SET area = %s WHERE yearinfo = %s AND (area IS NULL OR area = '')"

            # 使用游标执行更新
            cursor.execute(update_sql, (assigned_area, yearinfo))
            affected_rows = cursor.rowcount  # 获取受影响的行数
            records_updated_count += affected_rows
            print(
                f"  为 yearinfo '{yearinfo}' 设置 area 为 '{assigned_area}'，更新了 {affected_rows} 条记录。"
            )
            connection.commit()  # 每完成一个 yearinfo 的更新就提交一次

        print(
            f"所有 yearinfo 的 area 字段填充完成。总共更新了 {records_updated_count} 条记录。"
        )

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

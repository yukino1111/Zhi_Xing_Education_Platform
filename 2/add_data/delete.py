import pymysql
import random

# --- 数据库连接配置 ---
DB_CONFIG = {
    "host": "192.168.52.150",
    "user": "root",  # 你的数据库用户名
    "password": "123456",  # 你的数据库密码
    "database": "scrm",  # 你的数据库名
    "charset": "utf8mb4",
}

# --- 表名配置 ---
CUSTOMER_RELATIONSHIP_TABLE = "customer_relationship"  # 目标数据删除表

# --- 目标保留记录数 ---
TARGET_RECORDS = 50000

# --- 批量删除大小 ---
DELETE_BATCH_SIZE = 1000  # 每次删除多少条记录，避免一次性删除过多导致事务过大


def delete_random_records():
    connection = None
    try:
        connection = pymysql.connect(**DB_CONFIG)
        cursor = connection.cursor()
        cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
        connection.commit()  # 提交以确保设置生效
        # 1. 获取当前表的总记录数
        count_sql = f"SELECT COUNT(id) FROM `{CUSTOMER_RELATIONSHIP_TABLE}`;"
        cursor.execute(count_sql)
        current_total_records = cursor.fetchone()[0]
        print(
            f"当前表 `{CUSTOMER_RELATIONSHIP_TABLE}` 中共有 {current_total_records} 条记录。"
        )

        if current_total_records <= TARGET_RECORDS:
            print(
                f"当前记录数 ({current_total_records}) 已经小于或等于目标保留数 ({TARGET_RECORDS})，无需删除。"
            )
            return

        records_to_delete = current_total_records - TARGET_RECORDS
        print(f"需要删除 {records_to_delete} 条记录以达到目标 {TARGET_RECORDS} 条。")

        # 2. 获取所有ID，以便随机选择
        # 注意：如果表非常大，一次性获取所有ID可能会占用大量内存。
        # 对于超大表，可能需要更复杂的策略，例如分批获取ID或基于范围删除。
        # 但对于几十万到几百万的记录，一次性获取ID通常是可行的。
        get_ids_sql = f"SELECT id FROM `{CUSTOMER_RELATIONSHIP_TABLE}` ORDER BY id;"
        cursor.execute(get_ids_sql)
        all_ids = [row[0] for row in cursor.fetchall()]
        print(f"已获取 {len(all_ids)} 个ID。")

        if len(all_ids) < records_to_delete:
            print("警告：获取到的ID数量不足以删除目标数量的记录。")
            return

        # 3. 随机选择要删除的记录ID
        ids_to_delete = random.sample(all_ids, records_to_delete)
        print(f"已随机选择 {len(ids_to_delete)} 个ID进行删除。")

        # 4. 执行删除操作
        delete_sql = f"DELETE FROM `{CUSTOMER_RELATIONSHIP_TABLE}` WHERE id IN (%s);"

        deleted_count = 0
        for i in range(0, len(ids_to_delete), DELETE_BATCH_SIZE):
            batch_ids = ids_to_delete[i : i + DELETE_BATCH_SIZE]
            # 构建占位符字符串，例如 "%s, %s, %s"
            placeholders = ", ".join(["%s"] * len(batch_ids))
            current_delete_sql = delete_sql % placeholders

            cursor.execute(current_delete_sql, batch_ids)
            connection.commit()
            deleted_count += cursor.rowcount
            print(
                f"已删除 {deleted_count} 条记录 ({deleted_count}/{records_to_delete})..."
            )

        print(f"成功删除 {deleted_count} 条记录。")

        # 验证最终记录数
        cursor.execute(count_sql)
        final_total_records = cursor.fetchone()[0]
        print(
            f"删除后，表 `{CUSTOMER_RELATIONSHIP_TABLE}` 中剩余 {final_total_records} 条记录。"
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
    delete_random_records()

# DELETE FROM scrm.customer
# WHERE NOT EXISTS (
#     SELECT 1
#     FROM scrm.customer_relationship cr
#     WHERE scrm.customer.customer_relationship_id = cr.id
# );
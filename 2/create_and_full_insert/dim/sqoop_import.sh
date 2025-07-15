# 客户表
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/teach \
--username root \
--password 123456 \
--query 'SELECT 
  *, "2021-09-24" AS start_time
FROM customer where 1=1 and $CONDITIONS' \
--hcatalog-database dimen \
--hcatalog-table customer \
-m 1 

# 学科表:
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/scrm \
--username root \
--password 123456 \
--query 'SELECT 
  *, "2021-09-24" AS start_time
FROM itcast_subject where 1=1 and $CONDITIONS' \
--hcatalog-database dimen \
--hcatalog-table itcast_subject \
-m 1 

# 校区表:
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/scrm \
--username root \
--password 123456 \
--query 'SELECT 
  *, "2021-09-24" AS start_time
FROM itcast_school where 1=1 and $CONDITIONS' \
--hcatalog-database dimen \
--hcatalog-table itcast_school \
-m 1 

# 员工表
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/teach \
--username root \
--password 123456 \
--query 'SELECT 
  *, "2021-09-24" AS start_time
FROM employee where 1=1 and $CONDITIONS' \
--hcatalog-database dimen \
--hcatalog-table employee \
-m 1

# 部门表
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/scrm \
--username root \
--password 123456 \
--query 'SELECT 
  *, "2021-09-24" AS start_time
FROM scrm_department where 1=1 and $CONDITIONS' \
--hcatalog-database dimen \
--hcatalog-table scrm_department \
-m 1
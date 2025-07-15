CREATE DATABASE IF NOT EXISTS dimen;
-- 客户表
CREATE TABLE IF NOT EXISTS dimen.`customer` (
    `id` int COMMENT 'key id',
    `customer_relationship_id` int COMMENT '当前意向id',
    `create_date_time` STRING COMMENT '创建时间',
    `update_date_time` STRING COMMENT '最后更新时间',
    `deleted` int COMMENT '是否被删除（禁用）',
    `name` STRING COMMENT '姓名',
    `idcard` STRING COMMENT '身份证号',
    `birth_year` int COMMENT '出生年份',
    `gender` STRING COMMENT '性别',
    `phone` STRING COMMENT '手机号',
    `wechat` STRING COMMENT '微信',
    `qq` STRING COMMENT 'qq号',
    `email` STRING COMMENT '邮箱',
    `area` STRING COMMENT '所在区域',
    `leave_school_date` date COMMENT '离校时间',
    `graduation_date` date COMMENT '毕业时间',
    `bxg_student_id` STRING COMMENT '博学谷学员ID，可能未关联到，不存在',
    `creator` int COMMENT '创建人ID',
    `origin_type` STRING COMMENT '数据来源',
    `origin_channel` STRING COMMENT '来源渠道',
    `tenant` int,
    `md_id` int COMMENT '中台id'
) comment '客户表' PARTITIONED BY (start_time STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 学科表
CREATE TABLE IF NOT EXISTS dimen.`itcast_subject` (
    `id` int COMMENT '自增主键',
    `create_date_time` timestamp COMMENT '创建时间',
    `update_date_time` timestamp COMMENT '最后更新时间',
    `deleted` STRING COMMENT '是否被删除（禁用）',
    `name` STRING COMMENT '学科名称',
    `code` STRING COMMENT '学科编码',
    `tenant` int COMMENT '租户'
) comment '学科字典表' PARTITIONED BY (start_time STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 校区表
CREATE TABLE IF NOT EXISTS dimen.`itcast_school` (
    `id` int COMMENT '自增主键',
    `create_date_time` timestamp COMMENT '创建时间',
    `update_date_time` timestamp COMMENT '最后更新时间',
    `deleted` STRING COMMENT '是否被删除（禁用）',
    `name` STRING COMMENT '校区名称',
    `code` STRING COMMENT '校区标识',
    `tenant` int COMMENT '租户'
) comment '校区字典表' PARTITIONED BY (start_time STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 员工表
CREATE TABLE IF NOT EXISTS dimen.employee (
    id int COMMENT '员工id',
    email STRING COMMENT '公司邮箱，OA登录账号',
    real_name STRING COMMENT '员工的真实姓名',
    phone STRING COMMENT '手机号，目前还没有使用；隐私问题OA接口没有提供这个属性，',
    department_id STRING COMMENT 'OA中的部门编号，有负值',
    department_name STRING COMMENT 'OA中的部门名',
    remote_login STRING COMMENT '员工是否可以远程登录',
    job_number STRING COMMENT '员工工号',
    cross_school STRING COMMENT '是否有跨校区权限',
    last_login_date STRING COMMENT '最后登录日期',
    creator int COMMENT '创建人',
    create_date_time STRING COMMENT '创建时间',
    update_date_time STRING COMMENT '最后更新时间',
    deleted STRING COMMENT '是否被删除（禁用）',
    scrm_department_id int COMMENT 'SCRM内部部门id',
    leave_office STRING COMMENT '离职状态',
    leave_office_time STRING COMMENT '离职时间',
    reinstated_time STRING COMMENT '复职时间',
    superior_leaders_id int COMMENT '上级领导ID',
    tdepart_id int COMMENT '直属部门',
    tenant int COMMENT '租户',
    ems_user_name STRING COMMENT 'ems用户名称'
) comment '员工表' PARTITIONED BY (start_time STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 部门表
CREATE TABLE IF NOT EXISTS dimen.`scrm_department` (
    `id` int COMMENT '部门id',
    `name` STRING COMMENT '部门名称',
    `parent_id` int COMMENT '父部门id',
    `create_date_time` STRING COMMENT '创建时间',
    `update_date_time` STRING COMMENT '更新时间',
    `deleted` STRING COMMENT '删除标志',
    `id_path` STRING COMMENT '编码全路径',
    `tdepart_code` int COMMENT '直属部门',
    `creator` STRING COMMENT '创建者',
    `depart_level` int COMMENT '部门层级',
    `depart_sign` int COMMENT '部门标志，暂时默认1',
    `depart_line` int COMMENT '业务线，存储业务线编码',
    `depart_sort` int COMMENT '排序字段',
    `disable_flag` int COMMENT '禁用标志',
    `tenant` int COMMENT '租户'
) comment 'scrm部门表' PARTITIONED BY (start_time STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' stored as orc TBLPROPERTIES ('orc.compress' = 'SNAPPY');
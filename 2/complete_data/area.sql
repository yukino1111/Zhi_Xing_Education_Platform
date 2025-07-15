CREATE TEMPORARY TABLE provinces_cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO provinces_cities (name) VALUES
('安徽合肥'), ('北京北京'), ('重庆重庆'), ('福建福州'), ('甘肃兰州'),
('广东广州'), ('广西南宁'), ('贵州贵阳'), ('海南海口'), ('河北石家庄'),
('河南郑州'), ('黑龙江哈尔滨'), ('湖北武汉'), ('湖南长沙'), ('吉林长春'),
('江苏南京'), ('江西南昌'), ('辽宁沈阳'), ('内蒙古呼和浩特'), ('宁夏银川'),
('青海西宁'), ('山东济南'), ('山西太原'), ('陕西西安'), ('上海上海'),
('四川成都'), ('天津天津'), ('西藏拉萨'), ('新疆乌鲁木齐'), ('云南昆明'),
('浙江杭州'), ('香港香港'), ('澳门澳门'), ('台湾台北');

UPDATE customer c
SET area = (SELECT name FROM provinces_cities ORDER BY RAND() LIMIT 1)
WHERE area IS NULL OR area = ''; -- 只更新area字段为空的记录
-- 如果你想更新所有记录，即使它们不为空，可以去掉 WHERE 子句。

UPDATE customer_relationship
SET itcast_subject_id = FLOOR(1 + RAND() * 21)
WHERE itcast_subject_id IS NULL OR itcast_subject_id = 0; -- 或者其他表示“空”的条件
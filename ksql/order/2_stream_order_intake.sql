CREATE STREAM stream_order_intake
WITH (KAFKA_TOPIC='stream_order_intake', VALUE_FORMAT='JSON', KEY_FORMAT='JSON') AS
SELECT
    STRUCT(`id` := AFTER->ID) AS `KEY`,
    AFTER->ID AS `id`,
    AFTER->PRODUCT AS `product`,
    AFTER->AMOUNT AS `amount`,
    AFTER->BUYER_ID AS `buyer_id`,
    AFTER->CREATE_DATE AS `create_date`,
    AFTER->UPDATE_DATE AS `update_date`,
    (ROWTIME + 8*60*60*1000) AS `row_time`
FROM stream_order
WHERE AFTER IS NOT NULL
PARTITION BY STRUCT(`id` := AFTER->ID) 
EMIT CHANGES;
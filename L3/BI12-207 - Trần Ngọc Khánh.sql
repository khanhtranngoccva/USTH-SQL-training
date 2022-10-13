USE `northwind`;

ROLLBACK;

-- 1
SELECT * FROM `orders` WHERE `order_date` > '2006-03-24';

-- 2
SELECT `product_id` AS `product_code`, `unit_price`, `quantity`, `unit_price` * `quantity` * (1 - `discount`) AS `value` 
FROM `order_details` WHERE `order_id` = 31;

-- 3
SELECT 	`order_details`.`order_id` AS `order_id`,
		`orders`.`order_date` AS `order_date`, 
        `customers`.`company` AS `company`,
		`order_details`.`unit_price` * `order_details`.`quantity` * (1 - `order_details`.`discount`) AS `value`
FROM `order_details` 
INNER JOIN `orders` ON `order_details`.`order_id` = `orders`.`id`
INNER JOIN `customers` ON `customers`.`id` = `orders`.`customer_id`
WHERE `orders`.`order_date` > '2006-03-24';

-- 4
SELECT 	`order_details`.`order_id` AS `order_id`,
		`orders`.`order_date` AS `order_date`, 
        `customers`.`company` AS `company`,
		SUM(`order_details`.`unit_price` * `order_details`.`quantity` * (1 - `order_details`.`discount`)) AS `value`
FROM `order_details` 
INNER JOIN `orders` ON `order_details`.`order_id` = `orders`.`id`
INNER JOIN `customers` ON `customers`.`id` = `orders`.`customer_id`
WHERE `orders`.`order_date` > '2006-03-24'
GROUP BY `orders`.`id`;

-- 5
SELECT 	`order_details`.`order_id` AS `order_id`,
		`orders`.`order_date` AS `order_date`, 
        `customers`.`company` AS `company`,
		SUM(`order_details`.`unit_price` * `order_details`.`quantity` * (1 - `order_details`.`discount`)) AS `sub_total`
FROM `order_details` 
INNER JOIN `orders` ON `order_details`.`order_id` = `orders`.`id`
INNER JOIN `customers` ON `customers`.`id` = `orders`.`customer_id`
WHERE `orders`.`order_date` > '2006-03-24'
GROUP BY `orders`.`id`
HAVING `sub_total` >= 800;

-- 6
SELECT CONCAT(`employees`.`first_name`, " ", `employees`.`last_name`) AS `full_name`,
		SUM(`order_details`.`unit_price` * `order_details`.`quantity` * (1 - `order_details`.`discount`)) AS `sale_in_dollars`
FROM `order_details` 
INNER JOIN `orders` ON `order_details`.`order_id` = `orders`.`id`
INNER JOIN `customers` ON `customers`.`id` = `orders`.`customer_id`
INNER JOIN `employees` ON `orders`.`employee_id` = `employees`.`id`
GROUP BY `employees`.`id`
HAVING `sale_in_dollars` > 1000
ORDER BY `sale_in_dollars` DESC;

-- 7
CREATE OR REPLACE VIEW `partners` AS 
SELECT CONCAT(`first_name`, " ", `last_name`) AS `full_name`,
`company`, `email_address`, 'C' AS `type`
FROM `customers` UNION ALL
SELECT CONCAT(`first_name`, " ", `last_name`) AS `full_name`,
`company`, `email_address`, 'S' AS `type`
FROM `suppliers`;

SELECT * FROM `partners`;

-- 8
SELECT DISTINCT `category` FROM `products` ORDER BY `category` ASC;

-- 9
SELECT 	MIN(`standard_cost`) AS `min`,
		MAX(`standard_cost`) AS `max`,
		AVG(`standard_cost`) AS `avg`,
        STDDEV(`standard_cost`) AS `stddev`,
        VARIANCE(`standard_cost`) AS `variance`
		FROM `products`;
        
-- 10
SELECT `category`, AVG(`list_price`) AS `avg_list_price`
FROM `products` GROUP BY `category`;

-- 11
DROP PROCEDURE IF EXISTS `top_list_prices`;
CREATE PROCEDURE `top_list_prices` (lim int)
SELECT `category`, AVG(`list_price`) AS `avg_list_price`
FROM `products` GROUP BY `category`
ORDER BY `avg_list_price` DESC 
LIMIT 0, lim;
CALL `top_list_prices`(6);

-- 12
DROP PROCEDURE IF EXISTS `least_list_prices`;
CREATE PROCEDURE `least_list_prices` (lim int)
SELECT `category`, AVG(`list_price`) AS `avg_list_price`
FROM `products` GROUP BY `category`
ORDER BY `avg_list_price` ASC 
LIMIT 0, lim;

CALL `least_list_prices`(6);

-- 13
CREATE OR REPLACE VIEW `employees_copy` AS
SELECT * FROM `employees`;

SELECT `purchase_orders`.`id` AS `id`,
CONCAT(`employees`.`first_name`, " ", `employees`.`last_name`) AS `creator_name`,
CONCAT(`employees_copy`.`first_name`, " ", `employees_copy`.`last_name`) AS `approver_name`
FROM `purchase_orders`
INNER JOIN `employees` ON `employees`.`id` = `purchase_orders`.`created_by`
INNER JOIN `employees_copy` ON `employees_copy`.`id` = `purchase_orders`.`approved_by`
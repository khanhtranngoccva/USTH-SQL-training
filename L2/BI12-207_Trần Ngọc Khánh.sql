USE `northwind`;

SELECT * FROM `products`;

SELECT `id`, `product_name` FROM `products` WHERE `discontinued`=1;

SELECT * FROM `products` ORDER BY `list_price` ASC LIMIT 0, 4;

SELECT `id`, `product_name`, `list_price` FROM `products` WHERE `list_price` BETWEEN 15 AND 25;

SELECT `id`, CONCAT(`first_name`, " ", `last_name`) AS `full_name` FROM `employees`;

SELECT * FROM `employees` WHERE `first_name` LIKE "A%";

SELECT COUNT(DISTINCT `city`) AS `city_count` FROM `employees`;

SELECT DISTINCT `ship_name` FROM `orders`; 

SELECT MAX(`list_price`) AS `max`, MIN(`list_price`) AS `min` FROM `products`;

SELECT * FROM `products` WHERE `discontinued`=0;

SELECT AVG(`list_price`) AS `avg`, STDDEV(`list_price`) AS `stdev` FROM `products`;

SELECT `product_name`, `list_price` FROM `products` WHERE `list_price` > (SELECT AVG(`list_price`) AS `avg` FROM `products`);

INSERT INTO `suppliers` (`company`, `last_name`, `first_name`, `city`, `country_region`) VALUES ("Habeco", "Nguyễn", "Hồng Linh", "Hanoi", "Vietnam");

INSERT INTO `products` (`product_code`, `supplier_ids`, `list_price`, `discontinued`, `category`) VALUES (
	"TB-Truc-Bach", 
    (SELECT `id` FROM `suppliers` WHERE `company`="Habeco"),
    22,
    0,
    "Beverages"
);

UPDATE `products` SET `standard_cost`=18 WHERE `product_code`="TB-Truc-Bach";

SELECT * FROM `suppliers`;

DELETE FROM `suppliers` WHERE `company`="Habeco";

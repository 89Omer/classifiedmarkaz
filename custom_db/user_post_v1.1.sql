ALTER TABLE `user_posts`
	ADD COLUMN `sub_category_id` INT(10) UNSIGNED NOT NULL AFTER `category_id`,
	ADD CONSTRAINT `post_sub_category` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);
	ALTER TABLE `user_posts`
	CHANGE COLUMN `create_date` `create_date` DATE NULL DEFAULT NULL AFTER `sub_category_id`;


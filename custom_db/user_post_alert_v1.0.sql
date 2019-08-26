ALTER TABLE `user_post_alert`
	DROP FOREIGN KEY `post_alert_category`;
ALTER TABLE `user_post_alert`
	ADD COLUMN `created_at` TIMESTAMP NULL DEFAULT NULL AFTER `search_context`,
	ADD COLUMN `updated_at` TIMESTAMP NULL DEFAULT NULL AFTER `created_at`,
	ADD CONSTRAINT `post_alert_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

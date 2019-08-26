ALTER TABLE `user_posts`
	DROP FOREIGN KEY `post_category`;
ALTER TABLE `user_posts`
	CHANGE COLUMN `last_renewed_on` `last_renewed_on` TIMESTAMP NULL DEFAULT NULL AFTER `quot_received`,
	ADD COLUMN `created_at` TIMESTAMP NULL DEFAULT NULL AFTER `last_renewed_on`,
	ADD COLUMN `updated_at` TIMESTAMP NULL DEFAULT NULL AFTER `created_at`,
	ADD CONSTRAINT `post_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

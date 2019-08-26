ALTER TABLE `user_post_attribute`
	ADD COLUMN `created_at` TIMESTAMP NULL DEFAULT NULL AFTER `is_favourite`,
	ADD COLUMN `updated_at` TIMESTAMP NULL DEFAULT NULL AFTER `created_at`;

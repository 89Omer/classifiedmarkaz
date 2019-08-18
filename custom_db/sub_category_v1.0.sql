ALTER TABLE `sub_categories`
	ADD COLUMN `created_at` TIMESTAMP NULL DEFAULT NULL AFTER `post_validity_interval_in_days`,
	ADD COLUMN `updated_at` TIMESTAMP NULL DEFAULT NULL AFTER `created_at`;

ALTER TABLE `users`
	ADD COLUMN `preferred_language_id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `remember_token`,
	ADD COLUMN `country_id` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `preferred_language_id`,
	ADD COLUMN `upload` VARCHAR(100) NULL DEFAULT NULL AFTER `country_id`,
	ADD COLUMN `membership` VARCHAR(100) NULL DEFAULT NULL AFTER `upload`,
	ADD COLUMN `interest` VARCHAR(100) NULL DEFAULT NULL AFTER `membership`,
	ADD CONSTRAINT `users_language_id_foreign` FOREIGN KEY (`preferred_language_id`) REFERENCES `language` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	ADD CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

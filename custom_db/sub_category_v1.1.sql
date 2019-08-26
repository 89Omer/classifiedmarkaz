ALTER TABLE `sub_categories`
	ALTER `subcatagory_name` DROP DEFAULT;
ALTER TABLE `sub_categories`
	CHANGE COLUMN `subcatagory_name` `subcategory_name` VARCHAR(255) NOT NULL AFTER `id`;
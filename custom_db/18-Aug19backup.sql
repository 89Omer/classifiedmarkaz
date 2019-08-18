-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.16-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table classified_webapp.auctions
DROP TABLE IF EXISTS `auctions`;
CREATE TABLE IF NOT EXISTS `auctions` (
  `id` int(10) unsigned NOT NULL,
  `auction_id` int(10) unsigned DEFAULT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `bidder_id` int(10) unsigned DEFAULT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_seller_id` (`seller_id`),
  KEY `FK_bidder_id` (`bidder_id`),
  KEY `FK_item_id` (`item_id`),
  KEY `FK_auction_id` (`auction_id`),
  CONSTRAINT `FK_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auction_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bidder_id` FOREIGN KEY (`bidder_id`) REFERENCES `bidders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.auctions: ~0 rows (approximately)
DELETE FROM `auctions`;
/*!40000 ALTER TABLE `auctions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auctions` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.auction_items
DROP TABLE IF EXISTS `auction_items`;
CREATE TABLE IF NOT EXISTS `auction_items` (
  `id` int(10) unsigned NOT NULL,
  `auction_item_id` int(10) unsigned NOT NULL,
  `auction_start_date` date NOT NULL,
  `auction_actual_close_date` datetime NOT NULL,
  `auction_planned_close_date` datetime NOT NULL,
  `auction_item_actual_selling_price` varchar(50) NOT NULL DEFAULT '',
  `auction_item_reserve_price` varchar(50) NOT NULL DEFAULT '',
  `auction_item_comments` varchar(50) NOT NULL DEFAULT '',
  `status` tinyint(10) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.auction_items: ~0 rows (approximately)
DELETE FROM `auction_items`;
/*!40000 ALTER TABLE `auction_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction_items` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.bidders
DROP TABLE IF EXISTS `bidders`;
CREATE TABLE IF NOT EXISTS `bidders` (
  `id` int(10) unsigned NOT NULL,
  `bidder_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.bidders: ~0 rows (approximately)
DELETE FROM `bidders`;
/*!40000 ALTER TABLE `bidders` DISABLE KEYS */;
/*!40000 ALTER TABLE `bidders` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.bids
DROP TABLE IF EXISTS `bids`;
CREATE TABLE IF NOT EXISTS `bids` (
  `id` int(10) unsigned NOT NULL,
  `auction_id` int(10) unsigned DEFAULT NULL,
  `bid_low_price` decimal(10,0) DEFAULT NULL,
  `bid_preferred_price` decimal(10,0) DEFAULT NULL,
  `bid_high_price` decimal(10,0) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bid_auction_id` (`auction_id`),
  CONSTRAINT `FK_bid_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.bids: ~0 rows (approximately)
DELETE FROM `bids`;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.categories: ~4 rows (approximately)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
	(1, NULL, 1, 'Classified', 'classified', '2019-08-10 18:17:05', '2019-08-18 04:43:56'),
	(2, 2, 1, 'Auction', 'auction', '2019-08-10 18:17:05', '2019-08-18 04:44:39'),
	(3, NULL, 3, 'Asks For', 'asks-for', '2019-08-18 04:45:15', '2019-08-18 04:45:15'),
	(4, NULL, 4, 'Community', 'community', '2019-08-18 04:45:50', '2019-08-18 04:45:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `parent_category_id` int(10) unsigned DEFAULT NULL,
  `maximum_images_allowed` int(10) unsigned NOT NULL,
  `post_validity_interval_in_days` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_category` (`parent_category_id`),
  CONSTRAINT `category_category` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.category: ~0 rows (approximately)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.city
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city_name` varchar(255) NOT NULL,
  `state_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_state` (`state_id`),
  CONSTRAINT `city_state` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.city: ~0 rows (approximately)
DELETE FROM `city`;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.country
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) NOT NULL,
  `currency_code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.country: ~0 rows (approximately)
DELETE FROM `country`;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.county
DROP TABLE IF EXISTS `county`;
CREATE TABLE IF NOT EXISTS `county` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `county_name` varchar(255) NOT NULL,
  `city_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `county_city` (`city_id`),
  CONSTRAINT `county_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.county: ~0 rows (approximately)
DELETE FROM `county`;
/*!40000 ALTER TABLE `county` DISABLE KEYS */;
/*!40000 ALTER TABLE `county` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.data_rows
DROP TABLE IF EXISTS `data_rows`;
CREATE TABLE IF NOT EXISTS `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.data_rows: ~63 rows (approximately)
DELETE FROM `data_rows`;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
	(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
	(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
	(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
	(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
	(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
	(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
	(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsTo","column":"role_id","key":"id","label":"display_name","pivot_table":"roles","pivot":0}', 10),
	(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsToMany","column":"id","key":"id","label":"display_name","pivot_table":"user_roles","pivot":"1","taggable":"0"}', 11),
	(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
	(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
	(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9),
	(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{"default":"","null":"","options":{"":"-- None --"},"relationship":{"key":"id","label":"name"}}', 2),
	(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{"default":1}', 3),
	(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
	(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{"slugify":{"origin":"name"}}', 5),
	(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
	(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
	(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, NULL, 2),
	(31, 5, 'category_id', 'text', 'Category', 1, 0, 1, 1, 1, 0, NULL, 3),
	(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 4),
	(33, 5, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 5),
	(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 6),
	(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{"resize":{"width":"1000","height":"null"},"quality":"70%","upsize":true,"thumbnails":[{"name":"medium","scale":"50%"},{"name":"small","scale":"25%"},{"name":"cropped","crop":{"width":"300","height":"250"}}]}', 7),
	(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{"slugify":{"origin":"title","forceUpdate":true},"validation":{"rule":"unique:posts,slug"}}', 8),
	(37, 5, 'meta_description', 'text_area', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 9),
	(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 10),
	(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{"default":"DRAFT","options":{"PUBLISHED":"published","DRAFT":"draft","PENDING":"pending"}}', 11),
	(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 12),
	(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 13),
	(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, NULL, 14),
	(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, NULL, 15),
	(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
	(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
	(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
	(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
	(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{"slugify":{"origin":"title"},"validation":{"rule":"unique:pages,slug"}}', 6),
	(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
	(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
	(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{"default":"INACTIVE","options":{"INACTIVE":"INACTIVE","ACTIVE":"ACTIVE"}}', 9),
	(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
	(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
	(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
	(56, 7, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(57, 7, 'subcatagory_name', 'text', 'Subcatagory Name', 1, 1, 1, 1, 1, 1, '{}', 3),
	(58, 7, 'parent_category_id', 'number', 'Parent Category Id', 0, 1, 1, 1, 1, 1, '{}', 2),
	(59, 7, 'maximum_images_allowed', 'text', 'Maximum Images Allowed', 1, 1, 1, 1, 1, 1, '{}', 4),
	(60, 7, 'post_validity_interval_in_days', 'text', 'Post Validity Interval In Days', 1, 1, 1, 1, 1, 1, '{}', 5),
	(61, 7, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 6),
	(62, 7, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
	(70, 9, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(71, 9, 'subcatagory_name', 'text', 'Subcatagory Name', 1, 1, 1, 1, 1, 1, '{}', 3),
	(72, 9, 'parent_category_id', 'select_dropdown', 'Parent Category Id', 0, 1, 1, 1, 1, 1, '{"default":"","null":"","options":{"":"-- None --"},"relationship":{"key":"id","label":"name"}}', 2),
	(73, 9, 'maximum_images_allowed', 'text', 'Maximum Images Allowed', 1, 1, 1, 1, 1, 1, '{}', 4),
	(74, 9, 'post_validity_interval_in_days', 'text', 'Post Validity Interval In Days', 1, 1, 1, 1, 1, 1, '{}', 5),
	(75, 9, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 6),
	(76, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.data_types
DROP TABLE IF EXISTS `data_types`;
CREATE TABLE IF NOT EXISTS `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.data_types: ~8 rows (approximately)
DELETE FROM `data_types`;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
	(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2019-08-10 15:38:16', '2019-08-10 15:38:16'),
	(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2019-08-10 15:38:16', '2019-08-10 15:38:16'),
	(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, '', '', 1, 0, NULL, '2019-08-10 15:38:16', '2019-08-10 15:38:16'),
	(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2019-08-10 18:17:04', '2019-08-10 18:17:04'),
	(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(7, 'sub_category', 'sub-category', 'Sub Categories', 'Sub Categories', NULL, 'App\\Models\\SubCategory', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-08-17 17:54:57', '2019-08-17 17:57:32'),
	(9, 'sub_categories', 'sub-categories', 'Sub Category', 'Sub Categories', NULL, 'App\\Models\\SubCategory', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-08-17 18:02:54', '2019-08-18 04:55:12');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_category` (`category_id`),
  CONSTRAINT `property_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.items: ~0 rows (approximately)
DELETE FROM `items`;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.item_details
DROP TABLE IF EXISTS `item_details`;
CREATE TABLE IF NOT EXISTS `item_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_variants_id` int(11) DEFAULT NULL,
  `value_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_item_variants_id` (`item_variants_id`),
  CONSTRAINT `FK_item_variants_id` FOREIGN KEY (`item_variants_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.item_details: ~0 rows (approximately)
DELETE FROM `item_details`;
/*!40000 ALTER TABLE `item_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_details` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.item_variants
DROP TABLE IF EXISTS `item_variants`;
CREATE TABLE IF NOT EXISTS `item_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned DEFAULT NULL,
  `itemVariantName` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `is_favourite` tinyint(4) DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_items_variant_id` (`item_id`),
  CONSTRAINT `FK_items_variant_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.item_variants: ~0 rows (approximately)
DELETE FROM `item_variants`;
/*!40000 ALTER TABLE `item_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_variants` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.language
DROP TABLE IF EXISTS `language`;
CREATE TABLE IF NOT EXISTS `language` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.language: ~0 rows (approximately)
DELETE FROM `language`;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
/*!40000 ALTER TABLE `language` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.menus
DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.menus: ~0 rows (approximately)
DELETE FROM `menus`;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2019-08-10 15:38:18', '2019-08-10 15:38:18'),
	(2, 'ClassifiedMarkaz', '2019-08-17 18:01:19', '2019-08-17 18:01:19');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.menu_items
DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.menu_items: ~15 rows (approximately)
DELETE FROM `menu_items`;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
	(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.dashboard', NULL),
	(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 5, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.media.index', NULL),
	(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 3, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.users.index', NULL),
	(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 2, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.roles.index', NULL),
	(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 9, '2019-08-10 15:38:18', '2019-08-10 15:38:18', NULL, NULL),
	(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 10, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.menus.index', NULL),
	(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 11, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.database.index', NULL),
	(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 12, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.compass.index', NULL),
	(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 13, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.bread.index', NULL),
	(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 14, '2019-08-10 15:38:18', '2019-08-10 15:38:18', 'voyager.settings.index', NULL),
	(11, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 13, '2019-08-10 15:38:22', '2019-08-10 15:38:22', 'voyager.hooks', NULL),
	(12, 1, 'Categories', '', '_self', 'voyager-categories', NULL, NULL, 8, '2019-08-10 18:17:05', '2019-08-10 18:17:05', 'voyager.categories.index', NULL),
	(13, 1, 'Posts', '', '_self', 'voyager-news', NULL, NULL, 6, '2019-08-10 18:17:06', '2019-08-10 18:17:06', 'voyager.posts.index', NULL),
	(14, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, NULL, 7, '2019-08-10 18:17:08', '2019-08-10 18:17:08', 'voyager.pages.index', NULL),
	(17, 1, 'Sub Categories', '', '_self', NULL, NULL, NULL, 15, '2019-08-17 18:02:54', '2019-08-17 18:02:54', 'voyager.sub-categories.index', NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `message_text` text DEFAULT NULL,
  `uread` int(10) DEFAULT NULL,
  `thread_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_messages_post_id` (`post_id`),
  KEY `FK_messages_cat_id` (`category_id`),
  KEY `FK_mesages_thead_id` (`thread_id`),
  CONSTRAINT `FK_mesages_thead_id` FOREIGN KEY (`thread_id`) REFERENCES `messages_thread` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_messages_cat_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_messages_post_id` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.messages: ~0 rows (approximately)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.messages_thread
DROP TABLE IF EXISTS `messages_thread`;
CREATE TABLE IF NOT EXISTS `messages_thread` (
  `id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `message_id` int(10) unsigned NOT NULL,
  `uread` int(10) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `message_id` (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.messages_thread: ~0 rows (approximately)
DELETE FROM `messages_thread`;
/*!40000 ALTER TABLE `messages_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages_thread` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.migrations: ~31 rows (approximately)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2016_01_01_000000_add_voyager_user_fields', 1),
	(4, '2016_01_01_000000_create_data_types_table', 1),
	(5, '2016_05_19_173453_create_menu_table', 1),
	(6, '2016_10_21_190000_create_roles_table', 1),
	(7, '2016_10_21_190000_create_settings_table', 1),
	(8, '2016_11_30_135954_create_permission_table', 1),
	(9, '2016_11_30_141208_create_permission_role_table', 1),
	(10, '2016_12_26_201236_data_types__add__server_side', 1),
	(11, '2017_01_13_000000_add_route_to_menu_items_table', 1),
	(12, '2017_01_14_005015_create_translations_table', 1),
	(13, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
	(14, '2017_03_06_000000_add_controller_to_data_types_table', 1),
	(15, '2017_04_21_000000_add_order_to_data_rows_table', 1),
	(16, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
	(17, '2017_08_05_000000_add_group_to_settings_table', 1),
	(18, '2017_11_26_013050_add_user_role_relationship', 1),
	(19, '2017_11_26_015000_create_user_roles_table', 1),
	(20, '2018_03_11_000000_add_user_settings', 1),
	(21, '2018_03_14_000000_add_details_to_data_types_table', 1),
	(22, '2018_03_16_000000_make_settings_value_nullable', 1),
	(23, '2016_01_01_000000_create_pages_table', 2),
	(24, '2016_01_01_000000_create_posts_table', 2),
	(25, '2016_02_15_204651_create_categories_table', 2),
	(26, '2017_04_11_000000_alter_post_nullable_fields_table', 2),
	(27, '2016_06_01_000001_create_oauth_auth_codes_table', 3),
	(28, '2016_06_01_000002_create_oauth_access_tokens_table', 3),
	(29, '2016_06_01_000003_create_oauth_refresh_tokens_table', 3),
	(30, '2016_06_01_000004_create_oauth_clients_table', 3),
	(31, '2016_06_01_000005_create_oauth_personal_access_clients_table', 3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.oauth_access_tokens
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_access_tokens: ~17 rows (approximately)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('07e678ad934544863d90d6345e022b1cc5fdb43141dfa72a4701f9d5c5182796943f9487e018be7a', 17, 1, 'AppName', '[]', 0, '2019-08-15 20:37:50', '2019-08-15 20:37:50', '2020-08-15 20:37:50'),
	('0b25e41ad75c59d9c9159b9b5495b32cd73de37e59f7d60a55211f03bcbab84556370269e7641fe3', 8, 1, 'AppName', '[]', 0, '2019-08-15 13:15:05', '2019-08-15 13:15:05', '2020-08-15 13:15:05'),
	('0c1c98413da93916277dc5e83c9c8ceb6d31c49070b153b72d3eb3f8aaa73274a3b2aa11fa24bdc9', 6, 1, 'AppName', '[]', 0, '2019-08-15 12:24:35', '2019-08-15 12:24:35', '2020-08-15 12:24:35'),
	('1820506bdee6b8b68ca925cbc368fd497ebabbddd67760b77cdef4457b9317b03be936b7b792d36f', 2, 1, 'AppName', '[]', 0, '2019-08-15 10:35:04', '2019-08-15 10:35:04', '2020-08-15 10:35:04'),
	('186ba7371f1c2e113ec22e8df4e10505a81cd83452cf5fd67bc96e61fef39e0487848e8843e3d623', 10, 1, 'AppName', '[]', 0, '2019-08-15 13:16:18', '2019-08-15 13:16:18', '2020-08-15 13:16:18'),
	('18d88099d08edd5dc31c770e116cac1e5aef96b453b51f3cae31c2d12d2f7c5e30c6f9e0e5bf97d0', 3, 1, 'AppName', '[]', 0, '2019-08-15 10:38:56', '2019-08-15 10:38:56', '2020-08-15 10:38:56'),
	('1d0c620a236c97e09c052e8f644fdfc1daba6fcf4898f6f9281f7b624a2bd74e0f9828c531e6d1d4', 17, 1, 'AppName', '[]', 0, '2019-08-15 16:48:44', '2019-08-15 16:48:44', '2020-08-15 16:48:44'),
	('1d283a9064984a823ef36889a5d3f97b8c025f11bdb7e875207e8adc184b77c0309bbea8dc059edc', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:32:09', '2019-08-15 16:32:09', '2020-08-15 16:32:09'),
	('3a8c6989cf2afe0030b0f71476a72f3384024cf8f38efc4f1eef48d76febe45ff8fa133c60eba5b6', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:32:29', '2019-08-15 16:32:29', '2020-08-15 16:32:29'),
	('52847c6c86207f9bdb5bf9699e8e0cfa7ea84b2491802f9154b79ca9d22a505dd581a8137612eb8e', 17, 1, 'AppName', '[]', 0, '2019-08-15 20:48:16', '2019-08-15 20:48:16', '2020-08-15 20:48:16'),
	('a02dc29ecd335678a429286a3f8f008573d0d9e9b680a9c5756181ba94594d1cb6eb9724c02dfeff', 5, 1, 'AppName', '[]', 0, '2019-08-15 12:24:23', '2019-08-15 12:24:23', '2020-08-15 12:24:23'),
	('a835423d2ab836e097968be5187f72c788bfc108cc9acfed93b6a654ef001b5efcf299b302a239ee', 4, 1, 'AppName', '[]', 0, '2019-08-15 12:17:19', '2019-08-15 12:17:19', '2020-08-15 12:17:19'),
	('ac9fcbcf934908496045a1896ec101d20736c7112e94b2b8e7f5b883487195e2279d095fd1da7271', 7, 1, 'AppName', '[]', 0, '2019-08-15 12:24:42', '2019-08-15 12:24:42', '2020-08-15 12:24:42'),
	('d1b37d3108670ba6c450525a50ad7d7d7e0b4410fb1ad7ec93c5ebfd1330db99e7587549bacbfcf9', 13, 1, 'AppName', '[]', 0, '2019-08-15 14:04:35', '2019-08-15 14:04:35', '2020-08-15 14:04:35'),
	('d41fa2cd29d5589481d1a9d362861b0c1cb6cd761b488e8a769b36e5368f30383608b9fb38c7421d', 17, 1, 'AppName', '[]', 0, '2019-08-15 18:54:50', '2019-08-15 18:54:50', '2020-08-15 18:54:50'),
	('e9b616f0952a646d28a6e3b0e0b52bd47499fd61453d4d58cee1a4f91a6aa9f2768202b28463aba9', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:07:56', '2019-08-15 16:07:56', '2020-08-15 16:07:56'),
	('edbaa433959e40761e92a4514676602c1eddf93a60ef521a3e68f0e4cd7bfacdf85e8be628181f01', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:30:04', '2019-08-15 16:30:04', '2020-08-15 16:30:04'),
	('f98220675145144ed240d7ba79cbe1e8f1e244eb339e9b38927d6b915932115a0b12944ac3eca105', 12, 1, 'AppName', '[]', 0, '2019-08-15 13:18:42', '2019-08-15 13:18:42', '2020-08-15 13:18:42');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.oauth_auth_codes
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_auth_codes: ~0 rows (approximately)
DELETE FROM `oauth_auth_codes`;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.oauth_clients
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_clients: ~2 rows (approximately)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', 'MJc7Xj13fkPmZivHRdvEb6EaddakQ9sQDfZUAPey', 'http://localhost', 1, 0, 0, '2019-08-15 09:23:50', '2019-08-15 09:23:50'),
	(2, NULL, 'Laravel Password Grant Client', 'JMXoepVcJZhjdaYSBola0DXGbhs6cf3oLleGjDNX', 'http://localhost', 0, 1, 0, '2019-08-15 09:23:50', '2019-08-15 09:23:50');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.oauth_personal_access_clients
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_personal_access_clients: ~0 rows (approximately)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2019-08-15 09:23:50', '2019-08-15 09:23:50');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.oauth_refresh_tokens
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_refresh_tokens: ~0 rows (approximately)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.pages
DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.pages: ~0 rows (approximately)
DELETE FROM `pages`;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
	(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2019-08-10 18:17:08', '2019-08-10 18:17:08');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.password_resets: ~0 rows (approximately)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.payment_transaction
DROP TABLE IF EXISTS `payment_transaction`;
CREATE TABLE IF NOT EXISTS `payment_transaction` (
  `id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `user_account_id` int(10) unsigned NOT NULL,
  `transaction_id` int(10) unsigned NOT NULL,
  `amount` float DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_user_id` (`user_account_id`),
  KEY `FK_payment_item_id` (`post_id`),
  CONSTRAINT `FK_payment_item_id` FOREIGN KEY (`post_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_payment_user_id` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.payment_transaction: ~0 rows (approximately)
DELETE FROM `payment_transaction`;
/*!40000 ALTER TABLE `payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transaction` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.permissions
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.permissions: ~47 rows (approximately)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
	(1, 'browse_admin', NULL, '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(2, 'browse_bread', NULL, '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(3, 'browse_database', NULL, '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(4, 'browse_media', NULL, '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(5, 'browse_compass', NULL, '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(6, 'browse_menus', 'menus', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(7, 'read_menus', 'menus', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(8, 'edit_menus', 'menus', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(9, 'add_menus', 'menus', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(10, 'delete_menus', 'menus', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(11, 'browse_roles', 'roles', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(12, 'read_roles', 'roles', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(13, 'edit_roles', 'roles', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(14, 'add_roles', 'roles', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(15, 'delete_roles', 'roles', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(16, 'browse_users', 'users', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(17, 'read_users', 'users', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(18, 'edit_users', 'users', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(19, 'add_users', 'users', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(20, 'delete_users', 'users', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(21, 'browse_settings', 'settings', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(22, 'read_settings', 'settings', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(23, 'edit_settings', 'settings', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(24, 'add_settings', 'settings', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(25, 'delete_settings', 'settings', '2019-08-10 15:38:20', '2019-08-10 15:38:20'),
	(26, 'browse_hooks', NULL, '2019-08-10 15:38:22', '2019-08-10 15:38:22'),
	(27, 'browse_categories', 'categories', '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(28, 'read_categories', 'categories', '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(29, 'edit_categories', 'categories', '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(30, 'add_categories', 'categories', '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(31, 'delete_categories', 'categories', '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(32, 'browse_posts', 'posts', '2019-08-10 18:17:06', '2019-08-10 18:17:06'),
	(33, 'read_posts', 'posts', '2019-08-10 18:17:06', '2019-08-10 18:17:06'),
	(34, 'edit_posts', 'posts', '2019-08-10 18:17:06', '2019-08-10 18:17:06'),
	(35, 'add_posts', 'posts', '2019-08-10 18:17:06', '2019-08-10 18:17:06'),
	(36, 'delete_posts', 'posts', '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(37, 'browse_pages', 'pages', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(38, 'read_pages', 'pages', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(39, 'edit_pages', 'pages', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(40, 'add_pages', 'pages', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(41, 'delete_pages', 'pages', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(42, 'browse_sub_category', 'sub_category', '2019-08-17 17:54:57', '2019-08-17 17:54:57'),
	(43, 'read_sub_category', 'sub_category', '2019-08-17 17:54:57', '2019-08-17 17:54:57'),
	(44, 'edit_sub_category', 'sub_category', '2019-08-17 17:54:57', '2019-08-17 17:54:57'),
	(45, 'add_sub_category', 'sub_category', '2019-08-17 17:54:57', '2019-08-17 17:54:57'),
	(46, 'delete_sub_category', 'sub_category', '2019-08-17 17:54:57', '2019-08-17 17:54:57'),
	(52, 'browse_sub_categories', 'sub_categories', '2019-08-17 18:02:54', '2019-08-17 18:02:54'),
	(53, 'read_sub_categories', 'sub_categories', '2019-08-17 18:02:54', '2019-08-17 18:02:54'),
	(54, 'edit_sub_categories', 'sub_categories', '2019-08-17 18:02:54', '2019-08-17 18:02:54'),
	(55, 'add_sub_categories', 'sub_categories', '2019-08-17 18:02:54', '2019-08-17 18:02:54'),
	(56, 'delete_sub_categories', 'sub_categories', '2019-08-17 18:02:54', '2019-08-17 18:02:54');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.permission_role
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.permission_role: ~48 rows (approximately)
DELETE FROM `permission_role`;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(52, 1),
	(53, 1),
	(54, 1),
	(55, 1),
	(56, 1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.point_system
DROP TABLE IF EXISTS `point_system`;
CREATE TABLE IF NOT EXISTS `point_system` (
  `id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `user_account_id` int(10) unsigned NOT NULL,
  `post_activity` varchar(50) DEFAULT NULL,
  `point_earned` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_point_system_post_id` (`post_id`),
  KEY `FK_point_system_user_id` (`user_account_id`),
  CONSTRAINT `FK_point_system_post_id` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_point_system_user_id` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.point_system: ~0 rows (approximately)
DELETE FROM `point_system`;
/*!40000 ALTER TABLE `point_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_system` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.posts
DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.posts: ~4 rows (approximately)
DELETE FROM `posts`;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
	(1, 0, NULL, 'Lorem Ipsum Post', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'posts/post1.jpg', 'lorem-ipsum-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(2, 0, NULL, 'My Sample Post', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>', 'posts/post2.jpg', 'my-sample-post', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(3, 0, NULL, 'Latest Post', NULL, 'This is the excerpt for the latest post', '<p>This is the body for the latest post</p>', 'posts/post3.jpg', 'latest-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(4, 0, NULL, 'Yarr Post', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'posts/post4.jpg', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2019-08-10 18:17:07', '2019-08-10 18:17:07');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.roles: ~2 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'Administrator', '2019-08-10 15:38:19', '2019-08-10 15:38:19'),
	(2, 'user', 'Normal User', '2019-08-10 15:38:19', '2019-08-10 15:38:19');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.settings
DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.settings: ~10 rows (approximately)
DELETE FROM `settings`;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
	(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
	(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
	(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
	(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
	(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
	(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
	(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
	(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
	(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
	(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.state
DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_name` varchar(255) NOT NULL,
  `country_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_country` (`country_id`),
  CONSTRAINT `state_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.state: ~0 rows (approximately)
DELETE FROM `state`;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
/*!40000 ALTER TABLE `state` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.sub_categories
DROP TABLE IF EXISTS `sub_categories`;
CREATE TABLE IF NOT EXISTS `sub_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subcatagory_name` varchar(255) NOT NULL,
  `parent_category_id` int(10) unsigned DEFAULT NULL,
  `maximum_images_allowed` int(10) unsigned NOT NULL,
  `post_validity_interval_in_days` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_category_id` (`parent_category_id`),
  CONSTRAINT `sub_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.sub_categories: ~2 rows (approximately)
DELETE FROM `sub_categories`;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` (`id`, `subcatagory_name`, `parent_category_id`, `maximum_images_allowed`, `post_validity_interval_in_days`, `created_at`, `updated_at`) VALUES
	(1, 'Used', 1, 10, 10, '2019-08-18 05:33:25', '2019-08-18 05:33:25'),
	(2, 'New', 1, 10, 10, '2019-08-18 05:34:01', '2019-08-18 05:34:01');
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.translations
DROP TABLE IF EXISTS `translations`;
CREATE TABLE IF NOT EXISTS `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.translations: ~30 rows (approximately)
DELETE FROM `translations`;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
	(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2019-08-10 18:17:08', '2019-08-10 18:17:08'),
	(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(21, 'menu_items', 'title', 2, 'pt', 'Media', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(22, 'menu_items', 'title', 13, 'pt', 'Publicações', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(24, 'menu_items', 'title', 12, 'pt', 'Categorias', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(25, 'menu_items', 'title', 14, 'pt', 'Páginas', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2019-08-10 18:17:09', '2019-08-10 18:17:09'),
	(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2019-08-10 18:17:09', '2019-08-10 18:17:09');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_language_id` int(10) unsigned DEFAULT NULL,
  `country_id` int(10) unsigned DEFAULT NULL,
  `upload` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `remember_token` (`remember_token`),
  KEY `users_role_id_foreign` (`role_id`),
  KEY `users_language_id_foreign` (`preferred_language_id`),
  KEY `users_country_id_foreign` (`country_id`),
  CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_language_id_foreign` FOREIGN KEY (`preferred_language_id`) REFERENCES `language` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.users: ~4 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `first_name`, `last_name`, `email`, `mobile_number`, `avatar`, `email_verified_at`, `password`, `remember_token`, `preferred_language_id`, `country_id`, `upload`, `membership`, `interest`, `settings`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Admin', NULL, 'superadmin@markaz.com', '', 'users/default.png', NULL, '$2y$10$XeBVqR9UXPWj6iIyoQRVEOSVwswC4bvJWPLHmeq/EfqgucGEIiRaG', 'eqdPiBMbcBg0npQD87ehSdE5eOYBNrnfe2A1clCSntTkrbXFwlsbvmwjwqXi', NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(13, 2, NULL, NULL, NULL, '12345678', 'users/default.png', NULL, '$2y$10$Kohg/Sfsc7A/.ZQMHKDmVeGgJEqGMg7xij02nzq4qEgGktyAMytxW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 14:04:34', '2019-08-15 14:04:34'),
	(16, 2, NULL, NULL, NULL, '0987621235', 'users/default.png', NULL, '$2y$10$nZYT8HLvbL2Aq4Wj9saUDOuTMpRuD2jiS5JiJ2SY5nxe274TIxZW2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 16:07:53', '2019-08-15 16:07:54'),
	(17, NULL, NULL, NULL, NULL, '2223345677', 'users/default.png', NULL, '$2y$10$KT54NDlO9fHTUDq5i7TOCOgQm5N5kZYAlhGL3ThsHpp9pP7EoByVa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 16:48:42', '2019-08-15 16:48:42');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_account
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE IF NOT EXISTS `user_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_number` int(10) unsigned NOT NULL,
  `password` varchar(255) NOT NULL,
  `login_pwd_encry` varchar(20) NOT NULL,
  `preferred_language_id` int(10) unsigned NOT NULL,
  `county_id` int(10) unsigned NOT NULL,
  `zip` varchar(255) NOT NULL,
  `api_token` varchar(255) DEFAULT NULL,
  `upload` text DEFAULT NULL,
  `interest` text DEFAULT NULL,
  `membership` enum('standard','platinum','vip') DEFAULT 'standard',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  UNIQUE KEY `api_token` (`api_token`),
  KEY `user_account_county` (`county_id`),
  KEY `user_account_language` (`preferred_language_id`),
  CONSTRAINT `user_account_county` FOREIGN KEY (`county_id`) REFERENCES `county` (`id`),
  CONSTRAINT `user_account_language` FOREIGN KEY (`preferred_language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_account: ~0 rows (approximately)
DELETE FROM `user_account`;
/*!40000 ALTER TABLE `user_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_account` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_latest_searches
DROP TABLE IF EXISTS `user_latest_searches`;
CREATE TABLE IF NOT EXISTS `user_latest_searches` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `search_value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_recent_user_id` (`user_id`),
  CONSTRAINT `FK_recent_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_latest_searches: ~0 rows (approximately)
DELETE FROM `user_latest_searches`;
/*!40000 ALTER TABLE `user_latest_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_latest_searches` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_otp
DROP TABLE IF EXISTS `user_otp`;
CREATE TABLE IF NOT EXISTS `user_otp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mobile_number` varchar(255) NOT NULL,
  `verification_code` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `verification_code` (`verification_code`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_otp: ~3 rows (approximately)
DELETE FROM `user_otp`;
/*!40000 ALTER TABLE `user_otp` DISABLE KEYS */;
INSERT INTO `user_otp` (`id`, `mobile_number`, `verification_code`, `created_at`, `updated_at`) VALUES
	(12, '12345678', '4768', '2019-08-15 12:42:13', '2019-08-15 12:42:16'),
	(13, '0987621235', '2631', '2019-08-15 16:07:40', '2019-08-15 16:07:40'),
	(14, '2223345677', '3357', '2019-08-15 16:48:19', '2019-08-15 16:48:19');
/*!40000 ALTER TABLE `user_otp` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_points
DROP TABLE IF EXISTS `user_points`;
CREATE TABLE IF NOT EXISTS `user_points` (
  `id` int(10) unsigned NOT NULL,
  `user_account_id` int(10) unsigned NOT NULL,
  `point_type_id` int(10) unsigned NOT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_u_acc_id` (`user_account_id`),
  KEY `FK_point_id` (`point_type_id`),
  CONSTRAINT `FK_point_id` FOREIGN KEY (`point_type_id`) REFERENCES `point_system` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_u_acc_id` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_points: ~0 rows (approximately)
DELETE FROM `user_points`;
/*!40000 ALTER TABLE `user_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_points` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_posts
DROP TABLE IF EXISTS `user_posts`;
CREATE TABLE IF NOT EXISTS `user_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `create_date` date NOT NULL,
  `post_title` varchar(50) NOT NULL,
  `post_detail` text NOT NULL,
  `post_type` enum('featured','auction','classified','community','asf_for') NOT NULL DEFAULT 'classified',
  `is_active` tinyint(4) NOT NULL,
  `expected_price` int(10) unsigned DEFAULT NULL,
  `is_price_negotiable` tinyint(4) DEFAULT NULL,
  `quot_received` int(11) DEFAULT 0,
  `last_renewed_on` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_user_account` (`user_account_id`),
  KEY `post_category` (`category_id`),
  CONSTRAINT `post_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `post_user_account` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_posts: ~0 rows (approximately)
DELETE FROM `user_posts`;
/*!40000 ALTER TABLE `user_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_posts` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_alert
DROP TABLE IF EXISTS `user_post_alert`;
CREATE TABLE IF NOT EXISTS `user_post_alert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` int(10) unsigned NOT NULL,
  `create_date` date NOT NULL,
  `valid_for` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `search_context` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_alert_user_account` (`user_account_id`),
  KEY `post_alert_category` (`category_id`),
  CONSTRAINT `post_alert_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `post_alert_user_account` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_post_alert: ~0 rows (approximately)
DELETE FROM `user_post_alert`;
/*!40000 ALTER TABLE `user_post_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post_alert` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_attribute
DROP TABLE IF EXISTS `user_post_attribute`;
CREATE TABLE IF NOT EXISTS `user_post_attribute` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_attribute` text NOT NULL,
  `is_favourite` enum('1','0') DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  CONSTRAINT `post_property_post` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_post_attribute: ~0 rows (approximately)
DELETE FROM `user_post_attribute`;
/*!40000 ALTER TABLE `user_post_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post_attribute` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_image
DROP TABLE IF EXISTS `user_post_image`;
CREATE TABLE IF NOT EXISTS `user_post_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `image` blob NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Table_11_post` (`post_id`),
  CONSTRAINT `Table_11_post` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_post_image: ~0 rows (approximately)
DELETE FROM `user_post_image`;
/*!40000 ALTER TABLE `user_post_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post_image` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_roles
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.user_roles: ~0 rows (approximately)
DELETE FROM `user_roles`;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.variants
DROP TABLE IF EXISTS `variants`;
CREATE TABLE IF NOT EXISTS `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.variants: ~0 rows (approximately)
DELETE FROM `variants`;
/*!40000 ALTER TABLE `variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `variants` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

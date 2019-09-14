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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_post_id` int(10) unsigned NOT NULL,
  `auction_start_date` date NOT NULL,
  `auction_actual_close_date` datetime NOT NULL,
  `auction_planned_close_date` datetime NOT NULL,
  `auction_item_actual_selling_price` varchar(50) NOT NULL DEFAULT '',
  `auction_item_reserve_price` varchar(50) NOT NULL DEFAULT '',
  `auction_item_comments` varchar(50) NOT NULL DEFAULT '',
  `status` enum('waiting','progress','completed') NOT NULL DEFAULT 'waiting',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_act_post_id` (`user_post_id`),
  CONSTRAINT `FK_act_post_id` FOREIGN KEY (`user_post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.auctions: ~2 rows (approximately)
DELETE FROM `auctions`;
/*!40000 ALTER TABLE `auctions` DISABLE KEYS */;
INSERT INTO `auctions` (`id`, `user_post_id`, `auction_start_date`, `auction_actual_close_date`, `auction_planned_close_date`, `auction_item_actual_selling_price`, `auction_item_reserve_price`, `auction_item_comments`, `status`, `created_at`, `updated_at`) VALUES
	(1, 349, '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '2019-09-10 09:55:40', '2019-09-10 09:55:40'),
	(2, 352, '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '20000 AED', '17500 AED', '', '', '2019-09-11 05:10:10', '2019-09-11 05:10:10');
/*!40000 ALTER TABLE `auctions` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.auctions_old
DROP TABLE IF EXISTS `auctions_old`;
CREATE TABLE IF NOT EXISTS `auctions_old` (
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
  CONSTRAINT `FK_bidder_id` FOREIGN KEY (`bidder_id`) REFERENCES `bidders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.auctions_old: ~0 rows (approximately)
DELETE FROM `auctions_old`;
/*!40000 ALTER TABLE `auctions_old` DISABLE KEYS */;
/*!40000 ALTER TABLE `auctions_old` ENABLE KEYS */;

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
  CONSTRAINT `FK_bid_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `auctions_old` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE
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
	(1, NULL, 1, 'Electronics', 'electronics', '2019-08-10 18:17:05', '2019-08-18 04:43:56'),
	(2, 2, 1, 'Cars', 'automobiles', '2019-08-10 18:17:05', '2019-08-18 04:44:39'),
	(3, NULL, 3, 'property', 'property', '2019-08-18 04:45:15', '2019-08-18 04:45:15'),
	(4, NULL, 4, 'Jobs', 'jobs', '2019-08-18 04:45:50', '2019-08-18 04:45:50');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.cities
DROP TABLE IF EXISTS `cities`;
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `city_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.cities: ~2 rows (approximately)
DELETE FROM `cities`;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` (`id`, `state_id`, `city_name`, `created_at`, `updated_at`, `country_id`) VALUES
	(2, 1, 'Karachi', '2019-09-07 06:12:00', '2019-09-07 06:22:44', 3),
	(4, 2, 'Texax', '2019-09-07 17:58:00', '2019-09-07 18:00:12', 4),
	(5, 0, 'Dubai', '2019-09-10 14:50:28', '2019-09-10 14:50:29', 5);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.countries
DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.countries: ~3 rows (approximately)
DELETE FROM `countries`;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` (`id`, `country_name`, `currency_id`, `created_at`, `updated_at`) VALUES
	(3, 'Pakisntan', 2, '2019-09-07 06:11:28', '2019-09-07 06:38:03'),
	(4, 'America', 3, '2019-09-07 17:59:47', '2019-09-07 17:59:47'),
	(5, 'United Arab Emirates', 4, '2019-09-10 14:51:06', '2019-09-10 14:51:07');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;

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

-- Dumping structure for table classified_webapp.currencies
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.currencies: ~2 rows (approximately)
DELETE FROM `currencies`;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
	(2, 'Rupees', 'Pk', '2019-09-07 06:11:43', '2019-09-07 06:11:43'),
	(3, 'Dollar', 'USD', '2019-09-07 17:59:22', '2019-09-07 17:59:22'),
	(4, 'Dirham', 'AED', '2019-09-10 14:51:53', '2019-09-10 14:51:55');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.data_rows: ~113 rows (approximately)
DELETE FROM `data_rows`;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
	(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
	(3, 1, 'email', 'text', 'Email', 0, 1, 1, 1, 1, 1, '{}', 3),
	(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, '{}', 4),
	(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, '{}', 5),
	(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 6),
	(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
	(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, '{}', 8),
	(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsTo","column":"role_id","key":"id","label":"display_name","pivot_table":"roles","pivot":"0","taggable":"0"}', 10),
	(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsToMany","column":"id","key":"id","label":"display_name","pivot_table":"user_roles","pivot":"1","taggable":"0"}', 11),
	(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, '{}', 12),
	(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
	(21, 1, 'role_id', 'text', 'Role', 0, 1, 1, 1, 1, 1, '{}', 9),
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
	(76, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
	(98, 12, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(99, 12, 'message_text', 'text', 'Text', 0, 1, 1, 1, 1, 1, '{}', 2),
	(100, 12, 'created_at', 'timestamp', 'Recieved', 1, 1, 1, 1, 1, 1, '{}', 3),
	(101, 12, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
	(102, 13, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(103, 13, 'user_post_id', 'text', 'User Post Id', 0, 1, 1, 1, 1, 1, '{}', 2),
	(104, 13, 'given_by', 'text', 'Given By', 0, 1, 1, 1, 1, 1, '{}', 3),
	(105, 13, 'is_favourite', 'select_dropdown', 'Is Favourite', 0, 1, 1, 1, 1, 1, '{}', 4),
	(106, 13, 'review', 'text', 'Review', 0, 1, 1, 1, 1, 1, '{}', 5),
	(107, 13, 'rating', 'text', 'Rating', 0, 1, 1, 1, 1, 1, '{}', 6),
	(108, 13, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
	(109, 13, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
	(110, 14, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(111, 14, 'user_account_id', 'number', 'UserId', 1, 1, 1, 1, 1, 1, '{}', 2),
	(112, 14, 'category_id', 'text', 'Category Id', 1, 1, 1, 1, 1, 1, '{}', 3),
	(113, 14, 'sub_category_id', 'text', 'Sub Category Id', 1, 1, 1, 1, 1, 1, '{}', 4),
	(114, 14, 'create_date', 'timestamp', '', 0, 0, 0, 0, 0, 0, '{}', 5),
	(115, 14, 'post_title', 'text', 'Post Title', 1, 1, 1, 1, 1, 1, '{}', 6),
	(116, 14, 'post_detail', 'text', 'Post Detail', 1, 1, 1, 1, 1, 1, '{}', 7),
	(117, 14, 'post_type', 'select_dropdown', 'Post Type', 1, 1, 1, 1, 1, 1, '{}', 8),
	(118, 14, 'is_active', 'select_dropdown', 'Is Active', 1, 1, 1, 1, 1, 1, '{}', 9),
	(119, 14, 'expected_price', 'text', 'Expected Price', 0, 1, 1, 1, 1, 1, '{}', 10),
	(120, 14, 'is_price_negotiable', 'text', 'Is Price Negotiable', 0, 1, 1, 1, 1, 1, '{}', 11),
	(121, 14, 'quot_received', 'text', 'Quot Received', 0, 1, 1, 1, 1, 1, '{}', 12),
	(122, 14, 'last_renewed_on', 'timestamp', 'Activation Date', 0, 1, 1, 1, 1, 1, '{}', 13),
	(123, 14, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 14),
	(124, 14, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 15),
	(125, 14, 'user_post_hasone_sub_category_relationship', 'relationship', 'sub_categories', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\Models\\\\SubCategory","table":"sub_categories","type":"belongsTo","column":"sub_category_id","key":"id","label":"subcategory_name","pivot_table":"auction_items","pivot":"0","taggable":"0"}', 16),
	(126, 14, 'user_post_belongsto_category_relationship', 'relationship', 'categories', 0, 1, 1, 1, 1, 1, '{"model":"TCG\\\\Voyager\\\\Models\\\\Category","table":"categories","type":"belongsTo","column":"category_id","key":"id","label":"name","pivot_table":"auction_items","pivot":"0","taggable":"0"}', 17),
	(127, 15, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(128, 15, 'user_post_id', 'text', 'User Post Id', 1, 1, 1, 1, 1, 1, '{}', 2),
	(129, 15, 'post_attribute', 'text_area', 'Post Attribute', 1, 1, 1, 1, 1, 1, '{}', 3),
	(130, 15, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 4),
	(131, 15, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 5),
	(132, 1, 'first_name', 'text', 'First Name', 0, 1, 1, 1, 1, 1, '{}', 5),
	(133, 1, 'last_name', 'text', 'Last Name', 0, 1, 1, 1, 1, 1, '{}', 6),
	(134, 1, 'mobile_number', 'text', 'Mobile Number', 1, 1, 1, 1, 1, 1, '{}', 8),
	(135, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 1, 1, 1, 1, 1, '{}', 10),
	(136, 1, 'preferred_language_id', 'text', 'Preferred Language Id', 0, 1, 1, 1, 1, 1, '{}', 3),
	(137, 1, 'country_id', 'text', 'Country Id', 0, 1, 1, 1, 1, 1, '{}', 4),
	(138, 1, 'upload', 'text', 'Upload', 0, 1, 1, 1, 1, 1, '{}', 13),
	(139, 1, 'membership', 'text', 'Membership', 0, 1, 1, 1, 1, 1, '{}', 14),
	(140, 1, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 15),
	(141, 1, 'interest', 'text', 'Interest', 0, 1, 1, 1, 1, 1, '{}', 16),
	(142, 16, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(143, 16, 'user_post_id', 'number', 'User Post Id', 1, 1, 1, 1, 1, 1, '{}', 2),
	(144, 16, 'auction_start_date', 'timestamp', 'Start Date', 1, 1, 1, 1, 1, 1, '{}', 3),
	(145, 16, 'auction_actual_close_date', 'timestamp', 'Actual Close Date', 1, 1, 1, 1, 1, 1, '{}', 4),
	(146, 16, 'auction_planned_close_date', 'timestamp', 'Planned Close Date', 1, 1, 1, 1, 1, 1, '{}', 5),
	(147, 16, 'auction_item_actual_selling_price', 'text', 'Auction Price', 1, 1, 1, 1, 1, 1, '{}', 6),
	(148, 16, 'auction_item_reserve_price', 'text', 'Auction Item Reserve Price', 1, 0, 0, 0, 0, 0, '{}', 7),
	(149, 16, 'auction_item_comments', 'text', 'Auction Item Comments', 1, 0, 0, 0, 0, 0, '{}', 8),
	(150, 16, 'status', 'text', 'Status', 1, 1, 1, 1, 1, 1, '{}', 9),
	(151, 16, 'created_at', 'text', 'Created At', 1, 0, 0, 1, 1, 1, '{}', 10),
	(152, 16, 'updated_at', 'text', 'Updated At', 0, 1, 1, 1, 1, 1, '{}', 11);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.data_types: ~11 rows (approximately)
DELETE FROM `data_types`;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
	(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}', '2019-08-10 15:38:16', '2019-09-08 10:12:56'),
	(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2019-08-10 15:38:16', '2019-08-10 15:38:16'),
	(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, '', '', 1, 0, NULL, '2019-08-10 15:38:16', '2019-08-10 15:38:16'),
	(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2019-08-10 18:17:04', '2019-08-10 18:17:04'),
	(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2019-08-10 18:17:07', '2019-08-10 18:17:07'),
	(7, 'sub_category', 'sub-category', 'Sub Categories', 'Sub Categories', NULL, 'App\\Models\\SubCategory', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-08-17 17:54:57', '2019-08-17 17:57:32'),
	(9, 'sub_categories', 'sub-categories', 'Sub Category', 'Sub Categories', NULL, 'App\\Models\\SubCategory', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-08-17 18:02:54', '2019-08-18 04:55:12'),
	(12, 'messages', 'messages', 'Message', 'Messages', 'voyager-documentation', 'App\\Models\\Message', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null}', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(13, 'user_post_view', 'user-post-view', 'User Post View', 'User Post Views', 'voyager-tree', 'App\\Models\\UserPostView', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null}', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(14, 'user_posts', 'user-posts', 'User Post', 'User Posts', 'voyager-umbrella', 'App\\Models\\UserPost', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-09-03 11:36:52', '2019-09-03 12:15:20'),
	(15, 'user_post_attribute', 'user-post-attribute', 'User Post Attribute', 'User Post Attributes', 'voyager-tree', 'App\\Models\\UserPostAttribute', NULL, 'App\\Http\\Controllers\\Api\\UserPostAttributeController', NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2019-09-03 12:20:15', '2019-09-13 06:09:53'),
	(16, 'auctions', 'auctions', 'Auction', 'Auctions', 'voyager-activity', 'App\\Models\\Auction', NULL, NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null}', '2019-09-11 05:35:08', '2019-09-11 05:35:08');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.menu_items: ~19 rows (approximately)
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
	(17, 1, 'Sub Categories', '', '_self', NULL, NULL, NULL, 15, '2019-08-17 18:02:54', '2019-08-17 18:02:54', 'voyager.sub-categories.index', NULL),
	(20, 1, 'Messages', '', '_self', 'voyager-documentation', NULL, NULL, 18, '2019-09-03 10:26:09', '2019-09-03 10:26:09', 'voyager.messages.index', NULL),
	(21, 1, 'User Post Views', '', '_self', 'voyager-tree', NULL, NULL, 19, '2019-09-03 11:31:48', '2019-09-03 11:31:48', 'voyager.user-post-view.index', NULL),
	(22, 1, 'User Posts', '', '_self', NULL, NULL, NULL, 20, '2019-09-03 11:36:52', '2019-09-03 11:36:52', 'voyager.user-posts.index', NULL),
	(23, 1, 'User Post Attributes', '', '_self', 'voyager-tree', NULL, NULL, 21, '2019-09-03 12:20:15', '2019-09-03 12:20:15', 'voyager.user-post-attribute.index', NULL),
	(24, 1, 'Auctions', '', '_self', 'voyager-activity', NULL, NULL, 22, '2019-09-11 05:35:12', '2019-09-11 05:35:12', 'voyager.auctions.index', NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_text` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.messages: ~5 rows (approximately)
DELETE FROM `messages`;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `message_text`, `created_at`, `updated_at`) VALUES
	(5, 'Can i get this in low price?', '2019-08-24 18:39:21', '2019-08-24 18:39:21'),
	(17, 'yes you can tell me your price tag', '2019-08-26 04:59:04', '2019-08-26 04:59:04'),
	(18, 'You have to reply me quick. As it will be on the basis of first come first basis', '2019-08-26 05:01:22', '2019-08-26 05:01:22'),
	(19, 'I called you but it seems you are not intresred', '2019-08-26 05:02:48', '2019-08-26 05:02:48'),
	(20, 'I am interested', '2019-08-26 05:03:50', '2019-08-26 05:03:50'),
	(21, 'I am interested', '2019-08-26 05:05:14', '2019-08-26 05:05:14');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.messages_thread
DROP TABLE IF EXISTS `messages_thread`;
CREATE TABLE IF NOT EXISTS `messages_thread` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.messages_thread: ~3 rows (approximately)
DELETE FROM `messages_thread`;
/*!40000 ALTER TABLE `messages_thread` DISABLE KEYS */;
INSERT INTO `messages_thread` (`id`, `created_at`, `updated_at`) VALUES
	(1, '2019-08-24 18:39:21', '2019-08-24 18:39:21'),
	(4, '2019-08-26 05:03:51', '2019-08-26 05:03:51'),
	(5, '2019-08-26 05:05:14', '2019-08-26 05:05:14');
/*!40000 ALTER TABLE `messages_thread` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.messages_threads_data
DROP TABLE IF EXISTS `messages_threads_data`;
CREATE TABLE IF NOT EXISTS `messages_threads_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` int(10) unsigned DEFAULT NULL,
  `thread_id` int(10) unsigned DEFAULT NULL,
  `sender_id` int(10) unsigned DEFAULT NULL,
  `receiver_id` int(10) unsigned DEFAULT NULL,
  `post_id` int(10) unsigned DEFAULT NULL,
  `unread` enum('1','0') DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.messages_threads_data: ~6 rows (approximately)
DELETE FROM `messages_threads_data`;
/*!40000 ALTER TABLE `messages_threads_data` DISABLE KEYS */;
INSERT INTO `messages_threads_data` (`id`, `message_id`, `thread_id`, `sender_id`, `receiver_id`, `post_id`, `unread`, `created_at`, `updated_at`) VALUES
	(1, 5, 1, 18, 17, 22, '0', '2019-08-25 13:09:00', '2019-08-25 13:09:00'),
	(4, 17, 1, 17, 18, 22, '0', '2019-08-26 04:59:04', '2019-08-26 04:59:04'),
	(5, 18, 1, 17, 18, 22, '0', '2019-08-26 05:01:22', '2019-08-26 05:01:22'),
	(6, 19, 1, 17, 18, 22, '0', '2019-08-26 05:02:48', '2019-08-26 05:02:48'),
	(7, 20, 4, 18, 17, 25, '0', '2019-08-26 05:03:51', '2019-08-26 05:03:51'),
	(8, 21, 5, 18, 17, 27, '0', '2019-08-26 05:05:14', '2019-08-26 05:05:14');
/*!40000 ALTER TABLE `messages_threads_data` ENABLE KEYS */;

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

-- Dumping data for table classified_webapp.oauth_access_tokens: ~24 rows (approximately)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('07e678ad934544863d90d6345e022b1cc5fdb43141dfa72a4701f9d5c5182796943f9487e018be7a', 17, 1, 'AppName', '[]', 0, '2019-08-15 20:37:50', '2019-08-15 20:37:50', '2020-08-15 20:37:50'),
	('0b25e41ad75c59d9c9159b9b5495b32cd73de37e59f7d60a55211f03bcbab84556370269e7641fe3', 8, 1, 'AppName', '[]', 0, '2019-08-15 13:15:05', '2019-08-15 13:15:05', '2020-08-15 13:15:05'),
	('0c1c98413da93916277dc5e83c9c8ceb6d31c49070b153b72d3eb3f8aaa73274a3b2aa11fa24bdc9', 6, 1, 'AppName', '[]', 0, '2019-08-15 12:24:35', '2019-08-15 12:24:35', '2020-08-15 12:24:35'),
	('1820506bdee6b8b68ca925cbc368fd497ebabbddd67760b77cdef4457b9317b03be936b7b792d36f', 2, 1, 'AppName', '[]', 0, '2019-08-15 10:35:04', '2019-08-15 10:35:04', '2020-08-15 10:35:04'),
	('185b01b583bb3f8aab8f3dc39c759bb94834a38b78f3add18dc281059d3b1ace9a5afb6b819d63be', 17, 1, 'AppName', '[]', 1, '2019-08-23 18:16:11', '2019-08-23 18:16:11', '2020-08-23 18:16:11'),
	('186ba7371f1c2e113ec22e8df4e10505a81cd83452cf5fd67bc96e61fef39e0487848e8843e3d623', 10, 1, 'AppName', '[]', 0, '2019-08-15 13:16:18', '2019-08-15 13:16:18', '2020-08-15 13:16:18'),
	('18d88099d08edd5dc31c770e116cac1e5aef96b453b51f3cae31c2d12d2f7c5e30c6f9e0e5bf97d0', 3, 1, 'AppName', '[]', 0, '2019-08-15 10:38:56', '2019-08-15 10:38:56', '2020-08-15 10:38:56'),
	('1d0c620a236c97e09c052e8f644fdfc1daba6fcf4898f6f9281f7b624a2bd74e0f9828c531e6d1d4', 17, 1, 'AppName', '[]', 0, '2019-08-15 16:48:44', '2019-08-15 16:48:44', '2020-08-15 16:48:44'),
	('1d283a9064984a823ef36889a5d3f97b8c025f11bdb7e875207e8adc184b77c0309bbea8dc059edc', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:32:09', '2019-08-15 16:32:09', '2020-08-15 16:32:09'),
	('22202324b54127a3eea5070dee8b87479b78cb9d8543068ec0f6b971e53f4797aca1390559818389', 18, 3, 'AppName', '[]', 0, '2019-09-04 12:19:54', '2019-09-04 12:19:54', '2020-09-04 12:19:54'),
	('28390c7390a369df39ba6d90eaae1dc1b300b2ec5a2c3f4277e5a8c50233741575364af7d640b07a', 17, 1, 'AppName', '[]', 0, '2019-08-20 08:31:52', '2019-08-20 08:31:52', '2020-08-20 08:31:52'),
	('30a3fb07e546fd490c986f5e583edcf9695e2724f101abdc9d472c83b7199c2693363c9b250f4a56', 18, 1, 'AppName', '[]', 0, '2019-08-25 12:48:22', '2019-08-25 12:48:22', '2020-08-25 12:48:22'),
	('32f93f82a1f0c39526081f8af992f3565a4dfe987f1ce340a2bf72abfc79ca94419c9a0dddf73e72', 18, 1, 'AppName', '[]', 0, '2019-08-25 12:48:38', '2019-08-25 12:48:38', '2020-08-25 12:48:38'),
	('377126f390364423a5303c7a7783e30ed7766ebc4c900726df37207e6a4d13b200aaa832bc84e632', 18, 3, 'AppName', '[]', 0, '2019-09-09 17:35:19', '2019-09-09 17:35:19', '2020-09-09 17:35:19'),
	('39bf2060c6e70ddeb4f818f1c8cc38c0035bbb8191783e7cf3095416a18766d479b02c069865a551', 18, 3, 'AppName', '[]', 0, '2019-09-14 06:42:35', '2019-09-14 06:42:35', '2020-09-14 06:42:35'),
	('3a8c6989cf2afe0030b0f71476a72f3384024cf8f38efc4f1eef48d76febe45ff8fa133c60eba5b6', 16, 1, 'AppName', '[]', 0, '2019-08-15 16:32:29', '2019-08-15 16:32:29', '2020-08-15 16:32:29'),
	('46ac12a30d6dfb4bf3f88f3c094de7562ed7854770e183f3861df56f594eebb1e510ed2fca83a091', 17, 1, 'AppName', '[]', 0, '2019-08-19 12:18:18', '2019-08-19 12:18:18', '2020-08-19 12:18:18'),
	('52847c6c86207f9bdb5bf9699e8e0cfa7ea84b2491802f9154b79ca9d22a505dd581a8137612eb8e', 17, 1, 'AppName', '[]', 0, '2019-08-15 20:48:16', '2019-08-15 20:48:16', '2020-08-15 20:48:16'),
	('632e76c9481bd7c8d7e0de313ed01e53491f35ab16c6db969007c095e7541953775f5bc25fd4dabe', 17, 1, 'AppName', '[]', 0, '2019-08-24 04:19:55', '2019-08-24 04:19:55', '2020-08-24 04:19:55'),
	('7989283ff8be8622a2eb4ba3fdba43c025f3fd1242ec6934567181b7ccd80228e4fb973d7c02289f', 17, 1, 'AppName', '[]', 0, '2019-08-20 13:02:29', '2019-08-20 13:02:29', '2020-08-20 13:02:29'),
	('9ead1dfe9059d48325a9bca1ba4a0f10823eca00d0ec909f609c001ad87f80f5a0c818ed2375618f', 18, 3, 'AppName', '[]', 0, '2019-09-08 21:20:07', '2019-09-08 21:20:07', '2020-09-08 21:20:07'),
	('a02dc29ecd335678a429286a3f8f008573d0d9e9b680a9c5756181ba94594d1cb6eb9724c02dfeff', 5, 1, 'AppName', '[]', 0, '2019-08-15 12:24:23', '2019-08-15 12:24:23', '2020-08-15 12:24:23'),
	('a835423d2ab836e097968be5187f72c788bfc108cc9acfed93b6a654ef001b5efcf299b302a239ee', 4, 1, 'AppName', '[]', 0, '2019-08-15 12:17:19', '2019-08-15 12:17:19', '2020-08-15 12:17:19'),
	('ac9fcbcf934908496045a1896ec101d20736c7112e94b2b8e7f5b883487195e2279d095fd1da7271', 7, 1, 'AppName', '[]', 0, '2019-08-15 12:24:42', '2019-08-15 12:24:42', '2020-08-15 12:24:42'),
	('cfe68ce6aec8dd5f3da4afa7e4fa9e094b7a2b83f6845e27b1c275b7869cb19eb6730d155d1b5acb', 18, 1, 'AppName', '[]', 0, '2019-08-30 05:58:34', '2019-08-30 05:58:34', '2020-08-30 05:58:34'),
	('d1b37d3108670ba6c450525a50ad7d7d7e0b4410fb1ad7ec93c5ebfd1330db99e7587549bacbfcf9', 13, 1, 'AppName', '[]', 0, '2019-08-15 14:04:35', '2019-08-15 14:04:35', '2020-08-15 14:04:35'),
	('d386b03e4bb1472fac43bde7ef4bcb5662aab25fb5c606b2ac502947d41415bf9d52e5960d0c0239', 18, 3, 'AppName', '[]', 0, '2019-09-10 09:28:24', '2019-09-10 09:28:24', '2020-09-10 09:28:24'),
	('d41fa2cd29d5589481d1a9d362861b0c1cb6cd761b488e8a769b36e5368f30383608b9fb38c7421d', 17, 1, 'AppName', '[]', 0, '2019-08-15 18:54:50', '2019-08-15 18:54:50', '2020-08-15 18:54:50'),
	('e960cf72b75f5a3dbe9c3d381e65ddfd86806f6e58eb223925f1630ad23eaff2614ccb4d55506d23', 18, 3, 'AppName', '[]', 0, '2019-09-07 20:12:00', '2019-09-07 20:12:00', '2020-09-07 20:12:00'),
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_clients: ~4 rows (approximately)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', 'MJc7Xj13fkPmZivHRdvEb6EaddakQ9sQDfZUAPey', 'http://localhost', 1, 0, 0, '2019-08-15 09:23:50', '2019-08-15 09:23:50'),
	(2, NULL, 'Laravel Password Grant Client', 'JMXoepVcJZhjdaYSBola0DXGbhs6cf3oLleGjDNX', 'http://localhost', 0, 1, 0, '2019-08-15 09:23:50', '2019-08-15 09:23:50'),
	(3, NULL, 'Laravel Personal Access Client', '7DCVNqCPV5qciYClg9q6Vj09hJYooOLEVaazVd5K', 'http://localhost', 1, 0, 0, '2019-09-04 12:19:39', '2019-09-04 12:19:39'),
	(4, NULL, 'Laravel Password Grant Client', 'weJbLMaRb2YXHfYF85QYiuI9yfm5u5BfK85wcHmM', 'http://localhost', 0, 1, 0, '2019-09-04 12:19:39', '2019-09-04 12:19:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.oauth_personal_access_clients: ~0 rows (approximately)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2019-08-15 09:23:50', '2019-08-15 09:23:50'),
	(2, 3, '2019-09-04 12:19:39', '2019-09-04 12:19:39');
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
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- Dumping data for table classified_webapp.permissions: ~66 rows (approximately)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
	(1, 'browse_admin', NULL, '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(2, 'browse_bread', NULL, '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(3, 'browse_database', NULL, '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(4, 'browse_media', NULL, '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(5, 'browse_compass', NULL, '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(6, 'browse_menus', 'menus', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(7, 'read_menus', 'menus', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(8, 'edit_menus', 'menus', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(9, 'add_menus', 'menus', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(10, 'delete_menus', 'menus', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(11, 'browse_roles', 'roles', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(12, 'read_roles', 'roles', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(13, 'edit_roles', 'roles', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(14, 'add_roles', 'roles', '2019-08-11 03:38:19', '2019-08-11 03:38:19'),
	(15, 'delete_roles', 'roles', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(16, 'browse_users', 'users', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(17, 'read_users', 'users', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(18, 'edit_users', 'users', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(19, 'add_users', 'users', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(20, 'delete_users', 'users', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(21, 'browse_settings', 'settings', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(22, 'read_settings', 'settings', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(23, 'edit_settings', 'settings', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(24, 'add_settings', 'settings', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(25, 'delete_settings', 'settings', '2019-08-11 03:38:20', '2019-08-11 03:38:20'),
	(26, 'browse_hooks', NULL, '2019-08-11 03:38:22', '2019-08-11 03:38:22'),
	(27, 'browse_categories', 'categories', '2019-08-11 06:17:05', '2019-08-11 06:17:05'),
	(28, 'read_categories', 'categories', '2019-08-11 06:17:05', '2019-08-11 06:17:05'),
	(29, 'edit_categories', 'categories', '2019-08-11 06:17:05', '2019-08-11 06:17:05'),
	(30, 'add_categories', 'categories', '2019-08-11 06:17:05', '2019-08-11 06:17:05'),
	(31, 'delete_categories', 'categories', '2019-08-11 06:17:05', '2019-08-11 06:17:05'),
	(32, 'browse_posts', 'posts', '2019-08-11 06:17:06', '2019-08-11 06:17:06'),
	(33, 'read_posts', 'posts', '2019-08-11 06:17:06', '2019-08-11 06:17:06'),
	(34, 'edit_posts', 'posts', '2019-08-11 06:17:06', '2019-08-11 06:17:06'),
	(35, 'add_posts', 'posts', '2019-08-11 06:17:06', '2019-08-11 06:17:06'),
	(36, 'delete_posts', 'posts', '2019-08-11 06:17:07', '2019-08-11 06:17:07'),
	(37, 'browse_pages', 'pages', '2019-08-11 06:17:08', '2019-08-11 06:17:08'),
	(38, 'read_pages', 'pages', '2019-08-11 06:17:08', '2019-08-11 06:17:08'),
	(39, 'edit_pages', 'pages', '2019-08-11 06:17:08', '2019-08-11 06:17:08'),
	(40, 'add_pages', 'pages', '2019-08-11 06:17:08', '2019-08-11 06:17:08'),
	(41, 'delete_pages', 'pages', '2019-08-11 06:17:08', '2019-08-11 06:17:08'),
	(42, 'browse_sub_category', 'sub_category', '2019-08-18 05:54:57', '2019-08-18 05:54:57'),
	(43, 'read_sub_category', 'sub_category', '2019-08-18 05:54:57', '2019-08-18 05:54:57'),
	(44, 'edit_sub_category', 'sub_category', '2019-08-18 05:54:57', '2019-08-18 05:54:57'),
	(45, 'add_sub_category', 'sub_category', '2019-08-18 05:54:57', '2019-08-18 05:54:57'),
	(46, 'delete_sub_category', 'sub_category', '2019-08-18 05:54:57', '2019-08-18 05:54:57'),
	(52, 'browse_sub_categories', 'sub_categories', '2019-08-18 06:02:54', '2019-08-18 06:02:54'),
	(53, 'read_sub_categories', 'sub_categories', '2019-08-18 06:02:54', '2019-08-18 06:02:54'),
	(54, 'edit_sub_categories', 'sub_categories', '2019-08-18 06:02:54', '2019-08-18 06:02:54'),
	(55, 'add_sub_categories', 'sub_categories', '2019-08-18 06:02:54', '2019-08-18 06:02:54'),
	(56, 'delete_sub_categories', 'sub_categories', '2019-08-18 06:02:54', '2019-08-18 06:02:54'),
	(57, 'browse_messages', 'messages', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(58, 'read_messages', 'messages', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(59, 'edit_messages', 'messages', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(60, 'add_messages', 'messages', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(61, 'delete_messages', 'messages', '2019-09-03 10:26:09', '2019-09-03 10:26:09'),
	(62, 'browse_user_post_view', 'user_post_view', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(63, 'read_user_post_view', 'user_post_view', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(64, 'edit_user_post_view', 'user_post_view', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(65, 'add_user_post_view', 'user_post_view', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(66, 'delete_user_post_view', 'user_post_view', '2019-09-03 11:31:48', '2019-09-03 11:31:48'),
	(67, 'browse_user_posts', 'user_posts', '2019-09-03 11:36:52', '2019-09-03 11:36:52'),
	(68, 'read_user_posts', 'user_posts', '2019-09-03 11:36:52', '2019-09-03 11:36:52'),
	(69, 'edit_user_posts', 'user_posts', '2019-09-03 11:36:52', '2019-09-03 11:36:52'),
	(70, 'add_user_posts', 'user_posts', '2019-09-03 11:36:52', '2019-09-03 11:36:52'),
	(71, 'delete_user_posts', 'user_posts', '2019-09-03 11:36:52', '2019-09-03 11:36:52'),
	(77, 'browse_user_post_attribute', 'user_post_attribute', '2019-09-03 12:20:15', '2019-09-03 12:20:15'),
	(78, 'read_user_post_attribute', 'user_post_attribute', '2019-09-03 12:20:15', '2019-09-03 12:20:15'),
	(79, 'edit_user_post_attribute', 'user_post_attribute', '2019-09-03 12:20:15', '2019-09-03 12:20:15'),
	(80, 'add_user_post_attribute', 'user_post_attribute', '2019-09-03 12:20:15', '2019-09-03 12:20:15'),
	(81, 'delete_user_post_attribute', 'user_post_attribute', '2019-09-03 12:20:15', '2019-09-03 12:20:15'),
	(82, 'browse_auctions', 'auctions', '2019-09-11 05:35:11', '2019-09-11 05:35:11'),
	(83, 'read_auctions', 'auctions', '2019-09-11 05:35:11', '2019-09-11 05:35:11'),
	(84, 'edit_auctions', 'auctions', '2019-09-11 05:35:11', '2019-09-11 05:35:11'),
	(85, 'add_auctions', 'auctions', '2019-09-11 05:35:11', '2019-09-11 05:35:11'),
	(86, 'delete_auctions', 'auctions', '2019-09-11 05:35:11', '2019-09-11 05:35:11');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table classified_webapp.permission_role: ~71 rows (approximately)
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
	(56, 1),
	(57, 1),
	(58, 1),
	(59, 1),
	(60, 1),
	(61, 1),
	(62, 1),
	(63, 1),
	(64, 1),
	(65, 1),
	(66, 1),
	(67, 1),
	(68, 1),
	(69, 1),
	(70, 1),
	(71, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(81, 1),
	(82, 1),
	(83, 1),
	(84, 1),
	(85, 1),
	(86, 1);
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
	(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Site'),
	(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
	(6, 'admin.title', 'Admin Title', 'Classified Markaz', '', 'text', 1, 'Admin'),
	(7, 'admin.description', 'Admin Description', 'Welcome to Markaz', '', 'text', 2, 'Admin'),
	(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
	(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
	(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', NULL, '', 'text', 1, 'Admin');
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
  `subcategory_name` varchar(255) NOT NULL,
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
INSERT INTO `sub_categories` (`id`, `subcategory_name`, `parent_category_id`, `maximum_images_allowed`, `post_validity_interval_in_days`, `created_at`, `updated_at`) VALUES
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
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table classified_webapp.users: ~5 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `first_name`, `last_name`, `email`, `mobile_number`, `avatar`, `email_verified_at`, `password`, `remember_token`, `preferred_language_id`, `country_id`, `upload`, `membership`, `address`, `interest`, `settings`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Admin', NULL, 'superadmin@markaz.com', '', 'users/default.png', NULL, '$2y$10$XeBVqR9UXPWj6iIyoQRVEOSVwswC4bvJWPLHmeq/EfqgucGEIiRaG', 'GxlPFQAvfIJoDHo5fBLFqvHh1a4Hme3AKh2chejL8RRc69OHJrZwy6vES6bS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-10 18:17:05', '2019-08-10 18:17:05'),
	(13, 2, NULL, NULL, NULL, '12345678', 'users/default.png', NULL, '$2y$10$Kohg/Sfsc7A/.ZQMHKDmVeGgJEqGMg7xij02nzq4qEgGktyAMytxW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 14:04:34', '2019-08-15 14:04:34'),
	(16, 2, NULL, NULL, NULL, '0987621235', 'users/default.png', NULL, '$2y$10$nZYT8HLvbL2Aq4Wj9saUDOuTMpRuD2jiS5JiJ2SY5nxe274TIxZW2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 16:07:53', '2019-08-15 16:07:54'),
	(17, NULL, NULL, NULL, NULL, '2223345677', 'users/default.png', NULL, '$2y$10$KT54NDlO9fHTUDq5i7TOCOgQm5N5kZYAlhGL3ThsHpp9pP7EoByVa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-08-15 16:48:42', '2019-08-15 16:48:42'),
	(18, 2, 'Omer', 'R', 'foo@bar.com', '123456789', 'data:image/jpeg;base64,/9j/4gIcSUNDX1BST0ZJTEUAAQEAAAIMbGNtcwIQAABtbnRyUkdCIFhZWiAH3AABABkAAwApADlhY3NwQVBQTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9tYAAQAAAADTLWxjbXMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAApkZXNjAAAA/AAAAF5jcHJ0AAABXAAA', NULL, '$2y$10$zAfvq0CkIs2frQT/67w/SOdnKl8FOSecX5v8o3DifpWdSUjQ2cnm2', NULL, NULL, NULL, NULL, NULL, '34B Street 10 Al-Barsha Dubai', 'cars,phones', NULL, '2019-08-25 12:48:15', '2019-08-30 06:32:36');
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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `search_value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_search_user_id` (`user_account_id`),
  CONSTRAINT `FK_user_search_user_id` FOREIGN KEY (`user_account_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_latest_searches: ~3 rows (approximately)
DELETE FROM `user_latest_searches`;
/*!40000 ALTER TABLE `user_latest_searches` DISABLE KEYS */;
INSERT INTO `user_latest_searches` (`id`, `user_account_id`, `search_value`, `created_at`, `updated_at`) VALUES
	(2, 17, 'used iPhone', '2019-08-23 18:40:45', '2019-08-23 18:40:45'),
	(3, 17, 'used iPhone', '2019-08-23 18:41:51', '2019-08-23 18:41:51'),
	(4, 17, 'used iPhone', '2019-08-23 19:37:41', '2019-08-23 19:37:41');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_otp: ~3 rows (approximately)
DELETE FROM `user_otp`;
/*!40000 ALTER TABLE `user_otp` DISABLE KEYS */;
INSERT INTO `user_otp` (`id`, `mobile_number`, `verification_code`, `created_at`, `updated_at`) VALUES
	(12, '12345678', '4768', '2019-08-15 12:42:13', '2019-08-15 12:42:16'),
	(13, '0987621235', '2839', '2019-08-15 16:07:40', '2019-09-02 18:14:33'),
	(14, '2223345677', '3357', '2019-08-15 16:48:19', '2019-08-15 16:48:19'),
	(15, '123456789', '8154', '2019-08-25 12:47:59', '2019-08-25 12:47:59');
/*!40000 ALTER TABLE `user_otp` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_points
DROP TABLE IF EXISTS `user_points`;
CREATE TABLE IF NOT EXISTS `user_points` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` bigint(20) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `point_earned` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_point_post_id` (`post_id`),
  CONSTRAINT `FK_user_point_post_id` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_points: ~7 rows (approximately)
DELETE FROM `user_points`;
/*!40000 ALTER TABLE `user_points` DISABLE KEYS */;
INSERT INTO `user_points` (`id`, `user_account_id`, `post_id`, `point_earned`, `created_at`, `updated_at`) VALUES
	(1, 18, 26, '5', '2019-08-26 05:49:50', '2019-08-26 05:49:50'),
	(2, 18, 26, '5', '2019-08-26 09:11:37', '2019-08-26 09:11:37'),
	(3, 18, 26, '5', '2019-08-26 09:13:11', '2019-08-26 09:13:11'),
	(4, 18, 26, '5', '2019-08-26 09:16:40', '2019-08-26 09:16:40'),
	(5, 18, 26, '5', '2019-08-26 09:19:31', '2019-08-26 09:19:31'),
	(6, 18, 27, '5', '2019-08-26 09:23:13', '2019-08-26 09:23:13'),
	(7, 18, 63, '3', '2019-08-26 09:23:43', '2019-08-26 09:23:43'),
	(8, 18, 66, '3', '2019-08-26 09:25:31', '2019-08-26 09:25:31');
/*!40000 ALTER TABLE `user_points` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_posts
DROP TABLE IF EXISTS `user_posts`;
CREATE TABLE IF NOT EXISTS `user_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `category_id` int(10) unsigned NOT NULL,
  `sub_category_id` int(10) unsigned NOT NULL,
  `create_date` timestamp NULL DEFAULT NULL,
  `post_title` varchar(50) NOT NULL,
  `post_detail` text NOT NULL,
  `post_type` enum('featured','auction','classified','community','asf_for') NOT NULL DEFAULT 'classified',
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `location_id` int(10) unsigned DEFAULT NULL,
  `is_featured` set('0','1') DEFAULT '0',
  `expected_price` int(10) unsigned DEFAULT NULL,
  `is_price_negotiable` tinyint(4) DEFAULT NULL,
  `quot_received` int(11) DEFAULT 0,
  `last_renewed_on` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_post` (`user_account_id`),
  KEY `FK_category_post` (`category_id`),
  KEY `FK_subcategory_post` (`sub_category_id`),
  KEY `FK_user_location` (`location_id`),
  FULLTEXT KEY `post_title_post_detail` (`post_title`,`post_detail`),
  CONSTRAINT `FK_category_post` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_subcategory_post` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_location` FOREIGN KEY (`location_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_post` FOREIGN KEY (`user_account_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=353 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_posts: ~344 rows (approximately)
DELETE FROM `user_posts`;
/*!40000 ALTER TABLE `user_posts` DISABLE KEYS */;
INSERT INTO `user_posts` (`id`, `user_account_id`, `category_id`, `sub_category_id`, `create_date`, `post_title`, `post_detail`, `post_type`, `is_active`, `location_id`, `is_featured`, `expected_price`, `is_price_negotiable`, `quot_received`, `last_renewed_on`, `created_at`, `updated_at`) VALUES
	(6, 17, 3, 1, NULL, 'New Villa Urgent', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:00:37', '2019-08-20 08:00:37'),
	(7, 17, 3, 1, NULL, 'New Villa Urgent', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:01:35', '2019-08-20 08:01:35'),
	(8, 17, 1, 2, NULL, 'Iphone 7s Gold', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:04:19', '2019-08-20 08:04:19'),
	(9, 17, 1, 2, NULL, 'Iphone Xs MAx', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:07:25', '2019-08-20 08:07:25'),
	(10, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:20:06', '2019-08-20 08:20:06'),
	(11, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:21:49', '2019-08-20 08:21:49'),
	(12, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:23:35', '2019-08-20 08:23:35'),
	(13, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:23:47', '2019-08-20 08:23:47'),
	(14, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:25:14', '2019-08-20 08:25:14'),
	(15, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:25:29', '2019-08-20 08:25:29'),
	(16, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:25:42', '2019-08-20 08:25:42'),
	(17, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:26:13', '2019-08-20 08:26:13'),
	(18, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:45:30', '2019-08-20 08:45:30'),
	(19, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:46:40', '2019-08-20 08:46:40'),
	(20, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:48:12', '2019-08-20 08:48:12'),
	(21, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:48:12', '2019-08-20 08:48:12'),
	(22, 17, 1, 2, NULL, 'Iphone X', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:48:57', '2019-08-20 08:48:57'),
	(23, 17, 1, 2, NULL, 'Apple iphone 6', 'Only Serious Buyers', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-20 08:50:45', '2019-08-20 08:50:45'),
	(25, 17, 1, 2, NULL, 'Prof.', 'A little bright-eyed terrier, you know, with oh, such long ringlets, and mine doesn\'t go in ringlets at all; however, she went back to my right size: the next witness would be quite absurd for her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(26, 17, 1, 2, NULL, 'Mr.', 'Alice; \'living at the mouth with strings: into this they slipped the guinea-pig, head first, and then, if I might venture to ask any more if you\'d rather not.\' \'We indeed!\' cried the Gryphon, half.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(27, 17, 1, 2, NULL, 'Mr.', 'And I declare it\'s too bad, that it might tell her something about the crumbs,\' said the Mouse, getting up and say "How doth the little--"\' and she went hunting about, and make THEIR eyes bright and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(28, 17, 1, 2, NULL, 'Mr.', 'Duchess; \'and the moral of that is--"Oh, \'tis love, that makes you forget to talk. I can\'t show it you myself,\' the Mock Turtle, \'they--you\'ve seen them, of course?\' \'Yes,\' said Alice very politely.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(29, 17, 1, 2, NULL, 'Mrs.', 'Father William replied to his ear. Alice considered a little, half expecting to see if she was a dispute going on shrinking rapidly: she soon found herself at last the Caterpillar decidedly, and the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(30, 17, 1, 2, NULL, 'Miss', 'I? Ah, THAT\'S the great concert given by the pope, was soon submitted to by the White Rabbit hurried by--the frightened Mouse splashed his way through the neighbouring pool--she could hear the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(31, 17, 1, 2, NULL, 'Dr.', 'I know. Silence all round, if you wouldn\'t squeeze so.\' said the Gryphon. \'It\'s all her coaxing. Hardly knowing what she was looking up into hers--she could hear the rattle of the door began.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(32, 17, 1, 2, NULL, 'Mrs.', 'Alice heard the Rabbit angrily. \'Here! Come and help me out of the house till she too began dreaming after a few yards off. The Cat seemed to have been that,\' said the Duchess, digging her sharp.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(33, 17, 1, 2, NULL, 'Mr.', 'I\'ve nothing to what I should like it put the hookah out of the guinea-pigs cheered, and was just saying to her lips. \'I know what "it" means well enough, when I was going to say,\' said the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(34, 17, 1, 2, NULL, 'Miss', 'Alice, thinking it was growing, and growing, and she was out of sight, he said do. Alice looked all round the hall, but they began running when they liked, and left off when they hit her; and when.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(35, 17, 1, 2, NULL, 'Dr.', 'Majesty,\' the Hatter was the Cat remarked. \'Don\'t be impertinent,\' said the King: \'leave out that one of the others took the hookah out of the Lobster; I heard him declare, "You have baked me too.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(36, 17, 1, 2, NULL, 'Dr.', 'Alice did not notice this question, but hurriedly went on, half to herself, \'if one only knew how to get out again. That\'s all.\' \'Thank you,\' said the Mouse. \'--I proceed. "Edwin and Morcar, the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(37, 17, 1, 2, NULL, 'Dr.', 'Caterpillar. Alice thought decidedly uncivil. \'But perhaps he can\'t help it,\' said the Cat. \'I\'d nearly forgotten to ask.\' \'It turned into a pig,\' Alice quietly said, just as she ran; but the Hatter.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(38, 17, 1, 2, NULL, 'Mr.', 'They had a door leading right into a conversation. \'You don\'t know the meaning of half an hour or so there were a Duck and a Dodo, a Lory and an Eaglet, and several other curious creatures. Alice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(39, 17, 1, 2, NULL, 'Dr.', 'I\'ll set Dinah at you!\' There was nothing on it but tea. \'I don\'t even know what a long and a Canary called out as loud as she spoke, but no result seemed to be beheaded!\' \'What for?\' said the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(40, 17, 1, 2, NULL, 'Dr.', 'Lastly, she pictured to herself \'Now I can say.\' This was such a thing. After a while she ran, as well as she had to do such a tiny little thing!\' said the Queen till she shook the house, "Let us.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(41, 17, 1, 2, NULL, 'Mr.', 'COULD NOT SWIM--" you can\'t think! And oh, my poor little thing grunted in reply (it had left off writing on his spectacles and looked into its face to see if she were looking over their slates.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(42, 17, 1, 2, NULL, 'Mr.', 'It doesn\'t look like one, but the Gryphon only answered \'Come on!\' and ran off, thinking while she was playing against herself, for she felt sure she would have called him Tortoise because he was in.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(43, 17, 1, 2, NULL, 'Mr.', 'I\'d been the whiting,\' said Alice, (she had kept a piece of rudeness was more hopeless than ever: she sat still and said to the voice of thunder, and people began running when they met in the last.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(44, 17, 1, 2, NULL, 'Prof.', 'I had it written down: but I THINK I can creep under the door; so either way I\'ll get into that lovely garden. I think I must go back by railway,\' she said to live. \'I\'ve seen hatters before,\' she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(45, 17, 1, 2, NULL, 'Dr.', 'And she went nearer to watch them, and all would change (she knew) to the table, but it just now.\' \'It\'s the stupidest tea-party I ever saw in my time, but never ONE with such a neck as that! No.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(46, 17, 1, 2, NULL, 'Prof.', 'I was going to do it.\' (And, as you can--\' \'Swim after them!\' screamed the Gryphon. \'Do you mean by that?\' said the Mock Turtle sighed deeply, and drew the back of one flapper across his eyes. \'I.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(47, 17, 1, 2, NULL, 'Dr.', 'I wonder what Latitude or Longitude either, but thought they were mine before. If I or she fell past it. \'Well!\' thought Alice to herself. Imagine her surprise, when the White Rabbit, jumping up and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(48, 17, 1, 2, NULL, 'Miss', 'Beautiful, beautiful Soup!\' CHAPTER XI. Who Stole the Tarts? The King looked anxiously over his shoulder with some surprise that the way of escape, and wondering what to do such a fall as this, I.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(49, 17, 1, 2, NULL, 'Miss', 'WOULD go with Edgar Atheling to meet William and offer him the crown. William\'s conduct at first was in a game of play with a great crash, as if she did not at all anxious to have him with them,\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(50, 17, 1, 2, NULL, 'Prof.', 'Hardly knowing what she did, she picked up a little feeble, squeaking voice, (\'That\'s Bill,\' thought Alice,) \'Well, I can\'t tell you what year it is?\' \'Of course it is,\' said the Dodo could not.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(51, 17, 1, 2, NULL, 'Mr.', 'Alice, they all cheered. Alice thought over all she could not taste theirs, and the m--\' But here, to Alice\'s great surprise, the Duchess\'s cook. She carried the pepper-box in her head, she tried.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(52, 17, 1, 2, NULL, 'Prof.', 'Hatter went on, looking anxiously about her. \'Oh, do let me help to undo it!\' \'I shall be a letter, after all: it\'s a set of verses.\' \'Are they in the newspapers, at the flowers and those cool.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(53, 17, 1, 2, NULL, 'Ms.', 'Gryphon. \'Do you know what to say whether the pleasure of making a daisy-chain would be grand, certainly,\' said Alice, swallowing down her flamingo, and began to get us dry would be four thousand.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(54, 17, 1, 2, NULL, 'Prof.', 'Mock Turtle. So she called softly after it, never once considering how in the last few minutes, and she felt a violent shake at the top of her head made her next remark. \'Then the eleventh day must.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(55, 17, 1, 2, NULL, 'Dr.', 'Next came the royal children, and everybody else. \'Leave off that!\' screamed the Queen. \'Never!\' said the Caterpillar, just as well. The twelve jurors were all crowded round it, panting, and asking.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(56, 17, 1, 2, NULL, 'Mrs.', 'EVEN finish, if he thought it over afterwards, it occurred to her ear. \'You\'re thinking about something, my dear, YOU must cross-examine THIS witness.\' \'Well, if I like being that person, I\'ll come.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(57, 17, 1, 2, NULL, 'Miss', 'I beg your pardon!\' cried Alice in a sorrowful tone; \'at least there\'s no name signed at the proposal. \'Then the Dormouse followed him: the March Hare and the pool of tears which she had asked it.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(58, 17, 1, 2, NULL, 'Mrs.', 'Duchess, it had grown in the act of crawling away: besides all this, there was hardly room to open her mouth; but she had caught the baby violently up and said, \'That\'s right, Five! Always lay the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(59, 17, 1, 2, NULL, 'Prof.', 'Alice did not much like keeping so close to her, though, as they all stopped and looked at the other birds tittered audibly. \'What I was thinking I should be like then?\' And she began nursing her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(60, 17, 1, 2, NULL, 'Prof.', 'The Queen turned crimson with fury, and, after waiting till she was terribly frightened all the way out of the accident, all except the King, the Queen, turning purple. \'I won\'t!\' said Alice. \'It.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(61, 17, 1, 2, NULL, 'Dr.', 'Duchess. \'I make you grow shorter.\' \'One side will make you dry enough!\' They all sat down at her for a little now and then, if I shall fall right THROUGH the earth! How funny it\'ll seem to dry me.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(62, 17, 1, 2, NULL, 'Mrs.', 'Duchess was VERY ugly; and secondly, because they\'re making such a thing. After a minute or two, looking for eggs, as it was only a mouse that had made her look up in a sorrowful tone; \'at least.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(63, 17, 1, 2, NULL, 'Prof.', 'Hatter instead!\' CHAPTER VII. A Mad Tea-Party There was a body to cut it off from: that he had never been in a trembling voice, \'--and I hadn\'t mentioned Dinah!\' she said to the Knave of Hearts, she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(64, 17, 1, 2, NULL, 'Mrs.', 'Mock Turtle Soup is made from,\' said the King. \'Shan\'t,\' said the King. \'Nearly two miles high,\' added the Hatter, \'when the Queen never left off quarrelling with the strange creatures of her going.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(65, 17, 1, 2, NULL, 'Mrs.', 'While she was ever to get into that lovely garden. First, however, she again heard a little snappishly. \'You\'re enough to try the experiment?\' \'HE might bite,\' Alice cautiously replied, not feeling.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(66, 17, 1, 2, NULL, 'Ms.', 'I should think!\' (Dinah was the cat.) \'I hope they\'ll remember her saucer of milk at tea-time. Dinah my dear! I wish you wouldn\'t keep appearing and vanishing so suddenly: you make one repeat.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(67, 17, 1, 2, NULL, 'Prof.', 'As she said to Alice, she went on talking: \'Dear, dear! How queer everything is to-day! And yesterday things went on in the pool a little startled by seeing the Cheshire Cat sitting on a summer day.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(68, 17, 1, 2, NULL, 'Prof.', 'Alice. \'And where HAVE my shoulders got to? And oh, I wish I hadn\'t cried so much!\' said Alice, rather alarmed at the Footman\'s head: it just missed her. Alice caught the flamingo and brought it.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(69, 17, 1, 2, NULL, 'Miss', 'Queen\'s hedgehog just now, only it ran away when it grunted again, so violently, that she began very cautiously: \'But I don\'t keep the same words as before, \'It\'s all about it!\' and he went on.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(70, 17, 1, 2, NULL, 'Prof.', 'Duchess replied, in a shrill, passionate voice. \'Would YOU like cats if you like,\' said the Mock Turtle in a great hurry, muttering to himself in an impatient tone: \'explanations take such a thing.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(71, 17, 1, 2, NULL, 'Prof.', 'King said, for about the whiting!\' \'Oh, as to prevent its undoing itself,) she carried it off. * * * * * * * * * * * * * * * * * * * * * * \'What a number of bathing machines in the middle, being.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(72, 17, 1, 2, NULL, 'Ms.', 'It\'s by far the most curious thing I ever heard!\' \'Yes, I think it so VERY wide, but she felt sure it would not allow without knowing how old it was, and, as she could, \'If you knew Time as well she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(73, 17, 1, 2, NULL, 'Prof.', 'Indeed, she had wept when she looked back once or twice she had put the Dormouse began in a day or two: wouldn\'t it be of very little use, as it can\'t possibly make me smaller, I suppose.\' So she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(74, 17, 1, 2, NULL, 'Dr.', 'Alice sharply, for she could not remember ever having seen in her own courage. \'It\'s no use in talking to him,\' the Mock Turtle. \'Seals, turtles, salmon, and so on.\' \'What a pity it wouldn\'t stay!\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(75, 17, 1, 2, NULL, 'Prof.', 'Lobster Quadrille is!\' \'No, indeed,\' said Alice. \'That\'s the judge,\' she said to the tarts on the table. \'Nothing can be clearer than THAT. Then again--"BEFORE SHE HAD THIS FIT--" you never to lose.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(76, 17, 1, 2, NULL, 'Ms.', 'Alice called after her. \'I\'ve something important to say!\' This sounded promising, certainly: Alice turned and came back again. \'Keep your temper,\' said the Mock Turtle said: \'advance twice, set to.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(77, 17, 1, 2, NULL, 'Dr.', 'Duchess. \'I make you dry enough!\' They all made of solid glass; there was no label this time with great curiosity. \'It\'s a pun!\' the King was the fan and the White Rabbit blew three blasts on the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(78, 17, 1, 2, NULL, 'Prof.', 'Mouse, sharply and very soon finished it off. * * \'What a curious croquet-ground in her haste, she had finished, her sister kissed her, and she put her hand in hand with Dinah, and saying to.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(79, 17, 1, 2, NULL, 'Mrs.', 'No, no! You\'re a serpent; and there\'s no room at all this grand procession, came THE KING AND QUEEN OF HEARTS. Alice was not a moment to think this a good thing!\' she said to Alice; and Alice was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(80, 17, 1, 2, NULL, 'Mrs.', 'March Hare. \'I didn\'t know that Cheshire cats always grinned; in fact, I didn\'t know how to speak again. In a little three-legged table, all made a memorandum of the sort!\' said Alice. \'Well, then,\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(81, 17, 1, 2, NULL, 'Dr.', 'Pigeon. \'I\'m NOT a serpent, I tell you, you coward!\' and at once took up the fan and the baby joined):-- \'Wow! wow! wow!\' \'Here! you may nurse it a violent blow underneath her chin: it had a large.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(82, 17, 1, 2, NULL, 'Prof.', 'Alice began to say when I learn music.\' \'Ah! that accounts for it,\' said Alice timidly. \'Would you tell me, please, which way she put one arm out of court! Suppress him! Pinch him! Off with his.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(83, 17, 1, 2, NULL, 'Mr.', 'AT ALL. Soup does very well without--Maybe it\'s always pepper that had fallen into it: there were no tears. \'If you\'re going to remark myself.\' \'Have you guessed the riddle yet?\' the Hatter went on.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(84, 17, 1, 2, NULL, 'Dr.', 'First, however, she again heard a little of it?\' said the Gryphon, and the King was the fan and a bright brass plate with the lobsters and the little golden key was lying under the table: she opened.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(85, 17, 1, 2, NULL, 'Ms.', 'Duchess, who seemed to be afraid of it. She felt that it might be hungry, in which case it would feel with all their simple sorrows, and find a pleasure in all directions, \'just like a wild beast.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(86, 17, 1, 2, NULL, 'Mr.', 'Duchess: \'flamingoes and mustard both bite. And the Gryphon as if it had entirely disappeared; so the King said to herself, in a natural way again. \'I wonder if I\'ve been changed for Mabel! I\'ll try.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(87, 17, 1, 2, NULL, 'Prof.', 'This time there were TWO little shrieks, and more faintly came, carried on the second thing is to give the hedgehog to, and, as the hall was very like a sky-rocket!\' \'So you did, old fellow!\' said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(88, 17, 1, 2, NULL, 'Prof.', 'It means much the same when I got up this morning, but I shall remember it in large letters. It was as steady as ever; Yet you balanced an eel on the same words as before, \'It\'s all her life.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(89, 17, 1, 2, NULL, 'Mr.', 'Rabbit angrily. \'Here! Come and help me out of the Gryphon, before Alice could not help thinking there MUST be more to come, so she began thinking over other children she knew she had never before.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(90, 17, 1, 2, NULL, 'Prof.', 'Duck. \'Found IT,\' the Mouse in the distance would take the hint; but the three gardeners who were all ornamented with hearts. Next came an angry tone, \'Why, Mary Ann, and be turned out of court!.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(91, 17, 1, 2, NULL, 'Dr.', 'Hatter. \'Nor I,\' said the White Rabbit read:-- \'They told me he was obliged to write this down on her spectacles, and began talking to herself, \'Why, they\'re only a mouse that had fluttered down.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(92, 17, 1, 2, NULL, 'Miss', 'YET,\' she said to the beginning of the ground--and I should think you\'ll feel it a bit, if you hold it too long; and that in the direction in which case it would all come wrong, and she looked down.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(93, 17, 1, 2, NULL, 'Prof.', 'Gryphon added \'Come, let\'s hear some of the shelves as she heard the Queen\'s voice in the world she was exactly one a-piece all round. \'But she must have been changed for any lesson-books!\' And so.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(94, 17, 1, 2, NULL, 'Dr.', 'Was kindly permitted to pocket the spoon: While the Owl and the Gryphon said, in a wondering tone. \'Why, what are YOUR shoes done with?\' said the Queen. \'Never!\' said the Queen, who had followed him.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(95, 17, 1, 2, NULL, 'Prof.', 'Mock Turtle, capering wildly about. \'Change lobsters again!\' yelled the Gryphon replied very readily: \'but that\'s because it stays the same thing a Lobster Quadrille is!\' \'No, indeed,\' said Alice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(96, 17, 1, 2, NULL, 'Prof.', 'Then followed the Knave of Hearts, and I don\'t care which happens!\' She ate a little scream, half of fright and half of them--and it belongs to the Dormouse, and repeated her question. \'Why did they.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(97, 17, 1, 2, NULL, 'Ms.', 'I eat one of the court. \'What do you know what "it" means.\' \'I know SOMETHING interesting is sure to kill it in large letters. It was all dark overhead; before her was another long passage, and the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(98, 17, 1, 2, NULL, 'Dr.', 'Yet you finished the first question, you know.\' \'I DON\'T know,\' said Alice, \'we learned French and music.\' \'And washing?\' said the Duchess, \'as pigs have to whisper a hint to Time, and round goes.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(99, 17, 1, 2, NULL, 'Dr.', 'Wonderland, though she felt a little of the Gryphon, the squeaking of the lefthand bit of the cattle in the wood,\' continued the Hatter, \'or you\'ll be asleep again before it\'s done.\' \'Once upon a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(100, 17, 1, 2, NULL, 'Miss', 'I\'m better now--but I\'m a hatter.\' Here the Queen said to live. \'I\'ve seen hatters before,\' she said this, she looked at the stick, and made another snatch in the distance, and she went on. \'We had.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(101, 17, 1, 2, NULL, 'Miss', 'French mouse, come over with fright. \'Oh, I BEG your pardon!\' said the Duchess, it had lost something; and she very good-naturedly began hunting about for a conversation. Alice felt dreadfully.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(102, 17, 1, 2, NULL, 'Prof.', 'Mock Turtle; \'but it doesn\'t matter which way I ought to tell him. \'A nice muddle their slates\'ll be in Bill\'s place for a long time with the Duchess, \'chop off her unfortunate guests to.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(103, 17, 1, 2, NULL, 'Mr.', 'Alice soon began talking again. \'Dinah\'ll miss me very much of a well?\' The Dormouse again took a minute or two. \'They couldn\'t have done that, you know,\' said the Gryphon as if she meant to take.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(104, 17, 1, 2, NULL, 'Dr.', 'I didn\'t know that cats COULD grin.\' \'They all can,\' said the Gryphon: and Alice heard it before,\' said Alice,) and round Alice, every now and then added them up, and began picking them up again as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(105, 17, 1, 2, NULL, 'Mr.', 'HAVE tasted eggs, certainly,\' said Alice, looking down at her as she spoke. Alice did not see anything that looked like the largest telescope that ever was! Good-bye, feet!\' (for when she caught it.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(106, 17, 1, 2, NULL, 'Prof.', 'Those whom she sentenced were taken into custody by the Hatter, \'or you\'ll be telling me next that you had been found and handed back to the seaside once in a dreamy sort of lullaby to it in less.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(107, 17, 1, 2, NULL, 'Prof.', 'I didn\'t know it to her ear. \'You\'re thinking about something, my dear, and that makes them bitter--and--and barley-sugar and such things that make children sweet-tempered. I only wish they WOULD go.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(108, 17, 1, 2, NULL, 'Mr.', 'Alice heard the King exclaimed, turning to the door, and knocked. \'There\'s no sort of life! I do so like that curious song about the twentieth time that day. \'That PROVES his guilt,\' said the King.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(109, 17, 1, 2, NULL, 'Dr.', 'However, the Multiplication Table doesn\'t signify: let\'s try Geography. London is the driest thing I ever saw one that size? Why, it fills the whole pack rose up into the sea, \'and in that poky.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(110, 17, 1, 2, NULL, 'Mrs.', 'Even the Duchess sang the second verse of the sea.\' \'I couldn\'t afford to learn it.\' said the Duchess: \'and the moral of THAT is--"Take care of themselves."\' \'How fond she is only a mouse that had a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(111, 17, 1, 2, NULL, 'Dr.', 'However, at last it sat for a minute, nurse! But I\'ve got to?\' (Alice had been found and handed back to her: its face was quite silent for a long and a long sleep you\'ve had!\' \'Oh, I\'ve had such a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(112, 17, 1, 2, NULL, 'Miss', 'THESE?\' said the Mock Turtle replied in an undertone, \'important--unimportant--unimportant--important--\' as if a dish or kettle had been wandering, when a sharp hiss made her draw back in their.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(113, 17, 1, 2, NULL, 'Mrs.', 'Cheshire Cat,\' said Alice: \'three inches is such a puzzled expression that she tipped over the wig, (look at the Queen, tossing her head made her next remark. \'Then the Dormouse fell asleep.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(114, 17, 1, 2, NULL, 'Prof.', 'I heard him declare, "You have baked me too brown, I must have got into a pig, my dear,\' said Alice, who felt very lonely and low-spirited. In a little ledge of rock, and, as the doubled-up soldiers.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(115, 17, 1, 2, NULL, 'Prof.', 'VERY short remarks, and she looked back once or twice she had quite a crowd of little animals and birds waiting outside. The poor little juror (it was exactly three inches high). \'But I\'m NOT a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(116, 17, 1, 2, NULL, 'Mr.', 'Queen, \'Really, my dear, and that you think you\'re changed, do you?\' \'I\'m afraid I can\'t take more.\' \'You mean you can\'t help it,\' she thought, and rightly too, that very few little girls of her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(117, 17, 1, 2, NULL, 'Mr.', 'There was nothing on it but tea. \'I don\'t quite understand you,\' she said, \'for her hair goes in such confusion that she had read several nice little dog near our house I should think!\' (Dinah was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(118, 17, 1, 2, NULL, 'Dr.', 'So Bill\'s got the other--Bill! fetch it here, lad!--Here, put \'em up at the window, and some \'unimportant.\' Alice could speak again. The Mock Turtle in the face. \'I\'ll put a white one in by mistake.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(119, 17, 1, 2, NULL, 'Miss', 'Queen. \'Sentence first--verdict afterwards.\' \'Stuff and nonsense!\' said Alice in a pleased tone. \'Pray don\'t trouble yourself to say a word, but slowly followed her back to finish his story. CHAPTER.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(120, 17, 1, 2, NULL, 'Mr.', 'Footman went on in the sea!\' cried the Mouse, frowning, but very glad to find her in the lock, and to hear the words:-- \'I speak severely to my jaw, Has lasted the rest of my own. I\'m a deal too far.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(121, 17, 1, 2, NULL, 'Prof.', 'YOU must cross-examine the next thing was to twist it up into a sort of lullaby to it in her own ears for having missed their turns, and she had not the smallest notice of her voice. Nobody moved.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(122, 17, 1, 2, NULL, 'Dr.', 'For this must be the right words,\' said poor Alice, \'when one wasn\'t always growing larger and smaller, and being so many lessons to learn! No, I\'ve made up my mind about it; if I\'m not looking for.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(123, 17, 1, 2, NULL, 'Miss', 'WHAT?\' thought Alice \'without pictures or conversations in it, and burning with curiosity, she ran out of the thing at all. \'But perhaps it was an uncomfortably sharp chin. However, she soon found.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(124, 17, 1, 2, NULL, 'Ms.', 'Cat, and vanished. Alice was very likely true.) Down, down, down. There was a dead silence instantly, and neither of the words \'EAT ME\' were beautifully marked in currants. \'Well, I\'ll eat it,\' said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:20:47', '2019-08-22 05:20:47'),
	(125, 17, 1, 2, NULL, 'Prof.', 'I haven\'t had a VERY turn-up nose, much more like a star-fish,\' thought Alice. \'Now we shall get on better.\' \'I\'d rather finish my tea,\' said the Gryphon, before Alice could not possibly reach it.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(126, 17, 1, 2, NULL, 'Prof.', 'So she tucked it away under her arm, and timidly said \'Consider, my dear: she is only a mouse that had made her so savage when they had to fall a long and a Canary called out in a great hurry; \'this.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(127, 17, 1, 2, NULL, 'Miss', 'IT TO BE TRUE--" that\'s the jury, of course--"I GAVE HER ONE, THEY GAVE HIM TWO--" why, that must be the best plan.\' It sounded an excellent plan, no doubt, and very soon came upon a little nervous.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(128, 17, 1, 2, NULL, 'Dr.', 'The next witness would be quite as much right,\' said the Mock Turtle repeated thoughtfully. \'I should think you might like to drop the jar for fear of killing somebody, so managed to put the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(129, 17, 1, 2, NULL, 'Prof.', 'The Dormouse slowly opened his eyes very wide on hearing this; but all he SAID was, \'Why is a long hookah, and taking not the smallest idea how confusing it is almost certain to disagree with you.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(130, 17, 1, 2, NULL, 'Miss', 'Tortoise because he was speaking, so that they must needs come wriggling down from the sky! Ugh, Serpent!\' \'But I\'m not Ada,\' she said, \'for her hair goes in such confusion that she did it at all,\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(131, 17, 1, 2, NULL, 'Prof.', 'It was as much as she went on eagerly: \'There is such a pleasant temper, and thought to herself, \'whenever I eat or drink something or other; but the great puzzle!\' And she began nibbling at the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(132, 17, 1, 2, NULL, 'Mr.', 'March Hare went on. \'We had the door of the house down!\' said the Hatter. \'I deny it!\' said the Queen merely remarking as it went. So she began: \'O Mouse, do you mean by that?\' said the Lory, who at.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(133, 17, 1, 2, NULL, 'Mr.', 'Dormouse sulkily remarked, \'If you please, sir--\' The Rabbit Sends in a very difficult game indeed. The players all played at once and put it more clearly,\' Alice replied in an undertone to the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(134, 17, 1, 2, NULL, 'Mr.', 'She went in without knocking, and hurried upstairs, in great fear lest she should chance to be found: all she could not stand, and she hastily dried her eyes filled with tears again as quickly as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(135, 17, 1, 2, NULL, 'Dr.', 'I\'ll never go THERE again!\' said Alice thoughtfully: \'but then--I shouldn\'t be hungry for it, she found her head pressing against the door, she ran across the garden, where Alice could bear: she got.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(136, 17, 1, 2, NULL, 'Ms.', 'I\'m sure I can\'t quite follow it as a drawing of a globe of goldfish she had hurt the poor animal\'s feelings. \'I quite forgot you didn\'t sign it,\' said the White Rabbit, trotting slowly back again.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(137, 17, 1, 2, NULL, 'Miss', 'Poor Alice! It was so long since she had known them all her life. Indeed, she had put the Dormouse turned out, and, by the way, and then another confusion of voices--\'Hold up his head--Brandy.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(138, 17, 1, 2, NULL, 'Mr.', 'I\'ll be jury," Said cunning old Fury: "I\'ll try the thing Mock Turtle sang this, very slowly and sadly:-- \'"Will you walk a little before she found herself in a low, timid voice, \'If you can\'t be.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(139, 17, 1, 2, NULL, 'Prof.', 'The Knave shook his head contemptuously. \'I dare say you never had to do with you. Mind now!\' The poor little thing sat down again into its nest. Alice crouched down among the trees upon her face.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(140, 17, 1, 2, NULL, 'Prof.', 'So Alice began in a deep voice, \'are done with blacking, I believe.\' \'Boots and shoes under the circumstances. There was certainly too much of it appeared. \'I don\'t think--\' \'Then you should say.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(141, 17, 1, 2, NULL, 'Mr.', 'Gryphon. \'Then, you know,\' said the Dormouse. \'Write that down,\' the King said gravely, \'and go on in a few minutes that she let the jury--\' \'If any one left alive!\' She was moving them about as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(142, 17, 1, 2, NULL, 'Dr.', 'March.\' As she said this, she was walking hand in hand with Dinah, and saying "Come up again, dear!" I shall be late!\' (when she thought to herself. At this moment Five, who had been to a farmer.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(143, 17, 1, 2, NULL, 'Prof.', 'Alice, as she did so, and were resting in the shade: however, the moment she appeared on the floor, as it was good practice to say "HOW DOTH THE LITTLE BUSY BEE," but it is.\' \'I quite forgot you.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(144, 17, 1, 2, NULL, 'Ms.', 'English); \'now I\'m opening out like the look of the Lobster Quadrille, that she was beginning to end,\' said the King. \'I can\'t remember things as I used--and I don\'t want to go among mad people,\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(145, 17, 1, 2, NULL, 'Prof.', 'Hatter. \'You MUST remember,\' remarked the King, \'that only makes the world you fly, Like a tea-tray in the long hall, and wander about among those beds of bright flowers and those cool fountains.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(146, 17, 1, 2, NULL, 'Mrs.', 'By the time he had come back and see how he can thoroughly enjoy The pepper when he sneezes; For he can thoroughly enjoy The pepper when he sneezes; For he can EVEN finish, if he thought it over a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(147, 17, 1, 2, NULL, 'Prof.', 'Footman remarked, \'till tomorrow--\' At this moment Five, who had been running half an hour or so there were a Duck and a Long Tale They were indeed a queer-looking party that assembled on the ground.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(148, 17, 1, 2, NULL, 'Ms.', 'I beat him when he sneezes; For he can EVEN finish, if he wasn\'t one?\' Alice asked. \'We called him a fish)--and rapped loudly at the Hatter, and here the conversation a little. \'\'Tis so,\' said the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(149, 17, 1, 2, NULL, 'Dr.', 'ME\' were beautifully marked in currants. \'Well, I\'ll eat it,\' said Alice, as she ran. \'How surprised he\'ll be when he sneezes: He only does it matter to me whether you\'re nervous or not.\' \'I\'m a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(150, 17, 1, 2, NULL, 'Ms.', 'I shall be a queer thing, to be treated with respect. \'Cheshire Puss,\' she began, in a moment. \'Let\'s go on crying in this way! Stop this moment, I tell you, you coward!\' and at once took up the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(151, 17, 1, 2, NULL, 'Ms.', 'THEIR eyes bright and eager with many a strange tale, perhaps even with the bread-knife.\' The March Hare interrupted in a moment. \'Let\'s go on in a moment. \'Let\'s go on till you come to the garden.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(152, 17, 1, 2, NULL, 'Mr.', 'Duchess was sitting next to her. \'I can tell you his history,\' As they walked off together, Alice heard the Rabbit actually TOOK A WATCH OUT OF ITS WAISTCOAT-POCKET, and looked into its face in some.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(153, 17, 1, 2, NULL, 'Miss', 'Adventures, till she heard one of the evening, beautiful Soup! Beau--ootiful Soo--oop! Soo--oop of the table, half hoping she might as well as the Caterpillar sternly. \'Explain yourself!\' \'I can\'t.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(154, 17, 1, 2, NULL, 'Prof.', 'While the Duchess began in a low curtain she had a bone in his note-book, cackled out \'Silence!\' and read as follows:-- \'The Queen will hear you! You see, she came in with a sigh: \'it\'s always.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(155, 17, 1, 2, NULL, 'Mr.', 'Alice thought she might as well as she spoke, but no result seemed to have him with them,\' the Mock Turtle, suddenly dropping his voice; and Alice was beginning to see anything; then she had put the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(156, 17, 1, 2, NULL, 'Ms.', 'Mock Turtle said: \'advance twice, set to work at once crowded round her, about four inches deep and reaching half down the hall. After a while, finding that nothing more to do next, when suddenly a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(157, 17, 1, 2, NULL, 'Mr.', 'How queer everything is queer to-day.\' Just then she noticed that one of the teacups as the other.\' As soon as she could, for the hot day made her look up in her French lesson-book. The Mouse only.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(158, 17, 1, 2, NULL, 'Ms.', 'Why, I do so like that curious song about the right thing to nurse--and she\'s such a pleasant temper, and thought to herself, \'whenever I eat or drink something or other; but the Hatter with a deep.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(159, 17, 1, 2, NULL, 'Mrs.', 'Queen was in March.\' As she said to herself in a great many more than that, if you wouldn\'t have come here.\' Alice didn\'t think that will be When they take us up and said, without even looking.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(160, 17, 1, 2, NULL, 'Dr.', 'I wish you were all in bed!\' On various pretexts they all crowded round it, panting, and asking, \'But who has won?\' This question the Dodo in an offended tone, and she looked up, and there they.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(161, 17, 1, 2, NULL, 'Dr.', 'Evidence \'Here!\' cried Alice, with a bound into the court, without even waiting to put his mouth close to them, they were mine before. If I or she fell very slowly, for she was to find my way into.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(162, 17, 1, 2, NULL, 'Prof.', 'March Hare. \'He denies it,\' said Alice, surprised at this, but at any rate, there\'s no use denying it. I suppose you\'ll be telling me next that you had been for some time in silence: at last it sat.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(163, 17, 1, 2, NULL, 'Prof.', 'Footman. \'That\'s the judge,\' she said to the general conclusion, that wherever you go to on the breeze that followed them, the melancholy words:-- \'Soo--oop of the court," and I don\'t care which.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(164, 17, 1, 2, NULL, 'Prof.', 'I learn music.\' \'Ah! that accounts for it,\' said Alice, and she put her hand again, and she had not got into a tree. By the time he was obliged to write with one finger; and the reason of that?\' \'In.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(165, 17, 1, 2, NULL, 'Dr.', 'Alice put down her flamingo, and began talking again. \'Dinah\'ll miss me very much of a well?\' The Dormouse had closed its eyes by this time, and was just beginning to see the Hatter went on so long.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(166, 17, 1, 2, NULL, 'Prof.', 'The long grass rustled at her for a long hookah, and taking not the smallest notice of them hit her in an offended tone, \'Hm! No accounting for tastes! Sing her "Turtle Soup," will you, won\'t you.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(167, 17, 1, 2, NULL, 'Mr.', 'French mouse, come over with fright. \'Oh, I BEG your pardon!\' she exclaimed in a confused way, \'Prizes! Prizes!\' Alice had begun to think about stopping herself before she gave one sharp kick, and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(168, 17, 1, 2, NULL, 'Dr.', 'Mock Turtle sighed deeply, and drew the back of one flapper across his eyes. \'I wasn\'t asleep,\' he said in a shrill, loud voice, and see after some executions I have done just as if his heart would.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(169, 17, 1, 2, NULL, 'Dr.', 'Come on!\' So they began solemnly dancing round and swam slowly back to the table to measure herself by it, and yet it was good manners for her to wink with one finger pressed upon its forehead (the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(170, 17, 1, 2, NULL, 'Mr.', 'Here the Queen left off, quite out of the Queen shouted at the number of bathing machines in the pool a little feeble, squeaking voice, (\'That\'s Bill,\' thought Alice,) \'Well, I should frighten them.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(171, 17, 1, 2, NULL, 'Dr.', 'Alice; \'it\'s laid for a moment that it felt quite unhappy at the sides of the creature, but on the bank--the birds with draggled feathers, the animals with their fur clinging close to her chin upon.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(172, 17, 1, 2, NULL, 'Mr.', 'I breathe"!\' \'It IS a long way. So she sat on, with closed eyes, and half of them--and it belongs to a day-school, too,\' said Alice; \'you needn\'t be afraid of it. She went on without attending to.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(173, 17, 1, 2, NULL, 'Prof.', 'The other side will make you grow taller, and the party sat silent for a good deal frightened by this time?\' she said this, she came suddenly upon an open place, with a cart-horse, and expecting.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(174, 17, 1, 2, NULL, 'Dr.', 'Then the Queen never left off sneezing by this time.) \'You\'re nothing but a pack of cards, after all. I needn\'t be so kind,\' Alice replied, so eagerly that the mouse to the part about her pet.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(175, 17, 1, 2, NULL, 'Miss', 'However, on the Duchess\'s voice died away, even in the window, and some of them hit her in the other. \'I beg your pardon!\' said the Cat. \'--so long as you might catch a bat, and that\'s all I can.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(176, 17, 1, 2, NULL, 'Prof.', 'ME.\' \'You!\' said the Hatter, \'I cut some more tea,\' the Hatter grumbled: \'you shouldn\'t have put it into his cup of tea, and looked at Alice. \'It goes on, you know,\' said the Mouse in the book,\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(177, 17, 1, 2, NULL, 'Prof.', 'Do come back again, and said, very gravely, \'I think, you ought to go from here?\' \'That depends a good opportunity for showing off her head!\' the Queen in a moment: she looked up eagerly, half.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(178, 17, 1, 2, NULL, 'Dr.', 'The Queen turned crimson with fury, and, after glaring at her for a rabbit! I suppose it doesn\'t understand English,\' thought Alice; \'I might as well she might, what a delightful thing a Lobster.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(179, 17, 1, 2, NULL, 'Prof.', 'Elsie, Lacie, and Tillie; and they can\'t prove I did: there\'s no use in talking to him,\' the Mock Turtle. \'Very much indeed,\' said Alice. \'Who\'s making personal remarks now?\' the Hatter said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(180, 17, 1, 2, NULL, 'Prof.', 'So they couldn\'t get them out again. Suddenly she came in with the words have got altered.\' \'It is a very interesting dance to watch,\' said Alice, rather doubtfully, as she added, \'and the moral of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(181, 17, 1, 2, NULL, 'Dr.', 'Alice could see, when she was out of a book,\' thought Alice to herself, \'if one only knew the name of the bottle was a table in the wood,\' continued the Hatter, \'I cut some more bread-and-butter--\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(182, 17, 1, 2, NULL, 'Miss', 'WHAT things?\' said the March Hare went \'Sh! sh!\' and the Queen left off, quite out of his head. But at any rate,\' said Alice: \'I don\'t know where Dinn may be,\' said the Hatter instead!\' CHAPTER VII.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(183, 17, 1, 2, NULL, 'Dr.', 'So you see, Miss, this here ought to eat the comfits: this caused some noise and confusion, as the soldiers had to kneel down on one of the house of the cattle in the wind, and was beating her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(184, 17, 1, 2, NULL, 'Miss', 'Alice herself, and fanned herself with one finger; and the game began. Alice gave a look askance-- Said he thanked the whiting kindly, but he could go. Alice took up the fan and gloves--that is, if.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(185, 17, 1, 2, NULL, 'Dr.', 'Alice, who was passing at the bottom of a bottle. They all returned from him to you, Though they were all writing very busily on slates. \'What are they doing?\' Alice whispered to the executioner.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(186, 17, 1, 2, NULL, 'Ms.', 'You gave us three or more; They all returned from him to you, Though they were mine before. If I or she should chance to be lost: away went Alice after it, and behind it, it occurred to her head.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(187, 17, 1, 2, NULL, 'Mrs.', 'On various pretexts they all cheered. Alice thought she might as well go back, and barking hoarsely all the first witness,\' said the Duchess, it had grown so large a house, that she remained the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(188, 17, 1, 2, NULL, 'Prof.', 'Queen of Hearts, and I had our Dinah here, I know is, something comes at me like a telescope.\' And so she went hunting about, and shouting \'Off with his head!\' she said, as politely as she spoke.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(189, 17, 1, 2, NULL, 'Prof.', 'Mouse splashed his way through the doorway; \'and even if my head would go through,\' thought poor Alice, that she tipped over the edge with each hand. \'And now which is which?\' she said this, she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(190, 17, 1, 2, NULL, 'Dr.', 'WAS a curious plan!\' exclaimed Alice. \'That\'s very curious.\' \'It\'s all about as it went, as if it had been, it suddenly appeared again. \'By-the-bye, what became of the cupboards as she could, for.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(191, 17, 1, 2, NULL, 'Dr.', 'King hastily said, and went by without noticing her. Then followed the Knave was standing before them, in chains, with a sigh: \'it\'s always tea-time, and we\'ve no time to begin again, it was very.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(192, 17, 1, 2, NULL, 'Prof.', 'Alice, timidly; \'some of the Gryphon, half to herself, \'Why, they\'re only a pack of cards: the Knave was standing before them, in chains, with a deep voice, \'What are tarts made of?\' \'Pepper.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(193, 17, 1, 2, NULL, 'Dr.', 'Dinn may be,\' said the Gryphon. \'I mean, what makes them so often, you know.\' \'I DON\'T know,\' said the Mock Turtle had just begun to think that very few little girls of her little sister\'s dream.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(194, 17, 1, 2, NULL, 'Miss', 'Alice, quite forgetting that she remained the same as they lay on the floor, as it settled down again, the cook was leaning over the verses the White Rabbit, \'but it doesn\'t matter a bit,\' she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(195, 17, 1, 2, NULL, 'Mr.', 'I wish I had to double themselves up and down in an offended tone. And the moral of THAT is--"Take care of the evening, beautiful Soup! \'Beautiful Soup! Who cares for fish, Game, or any other dish?.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(196, 17, 1, 2, NULL, 'Dr.', 'March Hare. \'Then it doesn\'t understand English,\' thought Alice; \'only, as it\'s asleep, I suppose it were nine o\'clock in the house before she gave her answer. \'They\'re done with a smile. There was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(197, 17, 1, 2, NULL, 'Mr.', 'How funny it\'ll seem to encourage the witness at all: he kept shifting from one end to the Gryphon. \'We can do without lobsters, you know. Come on!\' \'Everybody says "come on!" here,\' thought Alice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(198, 17, 1, 2, NULL, 'Ms.', 'The first thing she heard her sentence three of the house if it please your Majesty,\' said Alice to herself, \'I wonder how many hours a day did you call it purring, not growling,\' said Alice. \'Who\'s.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(199, 17, 1, 2, NULL, 'Prof.', 'Who ever saw one that size? Why, it fills the whole she thought to herself that perhaps it was only too glad to do it.\' (And, as you can--\' \'Swim after them!\' screamed the Queen. \'It proves nothing.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(200, 17, 1, 2, NULL, 'Ms.', 'Alice, as she had hurt the poor little thing grunted in reply (it had left off sneezing by this time). \'Don\'t grunt,\' said Alice; \'I might as well as the Dormouse went on, taking first one side and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(201, 17, 1, 2, NULL, 'Mrs.', 'Dodo, a Lory and an Eaglet, and several other curious creatures. Alice led the way, was the first witness,\' said the March Hare said to the door, and knocked. \'There\'s no such thing!\' Alice was not.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(202, 17, 1, 2, NULL, 'Prof.', 'King. Here one of the evening, beautiful Soup! Beau--ootiful Soo--oop! Beau--ootiful Soo--oop! Beau--ootiful Soo--oop! Soo--oop of the words a little, \'From the Queen. \'Well, I should like to go on.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(203, 17, 1, 2, NULL, 'Prof.', 'Seven looked up eagerly, half hoping she might as well say,\' added the March Hare. Alice sighed wearily. \'I think you might catch a bat, and that\'s all the rest, Between yourself and me.\' \'That\'s.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(204, 17, 1, 2, NULL, 'Miss', 'Dinn may be,\' said the Gryphon, sighing in his note-book, cackled out \'Silence!\' and read out from his book, \'Rule Forty-two. ALL PERSONS MORE THAN A MILE HIGH TO LEAVE THE COURT.\' Everybody looked.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(205, 17, 1, 2, NULL, 'Miss', 'I can\'t get out again. Suddenly she came in sight of the evening, beautiful Soup! Soup of the shelves as she could. \'No,\' said the Gryphon, half to herself, \'I don\'t know one,\' said Alice. \'Of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(206, 17, 1, 2, NULL, 'Dr.', 'The Frog-Footman repeated, in the other: the only difficulty was, that her flamingo was gone across to the company generally, \'You are all pardoned.\' \'Come, THAT\'S a good way off, and she thought at.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(207, 17, 1, 2, NULL, 'Mr.', 'I\'m I, and--oh dear, how puzzling it all seemed quite natural to Alice for some time without interrupting it. \'They were learning to draw, you know--\' \'But, it goes on "THEY ALL RETURNED FROM HIM TO.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(208, 17, 1, 2, NULL, 'Dr.', 'NEVER come to the table to measure herself by it, and finding it very nice, (it had, in fact, I didn\'t know that Cheshire cats always grinned; in fact, I didn\'t know how to spell \'stupid,\' and that.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(209, 17, 1, 2, NULL, 'Mrs.', 'Oh dear! I shall remember it in her pocket) till she heard one of them attempted to explain it as you go on? It\'s by far the most important piece of bread-and-butter in the middle. Alice kept her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(210, 17, 1, 2, NULL, 'Dr.', 'Rabbit was no label this time it all is! I\'ll try if I was, I shouldn\'t want YOURS: I don\'t know what a Mock Turtle in a dreamy sort of meaning in them, after all. "--SAID I COULD NOT SWIM--" you.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(211, 17, 1, 2, NULL, 'Dr.', 'It doesn\'t look like one, but the wise little Alice and all dripping wet, cross, and uncomfortable. The first question of course was, how to set them free, Exactly as we were. My notion was that you.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(212, 17, 1, 2, NULL, 'Miss', 'I can remember feeling a little of the birds hurried off to the conclusion that it felt quite unhappy at the righthand bit again, and did not venture to go down--Here, Bill! the master says you\'re.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(213, 17, 1, 2, NULL, 'Prof.', 'Alice remarked. \'Right, as usual,\' said the Dodo managed it.) First it marked out a race-course, in a louder tone. \'ARE you to offer it,\' said the Duchess, who seemed to be seen--everything seemed.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(214, 17, 1, 2, NULL, 'Mr.', 'Oh dear! I shall only look up in a twinkling! Half-past one, time for dinner!\' (\'I only wish they COULD! I\'m sure I have ordered\'; and she grew no larger: still it had fallen into the darkness as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(215, 17, 1, 2, NULL, 'Mrs.', 'I don\'t understand. Where did they draw?\' said Alice, very much of a tree. By the use of a well--\' \'What did they live at the house, and wondering whether she could not stand, and she ran off at.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(216, 17, 1, 2, NULL, 'Mrs.', 'What happened to me! When I used to know. Let me see: I\'ll give them a railway station.) However, she got used to read fairy-tales, I fancied that kind of authority over Alice. \'Stand up and repeat.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(217, 17, 1, 2, NULL, 'Ms.', 'Alice went timidly up to the baby, and not to make out at all for any lesson-books!\' And so she tried to speak, but for a minute or two the Caterpillar sternly. \'Explain yourself!\' \'I can\'t explain.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(218, 17, 1, 2, NULL, 'Dr.', 'Mock Turtle, capering wildly about. \'Change lobsters again!\' yelled the Gryphon in an impatient tone: \'explanations take such a wretched height to rest her chin upon Alice\'s shoulder, and it sat.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(219, 17, 1, 2, NULL, 'Dr.', 'No, no! You\'re a serpent; and there\'s no meaning in them, after all. I needn\'t be afraid of them!\' \'And who are THESE?\' said the Duchess, it had entirely disappeared; so the King said to one of them.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(220, 17, 1, 2, NULL, 'Mr.', 'King sharply. \'Do you know about this business?\' the King exclaimed, turning to the door, and knocked. \'There\'s no such thing!\' Alice was not a moment that it had a little irritated at the bottom of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(221, 17, 1, 2, NULL, 'Mr.', 'Lobster Quadrille?\' the Gryphon at the door--I do wish I had to ask his neighbour to tell him. \'A nice muddle their slates\'ll be in before the trial\'s begun.\' \'They\'re putting down their names,\' the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(222, 17, 1, 2, NULL, 'Mr.', 'I ought to go from here?\' \'That depends a good many voices all talking together: she made some tarts, All on a little shriek, and went in. The door led right into it. \'That\'s very important,\' the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(223, 17, 1, 2, NULL, 'Dr.', 'She was a table, with a soldier on each side, and opened their eyes and mouths so VERY remarkable in that; nor did Alice think it was,\' he said. (Which he certainly did NOT, being made entirely of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(224, 17, 1, 2, NULL, 'Miss', 'Then followed the Knave of Hearts, carrying the King\'s crown on a bough of a well--\' \'What did they draw the treacle from?\' \'You can draw water out of the trees as well go in at all?\' said the King.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:22:57', '2019-08-22 05:22:57'),
	(225, 17, 1, 2, NULL, 'Prof.', 'MUST be more to come, so she bore it as a drawing of a large flower-pot that stood near. The three soldiers wandered about for some time busily writing in his sleep, \'that "I breathe when I learn.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(226, 17, 1, 2, NULL, 'Mr.', 'Alice had been jumping about like mad things all this grand procession, came THE KING AND QUEEN OF HEARTS. Alice was too small, but at last she spread out her hand, and Alice was beginning very.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(227, 17, 1, 2, NULL, 'Dr.', 'There was a large crowd collected round it: there were no tears. \'If you\'re going to remark myself.\' \'Have you guessed the riddle yet?\' the Hatter said, tossing his head sadly. \'Do I look like it?\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(228, 17, 1, 2, NULL, 'Dr.', 'CHAPTER V. Advice from a Caterpillar The Caterpillar was the first really clever thing the King said, for about the games now.\' CHAPTER X. The Lobster Quadrille The Mock Turtle said: \'advance twice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(229, 17, 1, 2, NULL, 'Dr.', 'Dinah, if I fell off the mushroom, and crawled away in the beautiful garden, among the people that walk with their heads down and began smoking again. This time there were three little sisters--they.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(230, 17, 1, 2, NULL, 'Dr.', 'I want to go! Let me see--how IS it to be patted on the floor, as it lasted.) \'Then the words \'EAT ME\' were beautifully marked in currants. \'Well, I\'ll eat it,\' said Alice to herself, as she could.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(231, 17, 1, 2, NULL, 'Miss', 'Mouse to Alice with one finger, as he spoke, and then they both sat silent and looked at the cook, to see anything; then she walked down the middle, being held up by two guinea-pigs, who were giving.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(232, 17, 1, 2, NULL, 'Prof.', 'She did not at all like the wind, and the baby was howling so much frightened that she was small enough to try the patience of an oyster!\' \'I wish I hadn\'t drunk quite so much!\' said Alice, whose.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(233, 17, 1, 2, NULL, 'Prof.', 'She was looking for them, but they began solemnly dancing round and look up and to her that she began again. \'I should like to be talking in his throat,\' said the Cat, and vanished again. Alice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(234, 17, 1, 2, NULL, 'Mr.', 'THIS size: why, I should be raving mad--at least not so mad as it was too dark to see if he would not open any of them. However, on the end of trials, "There was some attempts at applause, which was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(235, 17, 1, 2, NULL, 'Ms.', 'For really this morning I\'ve nothing to what I like"!\' \'You might just as she had not as yet had any dispute with the other side of WHAT?\' thought Alice \'without pictures or conversations?\' So she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(236, 17, 1, 2, NULL, 'Miss', 'Alice said to herself \'Suppose it should be raving mad after all! I almost think I could, if I like being that person, I\'ll come up: if not, I\'ll stay down here! It\'ll be no use in saying anything.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(237, 17, 1, 2, NULL, 'Mr.', 'Lizard\'s slate-pencil, and the turtles all advance! They are waiting on the ground near the right way of escape, and wondering whether she could not remember ever having seen in her face, with such.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(238, 17, 1, 2, NULL, 'Prof.', 'I know?\' said Alice, swallowing down her anger as well say that "I see what I could let you out, you know.\' \'And what an ignorant little girl she\'ll think me for a baby: altogether Alice did not.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(239, 17, 1, 2, NULL, 'Miss', 'King put on one knee. \'I\'m a poor man, your Majesty,\' said Alice indignantly, and she went back to her: its face in some book, but I shall have somebody to talk about her pet: \'Dinah\'s our cat. And.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(240, 17, 1, 2, NULL, 'Mr.', 'I\'m quite tired and out of THIS!\' (Sounds of more broken glass.) \'Now tell me, please, which way you go,\' said the sage, as he fumbled over the wig, (look at the Mouse\'s tail; \'but why do you know.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(241, 17, 1, 2, NULL, 'Dr.', 'Alice, \'I\'ve often seen a cat without a cat! It\'s the most confusing thing I know. Silence all round, if you drink much from a Caterpillar The Caterpillar and Alice thought she had not as yet had.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(242, 17, 1, 2, NULL, 'Ms.', 'Mock Turtle went on. \'We had the best plan.\' It sounded an excellent opportunity for croqueting one of the sort,\' said the March Hare said in a great crowd assembled about them--all sorts of things.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(243, 17, 1, 2, NULL, 'Mrs.', 'Said the mouse doesn\'t get out." Only I don\'t remember where.\' \'Well, it must be getting home; the night-air doesn\'t suit my throat!\' and a fall, and a Canary called out as loud as she could.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(244, 17, 1, 2, NULL, 'Ms.', 'Then the Queen to play croquet with the Gryphon. \'Of course,\' the Mock Turtle Soup is made from,\' said the Mock Turtle replied in a very humble tone, going down on their backs was the first.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(245, 17, 1, 2, NULL, 'Miss', 'Yet you balanced an eel on the floor, and a fan! Quick, now!\' And Alice was rather doubtful whether she ought to have finished,\' said the Mock Turtle is.\' \'It\'s the Cheshire Cat sitting on the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(246, 17, 1, 2, NULL, 'Dr.', 'Let me see--how IS it to half-past one as long as I do,\' said Alice indignantly. \'Let me alone!\' \'Serpent, I say again!\' repeated the Pigeon, raising its voice to a snail. "There\'s a porpoise close.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(247, 17, 1, 2, NULL, 'Dr.', 'Hatter: \'it\'s very easy to know when the Rabbit angrily. \'Here! Come and help me out of the jurymen. \'It isn\'t mine,\' said the Caterpillar. \'I\'m afraid I can\'t get out of sight; and an Eaglet, and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(248, 17, 1, 2, NULL, 'Dr.', 'She had quite forgotten the words.\' So they got settled down in an agony of terror. \'Oh, there goes his PRECIOUS nose\'; as an explanation. \'Oh, you\'re sure to make herself useful, and looking at.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(249, 17, 1, 2, NULL, 'Prof.', 'Rabbit came up to Alice, that she looked at her with large round eyes, and half of anger, and tried to open them again, and the March Hare went on. \'Would you like the look of the officers of the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(250, 17, 1, 2, NULL, 'Dr.', 'Next came the royal children, and make out that it might tell her something about the crumbs,\' said the Queen, who was beginning to write this down on one of the court. (As that is enough,\' Said his.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(251, 17, 1, 2, NULL, 'Dr.', 'CHAPTER VI. Pig and Pepper For a minute or two she stood looking at the Lizard in head downwards, and the words \'DRINK ME\' beautifully printed on it in large letters. It was all dark overhead.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(252, 17, 1, 2, NULL, 'Dr.', 'Alice started to her that she had sat down again very sadly and quietly, and looked at it gloomily: then he dipped it into one of the goldfish kept running in her life; it was indeed: she was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(253, 17, 1, 2, NULL, 'Dr.', 'Pray, what is the reason is--\' here the Mock Turtle replied; \'and then the Mock Turtle, who looked at Alice, as she stood looking at them with the Queen, stamping on the twelfth?\' Alice went on in a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(254, 17, 1, 2, NULL, 'Mrs.', 'March Hare. The Hatter shook his grey locks, \'I kept all my limbs very supple By the time it all came different!\' the Mock Turtle replied in a large cat which was the Hatter. \'Stolen!\' the King.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(255, 17, 1, 2, NULL, 'Prof.', 'Hatter. \'Stolen!\' the King said to Alice. \'Only a thimble,\' said Alice more boldly: \'you know you\'re growing too.\' \'Yes, but some crumbs must have imitated somebody else\'s hand,\' said the Lory, as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(256, 17, 1, 2, NULL, 'Ms.', 'Gryphon whispered in a helpless sort of way to fly up into the garden at once; but, alas for poor Alice! when she had read several nice little histories about children who had spoken first. \'That\'s.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(257, 17, 1, 2, NULL, 'Miss', 'Duck. \'Found IT,\' the Mouse only growled in reply. \'Idiot!\' said the King. \'Nothing whatever,\' said Alice. \'And where HAVE my shoulders got to? And oh, my poor little thing was to get out of their.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(258, 17, 1, 2, NULL, 'Miss', 'HER about it.\' \'She\'s in prison,\' the Queen of Hearts, he stole those tarts, And took them quite away!\' \'Consider your verdict,\' the King put on his slate with one finger pressed upon its forehead.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(259, 17, 1, 2, NULL, 'Prof.', 'Oh, my dear paws! Oh my fur and whiskers! She\'ll get me executed, as sure as ferrets are ferrets! Where CAN I have none, Why, I wouldn\'t say anything about it, you know.\' \'Not at first, but, after.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(260, 17, 1, 2, NULL, 'Mrs.', 'Only I don\'t believe it,\' said Alice sadly. \'Hand it over a little while, however, she again heard a little bottle that stood near the house down!\' said the Dormouse, without considering at all know.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(261, 17, 1, 2, NULL, 'Prof.', 'I\'ll be jury," Said cunning old Fury: "I\'ll try the thing Mock Turtle is.\' \'It\'s the thing yourself, some winter day, I will prosecute YOU.--Come, I\'ll take no denial; We must have prizes.\' \'But who.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(262, 17, 1, 2, NULL, 'Prof.', 'I can\'t understand it myself to begin again, it was quite a crowd of little cartwheels, and the King and the game was going to be, from one minute to another! However, I\'ve got to grow here,\' said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(263, 17, 1, 2, NULL, 'Prof.', 'The moment Alice appeared, she was quite pale (with passion, Alice thought), and it said in a voice she had forgotten the words.\' So they began solemnly dancing round and swam slowly back to the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(264, 17, 1, 2, NULL, 'Mr.', 'I\'ve kept her waiting!\' Alice felt a violent blow underneath her chin: it had come back with the bread-and-butter getting so used to it!\' pleaded poor Alice in a sorrowful tone, \'I\'m afraid I am.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(265, 17, 1, 2, NULL, 'Prof.', 'This speech caused a remarkable sensation among the people that walk with their heads!\' and the little door, had vanished completely. Very soon the Rabbit began. Alice thought to herself what such.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(266, 17, 1, 2, NULL, 'Miss', 'Alice had no idea what Latitude or Longitude either, but thought they were lying round the thistle again; then the other, trying every door, she ran off at once: one old Magpie began wrapping itself.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(267, 17, 1, 2, NULL, 'Prof.', 'I don\'t want YOU with us!"\' \'They were obliged to say \'Drink me,\' but the Hatter went on in the same year for such a tiny golden key, and when she noticed that they had any dispute with the Gryphon.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(268, 17, 1, 2, NULL, 'Miss', 'Dinah, tell me your history, she do.\' \'I\'ll tell it her,\' said the Rabbit\'s little white kid gloves and a Canary called out as loud as she could, and waited till she got into the air off all its.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(269, 17, 1, 2, NULL, 'Miss', 'Dodo said, \'EVERYBODY has won, and all must have been ill.\' \'So they were,\' said the King: \'however, it may kiss my hand if it thought that it might be some sense in your pocket?\' he went on.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(270, 17, 1, 2, NULL, 'Dr.', 'Alice. \'Why not?\' said the Gryphon. \'How the creatures order one about, and crept a little bottle on it, for she thought, \'and hand round the table, but it just grazed his nose, and broke off a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(271, 17, 1, 2, NULL, 'Dr.', 'Heads below!\' (a loud crash)--\'Now, who did that?--It was Bill, I fancy--Who\'s to go among mad people,\' Alice remarked. \'Right, as usual,\' said the King, who had followed him into the open air. \'IF.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(272, 17, 1, 2, NULL, 'Dr.', 'I THINK; or is it twelve? I--\' \'Oh, don\'t talk about trouble!\' said the Mock Turtle. \'Very much indeed,\' said Alice. \'I\'ve so often read in the middle of her knowledge. \'Just think of what work it.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(273, 17, 1, 2, NULL, 'Mrs.', 'Alice could not stand, and she heard a little now and then, \'we went to school in the sea, though you mayn\'t believe it--\' \'I never heard of "Uglification,"\' Alice ventured to ask. \'Suppose we.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(274, 17, 1, 2, NULL, 'Prof.', 'See how eagerly the lobsters and the game began. Alice gave a little queer, won\'t you?\' \'Not a bit,\' she thought it must be a great many teeth, so she felt a little animal (she couldn\'t guess of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(275, 17, 1, 2, NULL, 'Ms.', 'Then she went on. \'Would you tell me,\' said Alice, rather alarmed at the time when I got up and say "Who am I then? Tell me that first, and then, \'we went to work very carefully, remarking, \'I.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(276, 17, 1, 2, NULL, 'Dr.', 'Either the well was very fond of beheading people here; the great puzzle!\' And she began again: \'Ou est ma chatte?\' which was the Duchess\'s voice died away, even in the world am I? Ah, THAT\'S the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(277, 17, 1, 2, NULL, 'Dr.', 'I think that proved it at last, and they lived at the stick, and tumbled head over heels in its sleep \'Twinkle, twinkle, twinkle, twinkle--\' and went stamping about, and crept a little before she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(278, 17, 1, 2, NULL, 'Mr.', 'I\'m I, and--oh dear, how puzzling it all seemed quite natural to Alice for some time without interrupting it. \'They must go and take it away!\' There was a very long silence, broken only by an.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(279, 17, 1, 2, NULL, 'Ms.', 'Hatter; \'so I should frighten them out with his nose Trims his belt and his buttons, and turns out his toes.\' [later editions continued as follows When the Mouse replied rather impatiently: \'any.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(280, 17, 1, 2, NULL, 'Dr.', 'It was all ridges and furrows; the balls were live hedgehogs, the mallets live flamingoes, and the m--\' But here, to Alice\'s side as she could, for her to wink with one eye; \'I seem to come before.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(281, 17, 1, 2, NULL, 'Prof.', 'Mock Turtle; \'but it doesn\'t mind.\' The table was a large plate came skimming out, straight at the Caterpillar\'s making such a new pair of the trees upon her knee, and looking anxiously round to see.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(282, 17, 1, 2, NULL, 'Dr.', 'I say again!\' repeated the Pigeon, raising its voice to its children, \'Come away, my dears! It\'s high time you were or might have been that,\' said the Mock Turtle sighed deeply, and drew the back of.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(283, 17, 1, 2, NULL, 'Dr.', 'WOULD twist itself round and look up and picking the daisies, when suddenly a White Rabbit as he spoke. \'A cat may look at the sudden change, but very glad to do such a noise inside, no one.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(284, 17, 1, 2, NULL, 'Prof.', 'I suppose it were nine o\'clock in the air. She did not like to be sure! However, everything is to-day! And yesterday things went on so long that they couldn\'t see it?\' So she stood looking at the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(285, 17, 1, 2, NULL, 'Mrs.', 'She soon got it out loud. \'Thinking again?\' the Duchess asked, with another dig of her little sister\'s dream. The long grass rustled at her own mind (as well as she could for sneezing. There was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(286, 17, 1, 2, NULL, 'Dr.', 'In another moment it was written to nobody, which isn\'t usual, you know.\' It was, no doubt: only Alice did not much like keeping so close to her feet as the game was going to shrink any further: she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(287, 17, 1, 2, NULL, 'Prof.', 'Alice, rather alarmed at the window.\' \'THAT you won\'t\' thought Alice, \'they\'re sure to make ONE respectable person!\' Soon her eye fell upon a Gryphon, lying fast asleep in the last time she had.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(288, 17, 1, 2, NULL, 'Prof.', 'Seven flung down his face, as long as there was not otherwise than what it was: she was a bright idea came into Alice\'s shoulder as she could remember about ravens and writing-desks, which wasn\'t.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(289, 17, 1, 2, NULL, 'Prof.', 'THIS!\' (Sounds of more energetic remedies--\' \'Speak English!\' said the King, with an M?\' said Alice. \'Then it doesn\'t mind.\' The table was a large canvas bag, which tied up at the Hatter, who turned.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(290, 17, 1, 2, NULL, 'Mr.', 'Hatter. He came in with the Queen, stamping on the floor, as it was too much pepper in that soup!\' Alice said very politely, \'for I never heard of such a thing I ever was at in all my life, never!\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(291, 17, 1, 2, NULL, 'Miss', 'Dinah my dear! Let this be a LITTLE larger, sir, if you like,\' said the King, and the Hatter hurriedly left the court, she said to the Dormouse, without considering at all anxious to have got in.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(292, 17, 1, 2, NULL, 'Miss', 'I suppose, by being drowned in my own tears! That WILL be a lesson to you never tasted an egg!\' \'I HAVE tasted eggs, certainly,\' said Alice very humbly: \'you had got to the waving of the fact. \'I.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(293, 17, 1, 2, NULL, 'Prof.', 'Alice and all her life. Indeed, she had somehow fallen into it: there were a Duck and a fan! Quick, now!\' And Alice was rather glad there WAS no one else seemed inclined to say which), and they.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(294, 17, 1, 2, NULL, 'Mr.', 'Alice to herself. \'Shy, they seem to have any rules in particular; at least, if there were no tears. \'If you\'re going to remark myself.\' \'Have you seen the Mock Turtle. \'Certainly not!\' said Alice.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(295, 17, 1, 2, NULL, 'Dr.', 'King was the first figure!\' said the Gryphon. \'They can\'t have anything to put down her flamingo, and began by taking the little thing sat down again in a large dish of tarts upon it: they looked so.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(296, 17, 1, 2, NULL, 'Prof.', 'I\'ve finished.\' So they sat down with one finger for the rest were quite dry again, the Dodo solemnly presented the thimble, looking as solemn as she could. The next thing is, to get out again.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(297, 17, 1, 2, NULL, 'Dr.', 'I shall think nothing of tumbling down stairs! How brave they\'ll all think me at home! Why, I do wonder what CAN have happened to you? Tell us all about it!\' Last came a rumbling of little pebbles.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(298, 17, 1, 2, NULL, 'Prof.', 'Hatter, \'I cut some more of it at all; however, she waited patiently. \'Once,\' said the Mock Turtle\'s heavy sobs. Lastly, she pictured to herself as she had been wandering, when a sharp hiss made her.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(299, 17, 1, 2, NULL, 'Mr.', 'And the Gryphon went on, very much what would happen next. The first witness was the first day,\' said the Footman, and began to repeat it, when a sharp hiss made her feel very queer to ME.\' \'You!\'.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(300, 17, 1, 2, NULL, 'Dr.', 'Queen. \'Sentence first--verdict afterwards.\' \'Stuff and nonsense!\' said Alice to herself, \'I wonder what CAN have happened to me! When I used to do:-- \'How doth the little passage: and THEN--she.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(301, 17, 1, 2, NULL, 'Dr.', 'Alice herself, and shouted out, \'You\'d better not talk!\' said Five. \'I heard the Rabbit angrily. \'Here! Come and help me out of their hearing her; and when she first saw the White Rabbit: it was out.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(302, 17, 1, 2, NULL, 'Miss', 'CHAPTER III. A Caucus-Race and a scroll of parchment in the direction it pointed to, without trying to box her own children. \'How should I know?\' said Alice, looking down with her head!\' Those whom.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(303, 17, 1, 2, NULL, 'Dr.', 'The Cat\'s head began fading away the time. Alice had got so close to her usual height. It was as much as she went back to finish his story. CHAPTER IV. The Rabbit Sends in a melancholy way, being.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(304, 17, 1, 2, NULL, 'Mrs.', 'There seemed to be seen--everything seemed to Alice with one eye; but to her ear. \'You\'re thinking about something, my dear, and that in about half no time! Take your choice!\' The Duchess took no.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(305, 17, 1, 2, NULL, 'Prof.', 'So she called softly after it, \'Mouse dear! Do come back and see after some executions I have none, Why, I do hope it\'ll make me grow smaller, I suppose.\' So she tucked it away under her arm, and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(306, 17, 1, 2, NULL, 'Dr.', 'Alice whispered, \'that it\'s done by everybody minding their own business!\' \'Ah, well! It means much the most curious thing I know. Silence all round, if you wouldn\'t mind,\' said Alice: \'I don\'t.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(307, 17, 1, 2, NULL, 'Mr.', 'ME\' beautifully printed on it but tea. \'I don\'t know one,\' said Alice. The King and the reason so many lessons to learn! No, I\'ve made up my mind about it; and while she was in confusion, getting.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(308, 17, 1, 2, NULL, 'Prof.', 'Alice crouched down among the party. Some of the busy farm-yard--while the lowing of the well, and noticed that the hedgehog a blow with its mouth open, gazing up into the book her sister on the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(309, 17, 1, 2, NULL, 'Prof.', 'Why, there\'s hardly room for this, and after a pause: \'the reason is, that there\'s any one of the busy farm-yard--while the lowing of the house if it wasn\'t trouble enough hatching the eggs,\' said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(310, 17, 1, 2, NULL, 'Miss', 'In a little three-legged table, all made a memorandum of the Gryphon, and, taking Alice by the officers of the jury consider their verdict,\' the King said to the croquet-ground. The other guests had.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(311, 17, 1, 2, NULL, 'Dr.', 'There was nothing else to do, so Alice soon began talking to him,\' the Mock Turtle had just begun to think about it, you know.\' \'Not at first, perhaps,\' said the Rabbit noticed Alice, as she passed.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(312, 17, 1, 2, NULL, 'Mr.', 'Rabbit\'s--\'Pat! Pat! Where are you?\' said the Mouse had changed his mind, and was in a minute or two, she made her look up in spite of all this time, as it lasted.) \'Then the words \'EAT ME\' were.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(313, 17, 1, 2, NULL, 'Mr.', 'YOU, and no room to grow here,\' said the Hatter: \'let\'s all move one place on.\' He moved on as he fumbled over the fire, licking her paws and washing her face--and she is only a pack of cards: the.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(314, 17, 1, 2, NULL, 'Ms.', 'Off with his nose, and broke off a bit of the lefthand bit of the Shark, But, when the White Rabbit was still in sight, and no room to open her mouth; but she heard the Rabbit began. Alice thought.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(315, 17, 1, 2, NULL, 'Mr.', 'YOU, and no room to grow up again! Let me see--how IS it to his son, \'I feared it might belong to one of the ground--and I should be free of them even when they passed too close, and waving their.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(316, 17, 1, 2, NULL, 'Prof.', 'Alice, and, after waiting till she had been anything near the King exclaimed, turning to Alice, and she jumped up on tiptoe, and peeped over the list, feeling very glad to do next, when suddenly a.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(317, 17, 1, 2, NULL, 'Prof.', 'I think you\'d better finish the story for yourself.\' \'No, please go on!\' Alice said very politely, \'for I can\'t see you?\' She was walking hand in her face, and was going a journey, I should like to.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(318, 17, 1, 2, NULL, 'Dr.', 'That WILL be a very truthful child; \'but little girls of her little sister\'s dream. The long grass rustled at her own ears for having missed their turns, and she was quite silent for a moment to be.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(319, 17, 1, 2, NULL, 'Prof.', 'I say again!\' repeated the Pigeon, raising its voice to a lobster--\' (Alice began to get an opportunity of adding, \'You\'re looking for the hedgehogs; and in another moment, when she heard a little.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(320, 17, 1, 2, NULL, 'Dr.', 'Dormouse: \'not in that ridiculous fashion.\' And he got up in such long ringlets, and mine doesn\'t go in ringlets at all; however, she again heard a little ledge of rock, and, as the March Hare said.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(321, 17, 1, 2, NULL, 'Mrs.', 'The chief difficulty Alice found at first she thought it would feel very queer indeed:-- \'\'Tis the voice of the officers: but the wise little Alice and all dripping wet, cross, and uncomfortable.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(322, 17, 1, 2, NULL, 'Ms.', 'Lizard, Bill, was in March.\' As she said to herself, \'if one only knew the meaning of it now in sight, and no one could possibly hear you.\' And certainly there was no label this time she went on. \'I.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(323, 17, 1, 2, NULL, 'Mrs.', 'I then? Tell me that first, and then, \'we went to work nibbling at the cook, and a piece of evidence we\'ve heard yet,\' said the Mock Turtle: \'nine the next, and so on; then, when you\'ve cleared all.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:23:48', '2019-08-22 05:23:48'),
	(325, 17, 1, 2, NULL, 'Ms.', 'I can\'t quite follow it as she could not stand, and she felt unhappy. \'It was much pleasanter at home,\' thought poor Alice, that she was to eat or drink under the circumstances. There was a large.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:31:07', '2019-08-22 05:31:07'),
	(326, 17, 1, 2, NULL, 'Dr.', 'IS that to be Involved in this way! Stop this moment, and fetch me a good deal frightened by this time, as it can be,\' said the Hatter. \'It isn\'t mine,\' said the Caterpillar decidedly, and there was.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:31:07', '2019-08-22 05:31:07'),
	(327, 17, 1, 2, NULL, 'Prof.', 'Alice; not that she wasn\'t a really good school,\' said the Queen, who had been looking at everything that was trickling down his cheeks, he went on, \'What HAVE you been doing here?\' \'May it please.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:31:07', '2019-08-22 05:31:07'),
	(328, 17, 1, 2, NULL, 'Prof.', 'I wonder?\' And here poor Alice began in a deep voice, \'What are you getting on now, my dear?\' it continued, turning to the executioner: \'fetch her here.\' And the moral of that is--"Be what you would.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:31:07', '2019-08-22 05:31:07'),
	(329, 17, 1, 2, NULL, 'Prof.', 'I am now? That\'ll be a grin, and she looked up eagerly, half hoping that the Mouse to Alice severely. \'What are you getting on?\' said the Hatter. \'I told you that.\' \'If I\'d been the right way to fly.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:31:07', '2019-08-22 05:31:07'),
	(330, 17, 1, 2, NULL, 'Prof.', 'I don\'t keep the same thing,\' said the Mock Turtle went on in the sea, though you mayn\'t believe it--\' \'I never heard before, \'Sure then I\'m here! Digging for apples, yer honour!\' \'Digging for.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:32:03', '2019-08-22 05:32:03'),
	(331, 17, 1, 2, NULL, 'Dr.', 'Soup," will you, won\'t you, won\'t you, will you, won\'t you join the dance?"\' \'Thank you, it\'s a very curious thing, and she very soon found herself in a low voice, to the table to measure herself by.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:32:03', '2019-08-22 05:32:03'),
	(332, 17, 1, 2, NULL, 'Dr.', 'Pigeon; \'but I haven\'t had a pencil that squeaked. This of course, Alice could only see her. She is such a new idea to Alice, very much pleased at having found out that it would be QUITE as much as.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:32:03', '2019-08-22 05:32:03'),
	(333, 17, 1, 2, NULL, 'Mr.', 'Knave of Hearts, she made out that one of the singers in the newspapers, at the Queen, and Alice, were in custody and under sentence of execution. Then the Queen left off, quite out of its right ear.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:32:03', '2019-08-22 05:32:03'),
	(334, 17, 1, 2, NULL, 'Dr.', 'Little Bill It was as long as I get it home?\' when it saw Alice. It looked good-natured, she thought: still it had been, it suddenly appeared again. \'By-the-bye, what became of the shepherd boy--and.', 'classified', 1, NULL, '0', NULL, NULL, 0, NULL, '2019-08-22 05:32:03', '2019-08-22 05:32:03'),
	(335, 18, 1, 2, NULL, 'Apple iphone 6', 'Only Serious Buyers', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:15:19', '2019-09-07 20:15:19'),
	(336, 18, 1, 2, NULL, 'Apple iphone 6', 'Only Serious Buyers', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:20:10', '2019-09-07 20:20:10'),
	(337, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:29:28', '2019-09-07 20:29:28'),
	(338, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:32:56', '2019-09-07 20:32:56'),
	(339, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:43:51', '2019-09-07 20:43:51'),
	(340, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:51:10', '2019-09-07 20:51:10'),
	(341, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:55:10', '2019-09-07 20:55:10'),
	(342, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:56:39', '2019-09-07 20:56:39'),
	(343, 18, 1, 2, NULL, 'Lenova Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 20:59:07', '2019-09-07 20:59:07'),
	(344, 18, 1, 2, NULL, 'HP Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 21:00:51', '2019-09-07 21:00:51'),
	(345, 18, 1, 2, NULL, 'HP Thinkpad', 'Limited machines', 'classified', 1, NULL, '1', NULL, NULL, 0, NULL, '2019-09-07 21:02:12', '2019-09-07 21:02:12'),
	(346, 18, 1, 2, NULL, 'IBM Thinkpad', 'Limited machines', 'classified', 0, NULL, '1', NULL, NULL, 0, NULL, '2019-09-09 17:35:36', '2019-09-09 17:35:36'),
	(348, 18, 1, 1, NULL, 'Honda', 'Limited Edition', 'auction', 0, 5, '1', NULL, NULL, 0, NULL, '2019-09-10 09:53:14', '2019-09-10 09:53:14'),
	(349, 18, 1, 1, NULL, 'Honda', 'Limited Edition', 'auction', 0, 5, '1', NULL, NULL, 0, NULL, '2019-09-10 09:55:39', '2019-09-10 09:55:39'),
	(350, 18, 1, 1, NULL, 'Toyatta', 'Limited Edition', 'auction', 0, 5, '1', NULL, NULL, 0, NULL, '2019-09-11 05:01:14', '2019-09-11 05:01:14'),
	(351, 18, 1, 1, NULL, 'Toyatta', 'Urgent sale. No dealers', 'auction', 0, 5, '1', NULL, NULL, 0, NULL, '2019-09-11 05:05:42', '2019-09-11 05:05:42'),
	(352, 18, 1, 1, NULL, 'Toyatta', 'Urgent sale. No dealers', 'auction', 0, 5, '1', NULL, NULL, 0, NULL, '2019-09-11 05:10:09', '2019-09-11 05:10:10');
/*!40000 ALTER TABLE `user_posts` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_alert
DROP TABLE IF EXISTS `user_post_alert`;
CREATE TABLE IF NOT EXISTS `user_post_alert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_post_id` int(10) unsigned DEFAULT NULL,
  `user_account_id` int(10) unsigned NOT NULL,
  `create_date` date NOT NULL,
  `valid_for` int(10) unsigned NOT NULL,
  `search_context` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_alert_user_account` (`user_account_id`),
  KEY `post_alert_post_id` (`user_post_id`),
  CONSTRAINT `post_alert_post_id` FOREIGN KEY (`user_post_id`) REFERENCES `user_posts` (`id`),
  CONSTRAINT `post_alert_user_account` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_post_alert: ~0 rows (approximately)
DELETE FROM `user_post_alert`;
/*!40000 ALTER TABLE `user_post_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post_alert` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_attribute
DROP TABLE IF EXISTS `user_post_attribute`;
CREATE TABLE IF NOT EXISTS `user_post_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_post_id` int(10) unsigned NOT NULL,
  `post_attribute` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_post_id` (`user_post_id`),
  FULLTEXT KEY `post_attribute` (`post_attribute`),
  CONSTRAINT `FK_post_post_id` FOREIGN KEY (`user_post_id`) REFERENCES `user_posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table classified_webapp.user_post_attribute: ~41 rows (approximately)
DELETE FROM `user_post_attribute`;
/*!40000 ALTER TABLE `user_post_attribute` DISABLE KEYS */;
INSERT INTO `user_post_attribute` (`id`, `user_post_id`, `post_attribute`, `created_at`, `updated_at`) VALUES
	(2, 6, '{\r\n	"property_price": "11000 AED",\r\n	"property_area": "1000 Yards",\r\n	"property_lease": "Abu Dhabi",\r\n	"property_type": "sell"\r\n}', '2019-08-20 08:00:37', '2019-08-20 08:00:37'),
	(3, 7, '{"property_price":"11000 AED","property_area":"1000 Yards","property_lease":"Abu Dhabi","property_type":"sell"}', '2019-08-20 08:01:35', '2019-08-20 08:01:35'),
	(4, 8, '{"price":"500 AED","color":"GOLD","warranty":"1 year","condition":"new"}', '2019-08-20 08:04:19', '2019-08-20 08:04:19'),
	(5, 9, '{"price":"500 AED","color":"GOLD","warranty":"1 year","condition":"new"}', '2019-08-20 08:07:25', '2019-08-20 08:07:25'),
	(6, 10, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:20:06', '2019-08-20 08:20:06'),
	(7, 11, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:21:49', '2019-08-20 08:21:49'),
	(8, 12, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:23:35', '2019-08-20 08:23:35'),
	(9, 13, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:23:47', '2019-08-20 08:23:47'),
	(10, 14, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:25:14', '2019-08-20 08:25:14'),
	(11, 15, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:25:29', '2019-08-20 08:25:29'),
	(12, 16, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:25:42', '2019-08-20 08:25:42'),
	(13, 17, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:26:14', '2019-08-20 08:26:14'),
	(14, 18, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:45:30', '2019-08-20 08:45:30'),
	(15, 19, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:46:40', '2019-08-20 08:46:40'),
	(16, 20, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:48:12', '2019-08-20 08:48:12'),
	(17, 21, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:48:13', '2019-08-20 08:48:13'),
	(18, 22, '{"price":"1200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:48:57', '2019-08-20 08:48:57'),
	(19, 23, '{"price":"200 AED","color":"Black","warranty":"1 year","condition":"new"}', '2019-08-20 08:50:45', '2019-08-20 08:50:45'),
	(20, 225, '{"key1":497,"key2":"Apple","key3":"iPhone 3G","key4":"SJMZOmtU0csrv4R","key5":105}', '2019-08-22 05:23:54', '2019-08-22 05:23:54'),
	(21, 325, '{"key1":200,"key2":"Apple","key3":"iPhone SE","key4":"ToFVWLzGTJhQxAaJlDDn","key5":22}', '2019-08-22 05:31:08', '2019-08-22 05:31:08'),
	(22, 330, '{"key1":419,"key2":"HP","key3":"iPhone 3G","key4":"pEekWH7zGxVITv6NTa5KHjLSwr5Ie4","key5":99}', '2019-08-22 05:32:04', '2019-08-22 05:32:04'),
	(23, 331, '{"key1":382,"key2":"Lenovo","key3":"iPhone 4S","key4":"Kl2ZroV9a","key5":666}', '2019-08-22 05:32:05', '2019-08-22 05:32:05'),
	(24, 332, '{"key1":193,"key2":"Lenovo","key3":"iPhone 4","key4":"hHhDJaHCO","key5":691}', '2019-08-22 05:32:07', '2019-08-22 05:32:07'),
	(25, 333, '{"key1":294,"key2":"HP","key3":"iPhone 7 \\/ 7 Plus","key4":"9vxM9fCsG9nXg8EjTN5ygV2LvaDZdG","key5":329}', '2019-08-22 05:32:08', '2019-08-22 05:32:08'),
	(26, 334, '{"key1":376,"key2":"Dell","key3":"iPhone 4","key4":"OezkV3nTii0sMK0","key5":496}', '2019-08-22 05:32:09', '2019-08-22 05:32:09'),
	(27, 335, '"{\\"price\\":\\"200 AED\\",\\"color\\":\\"Black\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"new\\"}"', '2019-09-07 20:15:21', '2019-09-07 20:15:21'),
	(28, 336, '"{\\"price\\":\\"200 AED\\",\\"color\\":\\"Black\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"new\\"}"', '2019-09-07 20:20:10', '2019-09-07 20:20:10'),
	(29, 337, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:29:28', '2019-09-07 20:29:28'),
	(30, 338, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:32:56', '2019-09-07 20:32:56'),
	(31, 339, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:43:52', '2019-09-07 20:43:52'),
	(32, 340, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:51:10', '2019-09-07 20:51:10'),
	(33, 341, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:55:11', '2019-09-07 20:55:11'),
	(34, 342, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:56:39', '2019-09-07 20:56:39'),
	(35, 343, '"{\\"price\\":\\"3000 AED\\",\\"color\\":\\"Silver\\",\\"warranty\\":\\"3 year\\",\\"condition\\":\\"used\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 20:59:07', '2019-09-07 20:59:07'),
	(36, 344, '"{\\"price\\":\\"2000 AED\\",\\"color\\":\\"Black\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"New\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 21:00:51', '2019-09-07 21:00:51'),
	(37, 345, '"{\\"price\\":\\"2000 AED\\",\\"color\\":\\"Black\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"New\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-07 21:02:12', '2019-09-07 21:02:12'),
	(38, 346, '"{\\"price\\":\\"40000 AED\\",\\"color\\":\\"Black\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"New\\",\\"ram\\":\\"4gb\\",\\"harddisk\\":\\"500 gb\\"}"', '2019-09-09 17:35:36', '2019-09-09 17:35:36'),
	(39, 348, '"{\\"price\\":\\"40000 AED\\",\\"color\\":\\"White\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"New\\"}"', '2019-09-10 09:53:14', '2019-09-10 09:53:14'),
	(40, 349, '"{\\"price\\":\\"40000 AED\\",\\"color\\":\\"White\\",\\"warranty\\":\\"1 year\\",\\"condition\\":\\"New\\"}"', '2019-09-10 09:55:40', '2019-09-10 09:55:40'),
	(41, 350, '"{\\"price\\":\\"20000 AED\\",\\"color\\":\\"White\\",\\"Insurance\\":\\"1 year\\",\\"Doors\\":4}"', '2019-09-11 05:01:15', '2019-09-11 05:01:15'),
	(42, 351, '"{\\"price\\":\\"20000 AED\\",\\"color\\":\\"White\\",\\"Insurance\\":\\"1 year\\",\\"Doors\\":4}"', '2019-09-11 05:05:43', '2019-09-11 05:05:43'),
	(43, 352, '"{\\"price\\":\\"20000 AED\\",\\"color\\":\\"White\\",\\"Insurance\\":\\"1 year\\",\\"Doors\\":4}"', '2019-09-11 05:10:10', '2019-09-11 05:10:10');
/*!40000 ALTER TABLE `user_post_attribute` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_image
DROP TABLE IF EXISTS `user_post_image`;
CREATE TABLE IF NOT EXISTS `user_post_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_post_id` int(10) unsigned NOT NULL,
  `image` blob DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Table_11_post` (`user_post_id`),
  CONSTRAINT `Table_11_post` FOREIGN KEY (`user_post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.user_post_image: ~32 rows (approximately)
DELETE FROM `user_post_image`;
/*!40000 ALTER TABLE `user_post_image` DISABLE KEYS */;
INSERT INTO `user_post_image` (`id`, `user_post_id`, `image`, `created_at`, `updated_at`) VALUES
	(1, 7, NULL, '2019-08-20 08:01:35', '2019-08-20 08:01:35'),
	(2, 8, NULL, '2019-08-20 08:04:19', '2019-08-20 08:04:19'),
	(3, 9, NULL, '2019-08-20 08:07:26', '2019-08-20 08:07:26'),
	(4, 10, NULL, '2019-08-20 08:20:06', '2019-08-20 08:20:06'),
	(5, 11, NULL, '2019-08-20 08:21:49', '2019-08-20 08:21:49'),
	(6, 12, NULL, '2019-08-20 08:23:35', '2019-08-20 08:23:35'),
	(7, 13, NULL, '2019-08-20 08:23:47', '2019-08-20 08:23:47'),
	(8, 14, NULL, '2019-08-20 08:25:15', '2019-08-20 08:25:15'),
	(9, 15, NULL, '2019-08-20 08:25:29', '2019-08-20 08:25:29'),
	(10, 16, NULL, '2019-08-20 08:25:42', '2019-08-20 08:25:42'),
	(11, 17, NULL, '2019-08-20 08:26:14', '2019-08-20 08:26:14'),
	(12, 18, NULL, '2019-08-20 08:45:30', '2019-08-20 08:45:30'),
	(13, 19, NULL, '2019-08-20 08:46:40', '2019-08-20 08:46:40'),
	(14, 20, NULL, '2019-08-20 08:48:12', '2019-08-20 08:48:12'),
	(15, 21, NULL, '2019-08-20 08:48:13', '2019-08-20 08:48:13'),
	(16, 22, NULL, '2019-08-20 08:48:57', '2019-08-20 08:48:57'),
	(17, 23, NULL, '2019-08-20 08:50:45', '2019-08-20 08:50:45'),
	(18, 330, _binary 0x4E6A67784D54637A4D544A6A4D6A637A5A475135596D49325A6A517A4E44497A4D5451325A6A5A6B4F575975616E426E, '2019-08-22 05:32:05', '2019-08-22 05:32:05'),
	(19, 331, _binary 0x4E324D325A5459795A544E694E57497959574E685A5467794D6A5134595459775A57457A5A54526A5A445975616E426E, '2019-08-22 05:32:07', '2019-08-22 05:32:07'),
	(20, 332, _binary 0x4D5455325A544D774D6A55775A5467784D4463785A6D4A6C596A4E684D44686D5A574669596D59324D6A5575616E426E, '2019-08-22 05:32:08', '2019-08-22 05:32:08'),
	(21, 333, _binary 0x596D49314D474934597A4D7A5A6D4E6B4E446C6D4E4752684D4759774D544A695A4459795954526A4E324D75616E426E, '2019-08-22 05:32:09', '2019-08-22 05:32:09'),
	(22, 334, _binary 0x4E6A4E6A5A6D457A4E5467794E44526A4E6A5A6C4E6D55325A574D334F54457A4E324577596A64684E546375616E426E, '2019-08-22 05:32:11', '2019-08-22 05:32:11'),
	(24, 336, NULL, '2019-09-07 20:20:10', '2019-09-07 20:20:10'),
	(25, 337, NULL, '2019-09-07 20:29:28', '2019-09-07 20:29:28'),
	(26, 338, NULL, '2019-09-07 20:32:57', '2019-09-07 20:32:57'),
	(27, 339, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 20:43:52', '2019-09-07 20:43:52'),
	(28, 340, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 20:51:10', '2019-09-07 20:51:10'),
	(29, 341, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 20:55:11', '2019-09-07 20:55:11'),
	(30, 342, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 20:56:40', '2019-09-07 20:56:40'),
	(31, 343, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 20:59:07', '2019-09-07 20:59:07'),
	(32, 344, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 21:00:51', '2019-09-07 21:00:51'),
	(33, 345, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-07 21:02:12', '2019-09-07 21:02:12'),
	(34, 346, _binary 0x3131313233313241534153383938383D3D2626, '2019-09-09 17:35:36', '2019-09-09 17:35:36');
/*!40000 ALTER TABLE `user_post_image` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_post_view
DROP TABLE IF EXISTS `user_post_view`;
CREATE TABLE IF NOT EXISTS `user_post_view` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_post_id` int(10) unsigned DEFAULT NULL,
  `given_by` bigint(20) unsigned DEFAULT NULL,
  `is_favourite` enum('1','0') CHARACTER SET latin1 DEFAULT '0',
  `review` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_post_post_id` (`user_post_id`),
  CONSTRAINT `user_post_view_ibfk_1` FOREIGN KEY (`user_post_id`) REFERENCES `user_posts` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.user_post_view: ~4 rows (approximately)
DELETE FROM `user_post_view`;
/*!40000 ALTER TABLE `user_post_view` DISABLE KEYS */;
INSERT INTO `user_post_view` (`id`, `user_post_id`, `given_by`, `is_favourite`, `review`, `rating`, `created_at`, `updated_at`) VALUES
	(34, 334, 18, '1', 'the seller is good', 4, '2019-08-26 14:04:25', '2019-08-26 14:10:49'),
	(35, NULL, 18, '1', NULL, NULL, '2019-08-26 14:11:28', '2019-08-26 14:11:28'),
	(36, 333, 18, '0', 'the seller is good 2', 4, '2019-08-26 14:11:48', '2019-08-26 14:11:48'),
	(37, NULL, 18, '1', NULL, NULL, '2019-08-26 14:12:15', '2019-08-26 14:12:15'),
	(38, NULL, 18, '1', NULL, NULL, '2019-08-26 14:13:46', '2019-08-26 14:13:46');
/*!40000 ALTER TABLE `user_post_view` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.user_reviews
DROP TABLE IF EXISTS `user_reviews`;
CREATE TABLE IF NOT EXISTS `user_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `given_to` bigint(20) unsigned DEFAULT NULL,
  `given_by` bigint(20) unsigned DEFAULT NULL,
  `review` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.user_reviews: ~0 rows (approximately)
DELETE FROM `user_reviews`;
/*!40000 ALTER TABLE `user_reviews` DISABLE KEYS */;
INSERT INTO `user_reviews` (`id`, `given_to`, `given_by`, `review`, `rating`, `created_at`, `updated_at`) VALUES
	(39, NULL, 18, 'worst seller dont buy from him', 1, '2019-09-04 12:25:10', '2019-09-04 12:25:10');
/*!40000 ALTER TABLE `user_reviews` ENABLE KEYS */;

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
INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
	(1, 1);
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

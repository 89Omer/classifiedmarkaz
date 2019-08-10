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


-- Dumping database structure for classified_webapp
DROP DATABASE IF EXISTS `classified_webapp`;
CREATE DATABASE IF NOT EXISTS `classified_webapp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `classified_webapp`;

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
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `county` DISABLE KEYS */;
/*!40000 ALTER TABLE `county` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
/*!40000 ALTER TABLE `language` ENABLE KEYS */;

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
  CONSTRAINT `FK_messages_post_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.messages: ~0 rows (approximately)
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
/*!40000 ALTER TABLE `messages_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages_thread` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transaction` ENABLE KEYS */;

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
  CONSTRAINT `FK_point_system_post_id` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_point_system_user_id` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.point_system: ~0 rows (approximately)
/*!40000 ALTER TABLE `point_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_system` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.post
DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
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
  `last_renewed_on` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_category` (`category_id`),
  KEY `post_user_account` (`user_account_id`),
  CONSTRAINT `post_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `post_user_account` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.post: ~0 rows (approximately)
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.post_alert
DROP TABLE IF EXISTS `post_alert`;
CREATE TABLE IF NOT EXISTS `post_alert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_account_id` int(10) unsigned NOT NULL,
  `create_date` date NOT NULL,
  `valid_for` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `search_context` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_alert_category` (`category_id`),
  KEY `post_alert_user_account` (`user_account_id`),
  CONSTRAINT `post_alert_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `post_alert_user_account` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.post_alert: ~0 rows (approximately)
/*!40000 ALTER TABLE `post_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_alert` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.post_attribute
DROP TABLE IF EXISTS `post_attribute`;
CREATE TABLE IF NOT EXISTS `post_attribute` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_attribute` text NOT NULL,
  `is_favourite` enum('1','0') DEFAULT '0',
  PRIMARY KEY (`post_id`),
  CONSTRAINT `post_property_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.post_attribute: ~0 rows (approximately)
/*!40000 ALTER TABLE `post_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_attribute` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.post_image
DROP TABLE IF EXISTS `post_image`;
CREATE TABLE IF NOT EXISTS `post_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `image` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Table_11_post` (`post_id`),
  CONSTRAINT `Table_11_post` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.post_image: ~0 rows (approximately)
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
/*!40000 ALTER TABLE `state` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.sub_category
DROP TABLE IF EXISTS `sub_category`;
CREATE TABLE IF NOT EXISTS `sub_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subcatagory_name` varchar(255) NOT NULL,
  `parent_category_id` int(10) unsigned DEFAULT NULL,
  `maximum_images_allowed` int(10) unsigned NOT NULL,
  `post_validity_interval_in_days` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_category_id` (`parent_category_id`),
  CONSTRAINT `sub_category_id` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table classified_webapp.sub_category: ~0 rows (approximately)
/*!40000 ALTER TABLE `sub_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `sub_category` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `user_latest_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_latest_searches` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `user_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_points` ENABLE KEYS */;

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
/*!40000 ALTER TABLE `variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `variants` ENABLE KEYS */;

-- Dumping structure for table classified_webapp.variant_value
DROP TABLE IF EXISTS `variant_value`;
CREATE TABLE IF NOT EXISTS `variant_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) NOT NULL,
  `value` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_value_variant_id` (`variant_id`),
  CONSTRAINT `FK_value_variant_id` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table classified_webapp.variant_value: ~0 rows (approximately)
/*!40000 ALTER TABLE `variant_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `variant_value` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

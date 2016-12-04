-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.17-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for bookmark
CREATE DATABASE IF NOT EXISTS `bookmark` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bookmark`;


-- Dumping structure for table bookmark.bookmark_accounts
CREATE TABLE IF NOT EXISTS `bookmark_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `snowflake` int(11) NOT NULL,
  `verified` bit(1) NOT NULL DEFAULT b'0',
  `type` int(11) NOT NULL,
  `timezone` varchar(100) NOT NULL DEFAULT 'N/A',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` bit(1) DEFAULT b'1',
  `last_ip` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `snowflake` (`snowflake`),
  KEY `FK_bookmark_accounts_bookmark_account_types` (`type`),
  CONSTRAINT `FK_bookmark_accounts_bookmark_account_types` FOREIGN KEY (`type`) REFERENCES `bookmark_account_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_account_types
CREATE TABLE IF NOT EXISTS `bookmark_account_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_chapters
CREATE TABLE IF NOT EXISTS `bookmark_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `volume_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `is_released` bit(1) NOT NULL,
  `release_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` text NOT NULL,
  `teaser` text NOT NULL,
  `views` bigint(20) NOT NULL DEFAULT '0',
  `allow_comments` bit(1) NOT NULL DEFAULT b'1',
  `require_comment_verification` bit(1) NOT NULL DEFAULT b'0',
  `site_id` int(11) NOT NULL,
  `external_url` text NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapters_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_chapters_bookmark_stories` (`story_id`),
  KEY `FK_bookmark_chapters_bookmark_volumes` (`volume_id`),
  KEY `FK_bookmark_chapters_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_chapters_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_chapters_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`),
  CONSTRAINT `FK_bookmark_chapters_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`),
  CONSTRAINT `FK_bookmark_chapters_bookmark_volumes` FOREIGN KEY (`volume_id`) REFERENCES `bookmark_volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_chapter_comments
CREATE TABLE IF NOT EXISTS `bookmark_chapter_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  `pending_verification` bit(1) NOT NULL DEFAULT b'0',
  `comment` text NOT NULL,
  `reported` bit(1) NOT NULL DEFAULT b'0',
  `redacted` bit(1) DEFAULT b'0',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapter_comments_bookmark_chapters` (`chapter_id`),
  KEY `FK_bookmark_chapter_comments_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_chapter_comments_bookmark_accounts_2` (`updated_by`),
  CONSTRAINT `FK_bookmark_chapter_comments_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_chapter_comments_bookmark_accounts_2` FOREIGN KEY (`updated_by`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_chapter_comments_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_chapter_content
CREATE TABLE IF NOT EXISTS `bookmark_chapter_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `revision` int(11) NOT NULL DEFAULT '1',
  `revision_note` text NOT NULL,
  `content` longtext NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapter_content_bookmark_chapters` (`chapter_id`),
  KEY `FK_bookmark_chapter_content_bookmark_accounts` (`editor_id`),
  KEY `FK_bookmark_chapter_content_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_chapter_content_bookmark_accounts` FOREIGN KEY (`editor_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_chapter_content_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`),
  CONSTRAINT `FK_bookmark_chapter_content_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_donation_balances
CREATE TABLE IF NOT EXISTS `bookmark_donation_balances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `story_id` (`story_id`,`account_id`),
  KEY `FK_bookmark_donation_balances_bookmark_accounts` (`account_id`),
  CONSTRAINT `FK_bookmark_donation_balances_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_patreon_balances_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_early_chapter_unlocks
CREATE TABLE IF NOT EXISTS `bookmark_early_chapter_unlocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_early_chapter_access_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_early_chapter_access_bookmark_chapters` (`chapter_id`),
  CONSTRAINT `FK_bookmark_early_chapter_access_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_early_chapter_access_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_groups
CREATE TABLE IF NOT EXISTS `bookmark_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `can_admin` bit(1) NOT NULL,
  `can_author` bit(1) NOT NULL,
  `can_edit` bit(1) NOT NULL,
  `can_release` bit(1) NOT NULL,
  `can_moderate` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_groups_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_groups_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_group_members
CREATE TABLE IF NOT EXISTS `bookmark_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_group_members_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_group_members_bookmark_groups` (`group_id`),
  CONSTRAINT `FK_bookmark_group_members_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_group_members_bookmark_groups` FOREIGN KEY (`group_id`) REFERENCES `bookmark_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_nonces
CREATE TABLE IF NOT EXISTS `bookmark_nonces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nonce` varchar(100) NOT NULL,
  `origin` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_reports
CREATE TABLE IF NOT EXISTS `bookmark_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_reports_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_reports_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_reports_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_reports_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_revision_comments
CREATE TABLE IF NOT EXISTS `bookmark_revision_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `begin_index` int(11) NOT NULL,
  `end_index` int(11) NOT NULL,
  `comment` text NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_revision_comments_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_revision_comments_bookmark_revision_comments` (`revision_id`),
  CONSTRAINT `FK_bookmark_revision_comments_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_revision_comments_bookmark_revision_comments` FOREIGN KEY (`revision_id`) REFERENCES `bookmark_chapter_content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_revision_diffs
CREATE TABLE IF NOT EXISTS `bookmark_revision_diffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_reivision` int(11) NOT NULL,
  `to_revision` int(11) NOT NULL,
  `diff` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_revision_diffs_bookmark_chapter_content` (`from_reivision`),
  KEY `FK_bookmark_revision_diffs_bookmark_chapter_content_2` (`to_revision`),
  CONSTRAINT `FK_bookmark_revision_diffs_bookmark_chapter_content` FOREIGN KEY (`from_reivision`) REFERENCES `bookmark_chapter_content` (`id`),
  CONSTRAINT `FK_bookmark_revision_diffs_bookmark_chapter_content_2` FOREIGN KEY (`to_revision`) REFERENCES `bookmark_chapter_content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_sessions
CREATE TABLE IF NOT EXISTS `bookmark_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `session_key` varchar(255) NOT NULL,
  `ip_address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_sessions_bookmark_accounts` (`account_id`),
  CONSTRAINT `FK_bookmark_sessions_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_sites
CREATE TABLE IF NOT EXISTS `bookmark_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `premium_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_sites_bookmark_accounts` (`owner_id`),
  CONSTRAINT `FK_bookmark_sites_bookmark_accounts` FOREIGN KEY (`owner_id`) REFERENCES `bookmark_accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_site_members
CREATE TABLE IF NOT EXISTS `bookmark_site_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_site_members_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_site_members_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_site_members_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_site_members_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_stories
CREATE TABLE IF NOT EXISTS `bookmark_stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `cover_url` varchar(1000) NOT NULL,
  `allow_donations` bit(1) NOT NULL,
  `dollars_per_chapter` int(11) NOT NULL,
  `base_donated` int(11) NOT NULL,
  `current_donated` int(11) NOT NULL,
  `donation_per_early_preview` int(11) NOT NULL,
  `chapters_unlocked` int(11) NOT NULL,
  `paypal_id_email` varchar(255) NOT NULL,
  `patreon_id` varchar(255) NOT NULL,
  `patreon_secret` varchar(255) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `source_url` varchar(1000) NOT NULL,
  `ongoing` bit(1) NOT NULL,
  `translation` bit(1) NOT NULL,
  `notes` text NOT NULL,
  `nu_url` varchar(255) NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_stories_bookmark_sites` (`site_id`),
  KEY `FK_bookmark_stories_bookmark_accounts` (`owner_id`),
  CONSTRAINT `FK_bookmark_stories_bookmark_accounts` FOREIGN KEY (`owner_id`) REFERENCES `bookmark_accounts` (`id`),
  CONSTRAINT `FK_bookmark_stories_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_toc
CREATE TABLE IF NOT EXISTS `bookmark_toc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `link_position` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `story_id_link_position` (`story_id`,`link_position`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table bookmark.bookmark_volumes
CREATE TABLE IF NOT EXISTS `bookmark_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) NOT NULL,
  `vanity_name` varchar(255) NOT NULL,
  `cover_url` varchar(1000) NOT NULL,
  `story_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_volumes_bookmark_stories` (`story_id`),
  KEY `FK_bookmark_volumes_bookmark_sites` (`site_id`),
  CONSTRAINT `FK_bookmark_volumes_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`),
  CONSTRAINT `FK_bookmark_volumes_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

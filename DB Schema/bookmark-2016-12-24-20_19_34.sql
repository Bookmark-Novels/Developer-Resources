-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 24, 2016 at 08:19 PM
-- Server version: 10.1.20-MariaDB
-- PHP Version: 7.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookmark`
--
CREATE DATABASE IF NOT EXISTS `bookmark` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `bookmark`;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_accounts`
--

CREATE TABLE IF NOT EXISTS `bookmark_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `verified` bit(1) NOT NULL DEFAULT b'0',
  `account_type` int(11) NOT NULL,
  `timezone` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT 'N/A',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_bookmark_accounts_bookmark_account_types` (`account_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_account_types`
--

CREATE TABLE IF NOT EXISTS `bookmark_account_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `bookmark_account_types`
--

INSERT INTO `bookmark_account_types` (`id`, `display_name`) VALUES
(1, 'Admin'),
(2, 'Native'),
(3, 'Novel_Updates'),
(4, 'Global_Moderator'),
(5, 'Engineer');

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_chapters`
--

CREATE TABLE IF NOT EXISTS `bookmark_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `volume_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `vanity_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `is_released` bit(1) NOT NULL,
  `release_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` mediumtext COLLATE utf8_bin NOT NULL,
  `teaser` mediumtext COLLATE utf8_bin NOT NULL,
  `views` bigint(20) NOT NULL DEFAULT '0',
  `allow_comments` bit(1) NOT NULL DEFAULT b'1',
  `require_comment_verification` bit(1) NOT NULL DEFAULT b'0',
  `site_id` int(11) NOT NULL,
  `external_url` mediumtext COLLATE utf8_bin NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapters_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_chapters_bookmark_stories` (`story_id`),
  KEY `FK_bookmark_chapters_bookmark_volumes` (`volume_id`),
  KEY `FK_bookmark_chapters_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_chapter_comments`
--

CREATE TABLE IF NOT EXISTS `bookmark_chapter_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int(11) DEFAULT NULL,
  `pending_verification` bit(1) NOT NULL DEFAULT b'0',
  `comment` mediumtext COLLATE utf8_bin NOT NULL,
  `reported` bit(1) NOT NULL DEFAULT b'0',
  `redacted` bit(1) DEFAULT b'0',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapter_comments_bookmark_chapters` (`chapter_id`),
  KEY `FK_bookmark_chapter_comments_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_chapter_comments_bookmark_accounts_2` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_chapter_content`
--

CREATE TABLE IF NOT EXISTS `bookmark_chapter_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `revision` int(11) NOT NULL DEFAULT '1',
  `revision_note` mediumtext COLLATE utf8_bin NOT NULL,
  `content` longtext COLLATE utf8_bin NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_chapter_content_bookmark_chapters` (`chapter_id`),
  KEY `FK_bookmark_chapter_content_bookmark_accounts` (`editor_id`),
  KEY `FK_bookmark_chapter_content_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_donation_balances`
--

CREATE TABLE IF NOT EXISTS `bookmark_donation_balances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `balance` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `story_id` (`story_id`,`account_id`),
  KEY `FK_bookmark_donation_balances_bookmark_accounts` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_early_chapter_unlocks`
--

CREATE TABLE IF NOT EXISTS `bookmark_early_chapter_unlocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_early_chapter_access_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_early_chapter_access_bookmark_chapters` (`chapter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_groups`
--

CREATE TABLE IF NOT EXISTS `bookmark_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `vanity_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `can_admin` bit(1) NOT NULL,
  `can_author` bit(1) NOT NULL,
  `can_edit` bit(1) NOT NULL,
  `can_release` bit(1) NOT NULL,
  `can_moderate` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_groups_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_group_members`
--

CREATE TABLE IF NOT EXISTS `bookmark_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_group_members_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_group_members_bookmark_groups` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_instances`
--

CREATE TABLE IF NOT EXISTS `bookmark_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `instance_name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_id` (`instance_id`),
  UNIQUE KEY `instance_name` (`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_nonces`
--

CREATE TABLE IF NOT EXISTS `bookmark_nonces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nonce` varchar(100) COLLATE utf8_bin NOT NULL,
  `origin` varchar(50) COLLATE utf8_bin NOT NULL,
  `expires` datetime NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_nonces_bookmark_instances` (`origin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_reports`
--

CREATE TABLE IF NOT EXISTS `bookmark_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `reason` mediumtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_reports_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_reports_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_revision_comments`
--

CREATE TABLE IF NOT EXISTS `bookmark_revision_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `begin_index` int(11) NOT NULL,
  `end_index` int(11) NOT NULL,
  `comment` mediumtext COLLATE utf8_bin NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_revision_comments_bookmark_accounts` (`author_id`),
  KEY `FK_bookmark_revision_comments_bookmark_revision_comments` (`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_revision_diffs`
--

CREATE TABLE IF NOT EXISTS `bookmark_revision_diffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_reivision` int(11) NOT NULL,
  `to_revision` int(11) NOT NULL,
  `diff` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_revision_diffs_bookmark_chapter_content` (`from_reivision`),
  KEY `FK_bookmark_revision_diffs_bookmark_chapter_content_2` (`to_revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_sessions`
--

CREATE TABLE IF NOT EXISTS `bookmark_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `session_key` varchar(255) COLLATE utf8_bin NOT NULL,
  `ip_address` varchar(100) COLLATE utf8_bin NOT NULL,
  `last_use` datetime NOT NULL,
  `is_active` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_sessions_bookmark_accounts` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_sites`
--

CREATE TABLE IF NOT EXISTS `bookmark_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) NOT NULL,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `vanity_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `premium_expire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_sites_bookmark_accounts` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_site_members`
--

CREATE TABLE IF NOT EXISTS `bookmark_site_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_site_members_bookmark_accounts` (`account_id`),
  KEY `FK_bookmark_site_members_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_stories`
--

CREATE TABLE IF NOT EXISTS `bookmark_stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `vanity_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `allow_donations` bit(1) NOT NULL,
  `dollars_per_chapter` int(11) NOT NULL,
  `base_donated` int(11) NOT NULL,
  `current_donated` int(11) NOT NULL,
  `donation_per_early_preview` int(11) NOT NULL,
  `chapters_unlocked` int(11) NOT NULL,
  `paypal_id_email` varchar(255) COLLATE utf8_bin NOT NULL,
  `patreon_id` varchar(255) COLLATE utf8_bin NOT NULL,
  `patreon_secret` varchar(255) COLLATE utf8_bin NOT NULL,
  `owner_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `author` varchar(255) COLLATE utf8_bin NOT NULL,
  `source_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `ongoing` bit(1) NOT NULL,
  `translation` bit(1) NOT NULL,
  `notes` mediumtext COLLATE utf8_bin NOT NULL,
  `nu_url` varchar(255) COLLATE utf8_bin NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_stories_bookmark_sites` (`site_id`),
  KEY `FK_bookmark_stories_bookmark_accounts` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_toc`
--

CREATE TABLE IF NOT EXISTS `bookmark_toc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `link_position` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `story_id_link_position` (`story_id`,`link_position`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bookmark_volumes`
--

CREATE TABLE IF NOT EXISTS `bookmark_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `vanity_name` varchar(255) COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(1000) COLLATE utf8_bin NOT NULL,
  `story_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `private` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_bookmark_volumes_bookmark_stories` (`story_id`),
  KEY `FK_bookmark_volumes_bookmark_sites` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmark_accounts`
--
ALTER TABLE `bookmark_accounts`
  ADD CONSTRAINT `FK_bookmark_accounts_bookmark_account_types` FOREIGN KEY (`account_type`) REFERENCES `bookmark_account_types` (`id`);

--
-- Constraints for table `bookmark_chapters`
--
ALTER TABLE `bookmark_chapters`
  ADD CONSTRAINT `FK_bookmark_chapters_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapters_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapters_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapters_bookmark_volumes` FOREIGN KEY (`volume_id`) REFERENCES `bookmark_volumes` (`id`);

--
-- Constraints for table `bookmark_chapter_comments`
--
ALTER TABLE `bookmark_chapter_comments`
  ADD CONSTRAINT `FK_bookmark_chapter_comments_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapter_comments_bookmark_accounts_2` FOREIGN KEY (`updated_by`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapter_comments_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`);

--
-- Constraints for table `bookmark_chapter_content`
--
ALTER TABLE `bookmark_chapter_content`
  ADD CONSTRAINT `FK_bookmark_chapter_content_bookmark_accounts` FOREIGN KEY (`editor_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapter_content_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`),
  ADD CONSTRAINT `FK_bookmark_chapter_content_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`);

--
-- Constraints for table `bookmark_donation_balances`
--
ALTER TABLE `bookmark_donation_balances`
  ADD CONSTRAINT `FK_bookmark_donation_balances_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_patreon_balances_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`);

--
-- Constraints for table `bookmark_early_chapter_unlocks`
--
ALTER TABLE `bookmark_early_chapter_unlocks`
  ADD CONSTRAINT `FK_bookmark_early_chapter_access_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_early_chapter_access_bookmark_chapters` FOREIGN KEY (`chapter_id`) REFERENCES `bookmark_chapters` (`id`);

--
-- Constraints for table `bookmark_groups`
--
ALTER TABLE `bookmark_groups`
  ADD CONSTRAINT `FK_bookmark_groups_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`);

--
-- Constraints for table `bookmark_group_members`
--
ALTER TABLE `bookmark_group_members`
  ADD CONSTRAINT `FK_bookmark_group_members_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_group_members_bookmark_groups` FOREIGN KEY (`group_id`) REFERENCES `bookmark_groups` (`id`);

--
-- Constraints for table `bookmark_nonces`
--
ALTER TABLE `bookmark_nonces`
  ADD CONSTRAINT `FK_bookmark_nonces_bookmark_instances` FOREIGN KEY (`origin`) REFERENCES `bookmark_instances` (`instance_id`);

--
-- Constraints for table `bookmark_reports`
--
ALTER TABLE `bookmark_reports`
  ADD CONSTRAINT `FK_bookmark_reports_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_reports_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`);

--
-- Constraints for table `bookmark_revision_comments`
--
ALTER TABLE `bookmark_revision_comments`
  ADD CONSTRAINT `FK_bookmark_revision_comments_bookmark_accounts` FOREIGN KEY (`author_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_revision_comments_bookmark_revision_comments` FOREIGN KEY (`revision_id`) REFERENCES `bookmark_chapter_content` (`id`);

--
-- Constraints for table `bookmark_revision_diffs`
--
ALTER TABLE `bookmark_revision_diffs`
  ADD CONSTRAINT `FK_bookmark_revision_diffs_bookmark_chapter_content` FOREIGN KEY (`from_reivision`) REFERENCES `bookmark_chapter_content` (`id`),
  ADD CONSTRAINT `FK_bookmark_revision_diffs_bookmark_chapter_content_2` FOREIGN KEY (`to_revision`) REFERENCES `bookmark_chapter_content` (`id`);

--
-- Constraints for table `bookmark_sessions`
--
ALTER TABLE `bookmark_sessions`
  ADD CONSTRAINT `FK_bookmark_sessions_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`);

--
-- Constraints for table `bookmark_sites`
--
ALTER TABLE `bookmark_sites`
  ADD CONSTRAINT `FK_bookmark_sites_bookmark_accounts` FOREIGN KEY (`owner_id`) REFERENCES `bookmark_accounts` (`id`);

--
-- Constraints for table `bookmark_site_members`
--
ALTER TABLE `bookmark_site_members`
  ADD CONSTRAINT `FK_bookmark_site_members_bookmark_accounts` FOREIGN KEY (`account_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_site_members_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`);

--
-- Constraints for table `bookmark_stories`
--
ALTER TABLE `bookmark_stories`
  ADD CONSTRAINT `FK_bookmark_stories_bookmark_accounts` FOREIGN KEY (`owner_id`) REFERENCES `bookmark_accounts` (`id`),
  ADD CONSTRAINT `FK_bookmark_stories_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`);

--
-- Constraints for table `bookmark_volumes`
--
ALTER TABLE `bookmark_volumes`
  ADD CONSTRAINT `FK_bookmark_volumes_bookmark_sites` FOREIGN KEY (`site_id`) REFERENCES `bookmark_sites` (`id`),
  ADD CONSTRAINT `FK_bookmark_volumes_bookmark_stories` FOREIGN KEY (`story_id`) REFERENCES `bookmark_stories` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

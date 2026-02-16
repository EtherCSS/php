-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 16, 2026 at 05:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qad_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `application_logs`
--

CREATE TABLE `application_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `actor_user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(80) NOT NULL,
  `from_step_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `to_step_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `from_status` varchar(60) DEFAULT NULL,
  `to_status` varchar(60) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `c1_requirements`
--

CREATE TABLE `c1_requirements` (
  `id` int(11) NOT NULL,
  `item_no` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `c1_requirements`
--

INSERT INTO `c1_requirements` (`id`, `item_no`, `description`) VALUES
(1, 1, 'Letter of Intent / Application'),
(2, 2, 'School Site / Location Documents'),
(3, 3, 'Building / Floor Plan / Safety Documents'),
(4, 4, 'Staffing / Personnel Requirements'),
(5, 5, 'Learning Resources / Equipment List'),
(6, 6, 'Community / Stakeholder Support Documents');

-- --------------------------------------------------------

--
-- Table structure for table `c1_responses`
--

CREATE TABLE `c1_responses` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `requirement_id` int(11) NOT NULL,
  `status` enum('provided','not_provided','na') NOT NULL DEFAULT 'not_provided',
  `remarks` text DEFAULT NULL,
  `evidence_file_id` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `body` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklists`
--

CREATE TABLE `checklists` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `personnel_id` int(11) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `has_missing` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checklists`
--

INSERT INTO `checklists` (`id`, `report_id`, `personnel_id`, `data`, `has_missing`, `created_at`, `updated_at`) VALUES
(3, 38, 25, '{\"requesting_office\":\"\",\"proponent_name\":\"\",\"position\":\"\",\"school_name\":\"\",\"address\":\"\",\"submit_deadline\":\" March 20, 2026\",\"documents_received_by\":\"\",\"documents_received_date\":\"\",\"item1\":true,\"item2\":true,\"item2a\":false,\"item2b\":false,\"item2c\":false,\"item2d\":false,\"item2e\":false,\"item3\":true,\"item4\":true,\"item5\":true,\"item6\":true,\"item7a\":true,\"item7b\":true,\"item8\":true,\"item9\":true,\"item10\":true,\"item11\":true,\"item12\":true,\"item13\":true,\"item14\":true,\"item15\":true,\"item16\":true,\"item17\":true,\"item18\":true,\"item19\":true,\"item20\":true,\"item20a\":false,\"item20b\":false,\"item20c\":false,\"item20d\":false,\"item21\":true,\"item22\":true,\"item23\":true}', 0, '2026-02-16 22:54:07', '2026-02-17 00:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversation_members`
--

CREATE TABLE `conversation_members` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `d1_evaluations`
--

CREATE TABLE `d1_evaluations` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `form_data` longtext DEFAULT NULL,
  `status` varchar(30) DEFAULT 'draft',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `d1_forms`
--

CREATE TABLE `d1_forms` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('draft','final') NOT NULL DEFAULT 'draft',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `submitted_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `d1_forms`
--

INSERT INTO `d1_forms` (`id`, `report_id`, `user_id`, `status`, `data`, `submitted_at`, `updated_at`) VALUES
(1, 38, 15, 'final', '{\"field_0\":\"\",\"field_1\":\"\",\"field_2\":\"\",\"field_3\":\"\",\"field_4\":\"\",\"field_5\":\"\",\"field_6\":\"\",\"field_7\":\"\",\"field_8\":\"\",\"sds_endorse\":\"\",\"field_11\":\"\",\"field_12\":\"\",\"field_13\":\"\",\"field_14\":\"\",\"field_15\":\"\",\"field_16\":\"\",\"field_17\":\"\",\"field_18\":\"\",\"field_19\":\"\",\"field_20\":\"\",\"field_21\":\"\",\"field_22\":\"\",\"field_23\":\"\",\"field_24\":\"\",\"field_25\":\"\",\"field_26\":\"\",\"field_27\":\"\",\"field_28\":\"\",\"field_29\":\"\",\"field_30\":\"\",\"field_31\":\"\",\"loc_class\":\"\",\"field_34\":\"0\",\"field_35\":\"0\",\"field_36\":\"0\",\"field_37\":\"\",\"field_38\":\"\",\"field_39\":\"\",\"field_40\":\"\",\"field_41\":\"\",\"field_42\":\"\",\"field_43\":\"\",\"field_44\":\"\",\"field_45\":\"\",\"field_46\":\"\",\"field_47\":\"\",\"field_48\":\"\",\"field_49\":\"\",\"field_50\":\"\",\"field_51\":\"\",\"field_52\":\"\",\"field_53\":\"\",\"field_54\":\"\",\"field_55\":\"\",\"field_56\":\"\",\"field_57\":\"\",\"field_58\":\"\",\"field_59\":\"\",\"field_60\":\"\",\"field_61\":\"\",\"field_62\":\"\",\"field_63\":\"\",\"field_64\":\"\",\"field_65\":\"\",\"bdg_ps\":\"\",\"field_68\":\"\",\"field_69\":\"\",\"field_70\":\"\",\"field_71\":\"\",\"field_72\":\"\",\"bdg_mooe\":\"\",\"field_75\":\"\",\"field_76\":\"\",\"field_77\":\"\",\"field_78\":\"\",\"field_79\":\"\",\"bdg_co\":\"\",\"field_82\":\"\",\"field_83\":\"\",\"field_84\":\"\",\"field_85\":\"\",\"field_86\":\"\",\"multi_year\":\"\",\"field_89\":\"\",\"fund_source\":\"\",\"field_92\":\"\",\"insp_1\":\"\",\"insp_2\":\"\",\"insp_3\":\"\",\"field_99\":\"\",\"field_100\":\"\",\"field_101\":\"\",\"field_102\":\"\",\"field_103\":\"\",\"field_104\":\"\",\"lgu_fin\":\"\",\"field_107\":\"\",\"field_108\":\"\",\"field_109\":\"\",\"field_110\":\"\",\"field_111\":\"\",\"field_112\":\"\",\"field_113\":\"\",\"field_114\":\"\",\"field_115\":\"\",\"field_116\":\"\",\"field_117\":\"\",\"field_118\":\"\",\"info_1\":\"\",\"info_2\":\"\",\"info_3\":\"\",\"info_4\":\"\",\"field_127\":\"\",\"field_128\":\"\",\"field_129\":\"\",\"field_130\":\"\",\"field_131\":\"\",\"field_132\":\"\",\"field_133\":\"\",\"field_134\":\"\",\"field_135\":\"\",\"field_136\":\"\",\"field_137\":\"\",\"field_138\":\"\",\"field_139\":\"\",\"field_140\":\"\",\"field_141\":\"\",\"field_142\":\"\",\"field_143\":\"\",\"field_144\":\"\",\"map_dist\":\"\",\"field_147\":\"\",\"field_148\":\"\",\"field_149\":\"\",\"field_150\":\"\",\"field_151\":\"\",\"field_152\":\"\",\"field_153\":\"\",\"field_154\":\"\",\"field_155\":\"\",\"field_156\":\"\",\"field_157\":\"\",\"field_158\":\"\",\"field_159\":\"\",\"field_160\":\"\",\"field_161\":\"\",\"field_162\":\"\",\"field_163\":\"\",\"deed_deped\":\"\",\"field_166\":\"\",\"field_167\":\"\",\"field_168\":\"\",\"field_169\":\"\",\"field_170\":\"\",\"field_171\":\"\",\"field_172\":\"\",\"field_173\":\"\",\"field_174\":\"\",\"field_175\":\"\",\"field_176\":\"\",\"safe_risk\":\"\",\"field_179\":\"\",\"field_180\":\"\",\"field_181\":\"\",\"field_182\":\"\",\"field_183\":\"\",\"specs_att\":\"\",\"comp_std\":\"\",\"field_188\":\"\",\"field_189\":\"\",\"field_190\":\"\",\"field_191\":\"\",\"field_192\":\"\",\"field_193\":\"\",\"field_194\":\"\",\"field_195\":\"\",\"field_196\":\"\",\"field_197\":\"\",\"field_198\":\"\",\"field_199\":\"\",\"field_200\":\"\",\"field_201\":\"\",\"field_202\":\"\",\"field_203\":\"\",\"field_204\":\"\",\"field_205\":\"\",\"field_206\":\"\",\"field_207\":\"\",\"field_208\":\"\",\"field_209\":\"\",\"field_210\":\"\",\"field_211\":\"\",\"borrow_1\":\"\",\"borrow_2\":\"\",\"borrow_3\":\"\",\"field_218\":\"\",\"field_219\":\"\",\"field_220\":\"\",\"field_221\":\"\",\"field_222\":\"\",\"field_223\":\"\",\"field_224\":\"\",\"field_225\":\"\",\"field_226\":\"\",\"field_227\":\"\",\"field_228\":\"\",\"field_229\":\"\",\"field_230\":\"\",\"field_231\":\"\",\"field_232\":\"\"}', '2026-02-17 00:31:08', '2026-02-17 00:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `d1_indicators`
--

CREATE TABLE `d1_indicators` (
  `id` int(11) NOT NULL,
  `section` varchar(120) NOT NULL,
  `code` varchar(50) NOT NULL,
  `criteria` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `d1_indicators`
--

INSERT INTO `d1_indicators` (`id`, `section`, `code`, `criteria`) VALUES
(1, 'A. Legal & Documentary', 'D1-A1', 'Documents complete and consistent with requirements'),
(2, 'A. Legal & Documentary', 'D1-A2', 'School profile and proposed offering are valid'),
(3, 'B. Facilities', 'D1-B1', 'Facilities meet minimum standards'),
(4, 'B. Facilities', 'D1-B2', 'Safety compliance present (fire exits, hazards, etc.)'),
(5, 'C. Personnel', 'D1-C1', 'Staffing meets required qualifications'),
(6, 'D. Readiness', 'D1-D1', 'Readiness for opening confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `d1_responses`
--

CREATE TABLE `d1_responses` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `indicator_id` int(11) NOT NULL,
  `result` enum('passed','failed') NOT NULL DEFAULT 'failed',
  `fail_reason` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` int(11) NOT NULL,
  `school_id_ref` varchar(50) DEFAULT NULL,
  `sdo_evaluator` varchar(100) DEFAULT NULL,
  `application_type` varchar(50) NOT NULL,
  `q1_gaps` text DEFAULT NULL,
  `q2_access` text DEFAULT NULL,
  `q3_support` text DEFAULT NULL,
  `q4_site` text DEFAULT NULL,
  `q5_facilities` text DEFAULT NULL,
  `q6_enrollment` text DEFAULT NULL,
  `q7_personnel` text DEFAULT NULL,
  `q8_resources` text DEFAULT NULL,
  `q9_sustainability` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluations`
--

INSERT INTO `evaluations` (`id`, `school_id_ref`, `sdo_evaluator`, `application_type`, `q1_gaps`, `q2_access`, `q3_support`, `q4_site`, `q5_facilities`, `q6_enrollment`, `q7_personnel`, `q8_resources`, `q9_sustainability`, `recommendations`, `created_at`) VALUES
(1, '12313', 'juan', '', 'dadags', 'vsvssv', 'faf', 'fsfsfs', 'sfsfs', 'fefe', 'sfsf', 'sfs', 'fs', 'sfsfs', '2026-02-07 22:00:33'),
(13, '23121', 'John', 'Separation', 'gfgcgsgc', 'gscssg', 'sgcsgdc', 'gssggdsc', 'csgss', 'dscsgsc', 'scgsg', 'scsg', 'scsgs', 'cssgsgssgcs', '2026-02-14 09:57:31');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_sheets`
--

CREATE TABLE `evaluation_sheets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `has_failed` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_path` varchar(255) NOT NULL,
  `mime` varchar(120) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `doc_tag` enum('c1','d1','ocular','final_report','other') DEFAULT 'other',
  `version` int(11) DEFAULT 1,
  `uploaded_by` int(11) DEFAULT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `final_reports`
--

CREATE TABLE `final_reports` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `background` text DEFAULT NULL,
  `findings_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`findings_json`)),
  `recommendations_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`recommendations_json`)),
  `prepared_by` int(11) DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `pdf_file_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ocular_inspections`
--

CREATE TABLE `ocular_inspections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `complied` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ocular_items`
--

CREATE TABLE `ocular_items` (
  `id` int(11) NOT NULL,
  `category` varchar(120) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ocular_items`
--

INSERT INTO `ocular_items` (`id`, `category`, `code`, `description`) VALUES
(1, 'Facilities', 'OC-F1', 'Classrooms available and suitable'),
(2, 'Facilities', 'OC-F2', 'Toilets and handwashing facilities'),
(3, 'Facilities', 'OC-F3', 'Library / learning resource area'),
(4, 'Facilities', 'OC-F4', 'Playground / activity area'),
(5, 'Safety', 'OC-S1', 'Fire safety measures present'),
(6, 'Safety', 'OC-S2', 'Safe stairs/ramps, clear pathways'),
(7, 'Environment', 'OC-E1', 'Free from hazards (noise, pollution, flooding)'),
(8, 'Administration', 'OC-A1', 'Stakeholder/community support evident'),
(9, 'Administration', 'OC-A2', 'Learning materials ready'),
(10, 'Outcome', 'OC-O1', 'Recommendation decision recorded');

-- --------------------------------------------------------

--
-- Table structure for table `ocular_responses`
--

CREATE TABLE `ocular_responses` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `ocular_item_id` int(11) NOT NULL,
  `result` enum('complied','not_complied','na') NOT NULL DEFAULT 'not_complied',
  `remarks` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `school_name` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `sdo` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `school_year` varchar(20) DEFAULT NULL,
  `quarter` varchar(10) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `type` varchar(100) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `status` enum('pending','received','forwarded','processing','compliance','inspection','approved','disapproved') NOT NULL DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_received` datetime DEFAULT NULL,
  `assigned_to` int(11) DEFAULT NULL,
  `application_no` varchar(64) DEFAULT NULL,
  `level_applied` varchar(120) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_email` varchar(180) DEFAULT NULL,
  `contact_phone` varchar(64) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `c1_completed` tinyint(1) DEFAULT 0,
  `d1_completed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `school_name`, `user_id`, `owner_name`, `sdo`, `title`, `school_year`, `quarter`, `category`, `type`, `filename`, `status`, `remarks`, `created_at`, `date_received`, `assigned_to`, `application_no`, `level_applied`, `address`, `contact_email`, `contact_phone`, `updated_at`, `c1_completed`, `d1_completed`) VALUES
(38, '', 39, 'John', 'Unassigned', 'New App: jimmy', NULL, NULL, NULL, 'School Application (Separation)', 'EVAL:13', 'received', NULL, '2026-02-14 01:57:31', NULL, 25, NULL, NULL, NULL, NULL, NULL, '2026-02-17 00:34:01', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `report_actions`
--

CREATE TABLE `report_actions` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `actor_role` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report_actions`
--

INSERT INTO `report_actions` (`id`, `report_id`, `actor_id`, `actor_role`, `action`, `from_status`, `to_status`, `notes`, `created_at`) VALUES
(1, 27, 15, 'admin', 'ADMIN_SET_STATUS', '', 'eps_review', NULL, '2026-02-11 19:48:00'),
(2, 27, 15, 'admin', 'ADMIN_SET_STATUS', 'received', 'approved', NULL, '2026-02-11 20:05:35'),
(3, 27, 15, 'admin', 'ADMIN_SET_STATUS', 'approved', 'rd_review', NULL, '2026-02-11 20:05:38'),
(4, 27, 15, 'admin', 'ADMIN_SET_STATUS', '', 'forwarded_to_rd', NULL, '2026-02-11 20:05:43'),
(5, 27, 15, 'admin', 'ADMIN_SET_STATUS', '', 'eps_recommended', NULL, '2026-02-11 20:05:45'),
(6, 27, 15, 'admin', 'ADMIN_SET_STATUS', '', 'inspection', NULL, '2026-02-11 20:05:47'),
(7, 27, 15, 'admin', 'ADMIN_SET_STATUS', '', 'approved', NULL, '2026-02-11 20:05:54'),
(8, 27, 15, 'admin', 'ADMIN_SET_STATUS', 'approved', 'received', NULL, '2026-02-11 20:05:57'),
(9, 27, 15, 'admin', 'ADMIN_SET_STATUS', 'received', 'eps_review', NULL, '2026-02-11 20:06:05'),
(10, 28, 26, 'sdo', 'UPLOAD', NULL, 'submitted', NULL, '2026-02-11 20:09:12'),
(11, 29, 26, 'sdo', 'UPLOAD', NULL, 'submitted', NULL, '2026-02-11 20:09:12'),
(12, 28, 15, 'admin', 'ADMIN_SET_STATUS', '', 'received', NULL, '2026-02-11 20:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `report_logs`
--

CREATE TABLE `report_logs` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `actor_role` varchar(50) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_status_history`
--

CREATE TABLE `report_status_history` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `old_status` varchar(32) DEFAULT NULL,
  `new_status` varchar(32) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_tracking`
--

CREATE TABLE `report_tracking` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `id` int(11) NOT NULL,
  `school_id` varchar(50) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `contact_number` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `school_id`, `name`, `address`, `level`, `division`, `contact_number`, `email`) VALUES
(1, '12313', 'JOHN A RIB', 'SAMAR', 'Junior High School', 'Unassigned', '09661035295', 'johnrib.cananga001@deped.gov.ph'),
(2, '12313', 'JOHN A RIB', 'SAMAR', '', 'Unassigned', '09661035295', 'johnrib.cananga001@deped.gov.ph'),
(3, '12313', 'JOHN A RIB', 'SAMAR', 'Junior High School', 'Unassigned', '09661035295', 'johnrib.cananga001@deped.gov.ph'),
(4, '', 'jimmy', '2332', 'Senior High School', 'Unassigned', '131321', 'admin@deped.gov.ph'),
(5, '131', '131', '313', 'Elementary', 'Unassigned', '313', 'jorafear25@gmail.com'),
(6, '', 'JOHN A RIB', 'eqweqqe', 'Senior High School', 'Unassigned', 'qeqeq', 'johnrib.cananga001@deped.gov.ph'),
(7, '', 'dsdsad', 'sdad', 'Kindergarten', 'Unassigned', 'adad', 'daads@deped.gov.ph'),
(8, '', 'eqwewe', 'weqeqw', '', 'Unassigned', '', ''),
(9, 'erere', 'sdsdd', 'sda', 'Junior High School', 'Unassigned', 'rerererere', 'rerere'),
(10, '', 'wdqdw', 'wdqdw', '', 'Unassigned', '', ''),
(11, 'eqeq', 'qeqe', 'qeqe', 'Kindergarten', 'Unassigned', 'qeqe', 'qeq'),
(12, 'w2223223', '32323', '2322', 'Senior High School', 'Unassigned', '2323', 'jorafear25@gmail.com'),
(13, '23121', 'jimmy', '2332', '', 'Unassigned', '131321', 'admin@deped.gov.ph');

-- --------------------------------------------------------

--
-- Table structure for table `status_history`
--

CREATE TABLE `status_history` (
  `id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `from_status` varchar(40) DEFAULT NULL,
  `to_status` varchar(40) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','sdo','school') DEFAULT 'school',
  `sdo` varchar(100) DEFAULT 'Unassigned',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `sdo`, `created_at`) VALUES
(1, 'System Admin', 'admin@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'admin', 'Unassigned', '2026-02-06 01:19:23'),
(2, 'SDO Baybay City', 'sdo.baybay@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(3, 'SDO Biliran', 'sdo.biliran@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(4, 'SDO Borongan City', 'sdo.borongan@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(5, 'SDO Calbayog City', 'sdo.calbayog@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(6, 'SDO Catbalogan City', 'sdo.catbalogan@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(7, 'SDO Eastern Samar', 'sdo.easternsamar@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(8, 'SDO Leyte', 'sdo.leyte@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(9, 'SDO Maasin City', 'sdo.maasin@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(10, 'SDO Northern Samar', 'sdo.northernsamar@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(11, 'SDO Ormoc City', 'sdo.ormoc@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(12, 'SDO Samar', 'sdo.samar@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(13, 'SDO Southern Leyte', 'sdo.southernleyte@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(14, 'SDO Tacloban City', 'sdo.tacloban@deped.gov.ph', '$2y$10$ThH4.0v.Xv/gLzDk.u.xZO/G.hE6fG.hE6fG.hE6fG.hE6fG.hE6', 'sdo', 'Unassigned', '2026-02-06 01:19:24'),
(15, 'jimmy', 'johnrib.cananga001@deped.gov.ph', '$2y$10$qJUGewblRPj/AiV7LIEouuL9oTIIw6Fs0W7rMtDVIQs98T1DiHrxS', 'admin', 'Unassigned', '2026-02-06 05:35:31'),
(17, 'rem', 'rem001@deped.gov.ph', '$2y$10$z4unbR2h56JG1Bp2/Fluk.DTKfKhDMBljjjzLchln.IYFm50lInRO', 'school', 'Unassigned', '2026-02-06 06:06:13'),
(18, '123', '123001@deped.gov.ph', '$2y$10$vIiS4jYzrpDpgV1xJRVvV.9wKL729SdQ6NRvMsAXNuofP95SgLyLu', 'admin', 'Unassigned', '2026-02-06 06:17:05'),
(19, '12', '12001@deped.gov.ph', '$2y$10$8r/AogERe32eljSbjy48iOd/vQzfpdaGsMTKFJrJ3tb/Ph2ao9dQC', 'school', 'Unassigned', '2026-02-06 06:17:38'),
(20, 'samar', 'samar001@deped.gov.ph', '$2y$10$4ctlJReNiTSnxvqZ5zz/7.hTCOZ7VX4qVqXyS/decwMbb9qk.bV7a', 'school', 'Unassigned', '2026-02-06 07:03:27'),
(22, 'jimmy', 'adminn@deped.gov.ph', '$2y$10$mhxg..TYggGUEf.DlTZIPuiCZx9TtxJcn1LAgStRc6lvpTU69BSPy', 'sdo', 'Unassigned', '2026-02-06 11:26:25'),
(24, 'REX', 'sdoo.calbayog@deped.gov.ph', '$2y$10$XQj2YECJTxNtz8Tgm1hUru2aXyijgATCCdxhDwClHmjFuT2Zz9SPe', 'sdo', 'Unassigned', '2026-02-06 11:59:37'),
(25, 'Sonny', 'sonny001@deped.gov.ph', '$2y$10$muUnvtQq6C9mI3svQBaXpui6JELwYs3PMwAm32oo1e.HkGQLS5UT2', 'admin', 'SDO BAYBAY CITY', '2026-02-07 01:49:00'),
(26, 'juan', 'juan@deped.gov.ph', '$2y$10$oZ25cQ/9fI3SzKWoz8ama.mziG2mJBzaGj1re7/GZWzM0OKMUwrPK', 'sdo', 'Unassigned', '2026-02-07 01:49:44'),
(27, 'sonny', 'sonny@deped.gov.ph', '$2y$10$TuSC3SXyIx5oeCy9VFMonuvlLHlXzbLs6kMSu7TO6ZgavP4nCIiYy', 'sdo', 'Unassigned', '2026-02-07 15:01:45'),
(28, 'rex', 'rex@deped.gov.ph', '$2y$10$0Ufd16N6FM0qLOyfOta8VOzznJQ1R/sr71YbymMHeXJJjB1zWfdA.', 'sdo', 'SDO-REX', '2026-02-08 13:37:02'),
(29, 'victoria', 'victoria@deped.gov.ph', '$2y$10$xSff.p0g/.VBnOpQcU6uauuMg/XvhJgvBkk2JI2tvMeI0RFiElzau', 'school', 'Unassigned', '2026-02-08 13:46:54'),
(30, 'aide', 'aide@deped.gov.ph', '$2y$10$bJgTB0vStZaBSPASgQTBLupFo2KfrFfzGW.oUx9bCZ4I1/2f.g/AS', '', 'Unassigned', '2026-02-10 13:27:31'),
(31, 'ker', 'ker@deped.gov.ph', '$2y$10$qqlb1/oI1pBmRvqpdkbCk.MIQLDO6BzUW0fwi61whWIHpzPq2j1xC', '', 'Unassigned', '2026-02-11 13:18:30'),
(32, 'Admin Aide', 'aide@example.com', '$2y$10$e0NRgJ8ZcE0XjXg3g2fVnO9SxgUQ8u9yI2c9y7d4j9o0f2QyqvH4K', '', 'Unassigned', '2026-02-11 13:25:33'),
(34, 'John', 'JOHN@deped.gov.ph', '$2y$10$VyQJhx0DGWkJ6rUFbrhApuO3xg7kkMkpZ9QBv6Ys0QLLR.MV7pr0K', '', 'Unassigned', '2026-02-11 15:03:40'),
(35, 'JohnX', 'JOHNX@deped.gov.ph', '$2y$10$p6lTMQwA9Ow662ZS4b6cl.35laTIsi/EWrKd6RFV7a/688RNwKfiG', '', 'Unassigned', '2026-02-11 15:04:07'),
(36, 'jinn', 'jinn@deped.gov.ph', '$2y$10$0LJqFqwHVWrlTi.eJw31ROd4V6gE0DgA3B0BBFZC5dgoP9Cj.1u6e', 'admin', 'Unassigned', '2026-02-11 15:12:45'),
(37, 'testaide@deped.gov.ph', 'testaide@deped.gov.ph', '$2y$10$uGMXMa86tSDOVWmJgomuXetIc6PR2uMXCyNNRgKLkysuAp9Sn4LYW', '', 'Unassigned', '2026-02-11 15:13:39'),
(39, 'John', 'johnrib.cananga@deped.gov.ph', '$2y$10$yChQ7yDV514IXqUZB80/xO7Bht4DsimaZkzkU5zSeOP5znsfVO4SS', 'sdo', 'Unassigned', '2026-02-11 15:18:58'),
(40, 'aideRO', 'aidero@deped.gov.ph', '$2y$10$sp2QVEyBWCOsW3bhYu4KBO3XtzRdnGepGN8dNv68u69ROxkhhTJvi', '', 'Unassigned', '2026-02-13 10:43:27'),
(41, 'calbayog', 'calbayog@deped.gov.ph', '$2y$10$/EfpDCF69ZoQfE8YQJfM6e9gD8tfxZETZbp9V6JAtHVAYGy42rzPm', 'sdo', 'SDO CALBAYOG CITY', '2026-02-16 13:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `workflow_connections`
--

CREATE TABLE `workflow_connections` (
  `id` int(11) NOT NULL,
  `from_code` varchar(60) NOT NULL,
  `to_code` varchar(60) NOT NULL,
  `label_txt` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workflow_steps`
--

CREATE TABLE `workflow_steps` (
  `id` int(11) NOT NULL,
  `step_code` varchar(60) NOT NULL,
  `lane` tinyint(4) NOT NULL,
  `row_pos` int(11) NOT NULL,
  `col_pos` int(11) NOT NULL DEFAULT 0,
  `kind` enum('process','decision','label','terminator') NOT NULL DEFAULT 'process',
  `text` text NOT NULL,
  `status_key` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `application_logs`
--
ALTER TABLE `application_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_logs_report` (`report_id`),
  ADD KEY `idx_logs_actor` (`actor_user_id`),
  ADD KEY `idx_logs_created` (`created_at`);

--
-- Indexes for table `c1_requirements`
--
ALTER TABLE `c1_requirements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `c1_responses`
--
ALTER TABLE `c1_responses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_c1` (`report_id`,`requirement_id`),
  ADD KEY `fk_c1r_req` (`requirement_id`),
  ADD KEY `fk_c1r_file` (`evidence_file_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_to_read` (`to_id`,`read_at`),
  ADD KEY `idx_pair_time` (`from_id`,`to_id`,`created_at`);

--
-- Indexes for table `checklists`
--
ALTER TABLE `checklists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversation_members`
--
ALTER TABLE `conversation_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_member` (`conversation_id`,`user_id`);

--
-- Indexes for table `d1_evaluations`
--
ALTER TABLE `d1_evaluations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `report_id` (`report_id`);

--
-- Indexes for table `d1_forms`
--
ALTER TABLE `d1_forms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_report` (`report_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `d1_indicators`
--
ALTER TABLE `d1_indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `d1_responses`
--
ALTER TABLE `d1_responses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_d1` (`report_id`,`indicator_id`),
  ADD KEY `fk_d1r_ind` (`indicator_id`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `evaluation_sheets`
--
ALTER TABLE `evaluation_sheets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_d1_report_personnel` (`report_id`,`personnel_id`),
  ADD KEY `idx_d1_report` (`report_id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`);

--
-- Indexes for table `final_reports`
--
ALTER TABLE `final_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `report_id` (`report_id`),
  ADD KEY `fk_fr_pdf` (`pdf_file_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ocular_inspections`
--
ALTER TABLE `ocular_inspections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ocular_report_personnel` (`report_id`,`personnel_id`),
  ADD KEY `idx_ocular_report` (`report_id`);

--
-- Indexes for table `ocular_items`
--
ALTER TABLE `ocular_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ocular_responses`
--
ALTER TABLE `ocular_responses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ocular` (`report_id`,`ocular_item_id`),
  ADD KEY `fk_or_item` (`ocular_item_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `report_actions`
--
ALTER TABLE `report_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `actor_id` (`actor_id`);

--
-- Indexes for table `report_logs`
--
ALTER TABLE `report_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `actor_id` (`actor_id`);

--
-- Indexes for table `report_status_history`
--
ALTER TABLE `report_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `fk_hist_user` (`changed_by`);

--
-- Indexes for table `report_tracking`
--
ALTER TABLE `report_tracking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `workflow_connections`
--
ALTER TABLE `workflow_connections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_wf_from` (`from_code`),
  ADD KEY `fk_wf_to` (`to_code`);

--
-- Indexes for table `workflow_steps`
--
ALTER TABLE `workflow_steps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `step_code` (`step_code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `application_logs`
--
ALTER TABLE `application_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `c1_requirements`
--
ALTER TABLE `c1_requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `c1_responses`
--
ALTER TABLE `c1_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checklists`
--
ALTER TABLE `checklists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversation_members`
--
ALTER TABLE `conversation_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `d1_evaluations`
--
ALTER TABLE `d1_evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `d1_forms`
--
ALTER TABLE `d1_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `d1_indicators`
--
ALTER TABLE `d1_indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `d1_responses`
--
ALTER TABLE `d1_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `evaluation_sheets`
--
ALTER TABLE `evaluation_sheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `final_reports`
--
ALTER TABLE `final_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ocular_inspections`
--
ALTER TABLE `ocular_inspections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ocular_items`
--
ALTER TABLE `ocular_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ocular_responses`
--
ALTER TABLE `ocular_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `report_actions`
--
ALTER TABLE `report_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `report_logs`
--
ALTER TABLE `report_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_status_history`
--
ALTER TABLE `report_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `report_tracking`
--
ALTER TABLE `report_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `status_history`
--
ALTER TABLE `status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `workflow_connections`
--
ALTER TABLE `workflow_connections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workflow_steps`
--
ALTER TABLE `workflow_steps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `c1_responses`
--
ALTER TABLE `c1_responses`
  ADD CONSTRAINT `fk_c1r_file` FOREIGN KEY (`evidence_file_id`) REFERENCES `files` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_c1r_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_c1r_req` FOREIGN KEY (`requirement_id`) REFERENCES `c1_requirements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `d1_forms`
--
ALTER TABLE `d1_forms`
  ADD CONSTRAINT `fk_d1_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_d1_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `d1_responses`
--
ALTER TABLE `d1_responses`
  ADD CONSTRAINT `fk_d1r_ind` FOREIGN KEY (`indicator_id`) REFERENCES `d1_indicators` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_d1r_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `fk_files_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `final_reports`
--
ALTER TABLE `final_reports`
  ADD CONSTRAINT `fk_fr_pdf` FOREIGN KEY (`pdf_file_id`) REFERENCES `files` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_fr_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ocular_responses`
--
ALTER TABLE `ocular_responses`
  ADD CONSTRAINT `fk_or_item` FOREIGN KEY (`ocular_item_id`) REFERENCES `ocular_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_or_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `report_status_history`
--
ALTER TABLE `report_status_history`
  ADD CONSTRAINT `fk_hist_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_hist_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `report_tracking`
--
ALTER TABLE `report_tracking`
  ADD CONSTRAINT `report_tracking_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `status_history`
--
ALTER TABLE `status_history`
  ADD CONSTRAINT `fk_status_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workflow_connections`
--
ALTER TABLE `workflow_connections`
  ADD CONSTRAINT `fk_wf_from` FOREIGN KEY (`from_code`) REFERENCES `workflow_steps` (`step_code`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_wf_to` FOREIGN KEY (`to_code`) REFERENCES `workflow_steps` (`step_code`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

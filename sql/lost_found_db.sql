-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2025 at 09:11 PM
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
-- Database: `lost_found_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `claimer_id` int(11) NOT NULL,
  `claim_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `proof_details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `item_id`, `claimer_id`, `claim_status`, `proof_details`, `created_at`, `updated_at`) VALUES
(1, 6, 1, 'approved', 'logo', '2025-05-30 12:59:57', '2025-05-30 13:03:40'),
(2, 5, 2, 'rejected', 'logo', '2025-05-30 13:05:06', '2025-05-30 13:05:14'),
(3, 2, 2, 'approved', 'logo', '2025-05-30 13:08:31', '2025-05-30 13:08:37'),
(4, 7, 2, 'rejected', 'hell', '2025-05-30 13:14:16', '2025-05-30 13:14:31'),
(5, 8, 1, 'rejected', 'mine', '2025-05-30 14:47:49', '2025-05-30 14:49:43'),
(6, 9, 1, 'approved', 'name', '2025-05-30 17:59:01', '2025-05-30 17:59:18'),
(7, 10, 2, 'approved', 'name', '2025-05-30 18:12:49', '2025-05-30 18:13:55'),
(8, 11, 2, 'rejected', 'hello', '2025-05-30 18:35:03', '2025-05-30 18:35:18'),
(9, 12, 2, 'approved', 'name', '2025-05-30 18:36:18', '2025-05-30 18:36:30'),
(10, 13, 1, 'approved', 'name', '2025-05-30 18:51:58', '2025-05-30 18:52:09');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('lost','found') NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `date_lost_found` date NOT NULL,
  `status` enum('active','claimed','resolved','archived') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `type`, `name`, `category`, `description`, `location`, `image_url`, `date_lost_found`, `status`, `created_at`) VALUES
(1, 1, 'lost', 'Muhammad Zaeem Ul Hassan', 'dang', 'adfadfafagadgad ag agag aga', 'afdaf', 'uploads/6839a5f98e531_cta.jpg', '2025-05-08', 'active', '2025-05-30 12:35:05'),
(2, 1, 'found', 'Muhammad Zaeem Ul Hassan', 'gadgadff', 'agadfa af aga gaga aag a', 'fadfadfa  gagagdgag', 'uploads/6839a6129b938_lost& found.png', '2025-04-29', 'resolved', '2025-05-30 12:35:30'),
(3, 1, 'lost', 'dfhadfbdab', 'hahdhfab', 'afa dh iuadhguiadhguia hgisdhfgsdfghfgusdfhgydfhgdfhgdafyg', 'gfadkj fah af', 'uploads/6839a95e95d20_log-in.png', '2025-05-24', 'active', '2025-05-30 12:49:34'),
(4, 1, 'lost', 'afgjsfh giuwfhguh', 'ui fdhishu', 'fg sf gsdfihgsdiufhgdfhgdiushgiafdhiuhfgshhjfdsgsdfg f g dsfghsifd ghuif  hf fd gr', 'sfgsf jgsh fiughsuifhgus', 'uploads/6839a9711f2dc_dashboard.png', '2025-05-20', 'active', '2025-05-30 12:49:53'),
(5, 1, 'found', 'fsgsgs', 'fgsdfgsdf', 'sdghsfgasgs jig sfg sduif guirg hisurh gsrfhgf g', 'sgsfg dg d hsd', 'uploads/6839a9863ca71_lgu_logo.png', '2025-05-31', 'claimed', '2025-05-30 12:50:14'),
(6, 2, 'found', 'adgadgaga agag', 'aggadga', 'agadsga ga ag as ga dag', 'adgadg aadg a', 'uploads/6839abb02bce8_lost& found.png', '2025-05-09', 'resolved', '2025-05-30 12:59:28'),
(7, 1, 'found', 'zaeem', 'gadgasdgas', 's hhsfhsf hs  s sh', 'ghs h sr sh', NULL, '2025-05-01', 'claimed', '2025-05-30 13:14:05'),
(8, 2, 'found', 'test1', 'jjsfbnvja', 'agagasgdsaf', 'adfndkjn', 'uploads/6839c4d8ccc48_lost& found.png', '2025-06-06', 'claimed', '2025-05-30 14:46:48'),
(9, 2, 'found', 'moazam test', 'dihfaiudb', 'dafhaiudfbajfbadfadbfjad fduifha luidyf', 'dfbahdbhdfa', 'uploads/6839f19edebae_lost& found.png', '2025-05-16', 'resolved', '2025-05-30 17:57:50'),
(10, 1, 'found', 'test 2', 'hghhub', 'g ggygygyou  o', 'jkbh y gy y', 'uploads/6839f50a3b984_lost& found.png', '2003-01-01', 'resolved', '2025-05-30 18:12:26'),
(11, 1, 'found', 'test3', 'uahia', 'nshfgnangdjn uig haghai', 'adfnajf;n afjn', 'uploads/6839fa3c985ed_lost& found.png', '2025-05-15', 'claimed', '2025-05-30 18:34:36'),
(12, 1, 'found', 'test4', 'qnfjdnaj', 'jkanjkdnf', 'anfkjndf', 'uploads/6839fa97a1500_lost& found.png', '2025-05-20', 'resolved', '2025-05-30 18:36:07'),
(13, 2, 'found', 'test5', 'hlajhdjag', 'kjhg aldhfadh afui', 'jadhlfu adfoa dhgal', 'uploads/6839fe40d7747_lost& found.png', '2025-05-14', 'resolved', '2025-05-30 18:51:44'),
(14, 2, 'lost', 'aj;fgn', 'uhaguhui', 'gjafu gafu', 'agnj;g gf', 'uploads/6839fea8cd73d_lost& found.png', '2025-05-14', 'active', '2025-05-30 18:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Muhammad Zaeem Ul Hassan', 'zaeem@gmail.com', 'zaeem', 'user', '2025-05-30 12:33:55'),
(2, 'moazam ali', 'moazam@gmail.com', 'moazam', 'user', '2025-05-30 12:59:10'),
(3, 'admin', 'admin@gmail.com', 'admin', 'admin', '2025-05-30 18:04:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `claimer_id` (`claimer_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `claims`
--
ALTER TABLE `claims`
  ADD CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `claims_ibfk_2` FOREIGN KEY (`claimer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

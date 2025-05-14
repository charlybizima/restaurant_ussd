-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 02:24 PM
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
-- Database: `restaurant_ussd`
--

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `name`, `description`, `price`, `category`, `is_available`, `created_at`, `updated_at`) VALUES
(1, 'Chicken Burger', 'Grilled chicken patty with fresh vegetables', 8.99, 'Main Course', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(2, 'Beef Burger', 'Juicy beef patty with cheese and special sauce', 9.99, 'Main Course', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(3, 'French Fries', 'Crispy golden fries with seasoning', 3.99, 'Appetizers', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(4, 'Chicken Wings', 'Spicy chicken wings with dipping sauce', 7.99, 'Appetizers', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(5, 'Pizza Margherita', 'Classic pizza with tomato sauce and mozzarella', 12.99, 'Desserts', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(6, 'Caesar Salad', 'Fresh romaine lettuce with Caesar dressing', 6.99, 'Desserts', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(7, 'Soft Drink', 'Carbonated beverage of your choice', 2.99, 'Beverages', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26'),
(8, 'Ice Cream', 'Vanilla ice cream with chocolate sauce', 4.99, 'Beverages', 1, '2025-05-13 11:24:34', '2025-05-14 08:24:26');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_phone` varchar(15) NOT NULL,
  `items` text NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_phone`, `items`, `total_amount`, `status`, `created_at`) VALUES
(1, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:39:19'),
(2, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:39:22'),
(3, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:39:32'),
(4, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:40:53'),
(5, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:40:53'),
(6, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:02'),
(7, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:32'),
(8, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:33'),
(9, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:34'),
(10, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:34'),
(11, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:34'),
(12, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:41:45'),
(13, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:43:37'),
(14, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:43:38'),
(15, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:43:38'),
(16, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:43:48'),
(17, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:45:14'),
(18, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:45:14'),
(19, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:45:15'),
(20, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:45:24'),
(21, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:47:56'),
(22, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:47:58'),
(23, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:48:06'),
(24, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:49:01'),
(25, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:50:06'),
(26, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:50:07'),
(27, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:50:07'),
(28, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:50:08'),
(29, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:50:09'),
(30, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:51:05'),
(31, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:51:05'),
(32, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:51:06'),
(33, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 08:54:58'),
(34, '0784728788', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 09:13:03'),
(35, '+250789175240', '[{\"id\":\"2\",\"name\":\"Beef Burger\",\"price\":\"9.99\"}]', 9.99, 'pending', '2025-05-14 09:24:11'),
(36, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 09:31:46'),
(37, '+250798501999', '[{\"id\":\"6\",\"name\":\"Caesar Salad\",\"price\":\"6.99\"}]', 6.99, 'pending', '2025-05-14 09:41:29'),
(38, '+250798501999', '[{\"id\":\"8\",\"name\":\"Ice Cream\",\"price\":\"4.99\"}]', 4.99, 'pending', '2025-05-14 09:44:03'),
(39, '+250798501999', '[{\"id\":\"5\",\"name\":\"Pizza Margherita\",\"price\":\"12.99\"}]', 12.99, 'pending', '2025-05-14 09:49:52'),
(40, '+250798501999', '[{\"id\":\"3\",\"name\":\"French Fries\",\"price\":\"3.99\"}]', 3.99, 'pending', '2025-05-14 09:51:49'),
(41, '+250798501999', '[{\"id\":\"2\",\"name\":\"Beef Burger\",\"price\":\"9.99\"}]', 9.99, 'pending', '2025-05-14 10:06:10'),
(42, '+250798501999', '[{\"id\":\"1\",\"name\":\"Chicken Burger\",\"price\":\"8.99\"}]', 8.99, 'pending', '2025-05-14 10:52:02'),
(43, '+250798501999', '[{\"id\":\"3\",\"name\":\"French Fries\",\"price\":\"3.99\"}]', 3.99, 'pending', '2025-05-14 10:54:15'),
(44, '+250798501999', '[{\"id\":\"3\",\"name\":\"French Fries\",\"price\":\"3.99\"}]', 3.99, 'pending', '2025-05-14 10:56:06'),
(45, '+250789175240', '[{\"id\":\"2\",\"name\":\"Beef Burger\",\"price\":\"9.99\"}]', 9.99, 'pending', '2025-05-14 11:01:57'),
(46, '+250789175240', '[{\"id\":\"3\",\"name\":\"French Fries\",\"price\":\"3.99\"}]', 3.99, 'pending', '2025-05-14 11:02:14'),
(47, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:02:52'),
(48, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:05:59'),
(49, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:06:02'),
(50, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:09'),
(51, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:11'),
(52, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:12'),
(53, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:16'),
(54, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:35'),
(55, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:07:45'),
(56, '+250798501999', '[{\"id\":\"4\",\"name\":\"Chicken Wings\",\"price\":\"7.99\"}]', 7.99, 'pending', '2025-05-14 11:08:56'),
(57, '+250798501999', '[{\"id\":\"3\",\"name\":\"French Fries\",\"price\":\"3.99\"}]', 3.99, 'pending', '2025-05-14 11:09:44');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `role` enum('customer','manager') DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `phone`, `name`, `role`) VALUES
(1, '0784728788', NULL, 'customer'),
(2, '', NULL, 'customer'),
(3, '+250789175240', NULL, 'customer'),
(4, '+250798501999', NULL, 'customer'),
(5, '0781500734', 'manager1', 'manager'),
(6, '0789408280', 'manager2', 'manager'),
(7, '0798501999', 'manager3', 'manager'),
(8, '+250 798 501 99', NULL, 'customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_menu_items_available` (`is_available`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

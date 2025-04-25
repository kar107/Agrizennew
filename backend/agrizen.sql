-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2025 at 03:19 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agrizen`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `price`) STORED,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Seeds', 'A wide variety of high-quality seeds, including grains, vegetables, and fruit seeds, designed for maximum yield and adaptability to different climates.', 1, 'active', '2025-04-07 09:03:47', '2025-04-18 11:59:08'),
(2, 'Fertilizers', 'Organic and chemical fertilizers to enhance soil fertility and provide essential nutrients for crops, ensuring healthy and robust plant growth.', 1, 'active', '2025-04-07 09:04:07', '2025-04-07 12:34:07'),
(3, 'Pesticides', 'Advanced pest control solutions, including bio-pesticides and synthetic pesticides, to protect crops from insects, fungi, and diseases.', 1, 'active', '2025-04-07 09:04:21', '2025-04-07 12:34:21'),
(4, 'Equipment', 'Essential agricultural tools and machinery, such as tractors, plows, seeders, and sprayers, to facilitate efficient and large-scale farming operations.', 1, 'active', '2025-04-07 09:04:36', '2025-04-07 12:34:36'),
(5, 'Irrigation', 'Modern irrigation systems, including drip irrigation kits, sprinklers, and water pumps, to optimize water usage and improve crop yield.', 1, 'active', '2025-04-07 09:04:52', '2025-04-07 12:34:52'),
(6, 'Animal Feed', 'High-nutrition feed for livestock, including cattle, poultry, and fish, formulated to support healthy growth and increased productivity.', 1, 'active', '2025-04-07 09:05:14', '2025-04-07 12:35:14'),
(7, 'Greenhouse Kits', 'Complete greenhouse solutions, including polytunnels, temperature control systems, and hydroponic setups for year-round farming.', 1, 'active', '2025-04-07 09:05:28', '2025-04-07 12:35:28');

-- --------------------------------------------------------

--
-- Table structure for table `crops`
--

CREATE TABLE `crops` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `variety` varchar(255) NOT NULL,
  `season` varchar(100) NOT NULL,
  `duration_days` int(4) NOT NULL,
  `region` varchar(255) NOT NULL,
  `soil_type` varchar(100) NOT NULL,
  `sowing_method` varchar(100) NOT NULL,
  `yield_kg_per_hectare` int(6) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `crops`
--

INSERT INTO `crops` (`id`, `name`, `variety`, `season`, `duration_days`, `region`, `soil_type`, `sowing_method`, `yield_kg_per_hectare`, `description`, `created_at`, `updated_at`, `image`) VALUES
(1, 'Wheats', 'Lokwan', 'Winter Season (Oct–March)', 120, 'Punjab, Haryana, UP', 'Loamy soil', 'Broadcasting', 3500, 'Wheat is a winter crop that requires cool temperatures and loamy soil. Lokwan variety is popular for high-quality grains and good market value.', '2025-04-11 05:08:41', '2025-04-18 07:20:07', '68022c0c4d80e.jpg'),
(2, 'Rice', 'Basmati 370', 'Monsoon Season (June–Oct)', 140, 'West Bengal, Bihar', 'Clayey soil', 'Transplanting', 4000, 'Rice is a monsoon-season crop needing high water levels. Basmati 370 is aromatic and exported widely. Best grown in flooded fields.', '2025-04-11 05:08:41', '2025-04-18 07:21:09', '68022c1fae6a3.jpg'),
(3, 'Maize', 'Ganga-5', 'Monsoon Season (June–Oct)', 110, 'Maharashtra, MP', 'Sandy loam', 'Line sowing', 3000, 'Maize is a fast-growing crop suitable for food and fodder. Ganga-5 is a hybrid variety ideal for monsoon regions.', '2025-04-11 05:08:41', '2025-04-18 07:21:16', '68022c2c31924.jpg'),
(4, 'Potato', 'Kufri Jyoti', 'Winter Season (Oct–March)', 90, 'UP, West Bengal', 'Sandy loam', 'Ridge planting', 25000, 'Potato grows best in cool climates. Kufri Jyoti is early-maturing, high-yielding, and disease-resistant.', '2025-04-11 05:08:41', '2025-04-18 07:20:15', '68022cded77bd.jpg'),
(5, 'Sugarcane', 'Co-0238', 'Grown all year (long-duration crop)', 330, 'Tamil Nadu, Maharashtra', 'Alluvial soil', 'Furrow method', 80000, 'Sugarcane is a long-duration tropical crop. Co-0238 is high-yielding and drought-resistant with a strong market demand.', '2025-04-11 05:08:41', '2025-04-18 07:21:57', '68022ce8b2b5c.jpg'),
(6, 'Mustard', 'Pusa Bold', 'Winter Season (Oct–March)', 105, 'Rajasthan, Haryana', 'Loamy soil', 'Broadcasting', 1500, 'Mustard is a winter oilseed crop. Pusa Bold gives a good yield and high oil content. Grows well in dry, cool areas.', '2025-04-11 05:08:41', '2025-04-18 07:20:26', '68022cf7a731a.jpg'),
(7, 'Groundnut', 'TAG-24', 'Monsoon Season (June–Oct)', 105, 'Gujarat, Tamil Nadu', 'Sandy loam', 'Line sowing', 2000, 'Groundnut is an oilseed crop suited for warm climates. TAG-24 is early-maturing and produces high oil yields.', '2025-04-11 05:08:41', '2025-04-18 07:21:28', '68022d77b21e9.jpg'),
(8, 'Bajra', 'ICMV-221', 'Monsoon Season (June–Oct)', 90, 'Rajasthan, Gujarat', 'Sandy or loamy', 'Broadcasting', 1800, 'Bajra (Pearl Millet) is drought-tolerant and perfect for arid regions. ICMV-221 matures quickly and is cost-effective.', '2025-04-11 05:08:41', '2025-04-18 07:21:33', '68022d81190ee.jpg'),
(9, 'Soybean', 'JS 335', 'Monsoon Season (June–Oct)', 105, 'MP, Maharashtra', 'Loamy soil', 'Line sowing', 2800, 'Soybean is rich in protein and oil. JS 335 is a popular variety for rainfed and irrigated conditions.', '2025-04-11 05:08:41', '2025-04-18 07:21:39', '68022d90cc7f6.jpg'),
(10, 'Onion', 'N-53', 'Winter Season (Oct–March)/Monsoon Season (June–Oct)', 115, 'Maharashtra, Karnataka', 'Well-drained soil', 'Transplanting', 20000, 'Onion grows well in both seasons. N-53 is suitable for storage and provides good bulb size and market demand.', '2025-04-11 05:08:41', '2025-04-18 07:20:54', '68022dedeaa4f.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `name`, `message`, `is_read`, `created_at`) VALUES
(1, 0, 'User Module', 'Updated user: ankit', 1, '2025-04-21 08:12:08'),
(2, 0, 'User Module', 'Updated user: ankit', 0, '2025-04-21 08:12:43'),
(3, 0, 'User Module', 'Added new user: simun', 0, '2025-04-21 08:18:43'),
(4, 0, 'User Registration', 'A new user registered: Simun with email simun1234@gmail.com', 0, '2025-04-21 08:23:32'),
(5, 0, 'User Profile Update', 'Updated profile for user: 1', 0, '2025-04-21 08:27:10'),
(8, 23, 'Order Placed', 'Order #13 placed successfully.', 1, '2025-04-22 00:23:22'),
(9, 23, 'Login Successful', 'ankit patel logged in successfully.', 0, '2025-04-22 00:32:46'),
(10, 23, 'Cart', 'Added product ID 1 to cart', 0, '2025-04-22 00:38:32'),
(11, 23, 'Cart', 'Updated quantity for product ID 1 in cart', 0, '2025-04-22 00:38:45'),
(12, 23, 'Order Placed', 'Order #14 placed successfully.', 0, '2025-04-22 00:38:57'),
(13, 1, 'Login Successful', 'Ankit Patel logged in successfully.', 0, '2025-04-22 01:52:15'),
(14, 8, 'Login Successful', 'harish logged in successfully.', 0, '2025-04-22 02:20:04'),
(15, 23, 'Login Successful', 'ankit patel logged in successfully.', 0, '2025-04-22 02:27:07'),
(16, 23, 'Cart', 'Added product ID 1 to cart', 0, '2025-04-22 02:27:38'),
(17, 23, 'Cart', 'Updated quantity for product ID 1 in cart', 0, '2025-04-22 02:28:02'),
(18, 23, 'Login Successful', 'ankit patel logged in successfully.', 0, '2025-04-22 02:51:05'),
(19, 23, 'Login Successful', 'ankit patel logged in successfully.', 0, '2025-04-22 02:52:08'),
(20, 23, 'Cart', 'Updated quantity for product ID 1 in cart', 0, '2025-04-22 02:52:43'),
(21, 23, 'Order Placed', 'Order #15 placed successfully.', 0, '2025-04-22 02:55:10'),
(22, 1, 'Login Successful', 'Ankit Patel logged in successfully.', 0, '2025-04-22 02:55:24');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` varchar(50) DEFAULT 'Pending',
  `payment_status` varchar(50) DEFAULT 'Unpaid',
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_amount`, `order_status`, `payment_status`, `payment_method`, `shipping_address`, `created_at`, `updated_at`) VALUES
(1, 0, 6000.00, 'Pending', 'Paid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 09:19:51', '2025-04-09 07:45:54'),
(2, 0, 75.00, '0', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 09:32:09', '2025-04-08 09:32:09'),
(3, 23, 75.00, '0', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 09:46:43', '2025-04-08 09:46:43'),
(4, 23, 250.00, '0', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 09:47:45', '2025-04-08 09:47:45'),
(5, 23, 40.00, '0', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 09:48:06', '2025-04-08 09:48:06'),
(6, 23, 75.00, '0', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 11:51:41', '2025-04-08 11:51:41'),
(7, 23, 30.00, 'Processing', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-08 15:10:56', '2025-04-09 08:22:22'),
(9, 23, 195.00, 'Pending', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-09 12:18:22', '2025-04-09 12:18:22'),
(10, 23, 250.00, 'Cancelled', 'Paid', 'stripe', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-09 12:45:09', '2025-04-10 03:30:52'),
(12, 23, 75.00, 'Pending', 'Unpaid', 'stripe', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-21 09:17:23', '2025-04-21 09:17:23'),
(13, 23, 105.00, 'Pending', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-22 03:53:22', '2025-04-22 03:53:22'),
(14, 23, 150.00, 'Pending', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-22 04:08:57', '2025-04-22 04:08:57'),
(15, 23, 300.00, 'Pending', 'Unpaid', 'cod', '{\"fullName\":\"ankit patel\",\"phone\":\"09054430598\",\"street\":\"Lathidad\",\"city\":\"Lathidad\",\"state\":\"Gujarat\",\"zip\":\"364710\"}', '2025-04-22 06:25:10', '2025-04-22 06:25:10');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) GENERATED ALWAYS AS (`price` * `quantity`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 4, 1, 6000.00),
(2, 2, 1, 1, 75.00),
(3, 3, 1, 1, 75.00),
(4, 4, 5, 1, 250.00),
(5, 5, 3, 1, 40.00),
(6, 6, 1, 1, 75.00),
(7, 7, 2, 1, 30.00),
(9, 9, 1, 1, 75.00),
(10, 9, 13, 1, 120.00),
(11, 10, 5, 1, 250.00),
(13, 12, 1, 1, 75.00),
(14, 13, 2, 1, 30.00),
(15, 13, 1, 1, 75.00),
(16, 14, 1, 2, 75.00),
(17, 15, 1, 4, 75.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `category_id`, `price`, `stock_quantity`, `unit`, `image`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Hybrid Maize Seeds', 'High-yield maize seeds suitable for diverse climates, resistant to drought and pests, ensuring optimal germination and maximum productivity.', 1, 75.00, 500, 'kg', '67ee817ea21a0.png', 'active', 1, '2025-04-03 09:09:26', '2025-04-03 12:39:26'),
(2, 'Urea Fertilizer', 'A nitrogen-rich fertilizer essential for improving soil fertility and enhancing plant growth, widely used in agricultural production worldwide.', 2, 30.00, 400, 'kg', '67ee81b96fef9.jpg', 'active', 1, '2025-04-03 09:10:25', '2025-04-03 12:40:25'),
(3, 'Neem Oil Pesticide', 'Organic pesticide extracted from neem seeds, effective in controlling a wide range of agricultural pests without harming beneficial insects.', 3, 40.00, 200, 'liter', '67ee821c36fee.jpg', 'active', 1, '2025-04-03 09:12:04', '2025-04-03 12:42:04'),
(4, 'Heavy-Duty Tractor', 'A multi-purpose tractor designed for plowing, seeding, and harvesting, equipped with modern technology for precision agriculture.', 4, 6000.00, 10, 'unit', '67ee8250ce478.jpg', 'active', 1, '2025-04-03 09:12:56', '2025-04-03 12:42:56'),
(5, 'Drip Irrigation Kit', 'A water-saving irrigation system that delivers water directly to plant roots, minimizing evaporation and optimizing crop hydration.', 5, 250.00, 60, 'set', '67ee82b2326c2.jpg', 'active', 1, '2025-04-03 09:14:34', '2025-04-03 12:44:34'),
(6, 'Poultry Feed', 'A nutritionally balanced feed formulated for optimal poultry growth, egg production, and overall health, containing essential vitamins and minerals.', 6, 55.00, 300, 'kg', '67ee82dc90fbc.jpg', 'active', 1, '2025-04-03 09:15:16', '2025-04-03 12:45:16'),
(7, 'Hydroponic Grow Kit', 'A complete hydroponic system designed for soilless farming, enabling efficient growth of vegetables and herbs with controlled nutrients.', 7, 1500.00, 15, 'unit', '67ee83891e602.jpg', 'active', 1, '2025-04-03 09:18:09', '2025-04-03 12:48:09'),
(8, 'Organic Compost', 'A natural soil conditioner rich in organic matter, improving soil structure, enhancing moisture retention, and promoting microbial activity.', 2, 20.00, 250, 'kg', '67ee83b5a6343.jpg', 'active', 1, '2025-04-03 09:18:53', '2025-04-03 12:48:53'),
(9, 'Electric Sprayer', 'A battery-powered sprayer for applying pesticides and fertilizers efficiently over large crop fields with minimal manual effort.', 4, 350.00, 40, 'unit', '67ee83e97a6ce.jpg', 'active', 1, '2025-04-03 09:19:45', '2025-04-03 12:49:45'),
(10, 'Solar Water Pump', 'A solar-powered pump system ideal for remote agricultural areas, reducing irrigation costs and ensuring a sustainable water supply.', 5, 1800.00, 20, 'unit', '67ee84d533ae2.jpg', 'active', 1, '2025-04-03 09:23:41', '2025-04-03 12:53:41'),
(11, 'Fish Feed Pellets', 'High-protein fish feed pellets designed to promote fast growth and healthy development in aquaculture systems.', 6, 65.00, 180, 'kg', '67ee8527b0067.jpg', 'active', 1, '2025-04-03 09:25:03', '2025-04-03 12:55:03'),
(12, 'Hybrid Maize Seeds', 'High-yield maize seeds suitable for diverse climates, resistant to drought and pests, ensuring optimal germination and maximum productivity.', 2, 190.00, 200, 'kg', '67f0fea1b832d.jpg', 'active', 1, '2025-04-05 06:27:53', '2025-04-05 09:57:53'),
(18, 'gsf', 'sdfsfsdfs', 2, 233.00, 232, 'kg', '6806371ef3742.jpg', 'active', 1, '2025-04-21 08:46:30', '2025-04-21 12:16:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('Admin','Farmer','Supplier','Customer') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `name`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'Ankit Patel', 'abc12345@gmail.com', '$2y$10$TEmrR.isPGxshWT5uCGJZOednj/YVvbfLXp7qLzb0ck3AgnsXa0CS', 'Admin', '2025-03-17 17:12:21'),
(8, 'harish', 'harish123@gmail.com', '$2y$10$TEmrR.isPGxshWT5uCGJZOednj/YVvbfLXp7qLzb0ck3AgnsXa0CS', 'Supplier', '2025-03-23 11:51:25'),
(9, 'ankit', 'abc1234@gmail.com', '$2y$10$/kC4xBiiEqGZ/nM91z5E8.sk/8kNfVx7GtjkCbyiLtJN3ZtU3GDOa', 'Supplier', '2025-03-27 06:56:41'),
(23, 'ankit patel', 'ankitpatel99246@gmail.com', '$2y$10$Audwb0EDGueeYZ6snhxocuxTBQM6yh4Ma5QXid97KpfgEdlpOhWdm', 'Farmer', '2025-04-02 07:43:23'),
(24, 'simun', 'simun123@gmail.com', '$2y$10$0UNcGhwVrxav8Jn.U0uhF.kK7D3YwfWTqay7lIJzjF0f0QG2U/6Ji', 'Farmer', '2025-04-21 08:18:43'),
(25, 'Simun', 'simun1234@gmail.com', '$2y$10$PgWN3s4lclTlG4slUKrzOOoCp4aeDKGryQGjlO25tGItalJyUMYjG', 'Farmer', '2025-04-21 08:23:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `crops`
--
ALTER TABLE `crops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `crops`
--
ALTER TABLE `crops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

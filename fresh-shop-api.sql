-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 03, 2026 at 10:18 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fresh-shop-api`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'فواكه موسمية', '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(2, 'ورقيات', '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(3, 'عروض مميزة', '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(4, 'تمور ومجففات', '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(5, 'خضار طازجة', '2026-06-03 05:50:19', '2026-06-03 05:50:19');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_05_30_092051_create_categories_table', 1),
(5, '2026_05_31_103241_create_products_table', 1),
(6, '2026_05_31_112307_create_personal_access_tokens_table', 1),
(7, '2026_06_01_053859_create_orders_table', 1),
(8, '2026_06_01_053907_create_order_items_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `total_price`, `status`, `created_at`, `updated_at`) VALUES
(1, 0.95, 'pending', '2026-06-03 06:25:18', '2026-06-03 06:25:18');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 0.95, '2026-06-03 06:25:18', '2026-06-03 06:25:18');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `price`, `unit`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'بقدونس حقلي #111', 'broccoli.png', 1.22, 'سلة', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(2, 'نعنع طازج #562', 'apple.png', 0.95, '1 كيلو', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(3, 'بروكلي شتوي #924', 'banana.png', 5.26, '500 غرام', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(4, 'تفاح نخب أول #986', 'broccoli.png', 5.16, '1 كيلو', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(5, 'عنب صيفي #520', 'broccoli.png', 3.87, '1 كيلو', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(6, 'موز عضوي (Organic) #117', 'broccoli.png', 0.46, '500 غرام', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(7, 'موز صيفي #311', 'broccoli.png', 1.53, 'ضمة', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(8, 'بطاطا حقلي #906', 'broccoli.png', 5.44, 'صندوق', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(9, 'بطاطا نخب أول #921', 'apple.png', 2.92, 'صندوق', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(10, 'أفوكادو نخب أول #782', 'apple.png', 0.98, '500 غرام', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(11, 'جزر طازج #310', 'apple.png', 3.23, 'صندوق', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(12, 'خس مستورد #840', 'apple.png', 5.70, 'سلة', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(13, 'بندورة صيفي #937', 'broccoli.png', 4.07, 'صندوق', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(14, 'أفوكادو حقلي #83', 'carrot.png', 2.89, 'ضمة', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(15, 'بصل شتوي #145', 'carrot.png', 4.20, 'صندوق', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(16, 'تفاح حقلي #512', 'banana.png', 2.26, '500 غرام', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(17, 'أفوكادو صيفي #612', 'carrot.png', 6.18, 'ضمة', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(18, 'موز طازج #916', 'apple.png', 0.97, 'ضمة', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(19, 'جزر نخب أول #571', 'carrot.png', 5.50, 'سلة', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(20, 'خس نخب أول #267', 'carrot.png', 5.02, '500 غرام', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(21, 'خيار صيفي #193', 'carrot.png', 1.78, '1 كيلو', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(22, 'رمان مستورد #817', 'banana.png', 4.33, 'سلة', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(23, 'خس صيفي #797', 'banana.png', 3.04, 'سلة', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(24, 'نعنع مستورد #423', 'carrot.png', 1.70, 'صندوق', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(25, 'عنب عضوي (Organic) #574', 'apple.png', 2.91, 'صندوق', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(26, 'ثوم شتوي #884', 'banana.png', 1.74, 'سلة', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(27, 'بروكلي شتوي #566', 'broccoli.png', 4.64, 'سلة', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(28, 'جزر عضوي (Organic) #563', 'broccoli.png', 3.06, 'ضمة', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(29, 'خيار بلدي #318', 'apple.png', 2.89, '500 غرام', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(30, 'بطاطا نخب أول #351', 'banana.png', 1.86, 'سلة', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(31, 'رمان صيفي #976', 'carrot.png', 3.36, 'ضمة', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(32, 'برتقال نخب أول #450', 'carrot.png', 4.15, 'سلة', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(33, 'عنب نخب أول #494', 'apple.png', 2.10, '1 كيلو', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(34, 'فراولة نخب أول #796', 'banana.png', 6.03, 'صندوق', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(35, 'جزر شتوي #775', 'banana.png', 3.87, 'صندوق', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(36, 'نعنع صيفي #713', 'broccoli.png', 4.83, '500 غرام', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(37, 'جزر حقلي #818', 'banana.png', 2.95, '500 غرام', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(38, 'تفاح شتوي #442', 'banana.png', 2.59, 'ضمة', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(39, 'نعنع طازج #335', 'carrot.png', 5.57, '500 غرام', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(40, 'بندورة عضوي (Organic) #52', 'broccoli.png', 4.92, 'ضمة', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(41, 'برتقال شتوي #223', 'apple.png', 3.70, '500 غرام', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(42, 'بروكلي مستورد #791', 'carrot.png', 4.64, 'صندوق', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(43, 'ليمون شتوي #508', 'banana.png', 6.11, '500 غرام', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(44, 'بطيخ صيفي #113', 'broccoli.png', 0.56, '500 غرام', 4, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(45, 'عنب بلدي #215', 'banana.png', 2.32, '1 كيلو', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(46, 'خس مستورد #437', 'carrot.png', 3.29, '1 كيلو', 3, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(47, 'بروكلي بلدي #706', 'apple.png', 1.52, 'سلة', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(48, 'خس مستورد #841', 'broccoli.png', 5.30, '500 غرام', 2, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(49, 'بندورة طازج #988', 'carrot.png', 5.99, 'ضمة', 5, '2026-06-03 05:50:19', '2026-06-03 05:50:19'),
(50, 'أفوكادو شتوي #479', 'apple.png', 1.53, 'صندوق', 1, '2026-06-03 05:50:19', '2026-06-03 05:50:19');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

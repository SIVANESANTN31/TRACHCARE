-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 20, 2024 at 08:33 AM
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
-- Database: `trachcare`
--

-- --------------------------------------------------------

--
-- Table structure for table `addpatients`
--

CREATE TABLE `addpatients` (
  `doctor_id` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` varchar(10) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `bmi` varchar(10) DEFAULT NULL,
  `diagnosis` varchar(500) DEFAULT NULL,
  `surgery_status` varchar(100) DEFAULT NULL,
  `post_op_tracheostomy_day` varchar(10) DEFAULT NULL,
  `tube_name_size` varchar(50) DEFAULT NULL,
  `baseline_vitals` varchar(500) DEFAULT NULL,
  `respiratory_rate` varchar(10) DEFAULT NULL,
  `heart_rate` varchar(10) DEFAULT NULL,
  `spo2_room_air` varchar(10) DEFAULT NULL,
  `indication_of_tracheostomy` varchar(500) DEFAULT NULL,
  `comorbidities` varchar(500) DEFAULT NULL,
  `hemoglobin` varchar(10) DEFAULT NULL,
  `sr_sodium` varchar(10) DEFAULT NULL,
  `sr_potassium` varchar(10) DEFAULT NULL,
  `sr_calcium` varchar(10) DEFAULT NULL,
  `sr_bicarbonate` varchar(10) DEFAULT NULL,
  `pt` varchar(10) DEFAULT NULL,
  `aptt` varchar(10) DEFAULT NULL,
  `inr` varchar(10) DEFAULT NULL,
  `platelets` varchar(10) DEFAULT NULL,
  `liver_function_test` varchar(500) DEFAULT NULL,
  `renal_function_test` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addpatients`
--

INSERT INTO `addpatients` (`doctor_id`, `patient_id`, `name`, `age`, `address`, `bmi`, `diagnosis`, `surgery_status`, `post_op_tracheostomy_day`, `tube_name_size`, `baseline_vitals`, `respiratory_rate`, `heart_rate`, `spo2_room_air`, `indication_of_tracheostomy`, `comorbidities`, `hemoglobin`, `sr_sodium`, `sr_potassium`, `sr_calcium`, `sr_bicarbonate`, `pt`, `aptt`, `inr`, `platelets`, `liver_function_test`, `renal_function_test`) VALUES
('1', '52527ghz', 'ghz', 'bzh', 'xh', 'zbz', 'zvz', 'ss', 'ss', 'xxxccds', 'z', 'z', 'z', 'c', 'zx', 'ds', 'zz', 'zzc', 'ccas', 'vvb', 'bdz', 'cvv', 'zag', 'xv', 'zc', 'dv', 'nh'),
('123', '62585JohnDoe', 'JohnDoe', '45', '123 Main St', '25.5', 'Flu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `adminlogin`
--

CREATE TABLE `adminlogin` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adminlogin`
--

INSERT INTO `adminlogin` (`id`, `username`, `password`) VALUES
(1, 'Admin@test.com', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `appoinment_table`
--

CREATE TABLE `appoinment_table` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appoinment_table`
--

INSERT INTO `appoinment_table` (`doctorid`, `patient_id`, `date`) VALUES
('23', '556', '2023-08-28');

-- --------------------------------------------------------

--
-- Table structure for table `daily_report`
--

CREATE TABLE `daily_report` (
  `id` int(11) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `respiratory_rate` int(11) DEFAULT NULL,
  `heart_rate` int(11) DEFAULT NULL,
  `spo2_room_air` float DEFAULT NULL,
  `daily_dressing_done` enum('Yes','No') DEFAULT 'No',
  `tracheostomy_tie_changed` enum('Yes','No') DEFAULT 'No',
  `suctioning_done` enum('Yes','No') DEFAULT 'No',
  `oral_feeds_started` enum('Yes','No') DEFAULT 'No',
  `changed_to_green_tube` enum('Yes','No') DEFAULT 'No',
  `able_to_breathe_through_nose` enum('Yes','No') DEFAULT 'No',
  `secretion_color_consistency` varchar(50) DEFAULT NULL,
  `cough_or_breathlessness` enum('Yes','No') DEFAULT 'No',
  `breath_duration` int(11) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_report`
--

INSERT INTO `daily_report` (`id`, `patient_id`, `date`, `respiratory_rate`, `heart_rate`, `spo2_room_air`, `daily_dressing_done`, `tracheostomy_tie_changed`, `suctioning_done`, `oral_feeds_started`, `changed_to_green_tube`, `able_to_breathe_through_nose`, `secretion_color_consistency`, `cough_or_breathlessness`, `breath_duration`, `image_path`, `created_at`, `updated_at`) VALUES
(1, '123', '2024-08-24', 20, 80, 98.5, 'No', 'No', 'Yes', 'Yes', 'No', 'Yes', 'Clear', 'No', 5, '/images/patient_123.png', '2024-08-25 03:56:13', '2024-08-25 03:58:31'),
(2, '123', '2023-08-24', 20, 80, 98.5, 'Yes', 'No', 'Yes', 'Yes', 'No', 'Yes', 'Clear', 'No', 5, '/images/patient_123.png', '2024-08-25 03:56:52', '2024-08-25 03:56:52');

-- --------------------------------------------------------

--
-- Table structure for table `doctorlogin`
--

CREATE TABLE `doctorlogin` (
  `doctorid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctorlogin`
--

INSERT INTO `doctorlogin` (`doctorid`, `username`, `password`) VALUES
(1, 'Doctor@test.com', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `doctorprofile`
--

CREATE TABLE `doctorprofile` (
  `doctor_id` varchar(500) NOT NULL,
  `username` varchar(255) NOT NULL,
  `doctor_reg_no` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctorprofile`
--

INSERT INTO `doctorprofile` (`doctor_id`, `username`, `doctor_reg_no`, `email`, `phone_number`, `password`, `image_path`, `created_at`) VALUES
('25271587', 'bsbbdx', '1587', 'njaz@ywgs.co', 'bss', 'hsjs', '', '2024-09-18 07:00:10'),
('672630123456789', 'John Doe', '0123456789', 'johndoe@example.com', '+1234567890', 'examplePassword123', 'uploads/66ea6cf3a786a.jpg', '2024-09-18 06:02:27'),
('7749614523', 'hkh', '14523', 'asd@test.com', '4546', '46546', '../uploads/66ed108dc7e43.jpg', '2024-09-20 06:05:01');

-- --------------------------------------------------------

--
-- Table structure for table `medication_schedule`
--

CREATE TABLE `medication_schedule` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `tablet_name` varchar(255) NOT NULL,
  `morning_before_food` tinyint(1) DEFAULT 0,
  `morning_after_food` tinyint(1) DEFAULT 0,
  `afternoon_before_food` tinyint(1) DEFAULT 0,
  `afternoon_after_food` tinyint(1) DEFAULT 0,
  `night_before_food` tinyint(1) DEFAULT 0,
  `night_after_food` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medication_schedule`
--

INSERT INTO `medication_schedule` (`id`, `patient_id`, `date`, `tablet_name`, `morning_before_food`, `morning_after_food`, `afternoon_before_food`, `afternoon_after_food`, `night_before_food`, `night_after_food`, `created_at`) VALUES
(1, 123, '2024-08-29', 'Paracetamol', 1, 0, 1, 0, 0, 1, '2024-08-29 07:07:05'),
(2, 12345, '2024-08-29', 'Paracetamol', 1, 0, 1, 0, 1, 1, '2024-08-29 08:23:13'),
(3, 12345, '2024-08-29', 'Paracetamol', 1, 0, 1, 0, 1, 1, '2024-08-29 08:23:23');

-- --------------------------------------------------------

--
-- Table structure for table `patientlogin`
--

CREATE TABLE `patientlogin` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientlogin`
--

INSERT INTO `patientlogin` (`doctorid`, `patient_id`, `username`, `password`) VALUES
('1', '13717JohnDoe', '13717JohnDoe@trachcare.com', 'welcome'),
('2', 'p', 'p@test.com', '12');

-- --------------------------------------------------------

--
-- Table structure for table `patientprofile`
--

CREATE TABLE `patientprofile` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientprofile`
--

INSERT INTO `patientprofile` (`id`, `username`, `email`, `phone_number`, `password`, `image_path`, `created_at`, `updated_at`) VALUES
(1, 'drjohnsmith', 'drjohnsmith@example.com', '9500077434', 'newpassword123', 'uploads/66d0496e30a62.jpg', '2024-08-29 10:10:11', '2024-08-29 10:11:58'),
(2, 'Dr. John Doe', 'johndoe@example.com', '+14987888999', 'password123', NULL, '2024-09-15 05:15:59', '2024-09-15 05:15:59'),
(3, 'SIVANESAN', 'johndoe@example.com', '+14987888999', 'password123', NULL, '2024-09-15 05:17:44', '2024-09-15 05:17:44');

-- --------------------------------------------------------

--
-- Table structure for table `patientvideotable`
--

CREATE TABLE `patientvideotable` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `Video_url` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientvideotable`
--

INSERT INTO `patientvideotable` (`doctorid`, `patient_id`, `Video_url`) VALUES
('1', '13717JohnDoe', '/n/uploads/videos/477456981614-hd_1920_1080_30fps.mp4/n/uploads/videos/416586981614-hd_1920_1080_30fps.mp4/n/uploads/videos/595996981614-hd_1920_1080_30fps.mp4/n/uploads/videos/601046981614-hd_1920_1080_30fps.mp4/n/uploads/videos/363736981614-hd_1920_1080_30fps.mp4/n/uploads/videos/932676981614-hd_1920_1080_30fps.mp4/n/uploads/videos/710576981614-hd_1920_1080_30fps.mp4');

-- --------------------------------------------------------

--
-- Table structure for table `patient_details`
--

CREATE TABLE `patient_details` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `respiratory_rate` int(11) DEFAULT NULL,
  `heart_rate` int(11) DEFAULT NULL,
  `spo2_room_air` int(11) DEFAULT NULL,
  `daily_dressing_done` tinyint(1) DEFAULT NULL,
  `tracheostomy_tie_changed` tinyint(1) DEFAULT NULL,
  `suctioning_done` tinyint(1) DEFAULT NULL,
  `oral_feeds_started` tinyint(1) DEFAULT NULL,
  `changed_to_green_tube` tinyint(1) DEFAULT NULL,
  `able_to_breathe_through_nose` tinyint(1) DEFAULT NULL,
  `secretion_color_consistency` varchar(255) DEFAULT NULL,
  `cough_or_breathlessness` tinyint(1) DEFAULT NULL,
  `breath_duration` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_details`
--

INSERT INTO `patient_details` (`id`, `name`, `date`, `respiratory_rate`, `heart_rate`, `spo2_room_air`, `daily_dressing_done`, `tracheostomy_tie_changed`, `suctioning_done`, `oral_feeds_started`, `changed_to_green_tube`, `able_to_breathe_through_nose`, `secretion_color_consistency`, `cough_or_breathlessness`, `breath_duration`, `image_path`, `created_at`) VALUES
(1, 'John Doe', '2024-08-29', 92, 60, 98, 0, 0, 0, 0, 0, 0, 'Clear', 0, 'Normal', '/path/to/image.jpg', '2024-08-29 07:45:25');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addpatients`
--
ALTER TABLE `addpatients`
  ADD UNIQUE KEY `patient_id` (`patient_id`);

--
-- Indexes for table `adminlogin`
--
ALTER TABLE `adminlogin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `appoinment_table`
--
ALTER TABLE `appoinment_table`
  ADD PRIMARY KEY (`doctorid`,`patient_id`);

--
-- Indexes for table `daily_report`
--
ALTER TABLE `daily_report`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `patient_id` (`patient_id`,`date`);

--
-- Indexes for table `doctorlogin`
--
ALTER TABLE `doctorlogin`
  ADD PRIMARY KEY (`doctorid`);

--
-- Indexes for table `doctorprofile`
--
ALTER TABLE `doctorprofile`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `medication_schedule`
--
ALTER TABLE `medication_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patientlogin`
--
ALTER TABLE `patientlogin`
  ADD PRIMARY KEY (`patient_id`) USING BTREE;

--
-- Indexes for table `patientprofile`
--
ALTER TABLE `patientprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `patientvideotable`
--
ALTER TABLE `patientvideotable`
  ADD PRIMARY KEY (`doctorid`,`patient_id`);

--
-- Indexes for table `patient_details`
--
ALTER TABLE `patient_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminlogin`
--
ALTER TABLE `adminlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `daily_report`
--
ALTER TABLE `daily_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctorlogin`
--
ALTER TABLE `doctorlogin`
  MODIFY `doctorid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `medication_schedule`
--
ALTER TABLE `medication_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patientprofile`
--
ALTER TABLE `patientprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patient_details`
--
ALTER TABLE `patient_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

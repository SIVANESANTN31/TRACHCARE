-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 07, 2024 at 12:27 PM
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
  `doctor_id` varchar(255) DEFAULT NULL,
  `patient_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
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
  `renal_function_test` varchar(500) DEFAULT NULL,
  `image_path` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addpatients`
--

INSERT INTO `addpatients` (`doctor_id`, `patient_id`, `username`, `email`, `phone_number`, `password`, `age`, `address`, `bmi`, `diagnosis`, `surgery_status`, `post_op_tracheostomy_day`, `tube_name_size`, `baseline_vitals`, `respiratory_rate`, `heart_rate`, `spo2_room_air`, `indication_of_tracheostomy`, `comorbidities`, `hemoglobin`, `sr_sodium`, `sr_potassium`, `sr_calcium`, `sr_bicarbonate`, `pt`, `aptt`, `inr`, `platelets`, `liver_function_test`, `renal_function_test`, `image_path`) VALUES
('6273312345', '27855JohnDoe', 'JohnDoe', 'john.doe@example.com', '1234567890', '$2y$10$WU88KeGCsTAXYUG.LD8UieL53ZT0dkQJizyLmwU2jLu6cjlwPBPZ2', '45', '123 Main St, Springfield', '24.5', 'Lung Disease', 'Completed', '3', '8.0mm', 'Stable', '18', '72', '96', 'Respiratory Failure', 'Hypertension, Diabetes', '14', '140', '4.5', '9', '24', '12.5', '30', '1', '250000', 'Normal', 'Normal', '../uploads/patient_default.png'),
('6273312345', '62705hgflkhj', 'hgflkhj', '', '', '', 'hfjhlgh', 'ghfdhlkgj', 'jkgjfknfkh', 'kjglk', 'lfhgkfhg', 'kjgjddfh', 'dkjgfdnh', 'hgfg', 'fhgdfgnlf;', 'hvg;l', 'jjdg\'fkgh', 'sjdbffgfng;', 'hvfbg', 'jkdkbfjkdb', 'hvfhdvgf', 'jhfjhdfg', 'gfjhgdfj', 'fgjhsf', 'sjvvfhjv', 'shjdvsfh', 'vshch ', 'sjffasfh', 'sccshjfvjh', 'hcshfvhd', '');

--
-- Triggers `addpatients`
--
DELIMITER $$
CREATE TRIGGER `insertdata` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO patientprofile (doctor_id, patient_id, username, email, phone_number, password,image_path)
VALUES (NEW.doctor_id, NEW.patient_id, NEW.username,NEW.email,NEW.phone_number,NEW.password,NEW.image_path)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertid` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO patientlogin VALUES(doctor_id,patient_id,username,password)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adminlogin`
--

CREATE TABLE `adminlogin` (
  `id` int(11) NOT NULL,
  `doctor_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `doctor_reg_no` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image_path` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adminlogin`
--

INSERT INTO `adminlogin` (`id`, `doctor_id`, `username`, `doctor_reg_no`, `email`, `phone_number`, `password`, `image_path`) VALUES
(1, '12345', 'Admin@test.com', '12345', 'Admin@test.com', '12345678', '123456', '../uploads/doctorimages/66f38971e18f5.jpg');

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
  `date` date NOT NULL DEFAULT current_timestamp(),
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
(1, '123', '2024-10-02', 12, 34, 56, 'No', 'Yes', 'Yes', 'No', 'No', 'Yes', '50', 'No', 78, NULL, '2024-10-02 07:04:29', '2024-10-04 09:22:06'),
(2, 'PAT10023John', '2024-10-02', 98, 87, 0, 'Yes', '', 'Yes', '', 'Yes', '', '', '', 0, '', '2024-10-02 07:12:26', '2024-10-02 07:12:26');

-- --------------------------------------------------------

--
-- Table structure for table `daily_stauts`
--

CREATE TABLE `daily_stauts` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `stauts_10` tinyint(1) NOT NULL,
  `status_12` tinyint(1) NOT NULL,
  `stauts_2` tinyint(1) NOT NULL,
  `issues` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_stauts`
--

INSERT INTO `daily_stauts` (`doctorid`, `patient_id`, `stauts_10`, `status_12`, `stauts_2`, `issues`) VALUES
('jygj', 'jnk', 0, 1, 0, 0),
('jygj', 'jnk', 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `doctorlogin`
--

CREATE TABLE `doctorlogin` (
  `doctor_id` varchar(500) NOT NULL,
  `username` varchar(255) NOT NULL,
  `doctor_reg_no` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctorlogin`
--

INSERT INTO `doctorlogin` (`doctor_id`, `username`, `doctor_reg_no`, `email`, `phone_number`, `password`) VALUES
('6273312345', 'saranya', '12345', 'sranya@test.com', '145236987', '456');

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
('6273312345', 'saranya', '12345', 'sranya@test.com', '145236987', '456', '../uploads/doctorimages/66ff985694a0f.png', '2024-10-04 07:25:10');

--
-- Triggers `doctorprofile`
--
DELIMITER $$
CREATE TRIGGER `insertdoc` AFTER INSERT ON `doctorprofile` FOR EACH ROW INSERT INTO doctorlogin (doctor_id, username, doctor_reg_no, email, phone_number, password)
VALUES (NEW.doctor_id,NEW.username,NEW.doctor_reg_no,NEW.email,NEW.phone_number,NEW.password)
$$
DELIMITER ;

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
  `doctor_id` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientlogin`
--

INSERT INTO `patientlogin` (`doctor_id`, `patient_id`, `username`, `password`) VALUES
('', '', '', ''),
('1', '', '13717JohnDoe@trachcare.com', 'welcome'),
('2', '', 'p@test.com', '12'),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('1', '', '13717JohnDoe@trachcare.com', 'welcome'),
('2', '', 'p@test.com', '12'),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', ''),
('', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `patientprofile`
--

CREATE TABLE `patientprofile` (
  `doctor_id` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
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

INSERT INTO `patientprofile` (`doctor_id`, `patient_id`, `username`, `email`, `phone_number`, `password`, `image_path`, `created_at`, `updated_at`) VALUES
('6273312345', '62705hgflkhj', 'hgflkhj', 'test@test.com\r\n', '7418596', '12345', NULL, '2024-10-06 14:54:00', '2024-10-06 16:27:11'),
('6273312345', '27855JohnDoe', 'JohnDoe', 'john.doe@example.com', '1234567890', '$2y$10$WU88KeGCsTAXYUG.LD8UieL53ZT0dkQJizyLmwU2jLu6cjlwPBPZ2', '../uploads/patient_default.png', '2024-10-07 08:05:45', '2024-10-07 08:05:45');

-- --------------------------------------------------------

--
-- Table structure for table `patientvideotable`
--

CREATE TABLE `patientvideotable` (
  `s.no` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(500) NOT NULL,
  `Video_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientvideotable`
--

INSERT INTO `patientvideotable` (`s.no`, `title`, `description`, `Video_url`) VALUES
(8, 'sfdf', 'afar', '../uploads/videos/41380WhatsApp Video 2024-10-03 at 2.17.31 PM-73C809E4-8284-4F52-A593-FBDA206ADD99.MP4'),
(9, '', '', '../uploads/videos/62134363736981614-hd_1920_1080_30fps-579D5EEA-475B-4647-98D2-107B651D7EAF.MP4'),
(10, '', '', '../uploads/videos/71286363736981614-hd_1920_1080_30fps-579D5EEA-475B-4647-98D2-107B651D7EAF.MP4'),
(11, 'test1', 'fgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\n\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\nfgfgfgggfgggfgfgffffffgfgfgggfgggfgfgfffff\n', '../uploads/videos/74039363736981614-hd_1920_1080_30fps-579D5EEA-475B-4647-98D2-107B651D7EAF.MP4');

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
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id` (`id`) USING BTREE;

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
  ADD UNIQUE KEY `patient_id` (`patient_id`) USING BTREE;

--
-- Indexes for table `doctorlogin`
--
ALTER TABLE `doctorlogin`
  ADD UNIQUE KEY `doctorid` (`doctor_id`) USING BTREE;

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
-- Indexes for table `patientprofile`
--
ALTER TABLE `patientprofile`
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `patientvideotable`
--
ALTER TABLE `patientvideotable`
  ADD PRIMARY KEY (`s.no`);

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
-- AUTO_INCREMENT for table `medication_schedule`
--
ALTER TABLE `medication_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patientvideotable`
--
ALTER TABLE `patientvideotable`
  MODIFY `s.no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
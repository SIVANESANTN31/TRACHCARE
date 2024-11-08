-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2024 at 03:54 PM
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
('18771192121055', '32208ragul', 'ragul', 'test@test.com', ' 1234567890', '12345678', '30', '123 Main St', '22.5', 'Diagnosis description', 'Surgery status description', '2', ' Tube details', ' Normal vitals', ' 20', ' 80', ' 95', ' Indication description', ' None', ' 13.5', ' 140', ' 4.5', ' 9.0', ' 24', ' 12', ' 30', ' 1.0', ' 150000', ' Normal', ' Normal', '../uploads/patient.png');

--
-- Triggers `addpatients`
--
DELIMITER $$
CREATE TRIGGER `Add_spogotting` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO spiotting_status(doctorid,patient_id) VALUES(NEW.doctor_id,NEW.patient_id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deletelogin` AFTER DELETE ON `addpatients` FOR EACH ROW DELETE FROM patientlogin
WHERE patient_id = OLD.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deletepatients` AFTER DELETE ON `addpatients` FOR EACH ROW DELETE FROM patientprofile
WHERE patient_id = OLD.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deletespigotting` AFTER DELETE ON `addpatients` FOR EACH ROW DELETE FROM spiotting_status
WHERE patient_id = OLD.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deletestatus` AFTER DELETE ON `addpatients` FOR EACH ROW DELETE FROM daily_stauts
WHERE patient_id = OLD.patient_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientlogin` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO patientlogin (doctor_id, patient_id,username, password)
VALUES (NEW.doctor_id, NEW.patient_id, NEW.username,NEW.password)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientprofile` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO patientprofile (doctor_id, patient_id, username, email, phone_number, password,image_path)
VALUES (NEW.doctor_id, NEW.patient_id, NEW.username,NEW.email,NEW.phone_number,NEW.password,NEW.image_path)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `statusAdd` AFTER INSERT ON `addpatients` FOR EACH ROW INSERT INTO daily_stauts(doctorid,patient_id,username,status_10,status_12,status_2,status_4,status_6,issues)VALUES(NEW.doctor_id,NEW.patient_id,NEW.username,0,0,0,0,0,0)
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
(1, '192121057', 'admin', '192121057', 'test@test.com', '12345', '12345', '../uploads/admin/siva.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `appoinment_table`
--

CREATE TABLE `appoinment_table` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daily_report`
--

CREATE TABLE `daily_report` (
  `id` int(11) NOT NULL,
  `doctor_id` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
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
  `secretion_color_consistency` varchar(255) DEFAULT NULL,
  `cough_or_breathlessness` enum('Yes','No') DEFAULT 'No',
  `breath_duration` int(11) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_report`
--

INSERT INTO `daily_report` (`id`, `doctor_id`, `patient_id`, `username`, `date`, `respiratory_rate`, `heart_rate`, `spo2_room_air`, `daily_dressing_done`, `tracheostomy_tie_changed`, `suctioning_done`, `oral_feeds_started`, `changed_to_green_tube`, `able_to_breathe_through_nose`, `secretion_color_consistency`, `cough_or_breathlessness`, `breath_duration`, `image_path`, `created_at`, `updated_at`) VALUES
(1, '18771192121055', '32208ragul', 'ragul', '2024-11-08', 125, 147, 23, 'Yes', 'Yes', 'No', 'Yes', 'No', 'No', '', 'Yes', 0, '../uploads/patient.png', '2024-11-08 14:24:58', '2024-11-08 14:24:58');

--
-- Triggers `daily_report`
--
DELIMITER $$
CREATE TRIGGER `add_spigotting` AFTER INSERT ON `daily_report` FOR EACH ROW UPDATE spiotting_status
SET cough_or_breathlessness = NEW.cough_or_breathlessness,
    breath_duration = NEW.breath_duration
WHERE patient_id = NEW.patient_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `daily_stauts`
--

CREATE TABLE `daily_stauts` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `status_10` tinyint(1) NOT NULL,
  `status_12` tinyint(1) NOT NULL,
  `status_2` tinyint(1) NOT NULL,
  `status_4` tinyint(1) NOT NULL,
  `status_6` tinyint(1) NOT NULL,
  `issues` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daily_stauts`
--

INSERT INTO `daily_stauts` (`doctorid`, `patient_id`, `username`, `status_10`, `status_12`, `status_2`, `status_4`, `status_6`, `issues`) VALUES
('18771192121055', '32208ragul', 'ragul', 0, 0, 0, 0, 1, 1);

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
('18771192121055', 'varsha', '192121055', 'test@test.com', '123456789', '12345678', '../uploads/doctorimages/672e132c14553.jpg', '2024-11-08 13:33:32');

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
('18771192121055', '32208ragul', 'ragul', '12345678');

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
('18771192121055', '32208ragul', 'ragul', 'test@test.com', ' 1234567890', '12345678', '../uploads/patient.png', '2024-11-08 13:46:46', '2024-11-08 13:46:46');

--
-- Triggers `patientprofile`
--
DELIMITER $$
CREATE TRIGGER `deletepatientlogin` AFTER DELETE ON `patientprofile` FOR EACH ROW DELETE FROM patientlogin
WHERE patient_id = OLD.patient_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `patientvideotable`
--

CREATE TABLE `patientvideotable` (
  `s.no` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(500) NOT NULL,
  `Video_url` varchar(255) DEFAULT NULL,
  `Thumbnail_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patientvideotable`
--

INSERT INTO `patientvideotable` (`s.no`, `title`, `description`, `Video_url`, `Thumbnail_url`) VALUES
(1, 'Tracheostomy Tie', 'How to change tracheostomy tie', '../uploads/videos/43811VID_20241106_114338_580.mp4', '../uploads/thumbnails/43811JPEG_20241106_125837_1487491544511205671.jpg'),
(2, 'Tracheostomy dressing', 'How to change tracheostomy dressing', '../uploads/videos/62899VID_20241106_125602_863.mp4', '../uploads/thumbnails/62899JPEG_20241106_125951_4974202568391824599.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `spiotting_status`
--

CREATE TABLE `spiotting_status` (
  `doctorid` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `cough_or_breathlessness` varchar(255) DEFAULT NULL,
  `breath_duration` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `spiotting_status`
--

INSERT INTO `spiotting_status` (`doctorid`, `patient_id`, `cough_or_breathlessness`, `breath_duration`) VALUES
('18771192121055', '32208ragul', 'Yes', '0');

--
-- Triggers `spiotting_status`
--
DELIMITER $$
CREATE TRIGGER `updatetoDR` AFTER INSERT ON `spiotting_status` FOR EACH ROW UPDATE daily_report
SET cough_or_breathlessness = NEW.cough_or_breathlessness,
    breath_duration = NEW.breath_duration
WHERE patient_id = NEW.patient_id
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addpatients`
--
ALTER TABLE `addpatients`
  ADD UNIQUE KEY `patient_id` (`patient_id`),
  ADD UNIQUE KEY `email` (`email`,`phone_number`);

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
-- Indexes for table `daily_stauts`
--
ALTER TABLE `daily_stauts`
  ADD UNIQUE KEY `doctorid` (`doctorid`,`patient_id`);

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
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `patientprofile`
--
ALTER TABLE `patientprofile`
  ADD UNIQUE KEY `patient_id` (`patient_id`),
  ADD UNIQUE KEY `email` (`email`,`phone_number`);

--
-- Indexes for table `patientvideotable`
--
ALTER TABLE `patientvideotable`
  ADD PRIMARY KEY (`s.no`);

--
-- Indexes for table `spiotting_status`
--
ALTER TABLE `spiotting_status`
  ADD UNIQUE KEY `patient_id` (`patient_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `medication_schedule`
--
ALTER TABLE `medication_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patientvideotable`
--
ALTER TABLE `patientvideotable`
  MODIFY `s.no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `daily_status` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-06 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE daily_stauts SET status_10=0,status_12=0,status_2=0,status_4=0,status_6=0$$

CREATE DEFINER=`root`@`localhost` EVENT `daily_status_issues` ON SCHEDULE EVERY 2 HOUR STARTS '2024-11-06 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE daily_stauts SET issues=0$$

CREATE DEFINER=`root`@`localhost` EVENT `spogoting_update` ON SCHEDULE EVERY 2 HOUR STARTS '2024-11-06 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE spiotting_status SET cough_or_breathlessness=NULL,breath_duration=NULL$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

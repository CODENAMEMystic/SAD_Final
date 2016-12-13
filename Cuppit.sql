-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 13, 2016 at 12:59 PM
-- Server version: 5.6.30-cll-lve
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Cuppit`
--

-- --------------------------------------------------------

--
-- Table structure for table `game_center`
--

CREATE TABLE IF NOT EXISTS `game_center` (
  `highscore` int(11) DEFAULT NULL,
  `email` varchar(30) COLLATE ascii_bin DEFAULT NULL,
  `password` varchar(20) CHARACTER SET ascii DEFAULT NULL,
  KEY `email` (`email`),
  KEY `highscore` (`highscore`),
  KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin COMMENT='Game Center user info IF USED';

--
-- Dumping data for table `game_center`
--

INSERT INTO `game_center` (`highscore`, `email`, `password`) VALUES
(18, 'tanneremail@gmail.com', 'PasSWORd12');

-- --------------------------------------------------------

--
-- Table structure for table `game_session`
--

CREATE TABLE IF NOT EXISTS `game_session` (
  `session_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(40) NOT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `highscore` int(11) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `total_taps` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `device_id` (`device_id`),
  KEY `highscore` (`highscore`)
) ENGINE=InnoDB  DEFAULT CHARSET=ascii AUTO_INCREMENT=6 ;

--
-- Dumping data for table `game_session`
--

INSERT INTO `game_session` (`session_id`, `device_id`, `time`, `highscore`, `score`, `total_taps`) VALUES
(1, '1', '2016-12-12 07:00:00', 0, 0, 0),
(2, '043D08DB1F3180015092073399934230DEC30', '2016-12-12 16:34:06', 28, 15, 15),
(3, '065D265F651S000A63AA5648S8132S1356W', '2016-12-12 16:35:43', 32, 32, 32),
(4, '043D08DB1F3180015092073399934230DEC30', '2016-12-12 16:36:38', 18, 18, 18),
(5, '043D08DB1F3180015092073399934230DEC30', '2016-12-12 16:40:14', 20, 20, 20);

-- --------------------------------------------------------

--
-- Table structure for table `sensitive_data`
--

CREATE TABLE IF NOT EXISTS `sensitive_data` (
  `email` varchar(30) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COMMENT='Device information will be stored here';

--
-- Dumping data for table `sensitive_data`
--

INSERT INTO `sensitive_data` (`email`, `password`) VALUES
('tannertestemail@gmail.com', 'PasSWORd12'),
('tanneremail@gmail.com', 'Tannerpassword12');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `device_id` varchar(40) NOT NULL,
  `device_name` varchar(40) NOT NULL,
  `email` varchar(30) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`device_id`, `device_name`, `email`) VALUES
('043D08DB1F3180015092073399934230DEC30', '100000000000000001', 'tanneremail@gmail.com'),
('065D265F651S000A63AA5648S8132S1356W', 'Vm Name', NULL),
('1', 'Vm Test', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `game_center`
--
ALTER TABLE `game_center`
  ADD CONSTRAINT `game_center_ibfk_1` FOREIGN KEY (`email`) REFERENCES `sensitive_data` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_center_ibfk_2` FOREIGN KEY (`highscore`) REFERENCES `game_session` (`highscore`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `game_center_ibfk_3` FOREIGN KEY (`password`) REFERENCES `sensitive_data` (`password`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `game_session`
--
ALTER TABLE `game_session`
  ADD CONSTRAINT `game_session_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `user` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`email`) REFERENCES `sensitive_data` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

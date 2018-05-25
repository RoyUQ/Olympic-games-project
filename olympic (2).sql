-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 25, 2018 at 09:45 AM
-- Server version: 5.7.17
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `olympic`
--

-- --------------------------------------------------------

--
-- Table structure for table `Athlete`
--

CREATE TABLE `Athlete` (
  `AthleteID` int(11) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `PhoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Athlete`
--

INSERT INTO `Athlete` (`AthleteID`, `FirstName`, `LastName`, `Gender`, `Age`, `PhoneNumber`) VALUES
(10101, 'Matt', 'Graham', 'M', 24, 428387131),
(10102, 'Brodie', 'Summers', 'M', 27, 430234708),
(10103, 'James', 'Matheson', 'M', 26, 470652107),
(10104, 'Claudia', 'Gueli', 'F', 25, 430865234),
(10105, 'Lydia', 'Lassila', 'F', 25, 427855011),
(10302, 'Rose', 'Lawrance', 'F', 28, 452534712),
(10306, 'Sam', 'Watt', 'M', 30, 452567095),
(10400, 'Nick', 'Lee', 'M', 23, 384052752);

--
-- Triggers `Athlete`
--
DELIMITER $$
CREATE TRIGGER `filter_age1` BEFORE INSERT ON `Athlete` FOR EACH ROW BEGIN
SET
NEW.Age = IF (NEW.Age < 0 OR NEW.Age > 150, NULL, NEW.Age);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `AthleteInTeam`
--

CREATE TABLE `AthleteInTeam` (
  `AthleteID` int(11) NOT NULL,
  `TeamCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `AthleteInTeam`
--

INSERT INTO `AthleteInTeam` (`AthleteID`, `TeamCode`) VALUES
(10101, 310),
(10102, 311),
(10400, 311),
(10103, 313),
(10104, 313),
(10105, 314);

-- --------------------------------------------------------

--
-- Table structure for table `Coordinate`
--

CREATE TABLE `Coordinate` (
  `EventCode` int(11) NOT NULL,
  `CoordinatorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Coordinate`
--

INSERT INTO `Coordinate` (`EventCode`, `CoordinatorID`) VALUES
(3021, 510),
(3365, 511),
(3027, 512),
(4321, 513),
(4607, 514);

-- --------------------------------------------------------

--
-- Table structure for table `Coordinator`
--

CREATE TABLE `Coordinator` (
  `CoordinatorID` int(11) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `PhoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Coordinator`
--

INSERT INTO `Coordinator` (`CoordinatorID`, `FirstName`, `LastName`, `Gender`, `Age`, `PhoneNumber`) VALUES
(510, 'Harry', 'Harrison', 'M', 33, 411043190),
(511, 'Trina', 'Rostov', 'F', 37, 439087327),
(512, 'Phillis', 'Wilson', 'M', 29, 458523175),
(513, 'Grace', 'Ford', 'F', 43, 467020046),
(514, 'Neil', 'Oberford', 'M', 45, 452671208);

--
-- Triggers `Coordinator`
--
DELIMITER $$
CREATE TRIGGER `filter_age3` BEFORE INSERT ON `Coordinator` FOR EACH ROW BEGIN
SET
NEW.Age = IF (NEW.Age < 0 OR NEW.Age > 150, NULL, NEW.Age);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `TeamCode` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  `Salary` double DEFAULT NULL,
  `Job` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Employee`
--

INSERT INTO `Employee` (`TeamCode`, `StaffID`, `Salary`, `Job`) VALUES
(310, 16, 6302.8, 'Accountant'),
(310, 17, 8245.2, 'Lawyer'),
(311, 12, 5688.2, 'Assistant'),
(312, 22, 8203.1, 'Manager'),
(313, 11, 8039.6, 'Dentist');

--
-- Triggers `Employee`
--
DELIMITER $$
CREATE TRIGGER `filter_salary` BEFORE INSERT ON `Employee` FOR EACH ROW BEGIN
SET
NEW.Salary = IF (NEW.Salary <= 0, NULL, NEW.Salary);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Event`
--

CREATE TABLE `Event` (
  `EventCode` int(11) NOT NULL,
  `EventName` text,
  `Is_end` tinyint(1) NOT NULL,
  `WorldRecord` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Event`
--

INSERT INTO `Event` (`EventCode`, `EventName`, `Is_end`, `WorldRecord`) VALUES
(3001, 'Men\'s Aerials', 1, NULL),
(3002, 'Women\'s Aerials', 1, 222),
(3021, 'Men\'s Speedskating 5000m', 1, 369.76),
(3027, 'Women\'s Luge', 1, 46.254),
(3365, 'Women\'s Speedskating 500m', 1, 42.87),
(4321, 'Women\'s Slopestyle', 0, NULL),
(4607, 'Men\'s Slopestyle', 0, NULL);

--
-- Triggers `Event`
--
DELIMITER $$
CREATE TRIGGER `total_participation1` AFTER INSERT ON `Event` FOR EACH ROW BEGIN
IF NEW.EventCode <> ANY (SELECT EventCode FROM Register) 
OR NEW.EventCode <> ANY (SELECT EventCode FROM Coordinate) 
OR NEW.EventCode <> ANY (SELECT EventCode FROM HoldIn) 
OR NEW.EventCode <> ANY (SELECT EventCode FROM Preside)
THEN
DELETE FROM Event WHERE EventCode = NEW.EventCode;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `HoldIn`
--

CREATE TABLE `HoldIn` (
  `EventCode` int(11) NOT NULL,
  `VenueCode` int(11) NOT NULL,
  `Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `HoldIn`
--

INSERT INTO `HoldIn` (`EventCode`, `VenueCode`, `Date`) VALUES
(3021, 152, '2018-02-01'),
(3027, 154, '2018-02-03'),
(3365, 153, '2018-02-02'),
(4321, 155, '2018-05-20'),
(4607, 156, '2018-05-21');

-- --------------------------------------------------------

--
-- Table structure for table `PlaceMedal`
--

CREATE TABLE `PlaceMedal` (
  `Place` int(11) NOT NULL,
  `Medal` enum('Gold','Silver','Bronze') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PlaceMedal`
--

INSERT INTO `PlaceMedal` (`Place`, `Medal`) VALUES
(1, 'Gold'),
(2, 'Silver'),
(3, 'Bronze');

-- --------------------------------------------------------

--
-- Table structure for table `Preside`
--

CREATE TABLE `Preside` (
  `EventCode` int(11) NOT NULL,
  `RefereeID` int(11) NOT NULL,
  `Is_Mainreferee` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Preside`
--

INSERT INTO `Preside` (`EventCode`, `RefereeID`, `Is_Mainreferee`) VALUES
(3021, 2310, 1),
(3027, 2313, 0),
(3365, 2311, 0),
(4321, 2314, 1),
(4607, 2312, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Referee`
--

CREATE TABLE `Referee` (
  `RefereeID` int(11) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `PhoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Referee`
--

INSERT INTO `Referee` (`RefereeID`, `FirstName`, `LastName`, `Gender`, `Age`, `PhoneNumber`) VALUES
(2310, 'Gordon', 'Ford', 'M', 37, 410637142),
(2311, 'Jennifer', 'French', 'F', 32, 438234709),
(2312, 'Andrew', 'Spanner', 'M', 40, 452576881),
(2313, 'Nancy', 'Brown', 'F', 36, 460598422),
(2314, 'Jane', 'Smith', 'F', 43, 427265073);

--
-- Triggers `Referee`
--
DELIMITER $$
CREATE TRIGGER `filter_age2` BEFORE INSERT ON `Referee` FOR EACH ROW BEGIN
SET
NEW.Age = IF (NEW.Age < 0 OR NEW.Age > 150, NULL, NEW.Age);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Register`
--

CREATE TABLE `Register` (
  `AthleteID` int(11) NOT NULL,
  `EventCode` int(11) NOT NULL,
  `Place` int(11) DEFAULT NULL,
  `Score` double DEFAULT NULL,
  `Time` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Register`
--

INSERT INTO `Register` (`AthleteID`, `EventCode`, `Place`, `Score`, `Time`) VALUES
(10101, 3001, 2, 82.57, NULL),
(10101, 3021, 2, NULL, 370),
(10103, 3001, 14, 75.98, NULL),
(10104, 3002, 13, 68.68, NULL),
(10302, 3365, 3, NULL, 43.881),
(10306, 3021, 1, NULL, 369.76),
(10400, 3365, 1, NULL, 40);

--
-- Triggers `Register`
--
DELIMITER $$
CREATE TRIGGER `add_medal` AFTER INSERT ON `Register` FOR EACH ROW BEGIN
	IF NEW.place < 4 THEN
		SET @var = (SELECT TeamCode FROM AthleteInTeam
        WHERE AthleteID IN (SELECT AthleteID FROM Register WHERE 
        AthleteID = NEW.AthleteID)) ;
		UPDATE sum_medal
		SET medal_number = medal_number + 1
		WHERE tCode = @var;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `filter_place` BEFORE INSERT ON `Register` FOR EACH ROW BEGIN
SET
NEW.place = IF (NEW.place <= 0, NULL, NEW.place);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sum_medal`
--

CREATE TABLE `sum_medal` (
  `tCode` int(11) DEFAULT NULL,
  `tName` varchar(20) DEFAULT NULL,
  `medal_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sum_medal`
--

INSERT INTO `sum_medal` (`tCode`, `tName`, `medal_number`) VALUES
(310, 'Canada', 2),
(311, 'France', 1),
(312, 'Australia', 0),
(313, 'United States', 0),
(314, 'Russia', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Team`
--

CREATE TABLE `Team` (
  `TeamCode` int(11) NOT NULL,
  `TeamName` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Team`
--

INSERT INTO `Team` (`TeamCode`, `TeamName`) VALUES
(310, 'Canada'),
(311, 'France'),
(312, 'Australia'),
(313, 'United States'),
(314, 'Russia');

--
-- Triggers `Team`
--
DELIMITER $$
CREATE TRIGGER `add_team` AFTER INSERT ON `Team` FOR EACH ROW INSERT INTO sum_medal
    VALUES (NEW.TeamCode, NEW.TeamName, 0)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `Temp`
-- (See below for the actual view)
--
CREATE TABLE `Temp` (
`EventCode` int(11)
,`EventName` text
,`Is_end` tinyint(1)
,`VenueCode` int(11)
,`Date` date
,`VenueName` text
,`Seating_capacity` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `Venue`
--

CREATE TABLE `Venue` (
  `VenueCode` int(11) NOT NULL,
  `VenueName` text,
  `Seating_capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Venue`
--

INSERT INTO `Venue` (`VenueCode`, `VenueName`, `Seating_capacity`) VALUES
(152, 'St.George Hall', 18000),
(153, 'First Stadium', 15000),
(154, 'Great Sliding Center', 8800),
(155, 'Elizabeth Snow Park', 10000),
(156, 'Second Stadium', 13000);

--
-- Triggers `Venue`
--
DELIMITER $$
CREATE TRIGGER `filter_seating_capacity` BEFORE INSERT ON `Venue` FOR EACH ROW BEGIN
SET
NEW.Seating_capacity = IF (NEW.Seating_capacity <= 0 OR NEW.Seating_capacity >= 100000, NULL, NEW.Seating_capacity);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Volunteer`
--

CREATE TABLE `Volunteer` (
  `TeamCode` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  `Is_student` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Volunteer`
--

INSERT INTO `Volunteer` (`TeamCode`, `StaffID`, `Is_student`) VALUES
(310, 32, 1),
(311, 28, 0),
(312, 30, 1),
(313, 15, 1),
(313, 16, 0);

-- --------------------------------------------------------

--
-- Table structure for table `WorksForStaff`
--

CREATE TABLE `WorksForStaff` (
  `TeamCode` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `PhoneNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `WorksForStaff`
--

INSERT INTO `WorksForStaff` (`TeamCode`, `StaffID`, `FirstName`, `LastName`, `Gender`, `Age`, `PhoneNumber`) VALUES
(310, 16, 'Helen', 'Corn', 'F', 35, 406857312),
(310, 17, 'Frank', 'Lee', 'M', 42, 430234729),
(310, 32, 'Karen', 'Jonnason', 'F', 21, 438055712),
(311, 12, 'Mary', 'Watt', 'F', 27, 468035722),
(311, 28, 'Bill', 'Franklin', 'M', 40, 430876700),
(312, 22, 'Steve', 'Cristos', 'M', 50, 433065274),
(312, 30, 'Hyde', 'Green', 'M', 23, 480535286),
(312, 444, 'Nick', 'Lee', 'M', 22, 342334),
(313, 11, 'Robert', 'Anges', 'M', 42, 430876700),
(313, 15, 'Lucy', 'White', 'F', 28, 428852300),
(313, 16, 'David', 'Anderson', 'M', 25, 420604513);

--
-- Triggers `WorksForStaff`
--
DELIMITER $$
CREATE TRIGGER `filter_age4` BEFORE INSERT ON `WorksForStaff` FOR EACH ROW BEGIN
SET
NEW.Age = IF (NEW.Age < 0 OR NEW.Age > 150, NULL, NEW.Age);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `Temp`
--
DROP TABLE IF EXISTS `Temp`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `Temp`  AS  select `E`.`EventCode` AS `EventCode`,`E`.`EventName` AS `EventName`,`E`.`Is_end` AS `Is_end`,`H`.`VenueCode` AS `VenueCode`,`H`.`Date` AS `Date`,`V`.`VenueName` AS `VenueName`,`V`.`Seating_capacity` AS `Seating_capacity` from ((`Event` `E` left join `HoldIn` `H` on((`E`.`EventCode` = `H`.`EventCode`))) left join `Venue` `V` on((`H`.`VenueCode` = `V`.`VenueCode`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Athlete`
--
ALTER TABLE `Athlete`
  ADD PRIMARY KEY (`AthleteID`);

--
-- Indexes for table `AthleteInTeam`
--
ALTER TABLE `AthleteInTeam`
  ADD PRIMARY KEY (`AthleteID`,`TeamCode`),
  ADD KEY `TeamCode` (`TeamCode`);

--
-- Indexes for table `Coordinate`
--
ALTER TABLE `Coordinate`
  ADD PRIMARY KEY (`EventCode`,`CoordinatorID`),
  ADD KEY `CoordinatorID` (`CoordinatorID`);

--
-- Indexes for table `Coordinator`
--
ALTER TABLE `Coordinator`
  ADD PRIMARY KEY (`CoordinatorID`);

--
-- Indexes for table `Employee`
--
ALTER TABLE `Employee`
  ADD PRIMARY KEY (`TeamCode`,`StaffID`);

--
-- Indexes for table `Event`
--
ALTER TABLE `Event`
  ADD PRIMARY KEY (`EventCode`);

--
-- Indexes for table `HoldIn`
--
ALTER TABLE `HoldIn`
  ADD PRIMARY KEY (`EventCode`,`VenueCode`),
  ADD KEY `VenueCode` (`VenueCode`);

--
-- Indexes for table `PlaceMedal`
--
ALTER TABLE `PlaceMedal`
  ADD PRIMARY KEY (`Place`);

--
-- Indexes for table `Preside`
--
ALTER TABLE `Preside`
  ADD PRIMARY KEY (`EventCode`,`RefereeID`),
  ADD KEY `RefereeID` (`RefereeID`);

--
-- Indexes for table `Referee`
--
ALTER TABLE `Referee`
  ADD PRIMARY KEY (`RefereeID`);

--
-- Indexes for table `Register`
--
ALTER TABLE `Register`
  ADD PRIMARY KEY (`AthleteID`,`EventCode`),
  ADD KEY `EventCode` (`EventCode`);

--
-- Indexes for table `Team`
--
ALTER TABLE `Team`
  ADD PRIMARY KEY (`TeamCode`);

--
-- Indexes for table `Venue`
--
ALTER TABLE `Venue`
  ADD PRIMARY KEY (`VenueCode`);

--
-- Indexes for table `Volunteer`
--
ALTER TABLE `Volunteer`
  ADD PRIMARY KEY (`TeamCode`,`StaffID`);

--
-- Indexes for table `WorksForStaff`
--
ALTER TABLE `WorksForStaff`
  ADD PRIMARY KEY (`TeamCode`,`StaffID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AthleteInTeam`
--
ALTER TABLE `AthleteInTeam`
  ADD CONSTRAINT `AthleteInTeam_ibfk_1` FOREIGN KEY (`AthleteID`) REFERENCES `Athlete` (`AthleteID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `AthleteInTeam_ibfk_2` FOREIGN KEY (`TeamCode`) REFERENCES `Team` (`TeamCode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Coordinate`
--
ALTER TABLE `Coordinate`
  ADD CONSTRAINT `Coordinate_ibfk_1` FOREIGN KEY (`EventCode`) REFERENCES `Event` (`EventCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Coordinate_ibfk_2` FOREIGN KEY (`CoordinatorID`) REFERENCES `Coordinator` (`CoordinatorID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Employee`
--
ALTER TABLE `Employee`
  ADD CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`TeamCode`,`StaffID`) REFERENCES `WorksForStaff` (`TeamCode`, `StaffID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `HoldIn`
--
ALTER TABLE `HoldIn`
  ADD CONSTRAINT `HoldIn_ibfk_1` FOREIGN KEY (`EventCode`) REFERENCES `Event` (`EventCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `HoldIn_ibfk_2` FOREIGN KEY (`VenueCode`) REFERENCES `Venue` (`VenueCode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Preside`
--
ALTER TABLE `Preside`
  ADD CONSTRAINT `Preside_ibfk_1` FOREIGN KEY (`EventCode`) REFERENCES `Event` (`EventCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Preside_ibfk_2` FOREIGN KEY (`RefereeID`) REFERENCES `Referee` (`RefereeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Register`
--
ALTER TABLE `Register`
  ADD CONSTRAINT `Register_ibfk_1` FOREIGN KEY (`AthleteID`) REFERENCES `Athlete` (`AthleteID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Register_ibfk_2` FOREIGN KEY (`EventCode`) REFERENCES `Event` (`EventCode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Volunteer`
--
ALTER TABLE `Volunteer`
  ADD CONSTRAINT `Volunteer_ibfk_1` FOREIGN KEY (`TeamCode`,`StaffID`) REFERENCES `WorksForStaff` (`TeamCode`, `StaffID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `WorksForStaff`
--
ALTER TABLE `WorksForStaff`
  ADD CONSTRAINT `WorksForStaff_ibfk_1` FOREIGN KEY (`TeamCode`) REFERENCES `Team` (`TeamCode`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

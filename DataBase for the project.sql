-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2017 at 04:23 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pythonproj`
--

-- --------------------------------------------------------

--
-- Table structure for table `g1`
--

CREATE TABLE `g1` (
  `Number` tinyint(4) NOT NULL,
  `ItemRarity` varchar(20) DEFAULT NULL,
  `ItemQuality` varchar(20) DEFAULT NULL,
  `ItemCategory` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `g1`
--

INSERT INTO `g1` (`Number`, `ItemRarity`, `ItemQuality`, `ItemCategory`) VALUES
(1, 'Level 1', NULL, 'Crate Key'),
(2, 'Level 2', NULL, 'Paint Case'),
(3, 'Level 3', NULL, 'Cosmetic Case'),
(4, 'Level 4', NULL, 'Paint'),
(5, 'Level 5', NULL, 'Ticket'),
(6, 'Level 6', NULL, 'Tool'),
(7, 'Level 7', NULL, 'Apparel'),
(8, 'Level 8', NULL, 'Crate'),
(13, 'Level 13', NULL, NULL),
(15, 'Level 15', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `g2`
--

CREATE TABLE `g2` (
  `Number` tinyint(4) NOT NULL,
  `ItemRarity` varchar(20) DEFAULT NULL,
  `ItemQuality` varchar(20) DEFAULT NULL,
  `ItemCategory` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `g2`
--

INSERT INTO `g2` (`Number`, `ItemRarity`, `ItemQuality`, `ItemCategory`) VALUES
(1, 'Uncommon', NULL, 'Treasure'),
(2, 'Rare', NULL, 'Arms'),
(3, 'Mythical', NULL, 'Bundle'),
(4, 'Immortal', NULL, 'Pet'),
(5, 'Legendary', NULL, 'Head'),
(6, 'Arcana', NULL, 'Hair'),
(7, 'Ancient', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `g3`
--

CREATE TABLE `g3` (
  `Number` tinyint(4) NOT NULL,
  `ItemRarity` varchar(20) DEFAULT NULL,
  `ItemQuality` varchar(20) DEFAULT NULL,
  `ItemCategory` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `g3`
--

INSERT INTO `g3` (`Number`, `ItemRarity`, `ItemQuality`, `ItemCategory`) VALUES
(1, 'Consumer Grade', 'Field-Tested', 'Case'),
(2, 'Mil-Spec Grade', 'Minimal Wear', 'Case Key'),
(3, 'Industrial Grade', 'Battle-Scarred', 'AK-47'),
(4, 'Restricted', 'Well-Worn', 'M4A4'),
(5, 'Classified', 'Factory New', 'M4A1-S'),
(6, 'Covert', 'Not Painted', NULL),
(7, 'Base Grade', NULL, NULL),
(8, 'High Grade', NULL, NULL),
(9, 'Exotic', NULL, NULL),
(10, 'Extraordinary', NULL, NULL),
(11, 'Remarkable', NULL, NULL),
(12, 'Contraband', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `g5`
--

CREATE TABLE `g5` (
  `Number` tinyint(4) NOT NULL,
  `ItemRarity` varchar(20) DEFAULT NULL,
  `ItemQuality` varchar(20) DEFAULT NULL,
  `ItemCategory` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `g5`
--

INSERT INTO `g5` (`Number`, `ItemRarity`, `ItemQuality`, `ItemCategory`) VALUES
(1, NULL, NULL, 'Crate'),
(2, NULL, NULL, 'Key'),
(3, NULL, NULL, 'Top'),
(4, NULL, NULL, 'Pants'),
(5, NULL, NULL, 'Jacket'),
(6, NULL, NULL, 'Shirt'),
(7, NULL, NULL, 'Balaclava');

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

CREATE TABLE `games` (
  `GameId` smallint(5) UNSIGNED NOT NULL,
  `GameName` varchar(50) NOT NULL,
  `GamePrice` float NOT NULL,
  `GameCategory` tinyint(3) UNSIGNED NOT NULL,
  `HasItems` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`GameId`, `GameName`, `GamePrice`, `GameCategory`, `HasItems`) VALUES
(1, 'Team Fotress 2', 479, 0, 1),
(2, 'DOTA 2', 0, 0, 1),
(3, 'Counter-Strike GO', 20.2, 2, 1),
(4, 'GTA V', 2337, 0, 0),
(5, 'Player Unknown BattleGrounds', 999, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `iteminfo`
--

CREATE TABLE `iteminfo` (
  `ItemNo` int(10) UNSIGNED NOT NULL,
  `ItemName` varchar(64) NOT NULL,
  `ItemRarity` tinyint(3) UNSIGNED DEFAULT '0',
  `ItemQuality` tinyint(3) UNSIGNED DEFAULT '0',
  `ItemType` tinyint(3) UNSIGNED DEFAULT '0',
  `ItemPrice` float NOT NULL,
  `ItemQuantity` mediumint(8) UNSIGNED NOT NULL,
  `ItemCategory` tinyint(3) UNSIGNED DEFAULT '0',
  `ItemInfo` text,
  `GameId` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `iteminfo`
--

INSERT INTO `iteminfo` (`ItemNo`, `ItemName`, `ItemRarity`, `ItemQuality`, `ItemType`, `ItemPrice`, `ItemQuantity`, `ItemCategory`, `ItemInfo`, `GameId`) VALUES
(1, 'GAMESCOM INVITATIONAL CRATE\r\n', 0, 0, 0, 4.07, 52363, 0, 'GAMESCOM INVITATIONAL CRATE\r\n', 5),
(2, 'SURVIVOR CRATE\r\n\r\n', 0, 0, 0, 0.47, 82441, 0, 'SURVIVOR CRATE\r\n', 5),
(3, 'WANDERER CRATE', 0, 0, 0, 0.55, 74285, 0, 'WANDERER CRATE\r\n', 5),
(4, 'GAMESCOM INVITATIONAL KEY\r\n', 0, 0, 0, 3.17, 6424, 1, 'GAMESCOM INVITATIONAL KEY\r\n', 5),
(5, 'Tracksuit Top (Yellow)\r\n', 0, 0, 0, 17.98, 1292, 2, 'Tracksuit Top (Yellow)\r\n', 5),
(6, 'Tracksuit Pants (Yellow)\r\n', 0, 0, 0, 15.01, 1115, 3, 'Tracksuit Pants (Yellow)\r\n', 5),
(7, 'Mandarin Jacket (Black)\r\n', 0, 0, 0, 9.03, 1142, 4, 'Mandarin Jacket (Black)\r\n', 5),
(8, 'Shirt (Black)\r\nShirt (Black)\r\n', 0, 0, 0, 2.41, 2132, 5, 'Shirt (Black)\r\n', 5),
(9, 'checked shirt (red)\r\n', 0, 0, 1, 8.46, 2253, 5, 'checked shirt (red)\r\n', 5),
(10, 'Twitch Prime Balaclava\r\n', 0, 0, 0, 13.45, 1644, 6, 'Twitch Prime Balaclava\r\n', 5),
(11, 'Siltbreaker Reward\r\n', 4, 0, 0, 0.89, 17050, 0, 'This treasure is only available during The International 2017 Battle Pass duration as a reward for the Siltbreaker Campaign event. It contains treasures, as well as the chance to receive an extremely rare Desert Baby Roshan.\r\n', 2),
(12, 'Magus Accord\r\n', 5, 0, 1, 8.48, 1760, 1, '\"Used By: Invoker\r\nBefore the age of Gaster, even the most adept of mages would turn to flee with a burst of defensive magic when facing the close-quarters charge of a well-armed opponent.\"\r\n', 2),
(13, 'Sullen Harvest\r\n', 5, 0, 2, 19.24, 2124, 1, '\"Used By: Necrophos\r\nThe hooded figure that waits beyond the veil pays close mind to the path of the Necrophos. For where Rotund\'jere\'s footsteps fall, the reaper\'s work will surely follow.\"\r\n', 2),
(14, 'Origins of Faith\r\n', 5, 0, 3, 2.16, 1540, 1, '\"Used By: Anti-Mage\r\nAt all times the Anti-Mage feels the flames of defining loss burning against his back, pushing him ever forward in pursuit of his blood-sworn oath.\"\r\n', 2),
(15, 'Bitter Lineage\r\n', 5, 0, 4, 2, 1482, 1, 'Following a fatal clash with a pair of Oglodi troll hunters, Jah\'rakal cast off his crude clubs in favor of their twin blades that burn hot with the rage of battle.\r\n', 2),
(16, 'Exalted Bladeform Legacy\r\n', 7, 0, 5, 29.99, 2055, 1, 'Yurnero\'s mask has been cleaved in two, awakening the ancient souls that once laid dormant inside it. These spirits have become one with Yurnero, giving him both the wisdom and fury of his ancestors. This symbiotic relationship has transformed The Juggernaut into something new and terrifying - a celestial force of nature.\r\n', 2),
(17, 'Rambling Fatebender\r\n', 3, 0, 0, 2.45, 820, 2, '\"Used By: Rubick\r\nContains the Rambling Fatebender set for Rubick, including the Loading Screen.\"\r\n', 2),
(18, 'Almond the Frondillo\r\n', 5, 0, 0, 2.03, 2260, 3, 'A place of primal turmoil, the Yama Raskav Jungle is home to creatures evolved to guard against the endless and savage struggle. Taken from her home as a pup, a hard-shell Frondillo named Almond escaped her owner and found her way to an even greater conflict.\r\n', 2),
(19, 'Hair of the Survivor\r\n', 4, 0, 0, 36, 837, 4, 'As even the faces of favored kin fade from recollection, the unholy forms of the Turstarkuri faithful rise perversely in the mind\'s eye.\r\n', 2),
(20, 'Inscribed Magus Apex\r\n', 5, 0, 0, 3.36, 1795, 5, 'The Sol Apex Incantation, forgotten for over nine thousand years, promised its caster the chance to touch the sun, bathe in its blinding glory, and harness its most scalding wrath. Only one would dare be so bold.\r\n', 2),
(21, 'Spectrum 2 Case\r\n', 7, 0, 0, 0.4, 90124, 1, 'Container Series #220\r\n', 3),
(22, 'Spectrum 2 Case Key\r\n', 7, 0, 0, 2.64, 3585, 2, 'This key only opens Spectrum 2 cases\r\n', 3),
(23, 'Spectrum Case Key\r\n', 7, 0, 1, 2.64, 2661, 2, 'This key only opens Spectrum cases\r\n', 3),
(24, 'AK-47 | Point Disarray\r\n', 5, 1, 0, 11.04, 1410, 3, 'Powerful and reliable, the AK-47 is one of the most popular assault rifles in the world. It is most deadly in short, controlled bursts of fire. It has been custom painted with a geometric hydrographic. Up close it is chaos... from a distance it is beauty - Franz Kriegeld, Phoenix Tactician \r\n', 3),
(25, 'M4A4 | Desolate Space\r\n', 5, 1, 0, 8.48, 2325, 3, 'More accurate but less damaging than its AK-47 counterpart, the M4A4 is the full-auto assault rifle of choice for CTs. It has been custom painted with a space theme.\r\n', 3),
(26, 'M4A1-S | Hyper Beast\r\n', 5, 1, 0, 7.55, 2271, 5, 'With a smaller magazine than its unmuffled counterpart, the silenced M4A1 provides quieter shots with less recoil and better accuracy. It has been custom painted with a beastly creature in psychedelic colors. You really want to impress me Booth? Make this black light sensitive - Rona Sabri, Rising Star\r\n', 3),
(27, 'Glove Case Key\r\n', 7, 0, 2, 2.65, 1118, 2, 'This key only opens Glove cases \r\n', 3),
(28, 'Operation Hydra Case Key\r\n', 7, 0, 3, 2.58, 2895, 2, 'This key only opens Operation Hydra cases\r\n', 3),
(29, 'AK-47 | Redline\r\n', 5, 1, 1, 6.99, 11971, 3, 'Powerful and reliable, the AK-47 is one of the most popular assault rifles in the world. It is most deadly in short, controlled bursts of fire. It has been painted using a carbon fiber hydrographic and a dry-transfer decal of a red pinstripe. Never be afraid to push it to the limit \r\n', 3),
(30, 'M4A1-S | Decimator\r\n', 5, 1, 1, 6.01, 2377, 5, 'With a smaller magazine than its unmuffled counterpart, the silenced M4A1 provides quieter shots with less recoil and better accuracy. It has been custom painted with a beastly creature in psychedelic colors. You really want to impress me Booth? Make this black light sensitive - Rona Sabri, Rising Star\r\n', 3),
(31, 'Mann Co. Supply Crate Key\r\n', 5, 9, 0, 2.39, 3739, 1, 'Used to open locked supply crates.\r\n', 1),
(32, 'Infernal Reward War Paint Case\r\n', 0, 0, 0, 0.7, 292, 2, 'Paint your master piece with one of these community-made War Paints.\r\n', 1),
(33, 'Abominable Cosmetic Case\r\n', 0, 0, 0, 1.23, 1496, 3, '\"Contains a community made item\r\nfrom the Abominable Cosmetic Collection.\"\r\n', 1),
(34, 'Jungle Jackpot War Paint Case\r\n', 0, 0, 1, 4.23, 570, 2, 'Never bring an unpainted gun to a painted gunfight.\r\n', 1),
(35, 'Dragon Slayer War Paint\r\n', 0, 0, 0, 7.75, 26, 4, 'Elite Grade War Paint (Factory New)\r\n', 1),
(36, 'Tour of Duty Ticket\r\n', 1, 0, 0, 0.93, 4996, 5, 'Present this ticket in Mann vs. Machine to play Mann Up Mode on an official server to earn rare items and track progress on your Tour of Duty Badge.\r\n', 1),
(37, 'Unless the Beast Cosmetic Case\r\n', 0, 0, 1, 0.1, 1348, 3, 'Contains a community made item from the Unleash the Beast Cosmetic Collection.\r\n', 1),
(38, 'Name Tag\r\n', 1, 0, 0, 0.49, 5477, 6, 'Changes the name of an item in your backpack.\r\n', 1),
(39, 'The Space Diver\r\n', 15, 0, 0, 0.89, 290, 7, 'Mercenary Grade Apparel\r\n', 1),
(40, 'End of the Line Community Crate Series #87\r\n', 13, 0, 0, 0.03, 45603, 8, 'The End of the Line Community Crate contains Unusual effects that will only come from this crate.\r\n', 1);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `UserId` int(10) UNSIGNED DEFAULT NULL,
  `ItemId` int(10) UNSIGNED NOT NULL,
  `ItemNo` int(10) UNSIGNED NOT NULL,
  `ForSale` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`UserId`, `ItemId`, `ItemNo`, `ForSale`) VALUES
(1, 1, 1, 1),
(2, 2, 23, 0),
(1, 3, 6, 0),
(5, 4, 8, 1),
(2, 5, 27, 1),
(1, 6, 27, 0),
(1, 7, 19, 0),
(3, 8, 13, 0),
(2, 9, 7, 1),
(1, 10, 19, 1),
(3, 11, 32, 1),
(2, 12, 4, 0),
(5, 13, 7, 0),
(2, 14, 8, 0),
(1, 15, 11, 1),
(5, 16, 14, 1),
(2, 17, 18, 0),
(4, 18, 22, 1),
(5, 19, 24, 0),
(2, 20, 26, 0),
(1, 21, 33, 0),
(2, 22, 2, 1),
(2, 23, 17, 1),
(1, 24, 21, 1),
(5, 25, 3, 1),
(1, 26, 5, 0),
(1, 27, 10, 0),
(1, 28, 16, 0),
(4, 29, 20, 1),
(3, 30, 25, 1),
(2, 31, 25, 0),
(1, 32, 28, 0),
(1, 33, 30, 1),
(3, 34, 29, 0),
(4, 35, 30, 0),
(4, 36, 31, 0),
(5, 37, 33, 1),
(5, 38, 37, 0),
(2, 39, 34, 0),
(5, 40, 36, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transcation`
--

CREATE TABLE `transcation` (
  `TransId` bigint(20) UNSIGNED NOT NULL,
  `SellerId` int(10) UNSIGNED NOT NULL,
  `BuyerId` int(10) UNSIGNED NOT NULL,
  `ItemId` int(10) UNSIGNED NOT NULL,
  `SalePrice` float NOT NULL,
  `Time` datetime NOT NULL,
  `GameId` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transcation`
--

INSERT INTO `transcation` (`TransId`, `SellerId`, `BuyerId`, `ItemId`, `SalePrice`, `Time`, `GameId`) VALUES
(165092, 1, 2, 5, 2.65, '2017-11-01 03:11:17', 3),
(235369, 4, 2, 12, 3.17, '2017-11-01 17:08:56', 5),
(355905, 1, 2, 6, 2.65, '2017-11-01 02:34:07', 3),
(480237, 2, 1, 6, 2.65, '2017-11-01 02:47:24', 3),
(1296961, 2, 1, 24, 0.4, '2017-11-01 14:42:58', 3),
(1737122, 3, 1, 15, 0.89, '2017-11-03 20:36:35', 2),
(3375441, 3, 2, 39, 4.23, '2017-11-01 14:39:32', 1),
(3562223, 3, 1, 28, 29.99, '2017-11-03 20:30:33', 2),
(3827966, 3, 2, 2, 2.64, '2017-11-01 02:33:49', 3),
(4071920, 3, 1, 26, 17.98, '2017-11-01 14:46:04', 5),
(5125688, 2, 5, 40, 0.93, '2017-11-03 20:51:19', 1),
(5667767, 2, 1, 5, 2.65, '2017-11-01 02:47:16', 3),
(5945905, 3, 2, 14, 2.41, '2017-11-01 14:28:39', 5),
(6055688, 2, 1, 32, 2.58, '2017-11-01 14:44:23', 3),
(6651679, 3, 1, 27, 13.45, '2017-11-01 14:46:28', 5),
(6698139, 2, 1, 7, 36, '2017-11-01 02:32:04', 2),
(6903087, 2, 1, 3, 15.01, '2017-11-01 14:46:53', 5),
(6911246, 1, 2, 5, 2.65, '2017-11-01 02:33:12', 3),
(8471643, 5, 2, 3, 15.01, '2017-11-01 03:11:30', 5),
(8839898, 2, 1, 10, 36, '2017-11-01 02:32:48', 2),
(9227817, 5, 2, 31, 8.48, '2017-11-03 20:45:49', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserId` int(10) UNSIGNED NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Balance` float DEFAULT '0',
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `Phone` bigint(20) UNSIGNED NOT NULL,
  `Country` varchar(20) NOT NULL,
  `Email` varchar(32) NOT NULL,
  `Password` varchar(32) NOT NULL,
  `Description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserId`, `UserName`, `Balance`, `FirstName`, `LastName`, `Phone`, `Country`, `Email`, `Password`, `Description`) VALUES
(1, 'user1', 314.76, 'Bandaru', 'Kumar', 1345678965, 'India', 'bandarubharath7@gmail.com', '12345678', ''),
(2, 'user', 449.45, 'bbkhello', 'lastname', 159487159, 'india', 'abcd@gmail.com', 'bharath7', 'Hello'),
(3, 'user4', 71.59, 'fname', 'lname', 134578988, 'india', 'abcd@gmail.com', '134679', NULL),
(4, 'thermophobe', 123.17, 'Thermal', 'Related', 7355608, 'Isla de Muerta', 'thermophobe@cs.gg', 'rock paper scissors', 'Owner of SK Gaming\r\n'),
(5, 'phoon', 322.56, 'P', 'Hoon', 250350450, 'US', 'phoon@thealamente.com', 'Strafe', 'Check out my work at https://www.youtube.com/watch?v=2Kc-HfSG7m4\r\n'),
(11, 'asdsadsa', 0, 'dsaad', 'sadsad', 12345678, 'india', 'asa@gmail.com', '123', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`GameId`);

--
-- Indexes for table `iteminfo`
--
ALTER TABLE `iteminfo`
  ADD PRIMARY KEY (`ItemNo`),
  ADD KEY `GameId` (`GameId`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`ItemId`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `transcation`
--
ALTER TABLE `transcation`
  ADD PRIMARY KEY (`TransId`),
  ADD KEY `GameId` (`GameId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserId`),
  ADD UNIQUE KEY `UserName` (`UserName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `GameId` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `iteminfo`
--
ALTER TABLE `iteminfo`
  MODIFY `ItemNo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `iteminfo`
--
ALTER TABLE `iteminfo`
  ADD CONSTRAINT `iteminfo_ibfk_1` FOREIGN KEY (`GameId`) REFERENCES `games` (`GameId`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`);

--
-- Constraints for table `transcation`
--
ALTER TABLE `transcation`
  ADD CONSTRAINT `transcation_ibfk_1` FOREIGN KEY (`GameId`) REFERENCES `games` (`GameId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

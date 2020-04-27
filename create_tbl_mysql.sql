-- main moduel
CREATE TABLE IF NOT EXISTS `actor` (
 `id` int(11) NOT NULL,
 `name` varchar(50) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `actorname` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `casting` (
 `movieid` int(11) NOT NULL DEFAULT 0,
 `actorid` int(11) NOT NULL DEFAULT 0,
 `ord` int(11) NOT NULL DEFAULT 0,
 PRIMARY KEY (`movieid`,`actorid`,`ord`),
 KEY `castact` (`actorid`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `dept` (
 `id` int(11) NOT NULL,
 `name` varchar(50) DEFAULT NULL,
 PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `eteam` (
 `id` varchar(3) DEFAULT NULL,
 `teamname` varchar(50) DEFAULT NULL,
 `coach` varchar(50) DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `game` (
 `id` int(11) DEFAULT NULL,
 `mdate` varchar(12) DEFAULT NULL,
 `stadium` varchar(100) DEFAULT NULL,
 `team1` varchar(100) DEFAULT NULL,
 `team2` varchar(100) DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `ge` (
 `yr` int(11) NOT NULL,
 `firstName` varchar(40) NOT NULL,
 `lastName` varchar(40) NOT NULL,
 `constituency` varchar(10) NOT NULL,
 `party` varchar(50) DEFAULT NULL,
 `votes` int(11) DEFAULT NULL,
 PRIMARY KEY (`yr`,`firstName`,`lastName`,`constituency`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `goal` (
 `matchid` int(11) NOT NULL DEFAULT 0,
 `teamid` varchar(3) DEFAULT NULL,
 `player` varchar(100) DEFAULT NULL,
 `gtime` int(11) NOT NULL DEFAULT 0,
 PRIMARY KEY (`matchid`,`gtime`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `movie` (
 `id` int(11) NOT NULL,
 `title` varchar(50) DEFAULT NULL,
 `yr` int(11) DEFAULT NULL,
 `director` int(11) DEFAULT NULL,
 `budget` int(11) DEFAULT NULL,
 `gross` int(11) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `director` (`director`),
 KEY `movietitle` (`title`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `nobel` (
 `yr` int(11) DEFAULT NULL,
 `subject` varchar(15) DEFAULT NULL,
 `winner` varchar(50) DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `nss` (
 `ukprn` varchar(8) NOT NULL,
 `institution` varchar(100) DEFAULT NULL,
 `subject` varchar(60) NOT NULL DEFAULT '',
 `level` varchar(50) NOT NULL DEFAULT '',
 `question` varchar(10) NOT NULL DEFAULT '',
 `A_STRONGLY_DISAGREE` int(11) DEFAULT NULL,
 `A_DISAGREE` int(11) DEFAULT NULL,
 `A_NEUTRAL` int(11) DEFAULT NULL,
 `A_AGREE` int(11) DEFAULT NULL,
 `A_STRONGLY_AGREE` int(11) DEFAULT NULL,
 `A_NA` int(11) DEFAULT NULL,
 `CI_MIN` int(11) DEFAULT NULL,
 `score` int(11) DEFAULT NULL,
 `CI_MAX` int(11) DEFAULT NULL,
 `response` int(11) DEFAULT NULL,
 `sample` int(11) DEFAULT NULL,
 `aggregate` char(1) DEFAULT NULL,
 PRIMARY KEY (`ukprn`,`subject`,`level`,`question`),
 KEY `nss_question` (`question`),
 KEY `nss_subject` (`subject`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE IF NOT EXISTS `route` (
 `num` varchar(5) NOT NULL,
 `company` varchar(3) NOT NULL,
 `pos` int(11) NOT NULL,
 `stop` int(11) DEFAULT NULL,
 PRIMARY KEY (`num`,`company`,`pos`),
 KEY `stop` (`stop`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `stops` (
 `id` int(11) NOT NULL,
 `name` varchar(30) DEFAULT NULL,
 PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `teacher` (
 `id` int(11) NOT NULL,
 `dept` int(11) DEFAULT NULL,
 `name` varchar(50) DEFAULT NULL,
 `phone` varchar(50) DEFAULT NULL,
 `mobile` varchar(50) DEFAULT NULL,
 PRIMARY KEY (`id`),
 KEY `teacher_dept` (`dept`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `world` (
 `name` varchar(50) NOT NULL,
 `continent` varchar(60) DEFAULT NULL,
 `area` decimal(10,0) DEFAULT NULL,
 `population` decimal(11,0) DEFAULT NULL,
 `gdp` decimal(14,0) DEFAULT NULL,
 `capital` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
 `tld` varchar(5) DEFAULT NULL,
 `flag` varchar(255) DEFAULT NULL,
 PRIMARY KEY (`name`),
 KEY `world_continent` (`continent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `covid` (
  `name` varchar(50) NOT NULL,
  `whn` date NOT NULL, 
  `confirmed` int(11) DEFAULT NULL, 
  `deaths` int(11) DEFAULT NULL, 
  `recovered` int(11) DEFAULT NULL, 
  PRIMARY KEY (`name`,`whn`), 
  CONSTRAINT `covid_ibfk_1` FOREIGN KEY (`name`) REFERENCES `world` (`name`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- Advanced challenges
-- 1. Module feedback
CREATE TABLE IF NOT EXISTS `INS_CAT` (
  `CAT_CODE` varchar(8) NOT NULL,
  `CAT_NAME` varchar(100) DEFAULT NULL,
  `CAT_SNAM` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CAT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `INS_PRS` (
  `PRS_CODE` char(8) NOT NULL,
  `PRS_FNM1` varchar(100) DEFAULT NULL,
  `PRS_SURN` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRS_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `INS_MOD` (
  `MOD_CODE` char(8) NOT NULL,
  `MOD_NAME` varchar(100) DEFAULT NULL,
  `PRS_CODE` char(8) DEFAULT NULL,
  PRIMARY KEY (`MOD_CODE`),
  KEY `PRS_CODE` (`PRS_CODE`),
  CONSTRAINT `INS_MOD_ibfk_1` FOREIGN KEY (`PRS_CODE`) REFERENCES `INS_PRS` (`PRS_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `INS_SPR` (
  `SPR_CODE` char(8) NOT NULL,
  `SPR_FNM1` varchar(100) DEFAULT NULL,
  `SPR_SURN` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SPR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `CAM_SMO` (
  `SPR_CODE` char(8) NOT NULL,
  `MOD_CODE` char(8) NOT NULL,
  `AYR_CODE` char(7) NOT NULL,
  `PSL_CODE` char(3) NOT NULL,
  PRIMARY KEY (`SPR_CODE`,`MOD_CODE`,`AYR_CODE`,`PSL_CODE`),
  KEY `MOD_CODE` (`MOD_CODE`),
  CONSTRAINT `CAM_SMO_ibfk_1` FOREIGN KEY (`MOD_CODE`) REFERENCES `INS_MOD` (`MOD_CODE`),
  CONSTRAINT `CAM_SMO_ibfk_2` FOREIGN KEY (`SPR_CODE`) REFERENCES `INS_SPR` (`SPR_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `INS_RES` (
  `SPR_CODE` char(8) NOT NULL,
  `MOD_CODE` char(8) NOT NULL,
  `AYR_CODE` char(7) NOT NULL,
  `PSL_CODE` char(3) NOT NULL,
  `QUE_CODE` varchar(8) NOT NULL,
  `RES_VALU` int(11) DEFAULT NULL,
  PRIMARY KEY (`SPR_CODE`,`MOD_CODE`,`AYR_CODE`,`PSL_CODE`,`QUE_CODE`),
  CONSTRAINT `INS_RES_ibfk_1` FOREIGN KEY (`SPR_CODE`,`MOD_CODE`,`AYR_CODE`,`PSL_CODE`) REFERENCES `CAM_SMO` (`SPR_CODE`,`MOD_CODE`,`AYR_CODE`,`PSL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `INS_QUE` (
  `QUE_CODE` varchar(8) NOT NULL,
  `CAT_CODE` varchar(8) DEFAULT NULL,
  `QUE_NAME` varchar(100) DEFAULT NULL,
  `QUE_TEXT` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`QUE_CODE`),
  KEY `CAT_CODE` (`CAT_CODE`),
  CONSTRAINT `INS_QUE_ibfk_1` FOREIGN KEY (`CAT_CODE`) REFERENCES `INS_CAT` (`CAT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 2. Help desk
CREATE TABLE IF NOT EXISTS `Shift_type` (
  `Shift_type` varchar(7) NOT NULL,
  `Start_time` varchar(5) DEFAULT NULL,
  `End_time` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Shift_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Level` (
  `Level_code` int(11) NOT NULL,
  `Manager` char(1) DEFAULT NULL,
  `Operator` char(1) DEFAULT NULL,
  `Engineer` char(1) DEFAULT NULL,
  PRIMARY KEY (`Level_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Caller` (
  `Caller_id` int(11) NOT NULL AUTO_INCREMENT,
  `Company_ref` int(11) DEFAULT NULL,
  `First_name` varchar(50) DEFAULT NULL,
  `Last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Caller_id`),
  KEY `Company_ref` (`Company_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Customer` ( 
  `Company_ref` int(11) NOT NULL,
  `Company_name` varchar(50) DEFAULT NULL,
  `Contact_id` int(11) DEFAULT NULL,
  `Address_1` varchar(50) DEFAULT NULL,
  `Address_2` varchar(50) DEFAULT NULL,
  `Town` varchar(50) DEFAULT NULL,
  `Postcode` varchar(50) DEFAULT NULL,
  `Telephone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Company_ref`),
  KEY `Cust_FK` (`Contact_id`),
  CONSTRAINT `Cust_FK` FOREIGN KEY (`Contact_id`) REFERENCES `Caller` (`Caller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `Caller`
  ADD CONSTRAINT `Caller_ibfk_1` FOREIGN KEY (`Company_ref`) REFERENCES `Customer` (`Company_ref`);
CREATE TABLE IF NOT EXISTS `Staff` (
  `Staff_code` varchar(6) NOT NULL,
  `First_name` varchar(50) DEFAULT NULL,
  `Last_name` varchar(50) DEFAULT NULL,
  `Level_code` int(11) NOT NULL,
  PRIMARY KEY (`Staff_code`),
  KEY `Level_code` (`Level_code`),
  CONSTRAINT `Staff_ibfk_1` FOREIGN KEY (`Level_code`) REFERENCES `Level` (`Level_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Shift` (
  `Shift_date` date NOT NULL,
  `Shift_type` varchar(7) NOT NULL,
  `Manager` varchar(7) NOT NULL,
  `Operator` varchar(7) NOT NULL,
  `Engineer1` varchar(7) NOT NULL,
  `Engineer2` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`Shift_date`,`Shift_type`),
  KEY `Manager` (`Manager`),
  KEY `Operator` (`Operator`),
  KEY `Engineer1` (`Engineer1`),
  KEY `Engineer2` (`Engineer2`),
  KEY `Shift_type` (`Shift_type`),
  CONSTRAINT `Shift_ibfk_1` FOREIGN KEY (`Manager`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Shift_ibfk_2` FOREIGN KEY (`Operator`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Shift_ibfk_3` FOREIGN KEY (`Engineer1`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Shift_ibfk_4` FOREIGN KEY (`Engineer2`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Shift_ibfk_5` FOREIGN KEY (`Shift_type`) REFERENCES `Shift_type` (`Shift_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Issue` (
  `Call_date` datetime NOT NULL,
  `Call_ref` int(11) NOT NULL,
  `Caller_id` int(11) NOT NULL,
  `Detail` varchar(255) DEFAULT NULL,
  `Taken_by` varchar(6) NOT NULL,
  `Assigned_to` varchar(6) NOT NULL,
  `Status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Call_ref`),
  KEY `Taken_by` (`Taken_by`),
  KEY `Assigned_to` (`Assigned_to`),
  KEY `Caller_id` (`Caller_id`),
  CONSTRAINT `Issue_ibfk_1` FOREIGN KEY (`Taken_by`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Issue_ibfk_2` FOREIGN KEY (`Assigned_to`) REFERENCES `Staff` (`Staff_code`),
  CONSTRAINT `Issue_ibfk_3` FOREIGN KEY (`Caller_id`) REFERENCES `Caller` (`Caller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 3. Guest house
CREATE TABLE IF NOT EXISTS `room_type` (
  `id` varchar(6) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `rate` (
  `room_type` varchar(6) NOT NULL DEFAULT '',
  `occupancy` int(11) NOT NULL DEFAULT 0,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`room_type`,`occupancy`),
  CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `room` (
  `id` int(11) NOT NULL, 
  `room_type` varchar(6) DEFAULT NULL,
  `max_occupancy` int(11) DEFAULT NULL, 
  PRIMARY KEY (`id`), 
  KEY `room_typeIDX` (`room_type`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `extra` (
  `extra_id` int(11) NOT NULL, 
  `booking_id` int(11) DEFAULT NULL, 
  `description` varchar(50) DEFAULT NULL, 
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`extra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `guest` (
  `id` int(11) NOT NULL, 
  `first_name` varchar(50) DEFAULT NULL, 
  `last_name` varchar(50) DEFAULT NULL, 
  `address` varchar(50) DEFAULT NULL, 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(11) NOT NULL, 
  `booking_date` date DEFAULT NULL, 
  `room_no` int(11) DEFAULT NULL,
  `guest_id` int(11) NOT NULL, 
  `occupants` int(11) NOT NULL DEFAULT 1, 
  `room_type_requested` varchar(6) DEFAULT NULL, 
  `nights` int(11) NOT NULL DEFAULT 1, 
  `arrival_time` varchar(5) DEFAULT NULL, 
  PRIMARY KEY (`booking_id`), 
  KEY `room_no_IDX` (`room_no`), 
  KEY `guest_id_IDX` (`guest_id`), 
  KEY `room_type_requested_IDX` (`room_type_requested`,`occupants`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`guest_id`) REFERENCES `guest` (`id`),
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`room_type_requested`) REFERENCES `room_type` (`id`),
  CONSTRAINT `booking_ibfk_4` FOREIGN KEY (`room_type_requested`,`occupants`) REFERENCES `rate` (`room_type`,`occupancy`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 4. Adventure works
CREATE TABLE IF NOT EXISTS `CustomerAW` (
  `CustomerID` int(11) NOT NULL, 
  `NameStyle` varchar(50) NOT NULL DEFAULT '0', 
  `Title` varchar(8) DEFAULT NULL, 
  `FirstName` varchar(50) NOT NULL, 
  `MiddleName` varchar(50) DEFAULT NULL, 
  `LastName` varchar(50) NOT NULL, 
  `Suffix` varchar(10) DEFAULT NULL, 
  `CompanyName` varchar(128) DEFAULT NULL, 
  `SalesPerson` varchar(256) DEFAULT NULL, 
  `EmailAddress` varchar(50) DEFAULT NULL,
  `Phone` varchar(25) DEFAULT NULL, 
  `PasswordHash` varchar(128) NOT NULL, 
  `PasswordSalt` varchar(10) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `CustomerAddress` (
  `CustomerID` int(11) NOT NULL,
  `AddressID` int(11) NOT NULL,
  `AddressType` varchar(50) NOT NULL,
  PRIMARY KEY (`CustomerID`,`AddressType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Address` ( 
  `AddressID` int(11) NOT NULL,
  `AddressLine1` varchar(60) DEFAULT NULL,
  `AddressLine2` varchar(60) DEFAULT NULL,
  `City` varchar(60) DEFAULT NULL,
  `StateProvince` varchar(60) DEFAULT NULL,
  `CountryRegion` varchar(50) DEFAULT NULL,
  `PostalCode` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`AddressID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `SalesOrderHeader` (
  `SalesOrderID` int(11) NOT NULL,
  `RevisionNumber` int(11) NOT NULL DEFAULT 0,
  `OrderDate` date NOT NULL,
  `DueDate` date NOT NULL,
  `ShipDate` date NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 1,
  `OnlineOrderFlag` char(1) NOT NULL DEFAULT '1',
  `SalessOrderNumber` varchar(15) DEFAULT NULL,
  `PurchaseOrderNumber` varchar(15) DEFAULT NULL,
  `AccountNumber` varchar(25) DEFAULT NULL,
  `CustomerID` int(11) NOT NULL,
  `ShipToAddressID` int(11) DEFAULT NULL,
  `BillToAddressID` int(11) DEFAULT NULL,
  `ShipMethod` varchar(50) NOT NULL,
  `CreditCardApprovalCode` varchar(15) DEFAULT NULL,
  `SubTotal` decimal(10,2) NOT NULL,
  `TaxAmt` decimal(10,2) NOT NULL,
  `Freight` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Commnt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SalesOrderID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `ShipToAddressID` (`ShipToAddressID`),
  KEY `BillToAddressID` (`BillToAddressID`),
  CONSTRAINT `SalesOrderHeader_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CustomerAW` (`CustomerID`),
  CONSTRAINT `SalesOrderHeader_ibfk_2` FOREIGN KEY (`ShipToAddressID`) REFERENCES `Address` (`AddressID`),
  CONSTRAINT `SalesOrderHeader_ibfk_3` FOREIGN KEY (`BillToAddressID`) REFERENCES `Address` (`AddressID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ProductCategory` (
  `ProductCategoryID` int(11) NOT NULL,
  `ParentProductCategoryID` int(11) DEFAULT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`ProductCategoryID`),
  KEY `ParentProductCategoryID` (`ParentProductCategoryID`),
  CONSTRAINT `ProductCategory_ibfk_1` FOREIGN KEY (`ParentProductCategoryID`) REFERENCES `ProductCategory` (`ProductCategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `Product` (
  `ProductID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `ProductNumber` varchar(25) NOT NULL,
  `Color` varchar(15) DEFAULT NULL,
  `StandardCost` decimal(10,2) NOT NULL,
  `ListPrice` decimal(10,2) NOT NULL,
  `Sze` varchar(5) DEFAULT NULL,
  `Weight` decimal(8,2) DEFAULT NULL,
  `ProductCategoryID` int(11) DEFAULT NULL,
  `ProductModelID` int(11) DEFAULT NULL,
  `SellStartDate` date NOT NULL,
  `SellEndDate` date DEFAULT NULL,
  `DiscontinuedDate` date DEFAULT NULL,
  `ThumbnailPhotoFileName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `ProductCategoryID` (`ProductCategoryID`),
  CONSTRAINT `Product_ibfk_1` FOREIGN KEY (`ProductCategoryID`) REFERENCES `ProductCategory` (`ProductCategoryID`),
  CONSTRAINT `Product_ibfk_2` FOREIGN KEY (`ProductCategoryID`) REFERENCES `ProductCategory` (`ProductCategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `SalesOrderDetail` (
  `SalesOrderID` int(11) NOT NULL,
  `SalesOrderDetailID` int(11) NOT NULL,
  `OrderQty` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `UnitPriceDiscount` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`SalesOrderDetailID`),
  KEY `ProductID` (`ProductID`),
  KEY `SODSOIIndex` (`SalesOrderID`),
  CONSTRAINT `SalesOrderDetail_ibfk_1` FOREIGN KEY (`SalesOrderID`) REFERENCES `SalesOrderHeader` (`SalesOrderID`),
  CONSTRAINT `SalesOrderDetail_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ProductModel` (
  `ProductModelID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `CatalogDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ProductModelID`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ProductDescription` (
  `ProductDescriptionID` int(11) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`ProductDescriptionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ProductModelProductDescription` (
  `ProductModelID` int(11) NOT NULL,
  `ProductDescriptionID` int(11) NOT NULL,
  `Culture` char(6) NOT NULL,
  PRIMARY KEY (`ProductModelID`,`ProductDescriptionID`),
  KEY `ProductDescriptionID` (`ProductDescriptionID`),
  CONSTRAINT `ProductModelProductDescription_ibfk_1` FOREIGN KEY (`ProductModelID`) REFERENCES `ProductModel` (`ProductModelID`),
  CONSTRAINT `ProductModelProductDescription_ibfk_2` FOREIGN KEY (`ProductDescriptionID`) REFERENCES `ProductDescription` (`ProductDescriptionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 5. Univ timetables
CREATE TABLE IF NOT EXISTS `ut_staff` ( 
  `id` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_student` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sze` int(11) DEFAULT NULL,
  `parent` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `ut_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_room` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `parent` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`parent`) REFERENCES `ut_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_modle` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_event` (
  `id` varchar(20) NOT NULL,
  `modle` varchar(20) DEFAULT NULL,
  `kind` char(1) DEFAULT NULL,
  `dow` varchar(15) DEFAULT NULL,
  `tod` char(5) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `room` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room` (`room`),
  KEY `modle` (`modle`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`room`) REFERENCES `ut_room` (`id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`modle`) REFERENCES `ut_modle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_attends` (
  `student` varchar(20) NOT NULL,
  `event` varchar(20) NOT NULL,
  PRIMARY KEY (`student`,`event`),
  KEY `event` (`event`),
  CONSTRAINT `attends_ibfk_1` FOREIGN KEY (`student`) REFERENCES `ut_student` (`id`),
  CONSTRAINT `attends_ibfk_2` FOREIGN KEY (`event`) REFERENCES `ut_event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_teaches` (
  `staff` varchar(20) NOT NULL,
  `event` varchar(20) NOT NULL,
  PRIMARY KEY (`staff`,`event`),
  KEY `event` (`event`),
  CONSTRAINT `teaches_ibfk_1` FOREIGN KEY (`staff`) REFERENCES `ut_staff` (`id`),
  CONSTRAINT `teaches_ibfk_2` FOREIGN KEY (`event`) REFERENCES `ut_event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_occurs` (
  `event` varchar(20) NOT NULL,
  `week` varchar(20) NOT NULL,
  PRIMARY KEY (`event`,`week`),
  CONSTRAINT `occurs_ibfk_1` FOREIGN KEY (`event`) REFERENCES `ut_event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ut_week` (
  `id` char(2) NOT NULL,
  `wkstart` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 6. Musicians
CREATE TABLE IF NOT EXISTS `band` (
  `band_no` int(11) NOT NULL,
  `band_name` varchar(20) DEFAULT NULL,
  `band_home` int(11) NOT NULL,
  `band_type` varchar(10) DEFAULT NULL,
  `b_date` date DEFAULT NULL,
  `band_contact` int(11) NOT NULL,
  PRIMARY KEY (`band_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `composer` ( 
  `comp_no` int(11) NOT NULL,
  `comp_is` int(11) NOT NULL,
  `comp_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`comp_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `composition` ( 
  `c_no` int(11) NOT NULL,
  `comp_date` date DEFAULT NULL,
  `c_title` varchar(40) NOT NULL,
  `c_in` int(11) DEFAULT NULL,
  PRIMARY KEY (`c_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `concert` ( 
  `concert_no` int(11) NOT NULL,
  `concert_venue` varchar(20) DEFAULT NULL,
  `concert_in` int(11) NOT NULL,
  `con_date` date DEFAULT NULL,
  `concert_orgniser` int(11) DEFAULT NULL,
  PRIMARY KEY (`concert_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `has_composed` (
   `cmpr_no` int(11) NOT NULL,
  `cmpn_no` int(11) NOT NULL,
  PRIMARY KEY (`cmpr_no`,`cmpn_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `musician` ( 
  `m_no` int(11) NOT NULL,
  `m_name` varchar(20) DEFAULT NULL,
  `born` date DEFAULT NULL,
  `died` date DEFAULT NULL,
  `born_in` int(11) DEFAULT NULL,
  `living_in` int(11) DEFAULT NULL,
  PRIMARY KEY (`m_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `performance` ( 
  `pfrmnc_no` int(11) NOT NULL,
  `gave` int(11) DEFAULT NULL,
  `performed` int(11) DEFAULT NULL,
  `conducted_by` int(11) DEFAULT NULL,
  `performed_in` int(11) DEFAULT NULL,
  PRIMARY KEY (`pfrmnc_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `performer` ( 
  `perf_no` int(11) NOT NULL,
  `perf_is` int(11) DEFAULT NULL,
  `instrument` varchar(10) NOT NULL,
  `perf_type` varchar(10) DEFAULT 'not known',
  PRIMARY KEY (`perf_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `place` ( 
  `place_no` int(11) NOT NULL,
  `place_town` varchar(20) DEFAULT NULL,
  `place_country` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`place_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `plays_in` ( 
  `player` int(11) NOT NULL,
  `band_id` int(11) NOT NULL,
  PRIMARY KEY (`player`,`band_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 7. Dressmaker
CREATE TABLE IF NOT EXISTS `material` ( 
  `material_no` int(11) NOT NULL,
  `fabric` char(20) NOT NULL,
  `colour` char(20) NOT NULL,
  `pattern` char(20) NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`material_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `dress_order` ( 
  `order_no` int(11) NOT NULL,
  `cust_no` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `completed` char(1) DEFAULT NULL,
  PRIMARY KEY (`order_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `quantities` ( 
  `style_q` int(11) NOT NULL,
  `size_q` int(11) NOT NULL,
  `quantity` double NOT NULL,
  PRIMARY KEY (`style_q`,`size_q`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `garment` ( 
  `style_no` int(11) NOT NULL,
  `description` char(20) NOT NULL,
  `labour_cost` double NOT NULL,
  `notions` char(50) DEFAULT NULL,
  PRIMARY KEY (`style_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `jmcust` ( 
  `c_no` int(11) NOT NULL,
  `c_name` char(20) NOT NULL,
  `c_house_no` int(11) NOT NULL,
  `c_post_code` char(9) NOT NULL,
  PRIMARY KEY (`c_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `dressmaker` ( 
  `d_no` int(11) NOT NULL,
  `d_name` char(20) NOT NULL,
  `d_house_no` int(11) NOT NULL,
  `d_post_code` char(8) NOT NULL,
  PRIMARY KEY (`d_no`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `construction` ( 
  `maker` int(11) NOT NULL,
  `order_ref` int(11) NOT NULL,
  `line_ref` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `finish_date` date DEFAULT NULL,
  PRIMARY KEY (`maker`,`order_ref`,`line_ref`),
  KEY `order_ref` (`order_ref`,`line_ref`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `order_line` ( 
  `order_ref` int(11) NOT NULL,
  `line_no` int(11) NOT NULL,
  `ol_style` int(11) DEFAULT NULL,
  `ol_size` int(11) NOT NULL,
  `ol_material` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_ref`,`line_no`),
  KEY `ol_style` (`ol_style`,`ol_size`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- 8. Congestion charging
CREATE TABLE IF NOT EXISTS `camera` ( 
  `id` int(11) NOT NULL,
  `perim` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `keeper` ( 
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `address` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `image` (
  `camera` int(11) NOT NULL,
  `whn` datetime NOT NULL,
  `reg` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`camera`,`whn`),
  KEY `reg` (`reg`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `permit` ( 
  `reg` varchar(10) NOT NULL,
  `sDate` datetime NOT NULL,
  `chargeType` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`reg`,`sDate`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `vehicle` ( 
  `id` varchar(10) NOT NULL,
  `keeper` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `keeper` (`keeper`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- white christmas
CREATE TABLE IF NOT EXISTS `hadcet` ( 
  `yr` int(11) NOT NULL DEFAULT 0,
  `dy` int(11) NOT NULL DEFAULT 0,
  `m1` int(11) DEFAULT NULL,
  `m2` int(11) DEFAULT NULL,
  `m3` int(11) DEFAULT NULL,
  `m4` int(11) DEFAULT NULL,
  `m5` int(11) DEFAULT NULL,
  `m6` int(11) DEFAULT NULL,
  `m7` int(11) DEFAULT NULL,
  `m8` int(11) DEFAULT NULL,
  `m9` int(11) DEFAULT NULL,
  `m10` int(11) DEFAULT NULL,
  `m11` int(11) DEFAULT NULL,
  `m12` int(11) DEFAULT NULL,
  PRIMARY KEY (`yr`,`dy`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
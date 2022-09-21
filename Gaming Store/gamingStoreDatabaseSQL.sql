CREATE SCHEMA `gaming_store_database` ;

CREATE TABLE `gaming_store_database`.`gaming_store` (
  `STO_ID` INT NOT NULL AUTO_INCREMENT,
  `STO_Name` VARCHAR(45) NOT NULL,
  `STO_Location` VARCHAR(45) NOT NULL,
  `STO_NumOfEmp` INT NOT NULL,
  `STO_NumOfMan` INT NOT NULL,
  PRIMARY KEY (`STO_ID`));

CREATE TABLE `gaming_store_database`.`inventory` (
  `PROD_ID` INT NOT NULL AUTO_INCREMENT,
  `PROD_Name` VARCHAR(45) NOT NULL,
  `PROD_Quantity` INT NOT NULL,
  `STO_ID` INT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID));

CREATE TABLE `gaming_store_database`.`customers` (
  `CUST_ID` INT NOT NULL AUTO_INCREMENT,
  `CUST_Pass` VARCHAR(45) NOT NULL,
  `CUST_PhoneNum` BIGINT NOT NULL,
  `CUST_CreditCardNum` BIGINT NOT NULL,
  `CUST_Name` VARCHAR(45) NOT NULL,
  `CUST_DOB` DATE NOT NULL,
  `STO_ID` INT NULL,
  `Receipt` INT NULL,
  `Borrow_Price` INT NULL,
  `Start_Date` DATE NULL,
  `End_Date` DATE NULL,
  PRIMARY KEY (`CUST_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID));

CREATE TABLE `gaming_store_database`.`employees` (
  `EMP_ID` INT NOT NULL AUTO_INCREMENT,
  `EMP_Pass` VARCHAR(45) NOT NULL,
  `EMP_Name` VARCHAR(45) NOT NULL,
  `EMP_Salary` INT NOT NULL,
  `EMP_Manager` VARCHAR(45) NULL,
  `STO_ID` INT NULL,
  PRIMARY KEY (`EMP_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID));

CREATE TABLE `gaming_store_database`.`associate` (
  `EMP_ID` INT NOT NULL REFERENCES employees (EMP_ID),
  `NumOfSales` INT NOT NULL,
  PRIMARY KEY (`EMP_ID`));

CREATE TABLE `gaming_store_database`.`manager` (
  `EMP_ID` INT NOT NULL REFERENCES employees (EMP_ID),
  `NumOfAssoMan` INT NOT NULL,
  PRIMARY KEY (`EMP_ID`));

CREATE TABLE `gaming_store_database`.`gaming_company` (
  `C_ID` INT NOT NULL AUTO_INCREMENT,
  `C_Pass` VARCHAR(45) NOT NULL,
  `C_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`C_ID`));

CREATE TABLE `gaming_store_database`.`gaming_studio` (
  `STU_ID` INT NOT NULL AUTO_INCREMENT,
  `STU_Pass` VARCHAR(45) NOT NULL,
  `STU_Name` VARCHAR(45) NOT NULL,
  `STU_NumOfEmp` INT NOT NULL,
  `STU_NumOfGames` INT NOT NULL,
  PRIMARY KEY (`STU_ID`));

CREATE TABLE `gaming_store_database`.`private_gaming_studio` (
  `STU_ID` INT NOT NULL REFERENCES gaming_studio (STU_ID),
  `ExclusiveTitles` VARCHAR(45) NOT NULL,
  `C_ID` INT NOT NULL REFERENCES gaming_company (C_ID),
  PRIMARY KEY (`STU_ID`, `C_ID`));

CREATE TABLE `gaming_store_database`.`product` (
  `P_ID` INT NOT NULL AUTO_INCREMENT,
  `P_Name` VARCHAR(45) NOT NULL,
  `STO_ID` INT NULL,
  `C_ID` INT NULL,
  PRIMARY KEY (`P_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID),
  FOREIGN KEY (C_ID) REFERENCES gaming_company (C_ID));

CREATE TABLE `gaming_store_database`.`console` (
  `P_ID` INT NOT NULL REFERENCES product (P_ID),
  `C_Version` VARCHAR(45) NOT NULL,
  `P_Price` INT NOT NULL,
  PRIMARY KEY (`P_ID`, `C_Version`));

CREATE TABLE `gaming_store_database`.`subscription` (
  `P_ID` INT NOT NULL REFERENCES product (P_ID),
  `Tier` VARCHAR(45) NOT NULL,
  `P_Price` INT NOT NULL,
  PRIMARY KEY (`P_ID`, `Tier`));

CREATE TABLE `gaming_store_database`.`controller` (
  `P_ID` INT NOT NULL REFERENCES product (P_ID),
  `Type` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Features` VARCHAR(45) NOT NULL,
  `P_Price` INT NOT NULL,
  PRIMARY KEY (`P_ID`, `Features`));

CREATE TABLE `gaming_store_database`.`headset` (
  `P_ID` INT NOT NULL REFERENCES product (P_ID),
  `Type` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `SoundQuality` VARCHAR(45) NOT NULL,
  `P_Price` INT NOT NULL,
  PRIMARY KEY (`P_ID`, `SoundQuality`));

CREATE TABLE `gaming_store_database`.`harddrive` (
  `P_ID` INT NOT NULL REFERENCES product (P_ID),
  `Type` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `StorageSpace` VARCHAR(45) NOT NULL,
  `P_Price` INT NOT NULL,
  PRIMARY KEY (`P_ID`, `StorageSpace`));

CREATE TABLE `gaming_store_database`.`games` (
  `G_ID` INT NOT NULL AUTO_INCREMENT,
  `G_Name` VARCHAR(45) NOT NULL,
  `G_Price` INT NOT NULL,
  `G_Version` VARCHAR(45) NOT NULL,
  `STO_ID` INT NULL,
  `STU_ID` INT NULL,
  PRIMARY KEY (`G_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID),
  FOREIGN KEY (STU_ID) REFERENCES gaming_studio (STU_ID));

CREATE TABLE `gaming_store_database`.`order_games` (
  `OG_ID` INT NOT NULL AUTO_INCREMENT,
  `STO_ID` INT NULL,
  `STU_ID` INT NULL,
  PRIMARY KEY (`OG_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID),
  FOREIGN KEY (STU_ID) REFERENCES gaming_studio (STU_ID));

CREATE TABLE `gaming_store_database`.`order_product` (
  `OP_ID` INT NOT NULL AUTO_INCREMENT,
  `STO_ID` INT NULL,
  `C_ID` INT NULL,
  PRIMARY KEY (`OP_ID`),
  FOREIGN KEY (STO_ID) REFERENCES gaming_store (STO_ID),
  FOREIGN KEY (C_ID) REFERENCES gaming_company (C_ID));

USE gaming_store_database;

INSERT INTO `gaming_store_database`.`gaming_store` (`STO_Name`, `STO_Location`, `STO_NumOfEmp`, `STO_NumOfMan`) VALUES ('Games R Us', 'New York City, NY', '5', '1');
INSERT INTO `gaming_store_database`.`gaming_store` (`STO_Name`, `STO_Location`, `STO_NumOfEmp`, `STO_NumOfMan`) VALUES ('Games R Us', 'Los Angeles, CA', '6', '2');
INSERT INTO `gaming_store_database`.`gaming_store` (`STO_Name`, `STO_Location`, `STO_NumOfEmp`, `STO_NumOfMan`) VALUES ('Games R Us', 'Chicago, IL', '7', '3');

INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass1', '5168187208', '6401201390633346', 'Lyric Parrish', '1951-02-13', '1', '25026');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass2', '2127432365', '2886531913043051', 'Susan Day', '1955-01-02', '1', '56339');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass3', '7162585189', '2424028879215394', 'Hudson Price', '1958-07-11', '1', '73687');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Borrow_Price`, `Start_Date`, `End_Date`) VALUES ('CustPass4', '9172248023', '5046696353185236', 'Hassan Zimmerman', '1963-02-25', '1', '50', '2006-05-15', '2006-06-15');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass5', '5623259722', '7512654163330133', 'Cassie Guzman', '1963-11-06', '2', '24414');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass6', '4158132285', '3940648251319128', 'Sidney Bonilla', '1978-09-15', '2', '54128');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass7', '5593995194', '9031032139715893', 'Logan Sherman', '1978-10-23', '2', '86203');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Borrow_Price`, `Start_Date`, `End_Date`) VALUES ('CustPass8', '9096259388', '1878216247352017', 'Addison Jenkins', '1980-02-24', '2', '100', '2008-03-12', '2008-04-12');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass9', '3094821821', '9832838822926616', 'Haven Ayala', '1986-12-01', '3', '63369');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass10', '2175819917', '9594338090451254', 'Jayden Good', '1992-12-16', '3', '44744');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Receipt`) VALUES ('CustPass11', '3128449256', '0298359180091266', 'Payton Delacruz', '1999-05-21', '3', '03920');
INSERT INTO `gaming_store_database`.`customers` (`CUST_Pass`, `CUST_PhoneNum`, `CUST_CreditCardNum`, `CUST_Name`, `CUST_DOB`, `STO_ID`, `Borrow_Price`, `Start_Date`, `End_Date`) VALUES ('CustPass12', '2175163994', '2145749745131129', 'Sierra Aguirre', '2000-12-31', '3', '150', '2010-07-23', '2010-08-23');

INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass1', 'Anaya Hughes', '25000', 'Quincy Gomez', '1');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass2', 'Yareli Leonard', '25000', 'Quincy Gomez', '1');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass3', 'Dale Fitzgerald', '25000', 'Quincy Gomez', '1');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass4', 'Kailey Phillips', '25000', 'Quincy Gomez', '1');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass5', 'Quincy Gomez', '30000', '1');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass6', 'Kara Dunn', '26000', 'Kimberly Ewing', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass7', 'Nancy Singh', '26000', 'Kimberly Ewing', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass8', 'Madalyn Butler', '26000', 'Marlie Dickerson', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass9', 'Jasmin Mccann', '26000', 'Marlie Dickerson', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass10', 'Kimberly Ewing', '31000', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass11', 'Marlie Dickerson', '31000', '2');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass12', 'Tatum Crosby', '27000', 'Aldo Haynes', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass13', 'Harper Huerta', '27000', 'Kadence Montoya', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass14', 'Aniyah Winters', '27000', 'Matias Stone', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `EMP_Manager`, `STO_ID`) VALUES ('EmpPass15', 'Steve Hodge', '27000', 'Matias Stone', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass16', 'Aldo Haynes', '32000', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass17', 'Kadence Montoya', '32000', '3');
INSERT INTO `gaming_store_database`.`employees` (`EMP_Pass`, `EMP_Name`, `EMP_Salary`, `STO_ID`) VALUES ('EmpPass18', 'Matias Stone', '32000', '3');

INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('1', '10');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('2', '11');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('3', '12');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('4', '13');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('6', '20');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('7', '21');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('8', '22');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('9', '23');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('12', '30');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('13', '31');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('14', '32');
INSERT INTO `gaming_store_database`.`associate` (`EMP_ID`, `NumOfSales`) VALUES ('15', '33');

INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('5', '4');
INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('10', '2');
INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('11', '2');
INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('16', '1');
INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('17', '1');
INSERT INTO `gaming_store_database`.`manager` (`EMP_ID`, `NumOfAssoMan`) VALUES ('18', '2');

INSERT INTO `gaming_store_database`.`gaming_company` (`C_Pass`, `C_Name`) VALUES ('CPass1', 'Microsoft');
INSERT INTO `gaming_store_database`.`gaming_company` (`C_Pass`, `C_Name`) VALUES ('CPass2', 'Sony');
INSERT INTO `gaming_store_database`.`gaming_company` (`C_Pass`, `C_Name`) VALUES ('CPass3', 'Nintendo');

INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass1', 'Ubisoft', '18045', '5');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass2', 'Psyonix', '195', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass3', 'CD Projekt RED', '859', '2');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass4', 'Rockstar Games', '2684', '2');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass5', 'FromSoftware Inc', '332', '3');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass6', 'Electronic Arts', '9800', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass7', 'Behaviour Interactive', '912', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass8', 'Activision', '9578', '2');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass9', 'DICE', '714', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass10', 'Santa Monica Studio', '142', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass11', 'Bungie Inc', '2457', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass12', 'Insomniac Games', '457', '2');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass13', 'Game Freak', '297', '1');
INSERT INTO `gaming_store_database`.`gaming_studio` (`STU_Pass`, `STU_Name`, `STU_NumOfEmp`, `STU_NumOfGames`) VALUES ('StuPass14', 'Bethesda Game Studios', '1057', '2');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'Xbox One', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'PS4', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'Xbox Series X', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'PS5', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'Xbox One', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'PS4', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'Xbox Series X', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'PS5', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'Xbox One', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'PS4', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'Xbox Series X', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'PS5', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'Xbox One', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'PS4', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'Xbox Series X', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'PS5', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'Xbox One', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'PS4', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'Xbox Series X', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'PS5', '1', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'Xbox One', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'PS4', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'Xbox Series X', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'PS5', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'Xbox One', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'PS4', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'Xbox Series X', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'PS5', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'Xbox One', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'PS4', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'Xbox Series X', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'PS5', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'Xbox One', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'PS4', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'Xbox Series X', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'PS5', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'Xbox One', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'PS4', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'Xbox Series X', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'PS5', '2', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'Xbox One', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '60', 'PS4', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'Xbox Series X', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Assassin\'s Creed', '70', 'PS5', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'Xbox One', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '60', 'PS4', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'Xbox Series X', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '70', 'PS5', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'Xbox One', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '60', 'PS4', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'Xbox Series X', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Watch Dogs', '70', 'PS5', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'Xbox One', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '60', 'PS4', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'Xbox Series X', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '70', 'PS5', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'Xbox One', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '60', 'PS4', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'Xbox Series X', '3', '1');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('For Honor', '70', 'PS5', '3', '1');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'Xbox One', '1', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'PS4', '1', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'Xbox Series X', '1', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'PS5', '1', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'Xbox One', '2', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'PS4', '2', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'Xbox Series X', '2', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'PS5', '2', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'Xbox One', '3', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '60', 'PS4', '3', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'Xbox Series X', '3', '2');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Rocket League', '70', 'PS5', '3', '2');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'Xbox One', '1', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'PS4', '1', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'Xbox Series X', '1', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'PS5', '1', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'Xbox One', '2', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'PS4', '2', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'Xbox Series X', '2', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'PS5', '2', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'Xbox One', '3', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Witcher 3: Wild Hunt', '60', 'PS4', '3', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'Xbox Series X', '3', '3');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Cyberpunk 2077', '70', 'PS5', '3', '3');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'Xbox One', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'PS4', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'Xbox Series X', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'PS5', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'Xbox One', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'PS4', '1', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'Xbox One', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'PS4', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'Xbox Series X', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'PS5', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'Xbox One', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'PS4', '2', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'Xbox One', '3', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '60', 'PS4', '3', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'Xbox Series X', '3', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Grand Theft Auto V', '70', 'PS5', '3', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'Xbox One', '3', '4');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Red Dead Redemption 2', '60', 'PS4', '3', '4');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'Xbox One', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'PS4', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'Xbox Series X', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'PS5', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'Xbox One', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'PS4', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'Xbox Series X', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'PS5', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Demon\'s Souls', '70', 'PS5', '1', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'Xbox One', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'PS4', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'Xbox Series X', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'PS5', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'Xbox One', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'PS4', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'Xbox Series X', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'PS5', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Demon\'s Souls', '70', 'PS5', '2', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'Xbox One', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '60', 'PS4', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'Xbox Series X', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Elden Ring', '70', 'PS5', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'Xbox One', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '60', 'PS4', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'Xbox Series X', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dark Souls III', '70', 'PS5', '3', '5');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Demon\'s Souls', '70', 'PS5', '3', '5');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'Xbox One', '1', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'PS4', '1', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'Xbox Series X', '1', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'PS5', '1', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'Xbox One', '2', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'PS4', '2', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'Xbox Series X', '2', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'PS5', '2', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'Xbox One', '3', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '60', 'PS4', '3', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'Xbox Series X', '3', '6');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Apex Legends', '70', 'PS5', '3', '6');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'Xbox One', '1', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'PS4', '1', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'Xbox Series X', '1', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'PS5', '1', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'Xbox One', '2', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'PS4', '2', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'Xbox Series X', '2', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'PS5', '2', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'Xbox One', '3', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '60', 'PS4', '3', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'Xbox Series X', '3', '7');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Dead by Daylight', '70', 'PS5', '3', '7');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'Xbox Series X', '1', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'PS5', '1', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'Xbox Series X', '1', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'PS5', '1', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'Xbox Series X', '2', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'PS5', '2', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'Xbox Series X', '2', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'PS5', '2', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'Xbox Series X', '3', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Vanguard', '70', 'PS5', '3', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'Xbox Series X', '3', '8');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Call of Duty: Black Ops Cold War', '70', 'PS5', '3', '8');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'Xbox Series X', '1', '9');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'PS5', '1', '9');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'Xbox Series X', '2', '9');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'PS5', '2', '9');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'Xbox Series X', '3', '9');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Battlefield 2042', '70', 'PS5', '3', '9');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('God of War', '60', 'PS4', '1', '10');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('God of War', '60', 'PS4', '2', '10');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('God of War', '60', 'PS4', '3', '10');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Halo Infinite', '70', 'Xbox Series X', '1', '11');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Halo Infinite', '70', 'Xbox Series X', '2', '11');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Halo Infinite', '70', 'Xbox Series X', '3', '11');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Marvel\'s Spider-Man', '60', 'PS4', '1', '12');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Marvel\'s Spider-Man', '60', 'PS4', '2', '12');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Marvel\'s Spider-Man', '60', 'PS4', '3', '12');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Pokémon Legends: Arceus', '70', 'Nintendo Switch', '1', '13');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Pokémon Legends: Arceus', '70', 'Nintendo Switch', '2', '13');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Pokémon Legends: Arceus', '70', 'Nintendo Switch', '3', '13');

INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'Xbox One', '1', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'PS4', '1', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'Xbox One', '1', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'PS4', '1', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'Xbox One', '2', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'PS4', '2', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'Xbox One', '2', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'PS4', '2', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'Xbox One', '3', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('Fallout 4', '60', 'PS4', '3', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'Xbox One', '3', '14');
INSERT INTO `gaming_store_database`.`games` (`G_Name`, `G_Price`, `G_Version`, `STO_ID`, `STU_ID`) VALUES ('The Elder Scrolls V: Skyrim', '60', 'PS4', '3', '14');

INSERT INTO `gaming_store_database`.`private_gaming_studio` (`STU_ID`, `ExclusiveTitles`, `C_ID`) VALUES ('5', 'Demon\'s Souls', '2');
INSERT INTO `gaming_store_database`.`private_gaming_studio` (`STU_ID`, `ExclusiveTitles`, `C_ID`) VALUES ('10', 'God of War', '2');
INSERT INTO `gaming_store_database`.`private_gaming_studio` (`STU_ID`, `ExclusiveTitles`, `C_ID`) VALUES ('11', 'Halo Infinite', '1');
INSERT INTO `gaming_store_database`.`private_gaming_studio` (`STU_ID`, `ExclusiveTitles`, `C_ID`) VALUES ('12', 'Marvel\'s Spider-Man', '2');
INSERT INTO `gaming_store_database`.`private_gaming_studio` (`STU_ID`, `ExclusiveTitles`, `C_ID`) VALUES ('13', 'Pokémon Legends: Arceus', '3');

INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Consoles', '1', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Subscriptions', '1', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Controllers', '1', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Headsets', '1', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Harddrives', '1', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Consoles', '1', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Subscriptions', '1', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Controllers', '1', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Headsets', '1', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Harddrives', '1', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Consoles', '1', '3');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Subscriptions', '1', '3');

INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Consoles', '2', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Subscriptions', '2', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Controllers', '2', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Headsets', '2', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Harddrives', '2', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Consoles', '2', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Subscriptions', '2', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Controllers', '2', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Headsets', '2', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Harddrives', '2', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Consoles', '2', '3');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Subscriptions', '2', '3');

INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Consoles', '3', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Subscriptions', '3', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Controllers', '3', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Headsets', '3', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Xbox Harddrives', '3', '1');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Consoles', '3', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Subscriptions', '3', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Controllers', '3', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Headsets', '3', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Playstation Harddrives', '3', '2');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Consoles', '3', '3');
INSERT INTO `gaming_store_database`.`product` (`P_Name`, `STO_ID`, `C_ID`) VALUES ('Nintendo Subscriptions', '3', '3');

INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('1', '360', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('1', 'One', '600');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('1', 'Series X', '700');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('6', 'PS3', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('6', 'PS4', '600');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('6', 'PS5', '700');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('11', 'Switch', '700');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('13', '360', '400');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('13', 'One', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('13', 'Series X', '600');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('18', 'PS3', '400');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('18', 'PS4', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('18', 'PS5', '600');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('23', 'Switch', '600');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('25', '360', '300');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('25', 'One', '400');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('25', 'Series X', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('30', 'PS3', '300');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('30', 'PS4', '400');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('30', 'PS5', '500');
INSERT INTO `gaming_store_database`.`console` (`P_ID`, `C_Version`, `P_Price`) VALUES ('35', 'Switch', '500');

INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('2', '6 M', '32');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('2', '12 M', '62');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('7', '6 M', '32');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('7', '12 M', '62');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('12', '1 M', '12');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('14', '6 M', '31');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('14', '12 M', '61');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('19', '6 M', '31');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('19', '12 M', '61');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('24', '1 M', '11');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('26', '6 M', '30');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('26', '12 M', '60');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('31', '6 M', '30');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('31', '12 M', '60');
INSERT INTO `gaming_store_database`.`subscription` (`P_ID`, `Tier`, `P_Price`) VALUES ('36', '1 M', '10');

INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('3', 'Regular', 'Black', 'Base', '80');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('3', 'Elite', 'Grey', 'Paddles', '140');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('8', 'Regular', 'Black', 'Base', '80');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('8', 'Scuf', 'White', 'Paddles', '140');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('15', 'Regular', 'Red', 'Long Joysticks', '70');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('15', 'Elite', 'Blue', 'Paddles', '130');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('20', 'Regular', 'Gold', 'Base', '70');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('20', 'Scuf', 'Green', 'Paddles', '130');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('27', 'Regular', 'Pink', 'Grip', '60');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('27', 'Elite', 'Purple', 'Long Joysticks', '120');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('32', 'Regular', 'Orange', 'Base', '60');
INSERT INTO `gaming_store_database`.`controller` (`P_ID`, `Type`, `Color`, `Features`, `P_Price`) VALUES ('32', 'Scuf', 'Black', 'Paddles', '120');

INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('4', 'Xbox Wireless', 'Green', 'Bass', '120');
INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('9', 'PULSE 3D Wireless', 'White', 'FootSteps', '120');
INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('16', 'Xbox Wireless', 'Red', 'Clean', '110');
INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('21', 'PULSE 3D Wireless', 'Blue', 'FootSteps', '110');
INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('28', 'Xbox Wireless', 'Yellow', 'Clean', '100');
INSERT INTO `gaming_store_database`.`headset` (`P_ID`, `Type`, `Color`, `SoundQuality`, `P_Price`) VALUES ('33', 'PULSE 3D Wireless', 'Grey', 'Bass', '100');

INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('5', 'Base', 'Black', '500 GB', '600');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('5', 'Extra', 'Black', '1 TB', '800');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('10', 'Base', 'White', '500 GB', '600');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('10', 'Extra', 'White', '1 TB', '800');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('17', 'Base', 'Black', '500 GB', '500');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('17', 'Extra', 'Black', '1 TB', '700');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('22', 'Base', 'White', '500 GB', '500');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('22', 'Extra', 'White', '1 TB', '700');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('29', 'Base', 'Black', '500 GB', '400');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('29', 'Extra', 'Black', '1 TB', '600');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('34', 'Base', 'White', '500 GB', '400');
INSERT INTO `gaming_store_database`.`harddrive` (`P_ID`, `Type`, `Color`, `StorageSpace`, `P_Price`) VALUES ('34', 'Extra', 'White', '1 TB', '600');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 360', '2', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox One', '4', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Series X', '45', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS3', '2', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS4', '4', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS5', '43', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch', '33', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 3 M', '10', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 12 M', '10', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 3 M', '20', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 12 M', '20', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch 1 M', '5', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Regular Controller', '13', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Elite Controller', '25', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Regular Controller', '25', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Scuf Controller', '12', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Wireless Headset', '14', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation PULSE 3D Wireless Headset', '21', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Base Harddrive', '31', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Extra Harddrive', '24', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Base Harddrive', '12', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Extra Harddrive', '35', '1');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Assassin\'s Creed', '2', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '4', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Watch Dogs', '45', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '2', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('For Honor', '4', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Rocket League', '43', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Witcher 3: Wild Hunt', '33', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Cyberpunk 2077', '10', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Grand Theft Auto V', '10', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Red Dead Redemption 2', '20', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Elden Ring', '20', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dark Souls III', '5', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Demon\'s Souls', '13', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Apex Legends', '25', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dead by Daylight', '25', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Vanguard', '12', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Black Ops Cold War', '14', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Battlefield 2042', '21', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('God of War', '31', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Halo Infinite', '24', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Marvel\'s Spider-Man', '12', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Pokémon Legends: Arceus', '35', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Fallout 4', '12', '1');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Elder Scrolls V: Skyrim', '35', '1');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 360', '2', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox One', '4', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Series X', '45', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS3', '2', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS4', '4', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS5', '43', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch', '33', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 3 M', '10', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 12 M', '10', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 3 M', '20', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 12 M', '20', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch 1 M', '5', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Regular Controller', '13', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Elite Controller', '25', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Regular Controller', '25', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Scuf Controller', '12', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Wireless Headset', '14', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation PULSE 3D Wireless Headset', '21', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Base Harddrive', '31', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Extra Harddrive', '24', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Base Harddrive', '12', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Extra Harddrive', '35', '2');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Assassin\'s Creed', '2', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '4', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Watch Dogs', '45', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '2', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('For Honor', '4', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Rocket League', '43', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Witcher 3: Wild Hunt', '33', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Cyberpunk 2077', '10', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Grand Theft Auto V', '10', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Red Dead Redemption 2', '20', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Elden Ring', '20', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dark Souls III', '5', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Demon\'s Souls', '13', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Apex Legends', '25', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dead by Daylight', '25', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Vanguard', '12', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Black Ops Cold War', '14', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Battlefield 2042', '21', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('God of War', '31', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Halo Infinite', '24', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Marvel\'s Spider-Man', '12', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Pokémon Legends: Arceus', '35', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Fallout 4', '12', '2');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Elder Scrolls V: Skyrim', '35', '2');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 360', '2', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox One', '4', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Series X', '45', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS3', '2', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS4', '4', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('PS5', '43', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch', '33', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 3 M', '10', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox 12 M', '10', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 3 M', '20', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation 12 M', '20', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Switch 1 M', '5', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Regular Controller', '13', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Elite Controller', '25', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Regular Controller', '25', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Scuf Controller', '12', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Wireless Headset', '14', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation PULSE 3D Wireless Headset', '21', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Base Harddrive', '31', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Xbox Extra Harddrive', '24', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Base Harddrive', '12', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Playstation Extra Harddrive', '35', '3');

INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Assassin\'s Creed', '2', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Rainbow Six Siege', '4', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Watch Dogs', '45', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Tom Clancy\'s Ghost Recon', '2', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('For Honor', '4', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Rocket League', '43', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Witcher 3: Wild Hunt', '33', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Cyberpunk 2077', '10', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Grand Theft Auto V', '10', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Red Dead Redemption 2', '20', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Elden Ring', '20', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dark Souls III', '5', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Demon\'s Souls', '13', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Apex Legends', '25', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Dead by Daylight', '25', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Vanguard', '12', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Call of Duty: Black Ops Cold War', '14', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Battlefield 2042', '21', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('God of War', '31', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Halo Infinite', '24', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Marvel\'s Spider-Man', '12', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Pokémon Legends: Arceus', '35', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('Fallout 4', '12', '3');
INSERT INTO `gaming_store_database`.`inventory` (`PROD_Name`, `PROD_Quantity`, `STO_ID`) VALUES ('The Elder Scrolls V: Skyrim', '35', '3');

INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('1', '1');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('1', '2');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('1', '3');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('2', '1');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('2', '2');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('2', '3');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('3', '1');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('3', '2');
INSERT INTO `gaming_store_database`.`order_product` (`STO_ID`, `C_ID`) VALUES ('3', '3');

INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '1');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '2');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '3');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '4');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '5');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '6');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '7');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '8');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '9');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '10');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '11');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '12');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '13');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('1', '14');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '1');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '2');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '3');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '4');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '5');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '6');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '7');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '8');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '9');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '10');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '11');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '12');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '13');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('2', '14');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '1');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '2');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '3');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '4');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '5');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '6');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '7');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '8');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '9');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '10');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '11');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '12');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '13');
INSERT INTO `gaming_store_database`.`order_games` (`STO_ID`, `STU_ID`) VALUES ('3', '14');

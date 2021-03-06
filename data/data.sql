/*
CREATE TABLE `AGENCY` (
	`id`	INTEGER,
	`Name`	TEXT NOT NULL,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE `COMPANY` (
	`id`	INTEGER,
	`UnderwritingAgencyName`	TEXT NOT NULL,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE "POLICY" (
	`number`	INTEGER,
	`StartDate`	TEXT NOT NULL,
	`EndDate`	TEXT NOT NULL,
	`AgencyID`	INTEGER NOT NULL,
	`CompanyID`	INTEGER NOT NULL,
	`CancelDate`	TEXT,
	PRIMARY KEY(`number`),
	FOREIGN KEY(`AgencyID`) REFERENCES `AGENCY`,
	FOREIGN KEY(`CompanyID`) REFERENCES `COMPANY`
);
CREATE TABLE `VEHICLE` (
	`id`	INTEGER,
	`Make`	TEXT NOT NULL,
	`Model`	TEXT NOT NULL,
	`AvgPrice`	INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE `CLAIM` (
	`id`	INTEGER,
	`PolicyID`	INTEGER NOT NULL,
	`DriverID`	INTEGER NOT NULL,
	`VehicleID`	INTEGER NOT NULL,
	`Amount`	INTEGER NOT NULL,
	`Description`	TEXT NOT NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`PolicyID`) REFERENCES POLICY,
	FOREIGN KEY(`DriverID`) REFERENCES DRIVER,
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE `LOCATION` (
	`ZipCode`	INTEGER NOT NULL,
	`id`	INTEGER,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	`County`	TEXT NOT NULL,
	`Population`	INTEGER NOT NULL,
	`Percent0to15`	REAL NOT NULL,
	`Percent15to25`	REAL NOT NULL,
	`Percent25to40`	REAL NOT NULL,
	`Percent50`	REAL NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE "DRIVER" (
	`id`	INTEGER,
	`Fname`	TEXT NOT NULL,
	`Lname`	TEXT NOT NULL,
	`Violations`	INTEGER NOT NULL,
	`Accidents`	INTEGER NOT NULL,
	`MaritalStatus`	TEXT NOT NULL,
	`Gender`	TEXT NOT NULL,
	`MilesToWork`	INTEGER,
	`PrimaryVehicleUsage`	TEXT NOT NULL,
	`DateOfBirth`	TEXT,
	`VehicleID`	INTEGER,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE `DRIVERVEH` (
	`DriverID`	INTEGER,
	`VehicleID`	INTEGER,
	`VehicleModelYear`	INTEGER,
	PRIMARY KEY(`DriverID`,`VehicleID`),
	FOREIGN KEY(`DriverID`) REFERENCES DRIVER,
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE "RISK" (
	`id`	INTEGER,
	`PolicyID`	INTEGER NOT NULL,
	`DriverID`	INTEGER NOT NULL,
	`VehicleID`	INTEGER NOT NULL,
	`LocationID`	INTEGER,
	`Premium`	INTEGER,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`PolicyID`) REFERENCES `POLICY`,
	FOREIGN KEY(`DriverID`) REFERENCES `DRIVER`,
	FOREIGN KEY(`VehicleID`) REFERENCES `VEHICLE`,
	FOREIGN KEY(`LocationID`) REFERENCES `LOCATION`
);


CREATE TABLE `AGENCY` (
	`id`	INTEGER,
	`Name`	TEXT NOT NULL,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE `COMPANY` (
	`id`	INTEGER,
	`UnderwritingAgencyName`	TEXT NOT NULL,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE "POLICY" (
	`number`	INTEGER,
	`StartDate`	TEXT NOT NULL,
	`EndDate`	TEXT NOT NULL,
	`AgencyID`	INTEGER NOT NULL,
	`CompanyID`	INTEGER NOT NULL,
	`CancelDate`	TEXT,
	PRIMARY KEY(`number`),
	FOREIGN KEY(`AgencyID`) REFERENCES `AGENCY`,
	FOREIGN KEY(`CompanyID`) REFERENCES `COMPANY`
);
CREATE TABLE `VEHICLE` (
	`id`	INTEGER,
	`Make`	TEXT NOT NULL,
	`Model`	TEXT NOT NULL,
	`AvgPrice`	INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE `CLAIM` (
	`id`	INTEGER,
	`PolicyID`	INTEGER NOT NULL,
	`DriverID`	INTEGER NOT NULL,
	`VehicleID`	INTEGER NOT NULL,
	`Amount`	INTEGER NOT NULL,
	`Description`	TEXT NOT NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`PolicyID`) REFERENCES POLICY,
	FOREIGN KEY(`DriverID`) REFERENCES DRIVER,
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE `LOCATION` (
	`ZipCode`	INTEGER NOT NULL,
	`id`	INTEGER,
	`City`	TEXT NOT NULL,
	`State`	TEXT NOT NULL,
	`County`	TEXT NOT NULL,
	`Population`	INTEGER NOT NULL,
	`Percent0to15`	REAL NOT NULL,
	`Percent15to25`	REAL NOT NULL,
	`Percent25to40`	REAL NOT NULL,
	`Percent50`	REAL NOT NULL,
	PRIMARY KEY(`id`)
);
CREATE TABLE "DRIVER" (
	`id`	INTEGER,
	`Fname`	TEXT NOT NULL,
	`Lname`	TEXT NOT NULL,
	`Violations`	INTEGER NOT NULL,
	`Accidents`	INTEGER NOT NULL,
	`MaritalStatus`	TEXT NOT NULL,
	`Gender`	TEXT NOT NULL,
	`MilesToWork`	INTEGER,
	`PrimaryVehicleUsage`	TEXT NOT NULL,
	`DateOfBirth`	TEXT,
	`VehicleID`	INTEGER,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE `DRIVERVEH` (
	`DriverID`	INTEGER,
	`VehicleID`	INTEGER,
	`VehicleModelYear`	INTEGER,
	PRIMARY KEY(`DriverID`,`VehicleID`),
	FOREIGN KEY(`DriverID`) REFERENCES DRIVER,
	FOREIGN KEY(`VehicleID`) REFERENCES VEHICLE
);
CREATE TABLE "RISK" (
	`id`	INTEGER,
	`PolicyID`	INTEGER NOT NULL,
	`DriverID`	INTEGER NOT NULL,
	`VehicleID`	INTEGER NOT NULL,
	`LocationID`	INTEGER,
	`Premium`	INTEGER,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`PolicyID`) REFERENCES `POLICY`,
	FOREIGN KEY(`DriverID`) REFERENCES `DRIVER`,
	FOREIGN KEY(`VehicleID`) REFERENCES `VEHICLE`,
	FOREIGN KEY(`LocationID`) REFERENCES `LOCATION`
);
*/

/*
SELECT result
FROM table1
LEFT [OUTER] JOIN table2
ON table1.keyfield1 = table2.keyfield2
[WHERE expr]
*/

/*CHANGE*/
drop table claim_risk;
create table claim_risk as select RISK.id as RiskID, RISK.*,sum(CLAIM.Amount) as ClaimsAmount,count(CLAIM.DriverID) as ClaimsCount From RISK LEFT JOIN  CLAIM on CLAIM.DriverID=RISK.DriverID group by RISK.DriverID;
select RISK.*,sum(CLAIM.Amount) as ClaimsAmount,count(CLAIM.DriverID) as ClaimsCount From RISK LEFT JOIN  CLAIM on CLAIM.DriverID=RISK.DriverID group by RISK.DriverID order by  ClaimsCount Desc limit 5;
select ClaimsCount, count(*) from (select RISK.*,sum(CLAIM.Amount) as ClaimsAmount,count(CLAIM.DriverID) as ClaimsCount From RISK LEFT JOIN  CLAIM on CLAIM.DriverID=RISK.DriverID group by RISK.DriverID) group by ClaimsCount;

drop table driver_claim_risk;
create table driver_claim_risk as select claim_risk.*, DRIVER.id as DriverID, DRIVER.* from claim_risk LEFT JOIN  DRIVER on claim_risk.DriverID=Driver.id;
select count(*) from driver_claim_risk;

/*ADD*/
drop table driver_claim_risk_driverveh;
create table driver_claim_risk_driverveh as select driver_claim_risk.*,driverveh.VehicleModelYear as VehicleModelYear from driver_claim_risk LEFT JOIN DRIVERVEH on driver_claim_risk.DriverID=DRIVERVEH.DriverID;

/*CHANGE*/  
drop table location_driver_claim_risk;
create table location_driver_claim_risk as select driver_claim_risk_driverveh.*,LOCATION.id as LocationID, LOCATION.* from driver_claim_risk_driverveh LEFT JOIN LOCATION on LocationID=LOCATION.id;

drop table vehicle_location_driver_claim_risk;
create table vehicle_location_driver_claim_risk as select location_driver_claim_risk.*, VEHICLE.id as VehicleID, VEHICLE.* from location_driver_claim_risk LEFT JOIN VEHICLE on VehicleID=VEHICLE.id;
select count(*) from vehicle_location_driver_claim_risk;

/*CHANGE*/
drop table policy_company;
create table policy_company as select POLICY.number as id, POLICY.*,count(Policy.number) as numberDriversOnPolicy, COMPANY.id as CompanyID , COMPANY.*  from POLICY LEFT JOIN COMPANY on CompanyID=COMPANY.id group by Policy.number; 

drop table policy_company_agency;
create table policy_company_agency as select policy_company.*, AGENCY.id as AgencyID,  AGENCY.* from policy_company LEFT JOIN AGENCY on policy_company.AgencyID= AGENCY.id; 
select count(*) from policy_company_agency;

drop table All_DATA;
create table All_DATA as select vehicle_location_driver_claim_risk.*, policy_company_agency.* from vehicle_location_driver_claim_risk LEFT JOIN policy_company_agency on vehicle_location_driver_claim_risk.PolicyID=policy_company_agency.number;
select count(*) from All_DATA;

 
.headers on
.mode csv
.output all_data.txt

select RiskID,PolicyID,DriverID,VehicleID,LocationID,CompanyID,AgencyID,Premium,ClaimsAmount,ClaimsCount,Fname,Lname,Violations,Accidents,MaritalStatus,Gender,MilesToWork ,  PrimaryVehicleUsage , DateOfBirth ,  ZipCode ,  City ,  State ,  County,Population ,  Percent0to15,  Percent15to25 ,  Percent25to40 ,  Percent50 ,Make ,  Model ,  AvgPrice, VehicleModelYear,StartDate ,  EndDate ,    CancelDate , numberDriversOnPolicy,UnderwritingAgencyName ,  "City:1" ,  "State:1",  Name from ALL_DATA;


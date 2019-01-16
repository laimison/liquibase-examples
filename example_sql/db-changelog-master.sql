Starting Liquibase at Wed, 16 Jan 2019 11:46:36 GMT (version 3.6.2 built at 2018-07-03 11:28:09)
--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: db-changelog-master.xml
--  Ran at: 16/01/19 11:46
--  Against: root@localhost@jdbc:mysql://localhost:3306/mydbname2
--  Liquibase version: 3.6.2
--  *********************************************************************

--  Create Database Lock Table
CREATE TABLE mydbname2.DATABASECHANGELOGLOCK (ID INT NOT NULL, `LOCKED` BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

--  Initialize Database Lock Table
DELETE FROM mydbname2.DATABASECHANGELOGLOCK;

INSERT INTO mydbname2.DATABASECHANGELOGLOCK (ID, `LOCKED`) VALUES (1, 0);

--  Lock Database
UPDATE mydbname2.DATABASECHANGELOGLOCK SET `LOCKED` = 1, LOCKEDBY = '192.168.99.1 (192.168.99.1)', LOCKGRANTED = '2019-01-16 11:46:36.809' WHERE ID = 1 AND `LOCKED` = 0;

--  Create Database Change Log Table
CREATE TABLE mydbname2.DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, `DESCRIPTION` VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

--  Release Database Lock
UPDATE mydbname2.DATABASECHANGELOGLOCK SET `LOCKED` = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;


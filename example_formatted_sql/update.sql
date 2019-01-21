Starting Liquibase at Mon, 21 Jan 2019 09:30:11 GMT (version 3.6.2 built at 2018-07-03 11:28:09)
--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: databaseChangeLog.sql
--  Ran at: 21/01/19 09:30
--  Against: root@localhost@jdbc:mysql://localhost:3306/example_formatted_sql
--  Liquibase version: 3.6.2
--  *********************************************************************

--  Lock Database
UPDATE example_formatted_sql.DATABASECHANGELOGLOCK SET `LOCKED` = 1, LOCKEDBY = '192.168.99.1 (192.168.99.1)', LOCKGRANTED = '2019-01-21 09:30:12.162' WHERE ID = 1 AND `LOCKED` = 0;

--  Changeset databaseChangeLog.sql::1::author1
create table liquibase (
id int primary key,
name varchar(255)
);

INSERT INTO example_formatted_sql.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'author1', 'databaseChangeLog.sql', NOW(), 1, '8:4f034d9d8939bf719600b9ed99e6ea1a', 'sql', '', 'EXECUTED', NULL, NULL, '3.6.2', '8063012216');

--  Changeset databaseChangeLog.sql::2::author1
create table liquibase2 (
id int primary key,
name varchar(255)
);

INSERT INTO example_formatted_sql.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, `DESCRIPTION`, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('2', 'author1', 'databaseChangeLog.sql', NOW(), 2, '8:6815fc11f64c03396ab577c35952cad2', 'sql', '', 'EXECUTED', NULL, NULL, '3.6.2', '8063012216');

--  Release Database Lock
UPDATE example_formatted_sql.DATABASECHANGELOGLOCK SET `LOCKED` = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;


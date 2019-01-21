Starting Liquibase at Mon, 21 Jan 2019 09:31:07 GMT (version 3.6.2 built at 2018-07-03 11:28:09)
Rolling Back Changeset:databaseChangeLog.sql::2::author1
Rolling Back Changeset:databaseChangeLog.sql::1::author1
--  *********************************************************************
--  SQL to roll back currently unexecuted changes
--  *********************************************************************
--  Change Log: databaseChangeLog.sql
--  Ran at: 21/01/19 09:31
--  Against: root@localhost@jdbc:mysql://localhost:3306/example_formatted_sql
--  Liquibase version: 3.6.2
--  *********************************************************************

--  Lock Database
UPDATE example_formatted_sql.DATABASECHANGELOGLOCK SET `LOCKED` = 1, LOCKEDBY = '192.168.99.1 (192.168.99.1)', LOCKGRANTED = '2019-01-21 09:31:07.887' WHERE ID = 1 AND `LOCKED` = 0;

--  Rolling Back ChangeSet: databaseChangeLog.sql::2::author1
drop table liquibase2;

DELETE FROM example_formatted_sql.DATABASECHANGELOG WHERE ID = '2' AND AUTHOR = 'author1' AND FILENAME = 'databaseChangeLog.sql';

--  Rolling Back ChangeSet: databaseChangeLog.sql::1::author1
drop table liquibase;

DELETE FROM example_formatted_sql.DATABASECHANGELOG WHERE ID = '1' AND AUTHOR = 'author1' AND FILENAME = 'databaseChangeLog.sql';

--  Release Database Lock
UPDATE example_formatted_sql.DATABASECHANGELOGLOCK SET `LOCKED` = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;


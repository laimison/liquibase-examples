#!/bin/bash
#
# This script simulates the step how to use liquibase when using
# Just one SQL file and formatted SQL header
#

properties="liquibase.properties"
DB_NAME=`grep 'url:' $properties | sed -e 's/^.*\:[0-9][0-9]*//g' | awk -F '/' '{print $2}'`

case $1 in
  # CLEAN UP
  cleanup)
  echo "Press enter before any action"
  echo "Remove DB $DB_NAME , databaseChangeLog.sql, update.sql, rollback.sql and main Liquibase XML (ignore if they are not found)" && read
  mysql -u root -pmyexample -e "show databases; drop database $DB_NAME; show databases;"
  mv databaseChangeLog.sql /tmp/
  mv update.sql /tmp/
  mv rollback.sql /tmp/
  mv db-changelog-master.xml /tmp/
  ;;

  # RUN EVERYTHING
  run)
  echo "Press enter before any action"
  echo "Create DB $DB_NAME . Did you do the clean up before this?" && read
  mysql -u root -pmyexample -e "create database $DB_NAME; show databases;"

  echo "Create a table so it's created before starting to use Liquibase" && read
  mysql -u root -pmyexample -e "use $DB_NAME; create table no_liquibase (id INT NOT NULL PRIMARY KEY, name VARCHAR(50)); show tables;"

  echo "Create main databaseChangeLog.sql with 'formatted sql' header" && read
  echo "--liquibase formatted sql" > databaseChangeLog.sql

  echo "Run Liquibase update" && read
  liquibase --defaultsFile=$properties --changeLogFile="databaseChangeLog.sql" update

  echo "Define two new tables in Liquibase" && read
  echo "--changeset author1:1
create table liquibase (
id int primary key,
name varchar(255)
);
--rollback drop table liquibase;

--changeset author1:2
create table liquibase2 (
id int primary key,
name varchar(255)
);
--rollback drop table liquibase2;" >> databaseChangeLog.sql

  echo "Apply changes through Liquibase" && read
  liquibase --defaultsFile=$properties --changeLogFile="databaseChangeLog.sql" update

  echo "List current tables"
  mysql -u root -pmyexample -e "show databases; use $DB_NAME; show tables;"

  echo "Rollback to previous changeset" && read
  liquibase --defaultsFile=$properties --changeLogFile="databaseChangeLog.sql" rollbackCount 1

  echo "List current tables"
  mysql -u root -pmyexample -e "show databases; use $DB_NAME; show tables;"

  echo "Rollback to previous changeset" && read
  liquibase --defaultsFile=$properties --changeLogFile="databaseChangeLog.sql" rollbackCount 1

  echo "List current tables"
  mysql -u root -pmyexample -e "show databases; use $DB_NAME; show tables;"

  echo "Create update.sql which can be used later - usually this file needed when there is no access to DB (production, 3rd party, etc.)" && read
  liquibase --defaultsFile="liquibase.properties" --changeLogFile="databaseChangeLog.sql" updateSQL > update.sql
  less update.sql

  echo "Create rollback.sql which can be used later - usually this file needed when there is no access to DB (production, 3rd party, etc.)" && read
  liquibase --defaultsFile="liquibase.properties" --changeLogFile="databaseChangeLog.sql" futureRollbackSQL > rollback.sql
  less rollback.sql

  echo "It's done. Ideally, you can do 'cleanup'"
  ;;

  *)
  echo "Use 'cleanup' or 'run'"
  ;;
esac

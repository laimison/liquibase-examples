#!/bin/bash
#
# This script simulates the steps how to use liquibase
# Method is just one SQL file and formatted SQL header
#
# The reference
# https://www.youtube.com/watch?v=gwDmXh-PMME
#

properties="liquibase.properties"
DB_NAME=`grep 'url:' $properties | sed -e 's/^.*\:[0-9][0-9]*//g' | awk -F '/' '{print $2}'`

case $1 in
  cleanup)
  # CLEAN UP
  echo "Press enter before any action"
  echo "Remove DB $DB_NAME , databaseChangeLog.sql, update.sql, rollback.sql and main Liquibase XML (ignore if they are not found)" && read
  mysql -u root -pmyexample -e "show databases; drop database $DB_NAME; show databases;"
  # mv databaseChangeLog.sql /tmp/
  mv update.sql /tmp/
  mv rollback.sql /tmp/
  mv db-changelog-master.xml /tmp/
  ;;

  run)
  # RUN EVERYTHING
  echo "Press enter before any action"
  echo "Create DB $DB_NAME . Did you do the clean up before this?" && read
  mysql -u root -pmyexample -e "create database $DB_NAME; show databases;"

  echo "Create a table so it's created before starting to use Liquibase" && read
  mysql -u root -pmyexample -e "use $DB_NAME; create table no_liquibase (id INT NOT NULL PRIMARY KEY, name VARCHAR(50)); show tables;"

  echo "Apply changes from databaseChangeLog.sql" && read
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

  echo
  echo "It's done. Ideally, you can do 'cleanup'"
  ;;

  *)
  echo "Use 'cleanup' or 'run'"
  ;;
esac

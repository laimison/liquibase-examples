#!/bin/bash
#
# This script simulates the steps how to use liquibase
# Method is using XML only
#
# The reference
# http://shengwangi.blogspot.com/2016/04/liquibase-helloworld-example.html
#

properties="liquibase.properties"
DB_NAME=`grep 'url:' $properties | sed -e 's/^.*\:[0-9][0-9]*//g' | awk -F '/' '{print $2}'`

case $1 in
  cleanup)
  # CLEAN UP
  echo "Press enter before any action"
  echo "Remove DB $DB_NAME and remove unecessary xml file (ignore if they are not found)" && read
  mysql -u root -pmyexample -e "show databases; drop database $DB_NAME; show databases;"
  mv db-changelog-master-from-zero.xml /tmp/
  ;;

  run)
  # RUN EVERYTHING
  echo "Press enter before any action"
  echo "Create DB $DB_NAME . Did you do the clean up before this?" && read
  mysql -u root -pmyexample -e "create database $DB_NAME; show databases;"

  echo "Create a table so it's created before starting to use Liquibase" && read
  mysql -u root -pmyexample -e "use $DB_NAME; create table no_liquibase (id INT NOT NULL PRIMARY KEY, name VARCHAR(50)); show tables;"

  echo "Apply all changes through Liquibase using master XML" && read
  liquibase --defaultsFile=$properties --changeLogFile="db-changelog-master.xml" update

  echo "List current tables"
  mysql -u root -pmyexample -e "use $DB_NAME; show tables; describe DATABASECHANGELOG; describe DATABASECHANGELOGLOCK; describe department; describe employee;"

  echo "Rollback to previous changeset" && read
  liquibase --defaultsFile=$properties --changeLogFile="db-changelog-master.xml" rollback 1.0

  echo "List current tables"
  mysql -u root -pmyexample -e "use $DB_NAME; show tables; describe DATABASECHANGELOG; describe DATABASECHANGELOGLOCK; describe department; describe employee;"

  echo "Rollback to specific changeset 1.1" && read
  liquibase --defaultsFile=$properties --changeLogFile="db-changelog-master.xml" updateToTag 1.1

  echo "List current tables"
  mysql -u root -pmyexample -e "use $DB_NAME; show tables; describe DATABASECHANGELOG; describe DATABASECHANGELOGLOCK; describe department; describe employee;"

  echo "Generate ChangeLog from existent tables" && read
  liquibase --defaultsFile=$properties --changeLogFile="db-changelog-master-from-zero.xml" generateChangeLog

  echo "generateChangeLog is useful if you already have everything configured in database by hand or sql.
You can use liqubase to generate change log file for you, then you can keep working based on the generated xml."

  echo
  echo "It's done. Ideally, you can do 'cleanup'"
  ;;

  *)
  echo "Use 'cleanup' or 'run'"
  ;;
esac

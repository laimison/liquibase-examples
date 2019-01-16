#!/bin/bash

liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" updateSQL > db-changelog-master.sql
cat db-changelog-master.sql

#!/bin/bash

liquibase --defaultsFile="liquibase.properties" --changeLogFile="/tmp/db-changelog-master-new.xml" generateChangeLog

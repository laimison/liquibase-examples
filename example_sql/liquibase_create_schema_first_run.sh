#!/bin/bash

mv db-changelog-master.xml /tmp/
liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" generateChangeLog

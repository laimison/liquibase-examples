#!/bin/bash
# 1

# Remove main Liquibase XML
mv db-changelog-master.xml /tmp/

# Create main Liquibase XML
liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" generateChangeLog

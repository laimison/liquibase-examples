#!/bin/bash
# 2

# Usually this is used when there is no access to production DB or for 3rd party DB
#
# Obviously, this file doesn't have changelog or rollback data if you run this on a fresh DB which was not liquibase controlled
# If you have already applied any changes with "--liquibase formatted sql", you should have rollback data as well - in this example I didn't use this solution
#
# At this moment, I'm not sure whether this is the right method to
liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" updateSQL > db-changelog-master.sql

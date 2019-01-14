#!/bin/bash

liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" rollback 1.0

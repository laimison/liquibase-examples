#!/bin/bash

liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" updateToTag 1.1

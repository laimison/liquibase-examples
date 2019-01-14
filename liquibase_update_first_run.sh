#!/bin/bash

liquibase --defaultsFile="liquibase.properties" --changeLogFile="db-changelog-master.xml" update

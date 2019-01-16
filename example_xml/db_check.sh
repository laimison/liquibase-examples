#!/bin/bash

mysql -u root -pmyexample -e 'use mydbname; show tables; describe DATABASECHANGELOG; describe DATABASECHANGELOGLOCK; describe department; describe employee;'

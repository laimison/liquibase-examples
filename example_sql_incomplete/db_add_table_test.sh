#!/bin/bash

mysql -u root -pmyexample -e 'use mydbname2; create table test (id INT NOT NULL PRIMARY KEY, name VARCHAR(50)); show tables;'

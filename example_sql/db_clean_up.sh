#!/bin/bash

mysql -u root -pmyexample -e 'show databases; drop database mydbname2; show databases;'

--liquibase formatted sql

--changeset author1:1
create table liquibase (
id int primary key,
name varchar(255)
);
--rollback drop table liquibase;

--changeset author1:2
create table liquibase2 (
id int primary key,
name varchar(255)
);
--rollback drop table liquibase2;

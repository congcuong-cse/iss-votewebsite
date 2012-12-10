
--create user ISSVOTE identified by p123;

grant create table, create sequence, 
create procedure, create trigger, create user, drop user, create tablespace, drop tablespace to ISSVOTE;
grant connect, resource to ISSVOTE with admin option;
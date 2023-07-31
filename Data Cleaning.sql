create database projects;

use projects;

select * from hr;

---------------- data cleaning ---------------

set autocommit = Off;

rollback;

commit;

alter table hr 
change column ï»¿id emp_id varchar(20) null;

describe hr;



set sql_safe_updates = 0;

SET SQL_MODE = '';

select birthdate 
from hr;

-------------- uniforming the dates

update hr
set birthdate = case 
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column birthdate date;

------------------------------

update hr
set hire_date = case 
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column hire_date date;

-------------------------------

update hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '',
date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

set sql_mode ='allow_invalid_dates';

select termdate from hr;

alter table hr
modify column termdate date;

describe hr;

rollback;

commit;

--------------- Adding an Age Column ----------------

alter table hr
add column age int;

update hr
set age = timestampdiff(year, birthdate, curdate());

select birthdate, age from hr;







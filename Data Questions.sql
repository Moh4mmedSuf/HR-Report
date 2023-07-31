
----- Analysis -----

--------- Gender breakdown 

select gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by gender;



--------- Race Breakdown 


select race, count(*) as count
from hr 
where age >= 18 and termdate = '0000-00-00'
group by race
order by count(*) desc;


-------------- age distribution 


select
	min(age) as youngest,
	max(age) as oldest
from hr
where age >= 18 and termdate = '0000-00-00';


select
	case
     when age >= 18 and age <= 26 then '18-26'
     when age >= 27 and age <= 35 then '27-35'
     when age >= 36 and age <= 45 then '36-45'
     when age >= 46 and age <= 55 then '46-55'
     when age >= 56 and age <= 64 then '56-64'
     else '65+'
end as age_group,
count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by age_group
order by age_group;


---------- Gender/age breakdown


select
	case
     when age >= 18 and age <= 26 then '18-26'
     when age >= 27 and age <= 35 then '27-35'
     when age >= 36 and age <= 45 then '36-45'
     when age >= 46 and age <= 55 then '46-55'
     when age >= 56 and age <= 64 then '56-64'
     else '65+'
end as age_group, gender,
count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by age_group, gender
order by age_group, gender;


--------- work Location Breakdown


select location, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by location;


---------- lengthe of employment of terminated employees


select
	round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
from hr
where termdate <= curdate() and termdate <> '0000-00-00' and age >=18;



---------- gendey/department breakdown



select department, gender, count(*) as count
from hr
where age >= 18 and termdate ='0000-00-00'
group by department, gender 
order by department;


-------- Job Titles distribution


select jobtitle, count(*) as count 
from hr
where age >= 18 and termdate ='0000-00-00'
group by jobtitle
order by jobtitle desc;



-------- department turnover rate


select department,
	total_count,
    terminated_count,
    terminated_Count/total_count as termination_rate
from (
	select department,
    count(*) as total_count,
    sum(case when termdate <> '0000-00-00'
			and termdate <= curdate() 
			then 1 else 0 end) as terminated_count
    from hr
    where age >= 18
    group by department) as subquery
order by termination_rate desc;
    
    
--------- cite/state location breakdown


select location_state, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by location_state
order by count desc;



---------- employees count over the years


select
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires*100, 2) as net_change_percent
from(
	select
		year(hire_date) as year,
		count(*) as hires,
        sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end)
        as terminations
        from hr 
        where age >= 18
        group by year(hire_date)
        ) as subquery
order by year;



------------ employee tenure by department


select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr 
where termdate <= curdate() and termdate<> '0000-00-00' and age >= 18
group by department;



------------- employee tenure by job title



select jobtitle, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr 
where termdate <= curdate() and termdate<> '0000-00-00' and age >= 18
group by jobtitle
order by avg_tenure desc;


-----------------
        








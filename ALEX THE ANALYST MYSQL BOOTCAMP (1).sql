DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;


CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);



CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');


select* from employee_demographics;
# or 
SELECT * FROM parks_and_recreation.employee_demographics; 

select first_name
last_name,
birth_date,
age,
(age + 10)* 10+10/2-5  # PEMDAS
from employee_demographics;

select distinct first_name , gender,age
from employee_demographics
where age >= 21;

select * from employee_salary
where first_name = 'BEN';
select * from employee_salary
where salary > '2000';

select * from employee_demographics 
where gender != 'female';

select * from employee_demographics 
where birth_date > '1985-01-01';

-- logical operators 
-- OR NOT , AND

select * from employee_demographics 
where birth_date > '1985-01-01'
or  gender = 'male';

select * from employee_demographics 
where birth_date > '1985-01-01'
or not gender = 'male';

select*
from employee_demographics where (first_name = 'leslie' and age = 44) or age > 55;

-- like statement
-- % ( anything) and _ ( specific value )
select * from employee_demographics
where first_name like 'jer%';

select * from employee_demographics
where first_name like '%ER%';

select * from employee_demographics
where first_name like 'a%';

select * from employee_demographics
where first_name like 'a__'; -- it starts with an 'a' and has two more 
-- characters no more no less.
 select * from employee_demographics
where first_name like 'a___%';

-- Group by and Order by --

select gender 
from employee_demographics
group by gender;

select gender , avg(age)
from employee_demographics
group by gender;
select occupation , salary 
from employee_salary
group by occupation, salary;

select occupation , salary
from  employee_salary
group by occupation , salary;

select Gender , Avg(age) as Avg, max(age) as Max, min(age) as Min , count(age) as Count
from employee_demographics
group by gender;
-- Order By--
select gender, age , birth_date
 from employee_demographics
order by age asc , birth_date asc;
 select * from employee_demographics
 order by first_name asc;
select * from employee_demographics
 order by gender , age desc;

-- having , where --

select gender , avg(age) 
from employee_demographics
group by gender 
having avg(age) > 40;

select first_name, occupation , avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation, first_name
having  avg(salary) > 75000;

-- limit  and Alaising 
select * from employee_demographics
order by age desc
limit 3, 1;

select gender, avg(age) as Avg_Age
from employee_demographics
group by gender
having avg(age) > 40;

-- joints--
  select * from employee_demographics ;
  select * from employee_salary;
-- inner join also mean join

  select * from employee_demographics  as dem
  inner join employee_salary	as sal
		on  dem.employee_id=sal.employee_id;

select dem.employee_id , age , occupation 
 from employee_demographics  as dem
  inner join employee_salary	as sal
		on  dem.employee_id=sal.employee_id;
-- outer joins (left and right joins) 
-- can also be called left outter join and right outter join

select *
 from employee_demographics  as dem
  left join employee_salary	as sal
		on  dem.employee_id=sal.employee_id;

select *
 from employee_demographics  as dem
  right join employee_salary	as sal
		on  dem.employee_id=sal.employee_id;
        
        -- self join --
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from employee_salary Emp1
join employee_salary Emp2
on  emp1.employee_id + 1 = emp2.employee_id;

-- joining multiple tables together --

select * 
 from employee_demographics  as dem
  inner join employee_salary	as sal
		on  dem.employee_id=sal.employee_id
        inner join parks_departments pd
        on sal.dept_id = pd.department_id;

-- unions --

select age , gender 
from employee_demographics
union 
select first_name , last_name 
from employee_salary;

select first_name ,last_name
from employee_demographics
union  distinct
select first_name , last_name 
from employee_salary;

select first_name ,last_name
from employee_demographics
union  all
select first_name , last_name 
from employee_salary;

select first_name ,last_name , 'old man' as Label
from employee_demographics
where  age > 40 and gender= 'male'
union 
select first_name ,last_name , 'old lady ' as Label
from employee_demographics
where  age > 40 and gender = 'female' 
union
select first_name , last_name , 'highly paid employee' as label 
from employee_salary
where salary > 70000
order by first_name , last_name ;

-- String functions --
# how long the string is 
# use case phone numbers
select length('skyfall') as string;

select first_name ,length(first_name)
from employee_demographics
order by 2;

select upper( 'sky');
select lower( 'sky');                                      # helps with satandardazing
select first_name , upper(first_name)
from employee_demographics;

-- TRIM--

select trim ('    sky     ');
select Rtrim('    sky     ');
select Ltrim('    sky     ');

# LEFT # RIGHT

SELECT first_name , left(first_name , 4),
right(first_name , 4)
from employee_demographics;

# substring

SELECT first_name, 
left(first_name , 4),
right(first_name , 4),
SUBSTRING(first_name, 3,2)
from employee_demographics;

SELECT first_name, 
left(first_name , 4),
right(first_name , 4),
SUBSTRING(first_name, 3,2)
birth_date, substring(birth_date,6,2) Birth_Month
from employee_demographics;


# Replace 
select first_name , replace(first_name, 'a' , 'z')
from employee_demographics;

# Locate 
select Locate( 'a' , 'christina');
select locate( 'i' ,'soliana');
select first_name , locate('An' ,first_name)
from employee_demographics;

#CONCAT 
select first_name , last_name,
concat( first_name,'   ',last_name ) Full_Name
from employee_demographics;

-- case statements --
select first_name ,
last_name,
case when age<= 30 then 'young ' 
      when age between  31 and 50 then 'old'
      when age >= 50 then 'On Death Door'
end  as AGE_bracket
from employee_demographics;

-- pay increase and bonus--
-- < 50000 = 5%
-- > 50000 = 7%
-- finance = 10% bonus

select first_name , last_name  , salary,
case 
 when salary < 50000 then salary + (salary * 0.05)
 when salary > 50000 then salary + (salary * 0.07)
 end  as New_Salary,
 case  
   when dept_id = 6 then salary *0.10
   end as Bonus 
 from employee_salary;
-- Subqueries 
  
  SELECT * FROM employee_demographics;
  SELECT * FROM employee_salary;

SELECT * FROM employee_demographics
where employee_id IN
             ( select employee_id from employee_salary 
             where dept_id = 1);
             
             
        select first_name , salary , avg(salary)
	  from employee_salary
      group by first_name , salary  ;   
             
select first_name , salary ,( select  avg(salary) from employee_salary) Avg_salary 
	  from employee_salary;   

select gender , avg(age) , max(age) , min(age) , count(age)
from employee_demographics 
group by gender;

select * from ( select gender , avg(age) , max(age) , min(age) , count(age)
from employee_demographics 
group by gender) as agg_table;

 select   Avg(max_age)
 from ( select gender , avg(age)  avg_age , max(age) max_age, min(age) min_age , count(age)
from employee_demographics 
group by gender) as agg_table
;

-- window functions --

select  gender, avg(salary) Avg_salary
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id
group by gender;

select  gender, dem.first_name, dem.last_name ,avg(salary) Avg_salary
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id
group by gender, dem.first_name, dem.last_name;

select  dem.first_name, dem.last_name, gender , avg(salary) over( partition by gender) Avg_salary
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id;


select  dem.first_name, dem.last_name, gender , sum(salary) over( partition by gender) Sum_Salary
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id;

select  dem.first_name, dem.last_name, gender , salary, 
sum(salary) over( partition by gender order by dem.employee_id) Rolling_total
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id;

select  dem.employee_id, dem.first_name, dem.last_name, gender , salary, 
row_number() over(partition by gender order by salary desc) row_num,
rank() over(partition by gender order by salary desc) rank_num,
dense_rank()over(partition by gender order by salary desc) Dense_rank_num
from employee_demographics dem 
join employee_salary sal on  
dem.employee_id = sal.employee_id;

-- CTE(Common table expression)--
with cte_example as 
(
select gender,avg(salary) avg_sal , max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
on  dem.employee_id= sal.employee_id
group by gender)
select AVG(avg_sal) from CTE_example;

with cte_example as 
(
select employee_id, gender, birth_date
from employee_demographics 
where birth_date > '1985-01-01'),
CTE_Example2 as 
(select employee_id , salary
from employee_salary
where salary > 50000)
select * from cte_example 
join cte_example2
 on CTE_example.employee_id = CTE_Example2.employee_id;
 
-- temporary tables--
 -- temp table --
 
 create temporary table temp_table 
 (first_name varchar(50),
 last_name varchar(50),
 favorite_movie varchar(100)
 );

select * from temp_table;

insert into temp_table 
values('Alex' , 'freberg' , 'lord of the rings: the two towers');
select * from temp_table;

select * from
employee_salary;
	
create temporary table salary_over_50k
select* from employee_salary
where salary >= 50000;

select * from
salary_over_50k;


-- stored procedures --

select * from employee_salary
where salary >=50000;

create procedure large_salary()
select * from employee_salary
where salary >=50000;

call large_salary();

delimiter $$
 create procedure large_salaries3()
 begin
select * from employee_salary
where salary >=50000;
select * from employee_salary
where salary >= 10000;
end $$
delimiter ;

call large_salaries3();
-- parameters--

delimiter $$
 create procedure large_salaries4(p_employee_id int)
 begin
select salary 
from employee_salary
where employee_id = p_employee_id;
end $$
delimiter ;

call large_salaries4(1);
 
 -- triggers and events--

select * from employee_demographics;

select  * 
from employee_salary;

delimiter $$ 
create trigger employee_insert
   After insert on  employee_salary
   for each row 
begin 
 insert into employee_demographics ( employee_id , first_name , last_name)
 values ( NEW.employee_id , new.first_name , new.last_name);
 end $$
 delimiter ;

insert into employee_salary (employee_id ,  first_name , last_name ,occupation, salary , dept_id)
values(13, 'jean-ralphio' , 'saperstien' , 'exntertainment 720 CEO' , 1000000, null);

select  * 
from employee_salary
where first_name like  '%jean%';

select * from employee_demographics
where first_name like  '%jean%';
 
 -- Events--
 # this is scehduled 
select * from employee_demographics;

delimiter $$
create event delete_retirees
on schedule Every 30 second
do 
begin 
   Delete 
   from employee_demographics
   where age >= 60;
   end $$
delimiter ;

show variables like 'event%';

-- The End --




















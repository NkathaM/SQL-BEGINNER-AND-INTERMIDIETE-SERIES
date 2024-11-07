select *
from parks_and_recreation.employee_demographics ed ;

select *
from parks_and_recreation.employee_salary es ;

select *
from parks_and_recreation.parks_departments pd ;


select first_name 
from parks_and_recreation.employee_demographics ed ;

#you can separate multiple columns with a comma
select first_name,last_name 
from parks_and_recreation.employee_demographics ed ;

select first_name,last_name,age,age+10
from parks_and_recreation.employee_demographics ed ;

#PEMDAS-ORDER OF ARITHMETIC IN SQL. Parenthesis, Multiplication,  Division,Addition,Subtraction

#DINSTICT SELECTS ONLY UNIQUE COLUMNS

select distinct gender
from parks_and_recreation.employee_demographics ed ;


#SELECT STATEMENT selects the columns you want to see
# semi-colon shows the end of the query

#WHERE CLAUSE- FILTERS THE ROWS THAT FULFILL A SPECIFIC CONDITION

select * 
from parks_and_recreation.employee_demographics ed 
where first_name = 'Leslie';

#Comparisoson Operators- =,>,<
select *
from parks_and_recreation.employee_salary es 
where salary >=50000;

#LOGICAL OPERATORS - AND,OR,NOT-allows us to have diff logic
#OR-MEANS EITHER ONE HAS TO BE TRUE 
select * 
from parks_and_recreation.employee_demographics ed 
where birth_date > '1985-01-01'
and gender = 'male';

#LIKE STATEMENT %,_
select *
from parks_and_recreation.employee_demographics ed 
where first_name like 'a%';

#GROUP BY CLAUSE IS GOING TO GROUP TOGETHER ROWS THAT HAVE THE SAME VALUES IN A SPECIFIED COLUMN THAT YOU ARE GROUPING ON
#grouping on gender and performing aggregrate function
select gender,avg(age),max(age),min(age) ,count(age	) 
from parks_and_recreation.employee_demographics ed 
group by gender ;

#ORDER BY 
select *
from parks_and_recreation.employee_demographics ed 
order by first_name asc ;

select *
from parks_and_recreation.employee_demographics ed
order by first_name desc ;

select *
from parks_and_recreation.employee_demographics ed
order by gender;

select *
from parks_and_recreation.employee_demographics ed
order by gender,age ;

#HAVING CLAUSE

#LIMIT CLAUSE
select *
from PARKS_and_recreation.employee_demographics
limit 3;

#aliasing- changing the column name
 select gender ,avg(age) as avg_age
 from parks_and_recreation.employee_demographics ed 
 group by gender 
 having avg_age>40;
 
#INTERMEDIATE SQL SERIES PART2
#jOINS-ALLOWS YOU TO JOIN TWO TABLES OR MORE TOGETHER IF THEY HAVE A COMMON COLUMN
#THE COLUMN NAME DOESNT HAVE TO BE EXACTLY THE SAME,BUT THE DATA IS SIMILAR
#INNER JOIN-RETURN ROWS THAT ARE THE SAME IN BOTH COLUMNS FROM BOTH TABLES
select *
from parks_and_recreation.employee_demographics as dem # use of aliases
inner join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id ;

select dem.employee_id, age, occupation
from parks_and_recreation.employee_demographics as dem # use of aliases
inner join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id ;

#	OUTER JOINS
# LEFT JOIN-TAKES EVERYTHING FROM THE LEFT TABLE EVEN IF THERE IS NO MATCH IN THE JOIN
# RIGHT JOIN - TAKES EVERYHING FROM THE RIGHT TABLE EVEN IF THERE IS NO MATCH IN THE JOIN
select *
from parks_and_recreation.employee_demographics as dem # use of aliases
left outer join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id ;

#SELF JOIN- ITS A JOIN WHERE YOU TIE THE JOIN TO ITSELF
select *
from parks_and_recreation.employee_salary emp1 
join parks_and_recreation.employee_salary  emp2
 on emp1.employee_id+1 = emp2.employee_id ;

#JOINING MULTIPLE TABLES TOGETHER
select *
from parks_and_recreation.employee_demographics as dem # use of aliases
inner join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id 
inner join parks_and_recreation.parks_departments pd 
  on sal.dept_id=pd.department_id;
 
 
#UNIONS-HELPS YOU TO COMBINE ROWS TOGETHER FROM SEPARATE TABLES OR THE SAME TABLES
 select first_name ,last_name, 'old man' as label
 from parks_and_recreation.employee_demographics ed 
 where age>40 and gender ='male'
 union 
 select first_name ,last_name, 'old lady' as label
 from parks_and_recreation.employee_demographics ed 
 where age>40 and gender ='female'
 union
 select first_name ,last_name , 'highly_paid_employee' as label
 from parks_and_recreation.employee_salary es 
 where salary > 70000 
order by first_name , last_name ;

#STRING FUNCTIONS- built-in functions in mysql that HELPS US use and  WORK WITH STRINGS differently
#UPPER,LOWER,ACD,DESC,LENGTH
select first_name,length(first_name) 
from parks_and_recreation.employee_demographics ed 
order by 2;

select first_name,lower(first_name) 
from parks_and_recreation.employee_demographics ed 
;

select first_name,upper(first_name) 
from parks_and_recreation.employee_demographics ed ;

#TRIM,RIGHT TRIM,LEFT TRIM - TRIM GETS RID OF THE LEADING AND THE TRAILING WHITE SPACES
select first_name ,
left (first_name,4),
right (first_name,4),
substring(first_name,3,2),
birth_date ,
substring(birth_date,6,2) as birth_month
from parks_and_recreation.employee_demographics ed; 

#replace function will replace certain characters with the characters you want.

select first_name ,replace (first_name,'a','z')
from parks_and_recreation.employee_demographics ed ;

#Locate 
select first_name ,locate('An',first_name) 
from parks_and_recreation.employee_demographics ed ;

#concat
select first_name ,last_name ,
concat (first_name,'  ', last_name) as full_name
from parks_and_recreation.employee_demographics ed ;

#Case Statement-allows you to add logic in your case statement like else if

select first_name ,
last_name,
age,
case 
	when age <= 30 then 'young'
	WHEN age BETWEEN 31 AND 70 THEN 'old'
end as Age_bracket
from parks_and_recreation.employee_demographics ed ;

select first_name, last_name,salary ,
case 
	when salary < 50000 then salary * 1.05
	when salary > 50000 then salary + (salary*0.07)
end as new_salary
from parks_and_recreation.employee_salary; 

#Subqueries - query within another query
select 
from parks_and_recreation.employee_demographics ed 

#window functions allow us to look at a partition or a group but they each keep their own unique rows in the output.
#like group by except they dont row up everything into one row when GROUPING

select gender ,avg(salary) as avg_sal
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id 
group by gender ;

select dem.first_name ,dem.last_name ,gender ,avg(salary) over(partition by gender) 
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;

select dem.first_name ,dem.last_name ,gender ,sum(salary) over(partition by gender) as sum_salary
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;

#rolling total start at a specific function and add on values on subsequent rows based off of your partition
select dem.first_name ,dem.last_name ,gender,salary,
sum(salary) over(partition by gender order by dem.employee_id)as rolling_total
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;

#Row number - gives a unique row number based off what you are partitioning by or ordering by in your window function
select dem.employee_id ,dem.first_name ,dem.last_name ,gender,salary,
row_number() over()
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;

select dem.employee_id ,dem.first_name ,dem.last_name ,gender,salary,
row_number() over(partition by gender order by salary desc)
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;

#Rank- will give it more of an official rank.positionally
#dense_rank - numerically
select dem.employee_id ,dem.first_name ,dem.last_name ,gender,salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_num
from parks_and_recreation.employee_demographics dem
     join parks_and_recreation.employee_salary sal
on dem.employee_id=sal.employee_id ;



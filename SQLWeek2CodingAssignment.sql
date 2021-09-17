use employees;

-- I want to know how many employees with each title were born after 1965-01-01.

select t.title, count(t.emp_no) as "Number of Employees" from titles t 
inner join employees e on e.emp_no = t.emp_no
where e.birth_date > '1965-01-01'
group by t.title;


-- I want to know the average salary per title.


select t.title, avg(s.salary) as "Average Salary" from titles t
inner join salaries s on s.emp_no = t.emp_no
group by t.title;


-- How much money was spent on salary for the marketing department between the years 1990 and 1992?

select d.dept_name, sum(s.salary) as "$ Spent on Salaries" from departments d
inner join dept_emp de on de.dept_no = d.dept_no
inner join salaries s on s.emp_no = de.emp_no
where d.dept_name = 'Marketing' and (s.from_date <= '1992-12-31' and s.to_date >= '1990-01-01');


-- Here is a more precise method from our class meeting (we discussed a similar example which I modified here).
-- This accounts for employees that only worked a partial year in the marketing department during that time.

select d.dept_name, sum((round(s.salary/365, 2)) * least(
datediff(s.to_date, '1990-01-01'),
datediff('1992-12-31', s.from_date),
datediff(s.to_date, s.from_date)
)) as "$ Spent on Salaries" from departments d
inner join dept_emp de on de.dept_no = d.dept_no
inner join salaries s on s.emp_no = de.emp_no
where d.dept_name = 'Marketing' 
and s.from_date <= '1992-12-31' 
and s.to_date >= '1990-01-01';



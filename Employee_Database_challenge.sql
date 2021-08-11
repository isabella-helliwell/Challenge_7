---------------------------DELIVERABLE 1-----------------------------------

----------------------------part1.1---------------------------------------
SELECT employees.emp_no, employees.first_name, employees.last_name,
	   titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON (employees.emp_no=titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;
SELECT * FROM retirement_titles


------------------------------part 1.2--------------------------------
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no,to_date DESC;
SELECT * FROM unique_titles

-----part 1.3------

SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT DESC;

SELECT * FROM retiring_titles limit 10;

-----------------------------DELIVERABLE 2------------------------------------

SELECT employees.emp_no, employees.first_name, employees.last_name,employees.birth_date,
	   titles.title, dept_emp.from_date, dept_emp.to_date
INTO mentor_candidates   
FROM employees
LEFT JOIN dept_emp
ON (employees.emp_no=dept_emp.emp_no)
INNER JOIN titles
ON(employees.emp_no=titles.emp_no)
WHERE(employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (titles.to_date='9999-01-01')

SELECT * FROM mentor_candidates 

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
INTO mentorship_eligibilty
FROM mentor_candidates
ORDER BY emp_no, title Asc;

SELECT * FROM mentorship_eligibilty

------------Part 3----------

SELECT COUNT (title), title
INTO mentorship_eligible_titles
FROM mentorship_eligibilty
GROUP BY title 
ORDER BY COUNT DESC;


--Q1: How many of the ready to retire people are women and men?--

SELECT employees.emp_no, employees.first_name, employees.last_name,employees.gender,
	   titles.title, titles.from_date, titles.to_date
INTO retirement_titles_gender
FROM employees
INNER JOIN titles
ON (employees.emp_no=titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;



SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
gender,
title
INTO unique_titles_gender
FROM retirement_titles_gender
ORDER BY emp_no,to_date DESC;



SELECT COUNT (u.gender), u.gender
INTO retiring_count_gender
FROM unique_titles_gender AS u
GROUP BY u.gender 
ORDER BY COUNT DESC;
SELECT * FROM retiring_count_gender



---Q2-How many people are retiring per department?----
SELECT * FROM departments
SELECT * FROM dept_emp


SELECT unique_titles.emp_no, unique_titles.first_name, unique_titles.last_name,
departments.dept_name
INTO retire_dep
FROM unique_titles
INNER JOIN dept_emp
ON (unique_titles.emp_no = dept_emp.emp_no)
INNER JOIN departments
ON(dept_emp.dept_no=departments.dept_no)
--WHERE(dept_emp.to_date='9999-01-01')
ORDER BY unique_titles.emp_no;


SELECT COUNT (rt_d.dept_name), rt_d.dept_name
INTO retire_dep_count
FROM retire_dep AS rt_d
GROUP BY rt_d.dept_name 
ORDER BY COUNT DESC;

		

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
dept_name
INTO retire_dep_unique
FROM retire_dep 
ORDER BY emp_no, dept_name DESC;

SELECT COUNT (rt_d.dept_name), rt_d.dept_name
INTO retire_count_departments
FROM  retire_dep_unique AS rt_d
GROUP BY rt_d.dept_name 
ORDER BY COUNT DESC;

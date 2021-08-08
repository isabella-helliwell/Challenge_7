# Pewlett-Hackard-Analysis

## 1. Scope of Project
      The scope of the project is to determine the number of retiring employees per title, and identify employees that are eligible
      to participate in a amentorship program
      
## 2 . Resources
       - Data source: Employee_Challenge_starter_code.sql
       - Software: PostgreSQL v11.12, pgAdmin 4
       - Given Files : department.csv, dept_csv, dept_manager.csv, employees.csv, salaries.csv, titles.csv
       - Output Files : retirement_titles.csv, unique_titles.csv, retiring_titles.csv, mentor_candidates.csv, mentorship_eligibility.csv
       
## 3. Analysis
### 3.1 The number of retiring employess by title
        The given csv files are populated with information about the employers. These informations are stored in the csv file in various
        tables, and the contents in the tables are shown below. The names within the brackets are the names used in tables. Note that
        the table content vary with some of the information shown below.
        -- employement number (emp_no)
        -- first name (first_name)
        -- last name (last_name)
        -- birthday (birth_date)
        -- department number (dept_no)
        -- department name (dept_name)
        -- salary (salary)
        -- employee title (title)
        -- gender (gender)
        -- date for starting employement/or date for starting new position within the company (from_date)
        -- date for finnishing employement/and/or changing job title within company (to_date)
        
        The first step is to gather all the employees that are born between 1952-1955 in a table and call the table "retirement_titles"
        
        SELECT employees.emp_no, employees.first_name, employees.last_name,
        titles.title, titles.from_date, titles.to_date
        INTO retirement_titles
        FROM employees
        INNER JOIN titles
        ON (employees.emp_no=titles.emp_no)
        WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
        ORDER BY employees.emp_no;
        SELECT * FROM retirement_titles
 
 Output 1. 
 ![image](https://user-images.githubusercontent.com/85843030/128634656-ce7f75f5-87c7-406b-84dd-18611eada623.png)

        
       Since there are duplicates, as seen in Output 1, we remove them and order the table by emp_no and the most recent title they hold:
       
       SELECT DISTINCT ON (emp_no) emp_no,
       first_name,
       last_name,
       title
       INTO unique_titles
       FROM retirement_titles
       ORDER BY emp_no,to_date DESC;
        
Output 2.
![image](https://user-images.githubusercontent.com/85843030/128635591-8bdd5660-ba82-46c0-a6db-0f4c3fa5afe6.png)


      Create a retiring titles table to see how many employers are retiring:
      
      SELECT COUNT (title), title
      INTO retiring_titles
      FROM unique_titles
      GROUP BY title 
      ORDER BY COUNT DESC
      
Output 3.
![image](https://user-images.githubusercontent.com/85843030/128635818-74821d31-8dcd-4953-a4cb-50beb774e458.png)

### 3.2 Create a Mentorship Eligibility table
      For deliverable 2, we need to create a mentorship eligibility table, that holds the current employees who are born between
      January 1st, 1965 and December 31, 1965.
      We need to join 3 tables from the original files received to obtain emp_no, first_name, last_name, birth_date, from_date, to_date, and title
      for the employees that meet the age criteria. We also need to make sure that any dublicate employee numbers are deleted and that the most
      recent employee title is shown:
      
      SELECT employees.emp_no, employees.first_name, employees.last_name,employees.birth_date,
      titles.title, dept_emp.from_date, dept_emp.to_date
      INTO mentor_candidates   
      FROM employees
      LEFT JOIN dept_emp
      ON (employees.emp_no=dept_emp.emp_no)
      INNER JOIN titles
      ON(employees.emp_no=titles.emp_no)
      WHERE(employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
      AND (dept_emp.to_date='9999-01-01')
      
      
Output 4.
![image](https://user-images.githubusercontent.com/85843030/128636630-d49d7b04-0caa-404e-bce6-78aceb9d57f2.png)

      
     Finally we create a final table, where the duplicate emp_no's will be removed and the most recent title is shown:
     
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
     
     
Output 5. 
![image](https://user-images.githubusercontent.com/85843030/128636751-e1f62178-c18b-4f79-b2a6-1720e61159e1.png)



### 3.3 Additional Analysis
	It would be interesting to see how many of the employees are eligible for mentorship program with the following sql query:
	
	SELECT COUNT (title), title
	INTO mentorship_eligible_titles
	FROM mentorship_eligibilty
	GROUP BY title 
	ORDER BY COUNT DESC;


Output 6.
![image](https://user-images.githubusercontent.com/85843030/128640005-1e260751-1af2-4e91-b365-4c1eb91566bd.png)


	We can also see the how many of the soon to be retired personnel are male and female by this sql query:
	SELECT COUNT (u.gender), u.gender
	INTO retiring_count_gender
	FROM unique_titles_gender AS u
	GROUP BY u.gender 
	ORDER BY COUNT DESC;
	
Output 7.
![image](https://user-images.githubusercontent.com/85843030/128640652-574cc594-2290-4bf6-af27-3846f820d9ad.png)

	We can also find out how many people are about to retire in each department by writing the following sql query:
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

output 8.
![image](https://user-images.githubusercontent.com/85843030/128644304-74d68a03-104d-4250-96a1-7f22d6363a41.png)


# 4. Summary
	In summary, one can see from Output 2, that there are in total 90398 people due to retire.
	From the above, 


# 5. Results
	- There are in total 90398 people due to retire
	- The majority of them hold an senior title within the company
	- under 1% of those about to retire are managers
	- over 60% of those retiring hold a senior position which is a good rate for mentoring the next generation
	


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






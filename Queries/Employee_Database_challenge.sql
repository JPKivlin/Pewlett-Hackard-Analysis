-- Retrieve the columns
SELECT employees.emp_no, 
    employees.first_name,
    employees.last_name,
    titles.title,
    titles.from_date,
    titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) emp_no,
first_name,
last_name,
title

INTO Unique_Titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Use Count to cr8 new table summarizing titles
SELECT COUNT(Unique_Titles.emp_no), Unique_Titles.title
INTO retiring_titles
FROM Unique_Titles
GROUP BY Unique_Titles.title
ORDER BY count DESC;

-- Cr8 mentorship table
SELECT DISTINCT ON (employees.emp_no), employees.emp_no  
    employees.first_name,
    employees.last_name,
    employees.birth_date,
    dept_emp.from_date,
    dept_emp.to_date,
    titles.titles
INTO mentorship_eligibility
FROM employees
JOIN dept_emp
ON  dept_emp.emp_no = employees.emp_no
JOIN titles
ON titles.emp_no = employees.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;
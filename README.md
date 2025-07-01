# MYSQL


# Parks and Recreation Employee Database

A practical MySQL project inspired by the *Alex the Analyst Bootcamp* to strengthen SQL fundamentals.

# Database Overview
- `employee_demographics`: includes personal data such as age, gender, and birth date  
- `employee_salary`: contains job titles, salaries, and links to employee IDs

#SQL Skills Demonstrated
- Creating tables and relational structure  
- Writing joins and filtering data  
- Using aggregate functions like `AVG`, `SUM`, and `GROUP BY`

#Sample Query
```sql
SELECT gender, AVG(salary)
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id
GROUP BY gender;
```
 Built as part of my journey into data analytics. Always open to connecting with professionals and learning from new challenges.
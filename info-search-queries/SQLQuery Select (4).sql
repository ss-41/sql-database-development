SELECT PROJ_NAME, 
COUNT(DISTINCT ASSIGNMENT.EMP_NUM) AS NUM_EMPLOYEES,
SUM(ASSIGN_HOURS) AS TOTAL_HOURS, 
SUM(ASSIGN_CHARGE) AS TOTAL_CHARGE
FROM ASSIGNMENT
JOIN PROJECT ON ASSIGNMENT.PROJ_NUM = PROJECT.PROJ_NUM
GROUP BY PROJECT.PROJ_NUM, PROJ_NAME
ORDER BY PROJ_NAME;

/*
For each project, list the project name, the number of employees
worked for the project, the total number of hours worked, and the 
total charges assigned to each project. Sort the result by project
name 
*/
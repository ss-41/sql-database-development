SELECT DISTINCT EMP_FNAME, EMP_LNAME 
FROM EMPLOYEE, ASSIGNMENT, PROJECT
WHERE EMPLOYEE.EMP_NUM = ASSIGNMENT.EMP_NUM
AND ASSIGNMENT.PROJ_NUM = PROJECT.PROJ_NUM
AND PROJ_NAME = 'Evergreen';

/*
List the first and last names of all employees assigned 
to the project named “Evergreen” 
*/
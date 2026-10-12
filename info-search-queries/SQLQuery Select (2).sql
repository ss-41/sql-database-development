SELECT JOB.JOB_CODE, JOB.JOB_DESCRIPTION, 
EMPLOYEE.EMP_LNAME, EMPLOYEE.EMP_FNAME
FROM JOB 
JOIN EMPLOYEE ON JOB.JOB_CODE = EMPLOYEE.JOB_CODE
ORDER BY JOB_DESCRIPTION, EMP_LNAME;

/*
List the job code, job description, and employee last name and 
first name. Sort the result by job description, then by employee 
last name.
*/
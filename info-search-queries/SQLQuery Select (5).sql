SELECT A.EMP_NUM, EMP_LNAME, EMP_FNAME,
COUNT(DISTINCT PROJ_NUM) AS NUM_DISTINCT_PROJECTS
FROM ASSIGNMENT AS A
JOIN EMPLOYEE AS E ON A.EMP_NUM = E.EMP_NUM
GROUP BY A.EMP_NUM, EMP_LNAME, EMP_FNAME
HAVING COUNT(DISTINCT PROJ_NUM) > 1;

/*
List all employees who have been assigned to more than one 
project. Show their EMP_NUM, EMP_LNAME, EMP_FNAME, and the
number of distinct projects they were assigned to.
*/
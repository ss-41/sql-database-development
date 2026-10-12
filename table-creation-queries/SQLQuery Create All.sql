CREATE TABLE JOB (
	JOB_CODE INT NOT NULL, -- assume job code is a 3-digit integer
	CONSTRAINT CHECK_JOB_CODE CHECK (JOB_CODE BETWEEN 100 AND 999),
	JOB_DESCRIPTION VARCHAR(30) NOT NULL,
	JOB_CHG_HOUR NUMERIC(6,2) NOT NULL,
	CONSTRAINT CHECK_JOB_CHG_HOUR CHECK (JOB_CHG_HOUR >= 0),
	JOB_LAST_UPDATE DATE NOT NULL,

	PRIMARY KEY (JOB_CODE)
);

/*
	Sample data does not have NULL (blank) values for any column 
	in this table so define all columns as NOT NULL
*/

CREATE TABLE EMPLOYEE (
	EMP_NUM INT NOT NULL, -- assume employee number is a 3-digit integer
	CONSTRAINT CHECK_EMP_NUM CHECK (EMP_NUM BETWEEN 100 AND 999),
	EMP_LNAME VARCHAR(20) NOT NULL,
	EMP_FNAME VARCHAR(20) NOT NULL,
	EMP_INITIAL CHAR(1) NULL,
	EMP_HIREDATE DATE NOT NULL,
	JOB_CODE INT NOT NULL, -- each employee has exactly one job

	PRIMARY KEY (EMP_NUM),
	CONSTRAINT FK_EMPLOYEE_JOB
		FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE)
		ON UPDATE CASCADE 
		ON DELETE NO ACTION
);

/*
	Sample data only has NULL (blank) values for EMP_INITIAL so define as
	NULL to allow NULL values. All other columns do not have NULL values 
	in the sample data so define as NOT NULL.
*/

CREATE TABLE PROJECT(
	PROJ_NUM INT NOT NULL, -- assume project number is a 2-digit integer
	CONSTRAINT CHECK_PROJ_NUM CHECK (PROJ_NUM BETWEEN 10 AND 99),
	PROJ_NAME VARCHAR(30) NOT NULL,
	PROJ_VALUE NUMERIC(11,2) NOT NULL,
	CONSTRAINT CHECK_PROJ_VALUE CHECK (PROJ_VALUE >= 0),
	PROJ_BALANCE NUMERIC(11,2) NOT NULL,
	CONSTRAINT CHECK_PROJ_BALANCE CHECK (PROJ_BALANCE >= 0),
	EMP_NUM INT NOT NULL, -- each project is managed by exactly one employee

	PRIMARY KEY (PROJ_NUM),
	CONSTRAINT FK_PROJECT_EMPLOYEE
		FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE(EMP_NUM)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
);

/*
	Sample data does not have NULL (blank) values for any column 
	in this table so define all columns as NOT NULL
*/

CREATE TABLE ASSIGNMENT (
	ASSIGN_NUM INT NOT NULL, -- assume assignment number is a 4-digit integer 
	CONSTRAINT CHECK_ASSIGN_NUM CHECK (ASSIGN_NUM BETWEEN 1000 AND 9999),
	ASSIGN_DATE DATE NOT NULL, 
	PROJ_NUM INT NOT NULL,
	EMP_NUM INT NOT NULL,
	ASSIGN_JOB INT NOT NULL, -- assume assign_job is a job code which is a 3-digit integer
	CONSTRAINT CHECK_ASSIGN_JOB CHECK (ASSIGN_JOB BETWEEN 100 AND 999),
	ASSIGN_CHG_HR NUMERIC (6,2) NOT NULL, -- assume the charge per hour can be up to 9999.99
	CONSTRAINT CHECK_ASSIGN_CHG_HR CHECK (ASSIGN_CHG_HR >= 0),
	ASSIGN_HOURS NUMERIC(5,1) NOT NULL, -- assume the hours can be up to 9999.9
	CONSTRAINT CHECK_ASSIGN_HOURS CHECK (ASSIGN_HOURS >= 0),
	ASSIGN_CHARGE NUMERIC (10,2) NOT NULL, -- assignment charge can be up to 9999.99 * 9999.9 = 99998900.01
	CONSTRAINT CHECK_ASSIGN_CHARGE CHECK (ASSIGN_CHARGE >= 0),

	PRIMARY KEY (ASSIGN_NUM),
	CONSTRAINT FK_ASSIGNMENT_PROJECT
		FOREIGN KEY (PROJ_NUM) REFERENCES PROJECT(PROJ_NUM)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT FK_ASSIGNMENT_EMPLOYEE
		FOREIGN KEY (EMP_NUM) REFERENCES EMPLOYEE(EMP_NUM)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);

/*
	ASSIGN_NUM is the primary key because it uniquely identifies each row. 
	PROJ_NUM and EMP_NUM are foreign keys that reference the PROJECT and EMPLOYEE tables.
	PROJ_NUM and EMP_NUM are not primary keys in this table because they can have duplicate values, 
	as multiple employees can be assigned to the same project and multiple projects can be assigned to
	the same employee.

	Sample data does not have NULL (blank) values for any column 
	in this table so define all columns as NOT NULL

	ASSIGN_JOB is not implemented as a foreign key as the provided relational schema does not identify
	it as a foreign key. It would be logical to make ASSIGN_JOB reference JOB_CODE in the JOB table, 
	as it represents the job assigned to the employee for that assignment. However, this implementation
	follows the provided relational schema.

	If ASSIGN_JOB was defined as a foreign key in the schema, it could be implemented as:
		CONSTRAINT FK_ASSIGNMENT_JOB
		FOREIGN KEY (ASSIGN_JOB) REFERENCES JOB(JOB_CODE)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
*/
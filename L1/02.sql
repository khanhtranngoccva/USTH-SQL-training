INSERT INTO DEPARTMENT (Dname) VALUES ("Marketing");

INSERT INTO EMPLOYEE 
(Fname, Lname, Ssn, Bdate, Address, Sex, Salary, Dno)
VALUES ("Bob", "Boberson", "123-45-6789", "1990-12-27", "100 High Street", "M", 125000, 1);

INSERT INTO EMPLOYEE 
(Fname, Lname, Ssn, Bdate, Address, Sex, Salary, Dno, Super_ssn)
VALUES ("Bobby", "Boberson", "200-45-6789", "1990-12-27", "100 High Street", "M", 125000, 1, "123-45-6789");

UPDATE DEPARTMENT SET Mgr_ssn = "123-45-6789", Mgr_start_date = "2010-12-27" WHERE Dnumber = 1;

INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation)
VALUES (1, "4th floor");

INSERT INTO PROJECT (Pname, Plocation, Dnum)
VALUES ("Company presentation", "5th floor", 1);

INSERT INTO WORKS_ON VALUES ("123-45-6789", 1, 20);

INSERT INTO DEPENDENT VALUES ("123-45-6789", "Mary", "F", "1960-12-20", "Mother");

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_LOCATIONS;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;
DROP DATABASE Company;
CREATE DATABASE IF NOT EXISTS Company;
USE Company;

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    Fname VARCHAR(20) NOT NULL,
    Minit VARCHAR(20),
    Lname VARCHAR(20) NOT NULL,
    Ssn VARCHAR(11) PRIMARY KEY NOT NULL,
    Bdate DATE NOT NULL,
    Address VARCHAR(100),
    Sex CHAR NOT NULL,
    Salary INT NOT NULL,
    Super_ssn VARCHAR(11),
    Dno INT NOT NULL
);

CREATE TABLE IF NOT EXISTS DEPARTMENT (
    Dname VARCHAR(50) NOT NULL,
    Dnumber INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Mgr_ssn VARCHAR(11),
    FOREIGN KEY (Mgr_ssn)
        REFERENCES EMPLOYEE (Ssn),
    Mgr_start_date DATE
);

ALTER TABLE EMPLOYEE ADD CONSTRAINT FOREIGN KEY (Dno) REFERENCES DEPARTMENT (Dnumber);
ALTER TABLE EMPLOYEE ADD CONSTRAINT FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE (Ssn);

CREATE TABLE IF NOT EXISTS DEPT_LOCATIONS (
    Dnumber INT NOT NULL PRIMARY KEY,
    FOREIGN KEY (Dnumber)
        REFERENCES DEPARTMENT (Dnumber),
    Dlocation VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS PROJECT (
    Pname VARCHAR(100) NOT NULL,
    Pnumber INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Plocation VARCHAR(100),
    Dnum INT NOT NULL,
    FOREIGN KEY (Dnum)
        REFERENCES DEPARTMENT (Dnumber)
);

CREATE TABLE IF NOT EXISTS WORKS_ON (
    Essn VARCHAR(11) NOT NULL,
    Pno INT NOT NULL,
    Hours INT NOT NULL,
    FOREIGN KEY (Essn)
        REFERENCES EMPLOYEE (Ssn),
    FOREIGN KEY (Pno)
        REFERENCES PROJECT (Pnumber)
);

CREATE TABLE IF NOT EXISTS DEPENDENT (
    Essn VARCHAR(11) NOT NULL,
    Dependent_name VARCHAR(50) NOT NULL,
    Sex CHAR NOT NULL,
    Bdate DATE NOT NULL,
    Relationship VARCHAR(20) NOT NULL,
    FOREIGN KEY (Essn)
        REFERENCES EMPLOYEE (Ssn)
);

ALTER TABLE EMPLOYEE ADD COLUMN Partner_ssn VARCHAR(11);
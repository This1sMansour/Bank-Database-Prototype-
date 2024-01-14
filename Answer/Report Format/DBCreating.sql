CREATE TYPE MS_Address_Type AS OBJECT
(
    Street           VARCHAR2(20),
    City             VARCHAR2(20),
    PostCode         VARCHAR2(20)
) NOT FINAL;
/

CREATE TYPE MS_Mobile_Nested AS TABLE OF VARCHAR2(12);
/

CREATE Type MS_Phone_Type AS OBJECT
(
    Home             VARCHAR2(12),
    Mobile           MS_Mobile_Nested
) NOT FINAL;  
/

CREATE TYPE MS_Name_Type AS OBJECT
(
    title           VARCHAR2(20),
    firstName       VARCHAR2(20),
    SURName         VARCHAR2(20)
) NOT FINAL;
/

CREATE TYPE MS_Person_Type AS OBJECT
(
    P_Address       MS_Address_Type,
    P_Name          MS_Name_Type,
    P_Phone         MS_Phone_Type,
    niNum           VARCHAR2(20)
) NOT FINAL;
/

--  Job
CREATE TYPE MS_Job_Type AS OBJECT
(
    "Position"      VARCHAR2(20),
    Salary_Max      INT,
    Salary_Min      INT
) NOT FINAL;
/

CREATE TABLE MS_Job_Table OF MS_Job_Type (
    CONSTRAINT uk_Position UNIQUE ("Position")
);
/

--  Branch
CREATE TYPE MS_Branch_Type AS OBJECT
(
    bID             INT,
    b_Address       MS_Address_Type,
    b_Phone         Varchar2(12)
) NOT FINAL;
/

CREATE TABLE MS_Branch_Table OF MS_Branch_Type
(
    bID CONSTRAINT pk_bID PRIMARY KEY,
    b_Phone CONSTRAINT uc_bPhone UNIQUE
);
/

--  Account
CREATE TYPE MS_Account_Type AS OBJECT
(
    accNum          VARCHAR2(20),
    accType         VARCHAR2(20),
    balance         FLOAT(2),
    bID             REF MS_Branch_Type,
    inRate          FLOAT(5),
    limitOfFreeOD   INT,
    openDate        DATE
) NOT FINAL;
/

CREATE TABLE MS_Account_Table OF MS_Account_Type
(
    accNum CONSTRAINT pk_accNum PRIMARY KEY,
    accType CONSTRAINT chk_accType CHECK (accType IN ('current', 'savings'))
);
/

--  Customer
CREATE TYPE MS_Customer_Type UNDER MS_Person_Type
(
    CustID          VARCHAR2(20)
) NOT FINAL;
/

CREATE TABLE MS_Customer_Table OF MS_Customer_Type 
(
    CustID CONSTRAINT pk_custid PRIMARY KEY,
    niNum UNIQUE
) NESTED TABLE P_Phone.Mobile STORE AS MobileTable_Customer;


--  Employee
CREATE TYPE MS_Employee_Type UNDER MS_Person_Type
(
    empID           VARCHAR2(20),
    supervisorID    REF MS_Employee_Type,
    E_Job           REF MS_JOB_Type,
    bID             REF MS_Branch_Type,
    joinDate        DATE,
    salary          INT,
    
    MEMBER FUNCTION employeeStatus  RETURN VARCHAR2
) NOT FINAL;
/

CREATE TABLE MS_Employee_Table OF MS_Employee_Type
(
    empID CONSTRAINT pk_empID PRIMARY KEY
) NESTED TABLE P_Phone.Mobile STORE AS MobileTable_Employee;
/

CREATE OR REPLACE TYPE BODY MS_Employee_Type AS
MEMBER FUNCTION employeeStatus RETURN VARCHAR2 IS
sub_count INT;
years_worked INT;
status VARCHAR2(10);
BEGIN
    SELECT COUNT(*) INTO sub_count
    FROM MS_Employee_Table
    WHERE DEREF(supervisorID) = self;    
    years_worked := TRUNC(MONTHS_BETWEEN(SYSDATE, self.joinDate) / 12);
    
    IF years_worked >= 12 AND sub_count >= 8 THEN
        status := 'gold';
    ELSIF years_worked >= 10 AND sub_count >= 5 THEN
        status := 'silver';
    ELSIF years_worked >= 4 THEN
        status := 'bronze';
    
    END IF;
    
    RETURN status;
END employeeStatus;
END;
/
--  Customer Account
CREATE TYPE MS_CustomerAccount_Type AS OBJECT
(
    custID          REF MS_Customer_Type,
    accNum          REF MS_Account_Type
) NOT FINAL;
/
CREATE TABLE MS_CustomerAccount_Table OF MS_CustomerAccount_Type;
/

--Trigger
CREATE OR REPLACE TRIGGER MS_CustomerAccount_Table_BI
BEFORE INSERT ON MS_CustomerAccount_Table
FOR EACH ROW
DECLARE
    l_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO l_count
    FROM MS_CustomerAccount_Table
    WHERE custID = :NEW.custID AND accNum = :NEW.accNum;

    IF l_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot insert duplicate row in MS_CustomerAccount_Table.');
    END IF;
END;
/

exit;


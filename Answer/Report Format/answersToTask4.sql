--  Q4
--  --  A:

SELECT e.P_Name.title || ' ' || e.P_Name.FirstName || ' ' || e.P_Name.SurName AS "Full Name"
FROM MS_Employee_Table e 
WHERE 
    e.P_Name.SurName LIKE '%on%' AND 
    e.P_Address.City = 'Glasgow';
/

--  --  B:

SELECT count(1) AS "Number of savings accounts",
    deref(bID).b_address.street || ', ' || deref(bID).b_address.city || ', ' || deref(bID).b_address.PostCode AS "Address"
FROM MS_Account_Table
WHERE accType = 'savings'
GROUP BY bID;

--  --  C: 

SELECT 
    DEREF(DEREF(ca.accNum).bID).bID AS "Branch ID", 
    DEREF(ca.custID).P_Name.title || ' ' || DEREF(ca.custID).P_Name.firstName || ' ' || DEREF(ca.custID).P_Name.surName AS "Full name",
    DEREF(ca.accNum).balance AS "Balance"
FROM MS_CustomerAccount_Table ca
INNER JOIN
(
    SELECT 
        DEREF(DEREF(ca.accNum).bID).bID AS "Branch ID", 
        MAX(DEREF(ca.accNum).balance) AS "Balance"
    FROM MS_CustomerAccount_Table ca
    GROUP BY DEREF(DEREF(ca.accNum).bID).bID
) CA2
ON 
    DEREF(DEREF(ca.accNum).bID).bID = CA2."Branch ID" AND
    DEREF(ca.accNum).balance = CA2."Balance";

--  --  D:

SELECT 
    DEREF(E.bID).bID AS "Branch that the employee works.",
    DEREF(DEREF(CA.accNum).bID).bID AS "Branch that the Account was opend."

FROM MS_Customer_Table C
INNER JOIN MS_Employee_Table E
ON C.niNum = E.niNum
INNER JOIN MS_CustomerAccount_Table CA
ON C.CustID = DEREF(CA.custID).CustID;
WHERE DEREF(DEREF(E.supervisorID).E_Job)."Position" = 'Manager';
/

--  --  E:

SELECT 
    DEREF(DEREF(ca.accNum).bID).bID AS "Branch ID",
    DEREF(ca.custID).P_Name.title || ' ' || DEREF(ca.custID).P_Name.firstName || ' ' || DEREF(ca.custID).P_Name.surName AS "Full name",
    DEREF(ca.accNum).limitOfFreeOD AS "Limit Of Free Overdraft"
FROM MS_CustomerAccount_Table ca
INNER JOIN
(
    SELECT 
        DEREF(DEREF(ca.accNum).bID).bID AS "Branch ID", 
        MAX(DEREF(ca.accNum).limitOfFreeOD) AS "limitOfFreeOD",
        COUNT(*)  AS "Owners",
        DEREF(ca.accNum).accType 
    FROM MS_CustomerAccount_Table ca
    WHERE DEREF(ca.accNum).accType = 'current'
    GROUP BY DEREF(DEREF(ca.accNum).bID).bID, DEREF(ca.accNum).accNum, DEREF(ca.accNum).accType
) CA2
ON 
    DEREF(DEREF(ca.accNum).bID).bID = CA2."Branch ID"
WHERE CA2."Owners" > 1 AND DEREF(ca.accNum).limitOfFreeOD > 0;
/

--  --  F:

SELECT 
    C1."Full name", C2."Number of mobile phones"
FROM 
    (
        SELECT 
            C.niNum,
            C.P_Name.Title || '. '|| C.P_Name.FirstName || ' ' || C.P_Name.SurName AS "Full name"
        FROM MS_Customer_Table c, Table(C.P_Phone.Mobile) t
        WHERE COLUMN_VALUE LIKE '0760%'
    ) C1

INNER JOIN
    (
        SELECT 
            C.niNum,
            COUNT(1) AS "Number of mobile phones"
        FROM MS_Customer_Table c, Table(C.P_Phone.Mobile) t
        WHERE t.COLUMN_VALUE NOT LIKE '362%'
        GROUP BY C.niNum
        HAVING COUNT(1) > 1
        ORDER BY "Number of mobile phones"
    ) C2
ON C1.niNum = C2.niNum;

--  --  G:
DESCRIBE MS_Employee_Table;

SELECT COUNT(1) AS "Number of employees"
FROM MS_Employee_Table E
WHERE 
    DEREF(E.SupervisorID).P_Name.Title = 'Mr.' AND 
    DEREF(E.SupervisorID).P_Name.FirstName = 'John' AND 
    DEREF(DEREF(E.SupervisorID).SupervisorID).P_Name.Title = 'Mrs.' AND
    DEREF(DEREF(E.SupervisorID).SupervisorID).P_Name.FirstName = 'King';
/ 

--  --  H:

SELECT e.P_Name.firstName || ' ' || e.P_Name.SURName AS "Employee_Name",
       NVL(e.employeeStatus(), '') AS "Employee_Status"
FROM MS_Employee_Table e
WHERE e.employeeStatus() IS NOT NULL
ORDER BY 
    CASE
        WHEN e.employeeStatus() = 'gold' THEN 1
        WHEN e.employeeStatus() = 'silver' THEN 2
        WHEN e.employeeStatus() = 'bronze' THEN 3
    END;
    
exit;

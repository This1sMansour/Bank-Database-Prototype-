--  Job

--  --  Head, Manager, Project Leader, Accountant, Cashier

INSERT INTO MS_Job_Table VALUES ('Head', 42000, 87000);
INSERT INTO MS_Job_Table VALUES ('Manager', 28000, 57000);
INSERT INTO MS_Job_Table VALUES ('Project Leader', 27000, 97000);
INSERT INTO MS_Job_Table VALUES ('Accountant', 24000, 60000);
INSERT INTO MS_Job_Table VALUES ('Cashier', 15000, 33000);

--  Branch

--  --  Given

INSERT INTO MS_Branch_Table VALUES (901, MS_Address_Type('Market', 'Edinburgh', 'EH1 5AB'), '01311235560');
INSERT INTO MS_Branch_Table VALUES (908, MS_Address_Type('Bridge', 'Glasgow', 'G18 1QQ'), '01413214556');

--  --  Generated

INSERT INTO MS_Branch_Table VALUES (426, MS_Address_Type('Morningside Rd', 'Edinburgh', 'EH10 5QF'), '03457213141');
INSERT INTO MS_Branch_Table VALUES (9, MS_Address_Type('Clifton Pl', 'Glasgow', 'G3 7JU'), '03457242424');
INSERT INTO MS_Branch_Table VALUES (236, MS_Address_Type('Pollokshields', 'Glasgow', 'G41 2NL'), '03457273141');
INSERT INTO MS_Branch_Table VALUES (158, MS_Address_Type('Fenwick Rd', 'Glasgow', 'G46 6XB'), '03457242474');
INSERT INTO MS_Branch_Table VALUES (185, MS_Address_Type('Baker St', 'London', 'NW1 6XB'), '03456021997');
INSERT INTO MS_Branch_Table VALUES (90, MS_Address_Type('Paul St', 'London', 'EC2A 4NE'), '02039620108');
INSERT INTO MS_Branch_Table VALUES (1, MS_Address_Type('Pound Way', 'Oxford', 'OX4 3XS'), '03456025997');
INSERT INTO MS_Branch_Table VALUES (5, MS_Address_Type('Queen St', 'Oxford', 'OX1 1EJ'), '03450808500');
INSERT INTO MS_Branch_Table VALUES (130, MS_Address_Type('High St', 'Cheltenham', 'GL50 1EW'), '03454021997');
INSERT INTO MS_Branch_Table VALUES (4, MS_Address_Type('Westgate St', 'Gloucester', 'GL1 2NW'), '03457203040');
INSERT INTO MS_Branch_Table VALUES (3, MS_Address_Type('Wharfside Street', 'Birmingham ', 'B1 1RD'), '03330048048');
INSERT INTO MS_Branch_Table VALUES (762, MS_Address_Type('Brindley Pl', 'Birmingham', 'B1 2HP'), '01214078000');
INSERT INTO MS_Branch_Table VALUES (84, MS_Address_Type('High St', 'Birmingham', 'B4 7TE'), '03457345345');
INSERT INTO MS_Branch_Table VALUES (120, MS_Address_Type('Colmore Row', 'Birmingham', 'B3 3BA'), '03457212212');
INSERT INTO MS_Branch_Table VALUES (109, MS_Address_Type('Roman Rd', 'Glasgow', 'G61 2SP'), '03457213131');

--  Account

--  --  Given 

INSERT INTO MS_Account_Table VALUES('1001', 'current', 820.50, (SELECT REF(E) FROM MS_Branch_Table E WHERE E.bID = '901'), 0.005, 800, TO_DATE('01-May-16', 'DD-MON-YY'));
INSERT INTO MS_Account_Table VALUES('1010', 'savings', 3122.20, (SELECT REF(E) FROM MS_Branch_Table E WHERE E.bID = '901'), 0.02, NULL, TO_DATE('08-Mar-15', 'DD-MON-YY'));
INSERT INTO MS_Account_Table VALUES('8002', 'current', 200, (SELECT REF(E) FROM MS_Branch_Table E WHERE E.bID = '908'), 0.005, 100, TO_DATE('05-May-12', 'DD-MON-YY'));

--  --  Generated 

--  --  -- current account

DECLARE
  branch_id VARCHAR2(20);
  i NUMBER;
  rand_date DATE;
BEGIN
  FOR r IN (
    SELECT bID FROM MS_Branch_Table
  ) LOOP
    branch_id := r.bID;
    FOR i IN 1..3 LOOP
      rand_date := TO_DATE(
                     TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2010-01-01','J'),
                                         TO_CHAR(DATE '2023-01-01','J'))
                     ),'J'
                   );
      INSERT INTO MS_Account_Table
      VALUES (
        branch_id||i,
        'current',
        DBMS_RANDOM.VALUE(10, 1000000),
        (SELECT REF(E) FROM MS_Branch_Table e WHERE e.bID = branch_id),
        DBMS_RANDOM.VALUE(0, 2),
        DBMS_RANDOM.VALUE(50, 200),
        rand_date
      );
    END LOOP;
  END LOOP;
END;
/

--  --  --  savings account

DECLARE
  branch_id VARCHAR2(20);
  i NUMBER;
  rand_date DATE;
BEGIN
  FOR r IN (
    SELECT bID FROM MS_Branch_Table
  ) LOOP
    branch_id := r.bID;
    FOR i IN 1..3 LOOP
      rand_date := TO_DATE(
                     TRUNC(
                       DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J'),
                                         TO_CHAR(DATE '2023-03-08','J'))
                     ),'J'
                   );
      INSERT INTO MS_Account_Table
      VALUES (
        branch_id||i||5,
        'savings',
        DBMS_RANDOM.VALUE(10, 1000000),
        (SELECT REF(E) FROM MS_Branch_Table e WHERE e.bID = branch_id),
        DBMS_RANDOM.VALUE(0, 2),
        NULL,
        rand_date
      );
    END LOOP;
  END LOOP;
END;
/

--  Customer

--  --  Given

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('Adam', 'Edinburgh', 'EH1 6EA'),
    MS_Name_Type('Mr', 'Jack', 'Smith'),
    MS_Phone_Type('01311112223', MS_Mobile_Nested('0781209890', '0771234567')),
    'NI810',
    '1002'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Adam', 'Edinburgh', 'EH1 6EA'),
MS_Name_Type('Ms', 'Anna', 'Smith'),
MS_Phone_Type('01311112223', MS_Mobile_Nested('0770111222')),
'NI010', '1003'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('New', 'Edinburgh', 'EH2 8XN'),
MS_Name_Type('Mr', 'Liam', 'Bain'),
MS_Phone_Type('01314425567', null),
'NI034', '1098'
);

--  --  Generated

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('10 Park Street', 'Belfast', 'BT7 2ED'),
    MS_Name_Type('Mr', 'John', 'Doe'),
    MS_Phone_Type('02890222222', MS_Mobile_Nested('07912345678', '07787654321')),
    'NI1234',
    '1004'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('1 Main Street', 'Dublin', 'D01 AB2C'),
    MS_Name_Type('Ms', 'Mary', 'Murphy'),
    MS_Phone_Type('016789012', MS_Mobile_Nested('0831234567', '0760123456')),
    'EI9876',
    '1005'
);


INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('22 George Street', 'Glasgow', 'G1 1QB'),
    MS_Name_Type('Mr', 'David', 'Brown'),
    MS_Phone_Type('01411234567', MS_Mobile_Nested('07898765432', '07987654321')),
    'SI6789',
    '1006'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('123 Main Street', 'Cork', 'T12 XY1Z'),
    MS_Name_Type('Ms', 'Sarah', 'Jones'),
    MS_Phone_Type('0215555555', null),
    'EI1234',
    '1007'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('456 Queen Street', 'Belfast', 'BT3 9DS'),
    MS_Name_Type('Mr', 'Michael', 'O\Neill'),
    MS_Phone_Type('02812345678', null),
    'NI9876',
    '1008'
);

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('23 Rose Street', 'Edinburgh', 'EH2 2PR'),
    MS_Name_Type('Ms', 'Elizabeth', 'Taylor'),
    MS_Phone_Type('01315555555', MS_Mobile_Nested('07776543210', '0760765432')),
    'NI4321',
    '1009'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('4 High Street', 'Dublin', 'D02 XY34'),
    MS_Name_Type('Mr', 'Daniel', 'Murphy'),
    MS_Phone_Type('015555555', MS_Mobile_Nested('0851234567', '0867654321')),
    'EI5678',
    '1010'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('5 George Square', 'Glasgow', 'G2 1DY'),
    MS_Name_Type('Ms', 'Fiona', 'McDonald'),
    MS_Phone_Type('01412223344', null),
    'SI3456',
    '1011'
);

INSERT INTO MS_Customer_Table VALUES
(
    MS_Address_Type('6 Main Street', 'Cork', 'T23 XY12'),
    MS_Name_Type('Mr', 'Patrick', 'O\Leary'),
    MS_Phone_Type('0217777777', MS_Mobile_Nested('0861234567', '0760888777')),
    'EI4567',
    '1012'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('London', 'SE1 2SW', 'UK'),
MS_Name_Type('Ms', 'Sophie', 'Green'),
MS_Phone_Type('02071234567', MS_Mobile_Nested('07771234567', '07981234567', '0760987654')),
'GB123', '2034'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('New York', '10001', 'USA'),
MS_Name_Type('Mrs', 'Elizabeth', 'Brown'),
MS_Phone_Type('2125550123', MS_Mobile_Nested('9175550123')),
'US123', '4321'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Paris', '75008', 'France'),
MS_Name_Type('Mr', 'Jean', 'Dupont'),
MS_Phone_Type('0147202020', MS_Mobile_Nested('0620202020', '0760111222')),
'FR123', '5687'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Berlin', '10117', 'Germany'),
MS_Name_Type('Ms', 'Maria', 'Schmidt'),
MS_Phone_Type('03012345678', MS_Mobile_Nested('01761234567', '01781234567', '0760123456')),
'DE123', '9867'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Dublin', 'D02 DY26', 'Ireland'),
MS_Name_Type('Mr', 'David', 'Murphy'),
MS_Phone_Type('014567890', MS_Mobile_Nested('0851234567')),
'IE123', '2345'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Sydney', '2000', 'Australia'),
MS_Name_Type('Ms', 'Emily', 'Chen'),
MS_Phone_Type('0298765432', MS_Mobile_Nested('0410123456', '0760567890')),
'AU123', '8754'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Toronto', 'M5H 2N2', 'Canada'),
MS_Name_Type('Mr', 'Daniel', 'Lee'),
MS_Phone_Type('4165556789', MS_Mobile_Nested('6475556789', '4375556789', '0760998877')),
'CA123', '1289'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Tokyo', '100-0005', 'Japan'),
MS_Name_Type('Ms', 'Yuka', 'Ito'),
MS_Phone_Type('0367523412', MS_Mobile_Nested('08012345678')),
'JP123', '4567'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Rio de Janeiro', '22250-040', 'Brazil'),
MS_Name_Type('Mr', 'Luiz', 'Santos'),
MS_Phone_Type('2122334455', MS_Mobile_Nested('21999887766', '0760456789')),
'BR123', '3421'
);

INSERT INTO MS_Customer_Table VALUES
(
MS_Address_Type('Cape Town', '8001', 'South Africa'),
MS_Name_Type('Ms', 'Nomonde', 'Mbele'),
MS_Phone_Type('0211234567', null),
'ZA123', '6532'
);

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('123 Main Street', 'New York', '10001'),
    MS_Name_Type('Mr', 'William', 'Johnson'),
    MS_Phone_Type('2125555555', MS_Mobile_Nested('9175555555', '6465555555', '7185555555', '2125554444', '2125553333', '0760223344')),
    'US1234',
    '2001'
);

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('456 Queen Street', 'London', 'SE1 2SW'),
    MS_Name_Type('Ms', 'Olivia', 'Smith'),
    MS_Phone_Type('02071234567', MS_Mobile_Nested('07771234567', '07981234567', '07761234567', '07871234567')),
    'GB1234',
    '2002'
);

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('1 Main Street', 'Paris', '75008'),
    MS_Name_Type('Mr', 'Thomas', 'Martin'),
    MS_Phone_Type('0147202020', MS_Mobile_Nested('0620202020', '0620202021', '0620202022', '0760889900')),
    'FR1234',
    '2003'
);


INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('22 George Street', 'Sydney', '2000'),
    MS_Name_Type('Ms', 'Isabella', 'Brown'),
    MS_Phone_Type('0298765432', MS_Mobile_Nested('0410123456', '0420123456', '0430123456', '0440123456', '0450123456', '0460123456')),
    'AU1234',
    '2004'
);

INSERT INTO MS_Customer_Table VALUES 
(
    MS_Address_Type('5 George Square', 'Toronto', 'M5H 2N2'),
    MS_Name_Type('Mr', 'Jacob', 'Lee'),
    MS_Phone_Type('4165556789', MS_Mobile_Nested('6475556789', '4375556789', '9055556789')),
    'CA1234',
    '2005'
);

--  Employee

--  --  Given

INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('Colinton', 'Edinburgh', 'EH105TT'),
    MS_Name_Type('Mrs.', 'Alison', 'Smith'),
    MS_Phone_Type('01312125555', MS_Mobile_Nested('07705623443', '07907812345')),
    'NI001',
    
    '101',
    NULL,
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '901'),
    TO_DATE('01-Feb-05', 'DD-Mon-RR'),
    50000
);
/

INSERT INTO MS_Employee_Table VALUES
(
MS_Address_Type('New', 'Edinburgh', 'EH24AB'),
MS_Name_Type('Mr.', 'John', 'William'),
MS_Phone_Type('01312031990', MS_Mobile_Nested('07902314551', '07701234567')),
'NI010',
'105',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '101'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '901'),
TO_DATE('04-Mar-07', 'DD-Mon-RR'),
40000
);
/

INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('Old', 'Edinburgh', 'EH94BB'),
    MS_Name_Type('Mr.', 'Mark', 'Slack'),
    MS_Phone_Type('01312102211', MS_Mobile_Nested()),
    'NI120',
    
    '108',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '105'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '901'),
    TO_DATE('01-Feb-15', 'DD-Mon-RR'),
    30000
);
/

--  --  --  Because the other staff and supervisor wasn't provided it will not be inserted untill they are inserted.
/*
INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('Adam', 'Edinburgh', 'EH16EA'),
    MS_Name_Type('Mr.', 'Jack', 'Smith'),
    MS_Phone_Type('01311112223', MS_Mobile_Nested('0781209890')),
    'NI810',
    
    '804',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '801'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Leader'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '908'),
    TO_DATE('05-Feb-12', 'DD-Mon-RR'),
    35000
);
*/

--  --  Generated 

INSERT INTO MS_Employee_Table VALUES
(
MS_Address_Type('Ardwell Road', 'Glasgow', 'G52 1PR'),
MS_Name_Type('Mr.', 'John', 'Johnson'),
MS_Phone_Type('01362031990', MS_Mobile_Nested('07902323551', '07706454567')),
'NI010',
'115',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '101'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '901'),
TO_DATE('14-Mar-07', 'DD-Mon-RR'),
50800
);
/

--   --  --  Create sample employees for branch with bID 1
-- Head employee
INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('123 Main St', 'Anytown', '12345'),
    MS_Name_Type('Mr.', 'John', 'Doe'),
    MS_Phone_Type('555-1234', MS_Mobile_Nested('555-5678', '555-9012')),
    'AB123456C',
    
    '001',
    NULL,
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 1),
    SYSDATE,
    62200
);

-- Manager employee
INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('456 Elm St', 'Otherville', '67890'),
    MS_Name_Type('Ms.', 'Jane', 'Smith'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-1234', '555-9012')),
    'CD456789A',
    
    '002',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '001'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 1),
    SYSDATE,
    53300
);

INSERT INTO MS_Employee_Table VALUES 
(   
    MS_Address_Type('789 Oak St', 'Anycity', '13579'),
    MS_Name_Type('Dr.', 'Bob', 'Johnson'),
    MS_Phone_Type('555-9012', MS_Mobile_Nested('555-1234', '555-5678')),
    'EF789012B',
    
    '003',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '001'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 1),
    SYSDATE,
    91500
);

INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('123 Main St', 'Los Angeles', '90001'),
    MS_Name_Type('Mr.', 'John', 'Doe'),
    MS_Phone_Type('555-1234', MS_Mobile_Nested('555-5678', '555-9012')),
    'AB123456C',
    
    '004',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '002'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 1),
    SYSDATE,
    36900
);

INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('456 Oak Ave', 'New York', '10001'),
    MS_Name_Type('Ms.', 'Jane', 'Smith'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-1234', '555-9012')),
    'DE456789F',
    
    '005',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '003'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 1),
    SYSDATE,
    26000
);

--   --  --  Create sample employees for branch with bID 3
INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('456 Main St', 'Los Angeles', '90001'),
        MS_Name_Type('Mr.', 'John', 'Doe'),
        MS_Phone_Type('555-5678', MS_Mobile_Nested('555-9012')),
        'AB123456C',
        'EMP001',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 3),
        TO_DATE('2022-01-01', 'YYYY-MM-DD'),
        74000
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('789 Main St', 'Los Angeles', '90001'),
        MS_Name_Type('Ms.', 'Jane', 'Smith'),
        MS_Phone_Type('555-2345', MS_Mobile_Nested('555-6789')),
        'CD123456E',
        'EMP002',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'EMP001'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 3),
        TO_DATE('2022-01-02', 'YYYY-MM-DD'),
        53400
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('101 Main St', 'Los Angeles', '90001'),
        MS_Name_Type('Mr.', 'Bob', 'Johnson'),
        MS_Phone_Type('555-3456', MS_Mobile_Nested('555-7890')),
        'EF123456G',
        'EMP003',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'EMP001'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 3),
        TO_DATE('2022-01-03', 'YYYY-MM-DD'),
        72000
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('111 Main St', 'Los Angeles', '90001'),
        MS_Name_Type('Ms.', 'Emily', 'Davis'),
        MS_Phone_Type('555-4567', MS_Mobile_Nested('555-8901')),
        'GH123456H',
        
        'EMP004',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'EMP001'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 3),
        TO_DATE('2022-01-04', 'YYYY-MM-DD'),
        44500
);


--   --  --  Create sample employees for branch with bID 4
INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('456 Oak St', 'New York', '10001'),
    MS_Name_Type('Ms.', 'Jane', 'Smith'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-9012', '555-3456')),
    'CD456789E',
    
    'emp005', 
    NULL, 
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('01-01-2000', 'DD-MM-YYYY'),
    47000
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('789 Elm St', 'San Francisco', '94101'),
    MS_Name_Type('Mr.', 'David', 'Lee'),
    MS_Phone_Type('555-9012', MS_Mobile_Nested('555-3456', '555-7890')),
    'EF789012G',

    
    'emp006',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp005'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('01-01-2000', 'DD-MM-YYYY'),
    35400
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('321 Pine St', 'Chicago', '60601'),
    MS_Name_Type('Ms.', 'Emily', 'Nguyen'),
    MS_Phone_Type('555-3456', MS_Mobile_Nested('555-7890', '555-1234')),
    'GH234567I',

    'emp007',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp005'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('01-01-2000', 'DD-MM-YYYY'),
    49500
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('654 Cedar St', 'Boston', '02101'),
    MS_Name_Type('Mr.', 'Daniel', 'Chen'),
    MS_Phone_Type('555-7890', MS_Mobile_Nested('555-1234', '555-5678')),
    'IJ345678K',

    'emp008',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp006'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('01-01-2000', 'DD-MM-YYYY'),
    57600
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('987 Maple St', 'Seattle', '98101'),
    MS_Name_Type('Ms.', 'Catherine', 'Chung'),
    MS_Phone_Type('555-1234', MS_Mobile_Nested('555-5678', '555-9012')),
    'KL456789M',

    'emp009',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    53900
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('741 Birch St', 'Houston', '77001'),
    MS_Name_Type('Mr.', 'William', 'Huang'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-9012', '555-3456')),
    'MN567890O',
    
    'emp010',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    45200
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('852 Spruce St', 'Miami', '33101'),
    MS_Name_Type('Ms.', 'Isabella', 'Kim'),
    MS_Phone_Type('555-9012', MS_Mobile_Nested('555-3456', '555-7890')),
    'OP678901Q',
    
    'emp011',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    50600
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('963 Pine St', 'Dallas', '75201'),
    MS_Name_Type('Mr.', 'Samuel', 'Choi'),
    MS_Phone_Type('555-3456', MS_Mobile_Nested('555-7890', '555-1234')),
    'QR789012S',

    'emp012',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    34900
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('159 Cedar St', 'Washington D.C.', '20001'),
    MS_Name_Type('Ms.', 'Olivia', 'Park'),
    MS_Phone_Type('555-7890', MS_Mobile_Nested('555-1234', '555-5678')),
    'ST234567U',

    'emp013',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    40900
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('753 Oak St', 'Philadelphia', '19101'),
    MS_Name_Type('Mr.', 'Ethan', 'Wong'),
    MS_Phone_Type('555-1234', MS_Mobile_Nested('555-5678', '555-9012')),
    'UV345678W',

    'emp014',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    29000
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('456 Pine St', 'Los Angeles', '90001'), 
    MS_Name_Type('Ms.', 'Avery', 'Ng'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-9012', '555-3456')),
    'WX456789Y',

    'emp015',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    44800
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Address_Type('456 Elm St', 'New York', '10001'),
    MS_Name_Type('Ms.', 'Alice', 'Smith'),
    MS_Phone_Type('555-5678', MS_Mobile_Nested('555-1234', '555-9012')),
    'CD234567D',

    'emp016',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp007'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 4),
    TO_DATE('2000-01-01', 'YYYY-MM-DD'),
    29300
);

--   --  --  Create sample employees for branch with bID 5

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('12 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'John', 'Smith'), 
        MS_Phone_Type('0271234567', MS_Mobile_Nested('0212345678')),
        'NI123456A',
        'emp17',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        62900
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('14 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Jane', 'Doe'), 
        MS_Phone_Type('0272345678', MS_Mobile_Nested('0213456789')),
        'NI123457B',
        'emp18',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp17'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        52400
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('16 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Jack', 'Johnson'), 
        MS_Phone_Type('0273456789', MS_Mobile_Nested('0214567890')),
        'NI123458C',
        'emp19',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp17'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        33100
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('18 Main Street', 'Napier', '4110'),
MS_Name_Type('Ms.', 'Sarah', 'Lee'),
MS_Phone_Type('0274567890', MS_Mobile_Nested('0215678901')),
'NI123459D',
'emp20',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp18'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
TO_DATE('01-01-2000', 'DD-MM-YYYY'),
60500
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Address_Type('20 Main Street', 'Napier', '4110'),
MS_Name_Type('Mr.', 'William', 'Ng'),
MS_Phone_Type('0275678901', MS_Mobile_Nested('0216789012')),
'NI123460E',
'emp21',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp18'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
TO_DATE('01-01-2000', 'DD-MM-YYYY'),
55500
);

INSERT INTO MS_Employee_Table VALUES (
MS_Address_Type('22 Main Street', 'Napier', '4110'),
MS_Name_Type('Ms.', 'Emily', 'Wong'),
MS_Phone_Type('0276789012', MS_Mobile_Nested('0217890123')),
'NI123461F',
'emp22',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp19'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
TO_DATE('01-01-2000', 'DD-MM-YYYY'),
24700
);

INSERT INTO MS_Employee_Table VALUES (
MS_Address_Type('24 Main Street', 'Napier', '4110'),
MS_Name_Type('Mr.', 'David', 'Chen'),
MS_Phone_Type('0277890123', MS_Mobile_Nested('0218901234')),
'NI123462G',
'emp23',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp19'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
TO_DATE('01-01-2000', 'DD-MM-YYYY'),
32400
);

--   --  --  Create sample employees for branch with bID 9

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('12 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Samantha', 'Smith'), 
        MS_Phone_Type('0271234567', MS_Mobile_Nested('0212345678')),
        'NI123456A',
        'emp24',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 9),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        61000
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('14 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'John', 'Doe'), 
        MS_Phone_Type('0272345678', MS_Mobile_Nested('0213456789')),
        'NI123457B',
        'emp25',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp24'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 9),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        44700
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('16 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Adam', 'Johnson'), 
        MS_Phone_Type('0273456789', MS_Mobile_Nested('0214567890')),
        'NI123458C',
        'emp26',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp25'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 9),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        42900
);

INSERT INTO MS_Employee_Table VALUES (
        MS_Address_Type('18 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Emily', 'Lee'), 
        MS_Phone_Type('0274567890', MS_Mobile_Nested('0215678901')),
        'NI123459D',
        'emp27',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp25'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 9),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        21700
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('24 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Rachel', 'Nguyen'), 
        MS_Phone_Type('0278765432', MS_Mobile_Nested('0219876543')),
        'NI123460E',
        'emp31',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp25'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        86200
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('26 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Catherine', 'Wang'), 
        MS_Phone_Type('0277654321', MS_Mobile_Nested('0218765432')),
        'NI123461F',
        'emp32',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        28600
    )
);


INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('28 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Tom', 'Lee'), 
        MS_Phone_Type('0276543217', MS_Mobile_Nested('0217654321')),
        'NI123462G',
        'emp33',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        21200
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('30 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Emily', 'Tan'), 
        MS_Phone_Type('0275432176', MS_Mobile_Nested('0216543217')),
        'NI123463H',
        'emp34',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        27300
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('20 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Olivia', 'Brown'), 
        MS_Phone_Type('0275678901', MS_Mobile_Nested('0216789012')),
        'NI123463H',
        'emp35',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        15700
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('22 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Ethan', 'Johnson'), 
        MS_Phone_Type('0276789012', MS_Mobile_Nested('0217890123')),
        'NI123464J',
        'emp36',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        30300
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('24 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Isabella', 'Davis'), 
        MS_Phone_Type('0277890123', MS_Mobile_Nested('0218901234')),
        'NI123465K',
        'emp37',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp31'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 5),
        TO_DATE('01-01-2000', 'DD-MM-YYYY'),
        31600
    )
);

--   --  --  Create sample employees for branch with bID 84

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('28 Queen Street', 'Napier', '4110'), 
        MS_Name_Type('Mrs.', 'Maria', 'Garcia'), 
        MS_Phone_Type('0277890123', MS_Mobile_Nested('0218901234')),
        'NI678912A',
        'emp38',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        50100
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('30 Queen Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'David', 'Lee'), 
        MS_Phone_Type('0278901234', MS_Mobile_Nested('0219012345')),
        'NI678913B',
        'emp39',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        68400
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('32 Queen Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Emily', 'Wang'), 
        MS_Phone_Type('0279012345', MS_Mobile_Nested('0210123456')),
        'NI678914C',
        'emp40',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        40300
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('34 Queen Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Daniel', 'Kim'), 
        MS_Phone_Type('0270123456', MS_Mobile_Nested('0211234567')),
        'NI678915D',
        'emp41',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        57400
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('20 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Samantha', 'Jones'), 
        MS_Phone_Type('0275678901', MS_Mobile_Nested('0216789012')),
        'NI123462G',
        'emp42',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        25900
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('22 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Peter', 'Chen'), 
        MS_Phone_Type('0276789012', MS_Mobile_Nested('0217890123')),
        'NI123463H',
        'emp43',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        25200
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('24 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Julia', 'Wang'), 
        MS_Phone_Type('0277890123', MS_Mobile_Nested('0218901234')),
        'NI123464I',
        'emp44',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp38'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 84),
        TO_DATE('01-01-2012', 'DD-MM-YYYY'),
        32400
    )
);

--   --  --  Create sample employees for branch with bID 90

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('10 Marine Parade', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Adam', 'Smith'), 
        MS_Phone_Type('0271234567', MS_Mobile_Nested('0212345678')),
        'NI123456A',
        'emp45',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 90),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        59800
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('12 Marine Parade', 'Glasgow', '4110'), 
        MS_Name_Type('Ms.', 'Emma', 'Jones'), 
        MS_Phone_Type('0272345678', MS_Mobile_Nested('0213456789')),
        'NI123457B',
        'emp46',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp45'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 90),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        29700
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('14 Marine Parade', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'William', 'Brown'), 
        MS_Phone_Type('0273456789', MS_Mobile_Nested('0214567890')),
        'NI123458C',
        'emp47',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp45'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 90),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        41500
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('10 High Street', 'Glasgow', 'G1 1LE'), 
        MS_Name_Type('Mr.', 'David', 'On'), 
        MS_Phone_Type('01412345678', MS_Mobile_Nested('07712345678')),
        'GL123456D',
        'emp48',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp47'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 90),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        58500
    )
);

--   --  --  Create sample employees for branch with bID 109

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('123 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mrs.', 'King', 'Brown'), 
        MS_Phone_Type('0271111111', MS_Mobile_Nested('0211111111')),
        'NI123456A',
        'emp49',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 109),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        71500
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('125 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'John', 'Smith'), 
        MS_Phone_Type('0272222222', MS_Mobile_Nested('0212222222')),
        'NI123457B',
        'emp50',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp49'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 109),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        35500
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('10 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'David', 'Brown'), 
        MS_Phone_Type('0271234567', MS_Mobile_Nested('0212345678')),
        'NZ654321D',
        'emp51',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp50'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 109),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        55600
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('12 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Ms.', 'Emily', 'Davis'), 
        MS_Phone_Type('0272345678', MS_Mobile_Nested('0213456789')),
        'NZ654322E',
        'emp52',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp50'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 109),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        26800
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('14 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'Daniel', 'Taylor'), 
        MS_Phone_Type('0273456789', MS_Mobile_Nested('0214567890')),
        'NZ654323F',
        'emp53',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp50'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 109),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        32000
    )
);

--   --  --  Create sample employees for branch with bID 120

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('22 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'David', 'Taylor'), 
        MS_Phone_Type('0275678901', MS_Mobile_Nested('0216789012')),
        'NZ123456A',
        'emp54',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 120),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        48100
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('24 Main Street', 'Napier', '4110'), 
        MS_Name_Type('Mr.', 'John', 'Smith'), 
        MS_Phone_Type('0276789012', MS_Mobile_Nested('0217890123')),
        'NZ123457B',
        'emp55',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp54'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 120),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        55500
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('Toronto', 'M5H 2N2', 'Canada'), 
        MS_Name_Type('Mr.', 'Daniel', 'Lee'), 
        MS_Phone_Type('4165556789', MS_Mobile_Nested('6475556789', '4375556789')),
        'CA123',
        'emp56',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp54'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 120),
        TO_DATE('01-01-2018', 'DD-MM-YYYY'),
        44100
    )
);


--   --  --  Create sample employees for branch with bID 130
INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('10 Marine Parade', 'Napier', '4110'),
MS_Name_Type('Ms.', 'Emily', 'Wilson'),
MS_Phone_Type('0273456789', MS_Mobile_Nested('0214567890')),
'NW234567A',
'emp57',
NULL,
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 130),
TO_DATE('01-01-2020', 'DD-MM-YYYY'),
83000
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('12 Marine Parade', 'Napier', '4110'),
MS_Name_Type('Mr.', 'Jacob', 'Anderson'),
MS_Phone_Type('0274567890', MS_Mobile_Nested('0215678901')),
'NW234568B',
'emp58',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp57'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 130),
TO_DATE('01-01-2020', 'DD-MM-YYYY'),
31500
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('Toronto', 'M5H 2N2', 'Canada'),
MS_Name_Type('Mr.', 'Daniel', 'Lee'),
MS_Phone_Type('4165556789', MS_Mobile_Nested('6475556789', '4375556789')),
'CA123',
'emp59',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp57'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 130),
TO_DATE('01-01-2020', 'DD-MM-YYYY'),
59800
)
);
--   --  --  Create sample employees for branch with bID 158

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('22 George Street', 'Sydney', '2000'),
MS_Name_Type('Ms', 'Isabella', 'Brown'),
MS_Phone_Type('0298765432', MS_Mobile_Nested('0410123456', '0420123456', '0430123456', '0440123456', '0450123456', '0460123456')),
'AU1234',
'emp60',
NULL,
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 158),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
54200
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('22 George Street', 'Sydney', '2000'),
MS_Name_Type('Ms', 'Emma', 'Garcia'),
MS_Phone_Type('0498765432', MS_Mobile_Nested('0410111111', '0420222222', '0430333333', '0440444444')),
'AU1235',
'emp61',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp60'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 158),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
42600
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('22 George Street', 'Sydney', '2000'),
MS_Name_Type('Mr.', 'David', 'Jones'),
MS_Phone_Type('0398765432', MS_Mobile_Nested('0410777777', '0420888888', '0430999999')),
'AU1236',
'emp62',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp60'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 158),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
37600
)
);

--   --  --  Create sample employees for branch with bID 185

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('1 Napier Street', 'Napier', '4110'),
MS_Name_Type('Mr.', 'John', 'Smith'),
MS_Phone_Type('068759432', MS_Mobile_Nested('0210987654', '0220987654', '0230987654')),
'NZ123',
'emp63',
NULL,
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 185),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
86600
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('Paris', '75008', 'France'),
MS_Name_Type('Mr', 'Jean', 'Dupont'),
MS_Phone_Type('0147202020', MS_Mobile_Nested('0620202020')),
'FR123',
'emp64',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp63'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 185),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
54600
)
);

INSERT INTO MS_Employee_Table VALUES (
MS_Employee_Type(
MS_Address_Type('3 Napier Street', 'Napier', '4110'),
MS_Name_Type('Ms.', 'Olivia', 'Wilson'),
MS_Phone_Type('068234567', MS_Mobile_Nested('0213456789', '0223456789', '0233456789')),
'NZ345',
'emp65',
(SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp63'),
(SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
(SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 185),
TO_DATE('01-01-2022', 'DD-MM-YYYY'),
35100
)
);


--   --  --  Create sample employees for branch with bID 236

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('50 Emerson Street', 'Napier', '4110'),
    MS_Name_Type('Mr.', 'John', 'Smith'),
    MS_Phone_Type('06-123-4567', MS_Mobile_Nested('021-123-4567', '027-123-4567')),
    'NZ5678',
    'emp66',
    NULL,
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 236),
    TO_DATE('01-01-2022', 'DD-MM-YYYY'),
    76600
  )
);

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('10 Herschell Street', 'Napier', '4110'),
    MS_Name_Type('Ms', 'Samantha', 'Williams'),
    MS_Phone_Type('06-234-5678', MS_Mobile_Nested('021-234-5678', '027-234-5678')),
    'NZ6789',
    'emp67',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp66'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 236),
    TO_DATE('01-01-2022', 'DD-MM-YYYY'),
    46300
  )
);

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('25 Tennyson Street', 'Napier', '4110'),
    MS_Name_Type('Mr.', 'David', 'Johnson'),
    MS_Phone_Type('06-345-6789', MS_Mobile_Nested('021-345-6789', '027-345-6789')),
    'NZ7890',
    'emp68',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp66'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 236),
    TO_DATE('01-01-2022', 'DD-MM-YYYY'),
    34400
  )
);


--   --  --  Create sample employees for branch with bID 426

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('19 Shakespeare Road', 'Napier', '4110'),
        MS_Name_Type('Mr.', 'William', 'Smith'),
        MS_Phone_Type('068743218', MS_Mobile_Nested('027843219', '027643218', '027943217')),
        'NZ1234',
        'emp69',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 426),
        TO_DATE('01-01-2022', 'DD-MM-YYYY'),
        65000
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('31 Dalton Street', 'Napier', '4110'),
        MS_Name_Type('Ms', 'Olivia', 'Johnson'),
        MS_Phone_Type('068556789', MS_Mobile_Nested('027845678', '027645679', '027945678')),
        'NZ2345',
        'emp70',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp69'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 426),
        TO_DATE('01-01-2022', 'DD-MM-YYYY'),
        33100
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('6 Main Street', 'Cork', 'T23 XY12'),
        MS_Name_Type('Mr', 'Patrick', 'O\Leary'),
        MS_Phone_Type('0217777777', MS_Mobile_Nested('0861234567')),
        'EI4567',
        'emp71',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp70'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 426),
        TO_DATE('01-01-2022', 'DD-MM-YYYY'),
        45200
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('56 Carlyle Street', 'Napier', '4110'),
        MS_Name_Type('Mr.', 'Lucas', 'Brown'),
        MS_Phone_Type('068987654', MS_Mobile_Nested('027843215', '027643214', '027943213')),
        'NZ4567',
        'emp72',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp69'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 426),
        TO_DATE('01-01-2022', 'DD-MM-YYYY'),
        21600
    )
);


--   --  --  Create sample employees for branch with bID 762

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('42 Elm Street', 'Napier', '4110'),
        MS_Name_Type('Ms', 'Olivia', 'Jones'),
        MS_Phone_Type('06-843-8572', MS_Mobile_Nested('027-123-4567', '021-234-5678')),
        'NZ1290',
        'emp73',
        NULL,
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 762),
        TO_DATE('01-01-2023', 'DD-MM-YYYY'),
        60000
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('55 High Street', 'Napier', '4110'),
        MS_Name_Type('Mr', 'Ethan', 'Wang'),
        MS_Phone_Type('06-843-3456', MS_Mobile_Nested('021-345-6789', '027-456-7890')),
        'NZ1289',
        'emp74',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp73'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 762),
        TO_DATE('01-01-2023', 'DD-MM-YYYY'),
        47300
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('33 Main Road', 'Napier', '4112'),
        MS_Name_Type('Ms', 'Sophia', 'Lee'),
        MS_Phone_Type('06-842-1234', MS_Mobile_Nested('021-987-6543', '027-876-5432')),
        'NZ1288',
        'emp75',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp73'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 762),
        TO_DATE('01-01-2023', 'DD-MM-YYYY'),
        30100
    )
);

INSERT INTO MS_Employee_Table VALUES (
    MS_Employee_Type(
        MS_Address_Type('21 Broadway', 'Napier', '4110'),
        MS_Name_Type('Mr', 'William', 'Smith'),
        MS_Phone_Type('06-845-6789', MS_Mobile_Nested('027-765-4321', '021-654-3210')),
        'NZ1287',
        'emp76',
        (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp73'),
        (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
        (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 762),
        TO_DATE('01-01-2023', 'DD-MM-YYYY'),
        23600
    )
);


--   --  --  Create sample employees for branch with bID 908

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('456 High St', 'Napier', '4110'),
    MS_Name_Type('Ms', 'Samantha', 'Jones'),
    MS_Phone_Type('06-765-4321', MS_Mobile_Nested('021-012-3456', '021-112-3456')),
    'NZ1234',
    '801',
    NULL,
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Head'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 908),
    TO_DATE('01-01-2023', 'DD-MM-YYYY'),
    64100
  )
);

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('5 George Square', 'Toronto', 'M5H 2N2'),
    MS_Name_Type('Mr', 'Jacob', 'Lee'),
    MS_Phone_Type('4165556789', MS_Mobile_Nested('6475556789', '4375556789', '9055556789')),
    'CA14',

    'emp78',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '801'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Manager'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 908),
    TO_DATE('01-01-2023', 'DD-MM-YYYY'),
    38300
  )
);

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('567 King St', 'Napier', '4110'),
    MS_Name_Type('Ms', 'Emily', 'Wilson'),
    MS_Phone_Type('06-444-4444', MS_Mobile_Nested('021-432-3456', '021-532-3456')),
    'NZ9101',
    'emp79',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp78'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Accountant'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 908),
    TO_DATE('01-01-2023', 'DD-MM-YYYY'),
    30900
  )
);

INSERT INTO MS_Employee_Table VALUES (
  MS_Employee_Type(
    MS_Address_Type('234 Elm St', 'Napier', '4110'),
    MS_Name_Type('Mr', 'Thomas', 'Nguyen'),
    MS_Phone_Type('06-222-2222', MS_Mobile_Nested('021-632-3456', '021-732-3456')),
    'NZ1112',
    'emp80',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = 'emp78'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Cashier'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = 908),
    TO_DATE('01-01-2023', 'DD-MM-YYYY'),
    17900
  )
);


INSERT INTO MS_Employee_Table VALUES 
(
    MS_Address_Type('Adam', 'Edinburgh', 'EH16EA'),
    MS_Name_Type('Mr', 'Jack', 'Smith'),
    MS_Phone_Type('01311112223', MS_Mobile_Nested('0781209890')),
    'NI810',
    
    '804',
    (SELECT REF(e) FROM MS_Employee_Table e WHERE e.empID = '801'),
    (SELECT REF(j) FROM MS_Job_Table j WHERE j."Position" = 'Project Leader'),
    (SELECT REF(b) FROM MS_Branch_Table b WHERE b.bID = '908'),
    TO_DATE('05-Feb-12', 'DD-Mon-RR'),
    35000
);
/

--  Customer Account

--  --  Given

INSERT INTO MS_CustomerAccount_Table VALUES 
(
    (SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1002'),
    (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1001')
);
/

INSERT INTO MS_CustomerAccount_Table VALUES 
(
    (SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1002'),
    (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1010')
);
/

INSERT INTO MS_CustomerAccount_Table VALUES 
(
    (SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1003'),
    (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1010')
);
/

INSERT INTO MS_CustomerAccount_Table VALUES 
(
    (SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1098'),
    (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '8002')
);
/

--  --  Generated

--  --  --  Savings Account

INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90115'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '925'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '23635'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '76215'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '8435'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '10915'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1006'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '42615'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1006'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '42635'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1006'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '915'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1006'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '8425'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1007'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '315'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '18525'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '13015'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '15835'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '13025'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '12025'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1011'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '335'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1012'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90125'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1012'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90135'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1012'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9025'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1012'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '10925'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1012'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '10935'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2034'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '15825'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90825'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '18515'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '515'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '13035'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '435'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '12015'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '9867'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '135'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2345'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '12035'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '8754'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '23615'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '8754'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '415'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '4567'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '23625'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '525'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '42625'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9035'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '425'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '8415'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2001'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90835'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2001'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '935'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2001'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '15815'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2001'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '76235'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2003'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '90815'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9015'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '115'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '325'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '18535'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '125'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '535'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '76225'));

--  --  --  Current Account

INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '51'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1301'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1301'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9081'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9081'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9081'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '53'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9013'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9083'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1581'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1583'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '51'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1301'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1007'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9081'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1007'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '91'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1007'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '903'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1007'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '32'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '908'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '4261'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '4262'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '93'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '842'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1008'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1203'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '2363'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '901'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '12'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1302'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1303'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1010'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1202'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1011'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '92'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1011'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '41'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '1011'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '7623'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2034'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '52'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '5687'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1853'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '9867'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '843'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '9867'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1093'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2345'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1851'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2345'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '902'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2345'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '42'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2345'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1092'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '4567'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9012'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '4567'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '2361'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '158'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '11'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '43'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '33'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '3421'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1091'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '9011'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '2362'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '6532'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '841'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2001'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '13'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1852'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '31'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '7622'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2004'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '1201'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '426'));
INSERT INTO MS_CustomerAccount_Table VALUES ((SELECT REF(c) FROM MS_Customer_Table c WHERE c.CustID = '2005'), (SELECT REF(a) FROM MS_Account_Table a WHERE a.accNum = '7621'));

exit;
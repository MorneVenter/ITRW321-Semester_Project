-----------------Subype Fact Table

-----------------Populate Subscription Dimension

INSERT INTO dim_subscription
SELECT  c.subscription_type AS "Subscription_Type",
        p.firstname ||' '|| p.LastName AS "Name"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.subscription_type,
            p.firstname ||' '|| p.LastName;

-----------------Populate Customer Dimension

INSERT INTO DIM_CUSTOMER
SELECT  c.personid AS "Person_ID",
        p.birth_date AS "Birth_Date"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.personid,
            p.birth_date;


-----------------Populate Subtypes Fact Table

INSERT INTO fact_subtypes
SELECT  p.personid AS "Person_ID",
        c.subscription_type AS "Subscription_Type"
FROM    PERSON p,
        CUSTOMER c,
        SUBSCRIPTION s
WHERE   c.PersonID = p.PersonID
        AND c.subscription_type = s.subscription_type
GROUP BY    p.personid,
            c.subscription_type;

-----------------Salary Paid Fact Table

-----------------Populate Employee Dimension

INSERT INTO DIM_EMPLOYEE
SELECT  p.personid AS "Person_ID",
        e.positiontype AS "Employee Position Type"
FROM    PERSON p,
        EMPLOYEE e
WHERE   e.PersonID = p.PersonID
GROUP BY    p.personid,
            e.positiontype;

-----------------Populate Salary Dimension

INSERT INTO DIM_SALARY
SELECT  s.salaryid AS "Salary_ID",
        AVG(s.amount) AS "Salary_Amount"
FROM    PERSON p,
        EMPLOYEE e,
        SALARY s
WHERE   e.PersonID = p.PersonID AND
        s.personid = e.personid
GROUP BY    s.salaryid;

-----------------Populate SalaryPaid Fact Table

INSERT INTO FACT_SALARYPAID
SELECT  p.personid AS "Person_ID",
        s.salaryid AS "Salary_ID",
        t.timeid AS "Time_ID"
FROM    PERSON p,
        EMPLOYEE e,
        SALARY s,
        DIM_TIME t
WHERE   e.PersonID = p.PersonID
        AND s.personid = e.personid
GROUP BY    p.personid,
            s.salaryid,
            t.time_id;

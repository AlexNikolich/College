SET SERVEROUTPUT ON




DECLARE
  v_averageSalary     NUMBER(7,2);
  v_comment           VARCHAR2(100);
BEGIN 
DBMS_OUTPUT.PUT_LINE('EmpID ' || 'DeptId ' || 'Salary ' || 'AvgSalary ' || 'Comment' );
DBMS_OUTPUT.PUT_LINE('===== ' || '====== ' || '====== ' || '========= ' || '=======' );
DBMS_OUTPUT.PUT_LINE('=====================================================================================================' );
  
  FOR emp_rec IN(Select * from EMPLOYEES)
  LOOP
    SELECT AVG(salary) INTO v_averageSalary FROM employees WHERE department_id = emp_rec.department_id;
    IF emp_rec.department_id IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Employee with ID ' || emp_rec.employee_id || ' DO NOT have department ID!!!');
    ELSE
      IF emp_rec.salary > v_averageSalary THEN
        v_comment := 'Employee salary is more than average salary for the department';
      ELSIF emp_rec.salary < v_averageSalary THEN
        v_comment := 'Employee salary is less than average salary for the department';
      ELSE
        v_comment := 'Employee salary is equal to average salary for the department';
      END IF;
    DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id || '     ' || emp_rec.department_id || '  ' || emp_rec.salary || '   ' || v_averageSalary || '    ' || v_comment);
    END IF;
  END LOOP;
END;



--------------------------------------------------------------------------------------------------------------------------




DECLARE
   CURSOR country_cur IS
      SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID
        FROM countries;

   CURSOR location_cur (p_country_id CHAR) IS
      SELECT *
        FROM locations
       WHERE COUNTRY_ID = p_country_id;

  TYPE t_location_table IS TABLE OF
    locations%ROWTYPE
    INDEX BY PLS_INTEGER;
t_location t_location_table;

  TYPE t_country_table IS TABLE OF
    countries%ROWTYPE
    INDEX BY PLS_INTEGER;
t_countries t_country_table;
v_flag NUMBER(3) := 1;
v_num NUMBER(3) := 1;
   /* Create an array to hold country names.
      Create a variable to refer the array holding country names.
   */ 
   /* Create an array to hold records from LOCATIONS table.
      Create a variable to refer the array holding LOCATIONS records.
   */ 
BEGIN
    -- INSERT ELEMENTS IN FIRST ARRAY
    FOR country_rec IN country_cur
      LOOP
        t_countries(v_flag).country_id := country_rec.country_id;
        t_countries(v_flag).country_name := country_rec.country_name;
        t_countries(v_flag).region_id := country_rec.region_id;
        v_flag := v_flag +1;
    END LOOP;
    
    v_flag := 1;
   -- INSERT ELEMENTS IN SECOND ARRAY
  FOR i IN 1..t_countries.COUNT
  LOOP
        FOR location_rec IN location_cur(t_countries(i).country_id)
          LOOP
              t_location(v_flag) := location_rec;
            v_flag := v_flag +1;
        END LOOP;
  END LOOP;
  
  --DISPLAY INFO
  FOR i IN 1..t_countries.COUNT
    LOOP
      DBMS_OUTPUT.PUT_LINE('Country Name (' || i || '): ' || t_countries(i).country_name );
    FOR y IN 1..t_location.COUNT
    LOOP
      IF t_countries(i).country_id = t_location(y).country_id THEN
        DBMS_OUTPUT.PUT_LINE('location (' || v_num || '): ' || t_location(y).street_address || ' , ' || t_location(y).city || ' , ' || t_location(y).state_province);
        v_num := v_num +1;
      END IF;
    END LOOP;
    v_num := 1;
      DBMS_OUTPUT.PUT_LINE('=======================================================');
  
  END LOOP;
END;









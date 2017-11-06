--------------------------------------
----         ASSIGNMENT 1         ----
---- STUDENT: Aleksandar Nikolic  ----
----        ID: 040366148         ----
--------------------------------------

SET SERVEROUTPUT ON

----------------
-- QUESTION 1 --
----------------
DECLARE
TYPE customer_rec is RECORD
  (
  Name      VARCHAR2(15) := 'Customer',
  Phone     VARCHAR2(15),
  areaCode  VARCHAR2(3),
  prefix    VARCHAR(3),
  num       VARCHAR(4));
cust_rec customer_rec;

BEGIN
  cust_rec.Phone := 'Home Phone';
  cust_rec.areaCode := '905';
  cust_rec.prefix := '804';
  cust_rec.num := '9090';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num);
  
  cust_rec.Phone := 'Office Phone';
  cust_rec.areaCode := '416';
  cust_rec.prefix := '788';
  cust_rec.num := '9191';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Mobile Phone';
  cust_rec.areaCode := '965';
  cust_rec.prefix := '856';
  cust_rec.num := '9292';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Cottage Phone';
  cust_rec.areaCode := '905';
  cust_rec.prefix := '259';
  cust_rec.num := '9393';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Pager Phone';
  cust_rec.areaCode := '417';
  cust_rec.prefix := '794';
  cust_rec.num := '9797';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
    cust_rec.Phone := 'Fax Phone';
  cust_rec.areaCode := '450';
  cust_rec.prefix := '169';
  cust_rec.num := '9898';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
END;


----------------
-- QUESTION 2 --
----------------
DECLARE
v_count NUMBER(5) :=0;
v_counter_loop NUMBER(5) := 10;
v_counter NUMBER(5) := 1;
v_averageSalary NUMBER(8,2) :=0;
v_totalSalary employees.salary%TYPE;
v_numOfEmployees NUMBER(4) :=0;

  TYPE dep_table IS TABLE OF
    departments%ROWTYPE
    INDEX BY PLS_INTEGER;
    dep_tab dep_table;
    
BEGIN 
SELECT COUNT(*) INTO v_count FROM departments;
v_count := v_count * 10;

WHILE v_counter_loop <= v_count 
  LOOP
   SELECT * INTO dep_tab(v_counter) FROM departments WHERE department_id = v_counter_loop;
    v_counter := v_counter + 1;
    v_counter_loop := v_counter_loop + 10;
  END LOOP;
   
  FOR i IN dep_tab.FIRST..dep_tab.LAST
  LOOP    
      SELECT COUNT(*) INTO v_numOfEmployees FROM employees WHERE department_id = dep_tab(i).department_id;
      IF v_numOfEmployees > 0 THEN
        DBMS_OUTPUT.PUT_LINE(dep_tab(i).department_name);
        DBMS_OUTPUT.PUT_LINE('Nmber of Employees: ' || v_numOfEmployees);
        SELECT AVG(salary) INTO v_averageSalary FROM employees WHERE DEPARTMENT_ID = dep_tab(i).department_id;
        DBMS_OUTPUT.PUT_LINE('Average Salary: ' || v_averageSalary);
        SELECT SUM(salary) INTO v_totalSalary FROM employees WHERE DEPARTMENT_ID = dep_tab(i).department_id;
        DBMS_OUTPUT.PUT_LINE('Total Salary: ' || v_totalSalary);
        DBMS_OUTPUT.PUT_LINE('');
      ELSE
        DBMS_OUTPUT.PUT_LINE(dep_tab(i).department_name || ' has no employees');
      END IF;
  END LOOP;

END;



----------------
-- QUESTION 3 --
----------------

-- Create table location_temp --
CREATE TABLE LOCATIONS_TEMP(
	LOCATION_ID NUMBER(4,0),
	STREET_ADDRESS VARCHAR2(40),
	POSTAL_CODE VARCHAR2(12),
	CITY VARCHAR2(30),
	STATE_PROVINCE VARCHAR2(25),
	COUNTRY_ID VARCHAR2(2),
	OPERATION VARCHAR2(1)
);

-- Populate table location_temp
INSERT INTO LOCATIONS_TEMP -- row exists
VALUES (1000, 'Kamenicki put - UPDATE', 10934, 'Petrovaradin', null, 'IT', 'U');
INSERT INTO LOCATIONS_TEMP -- row doesn't exist
VALUES (1050, 'Narodnog fronta - INSERT BY UPDATE', 21000, 'Novi Sad', null, 'IT', 'U');
INSERT INTO LOCATIONS_TEMP -- row exists
VALUES (1100, '93091 Calle della Testa', 10934, 'Venice', null, 'IT', 'D'); 
INSERT INTO LOCATIONS_TEMP -- row doesn't exist
VALUES (1150, '93091 Calle della Testa', 10934, 'Venice', null, 'IT', 'D'); 
INSERT INTO LOCATIONS_TEMP -- row exists
VALUES (1200, '93091 Calle della Testa', 10934, 'Venice', null, 'JP', 'I'); 
INSERT INTO LOCATIONS_TEMP -- row doesn't exist
VALUES (1250, 'Futoski put - INSERT', 10934, 'Futog', null, 'JP', 'I'); 
INSERT INTO LOCATIONS_TEMP -- Operator X doesn't exist
VALUES (1300, '93091 Calle della Testa', 10934, 'Venice', null, 'JP', 'X'); 

DECLARE

v_counter NUMBER(8) :=1;
v_counter_loop NUMBER(8) :=1000;
v_counter_loop_end NUMBER(8) :=0;
v_flag NUMBER(8) :=0;

TYPE location_temp_record is RECORD
  (
    locat_temp_rec locations_temp%ROWTYPE);
loc_temp_rec location_temp_record;

TYPE location_temp_table IS TABLE OF
    locations_temp%ROWTYPE
    INDEX BY PLS_INTEGER;
loc_temp_tab location_temp_table;

BEGIN 
SELECT COUNT(*) INTO v_counter_loop_end FROM locations_temp;
v_counter_loop_end := v_counter_loop_end *50 + 1000;

WHILE v_counter_loop < v_counter_loop_end
  LOOP
   SELECT * INTO loc_temp_rec.locat_temp_rec FROM locations_temp WHERE location_id = v_counter_loop;
   loc_temp_tab(v_counter) := loc_temp_rec.locat_temp_rec;
    v_counter := v_counter + 1;
    v_counter_loop := v_counter_loop + 50;
  END LOOP;
   
   
  FOR i IN loc_temp_tab.FIRST..loc_temp_tab.LAST
  LOOP 
      IF loc_temp_tab(i).operation = 'D' THEN
            v_flag :=0;
                BEGIN    
                SELECT location_id INTO v_flag FROM locations WHERE location_id = loc_temp_tab(i).location_id;
                 EXCEPTION
                 when no_data_found then
                 v_flag := 0;
                 END;
              IF v_flag >0 THEN
                DELETE FROM LOCATIONS
                WHERE LOCATION_ID = v_flag;
                DBMS_OUTPUT.PUT_LINE('Delete row in location table with ID: ' || v_flag);
              ELSE
                DBMS_OUTPUT.PUT_LINE('There is NO location with this ID: ' || loc_temp_tab(i).location_id || ' an the row is NOT deleted');
              END IF;
              
        ELSIF loc_temp_tab(i).operation = 'I' THEN 
        v_flag :=0;
           BEGIN    
            SELECT location_id INTO v_flag FROM LOCATIONS WHERE location_id = loc_temp_tab(i).location_id;
             EXCEPTION
             when no_data_found then
             v_flag := 0;
             END;
          IF v_flag <1 THEN           
            INSERT INTO LOCATIONS
            VALUES(loc_temp_tab(i).location_id,loc_temp_tab(i).street_address, loc_temp_tab(i).postal_code, loc_temp_tab(i).city, loc_temp_tab(i).state_province, loc_temp_tab(i).country_id);
            DBMS_OUTPUT.PUT_LINE('Insert Row in location with ID: ' || loc_temp_tab(i).location_id);
          ELSE
            DBMS_OUTPUT.PUT_LINE('This row ALREADY exists with this location ID: ' || loc_temp_tab(i).location_id);
          END IF;   
          
        ELSIF loc_temp_tab(i).operation = 'U' THEN 
        v_flag :=0;
           BEGIN    
            SELECT location_id INTO v_flag FROM LOCATIONS WHERE location_id = loc_temp_tab(i).location_id;
             EXCEPTION
             when no_data_found then
             v_flag := 0;
             END;
          IF v_flag <1 THEN

            INSERT INTO LOCATIONS
            VALUES(loc_temp_tab(i).location_id,loc_temp_tab(i).street_address, loc_temp_tab(i).postal_code, loc_temp_tab(i).city, loc_temp_tab(i).state_province, loc_temp_tab(i).country_id);
            DBMS_OUTPUT.PUT_LINE('There is no such a location with ID ' || loc_temp_tab(i).location_id || ', so the row will be insert.'); 
          ELSE
            UPDATE locations
                  SET street_address = loc_temp_tab(i).street_address, 
                  postal_code = loc_temp_tab(i).postal_code, 
                  city = loc_temp_tab(i).city, 
                  state_province = loc_temp_tab(i).state_province, 
                  country_id = loc_temp_tab(i).country_id 
                  WHERE location_id = loc_temp_tab(i).location_id;
          DBMS_OUTPUT.PUT_LINE('Update Row in location with ID: ' || loc_temp_tab(i).location_id);  
          END IF;
          
      ELSE
        DBMS_OUTPUT.PUT_LINE('There is NO OPERATION: ' || loc_temp_tab(i).operation);       
              
      END IF; 
      
  END LOOP;
END;

--commit;
--rollback;
--drop table locations_temp;

  
  
  
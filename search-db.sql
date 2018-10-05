set serveroutput on
DECLARE
      what_to_search varchar2(100):= '%EX00009%';
      match_count INTEGER;
      w varchar2(4000);
BEGIN
  FOR t IN (SELECT owner, table_name, column_name, data_type
              FROM all_tab_columns
--                WHERE table_name like 'RBAC_%'
              WHERE owner = 'GERARD'
              and ( data_type LIKE '%CHAR%' or data_type in ('CLOB', 'BLOB'))
              ) LOOP

    if t.data_type like '%LOB' then
      w:= 'DBMS_LOB.SUBSTR('||t.column_name||', 2000, 1)';
    elsif (t.data_type LIKE '%CHAR%') then
      w:= t.column_name;
    else
      w:= t.column_name||'||'' ''';
    end if;
    
    EXECUTE IMMEDIATE
      'SELECT COUNT(*) FROM ' || t.owner || '.' || t.table_name ||
      ' WHERE upper(' || w || ') like upper(:1)'
    INTO match_count
    USING what_to_search;

    IF match_count > 0 THEN
      dbms_output.put_line( t.table_name ||'.'||t.column_name||' ('||t.data_type||') = '||match_count );
    END IF;

  END LOOP;

END;
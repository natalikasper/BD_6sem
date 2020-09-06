--1
create table Report (
    id NUMBER ,
    xm XMLTYPE);    
--2

create or replace function CreateXML
(table_name in varchar2,
word in varchar2) 
return xmltype 
as
  xml xmltype;
  a      NVARCHAR2(500);
  b      NVARCHAR2(600);
begin
  a:='select SYSTIMESTAMP, COUNT(FACULTY.FACULTY), PULPIT.PULPIT, FACULTY.FACULTY from FACULTY
  inner join PULPIT
				on FACULTY.FACULTY = PULPIT.FACULTY 
			  inner join  TEACHER
				on TEACHER.PULPIT = PULPIT.PULPIT
        and PULPIT.FACULTY = ''';
   b:=a || word ||  ''' group by FACULTY.FACULTY, PULPIT.PULPIT '  ;
        
  dbms_output.put_line(b);
        
  select xmlelement("XML",
      xmlelement(evalname(table_name),
      dbms_xmlgen.getxmltype( b )))
  into xml
  from dual;
  return xml;
end CreateXML;

create or replace procedure expsessions as
 CTX    dbms_xmlgen.ctxHandle;
 XML    CLOB;
BEGIN
CTX := DBMS_XMLGEN.NEWCONTEXT('select PULPIT.PULPIT, FACULTY.FACULTY from FACULTY
        inner join PULPIT
				on FACULTY.FACULTY = PULPIT.FACULTY 
			  inner join  TEACHER
				on TEACHER.PULPIT = PULPIT.PULPIT'); 
XML := dbms_xmlgen.getXML(CTX);
dbms_output.put_line(XML);
end;

exec expsessions;

--3
CREATE OR REPLACE PROCEDURE insertProcedure(
    id integer,
    xml IN XMLTYPE)
IS
BEGIN
  INSERT INTO Report (id, xm) 
  VALUES (id, xml);
  COMMIT;
END;

begin 
    insertProcedure(1, CreateXML('SUBJECT', 'ясад'));
    insertProcedure(2, CreateXML('SUBJECT', '???'));
end;

--4
create index xml_index on Report(extractvalue(xm,'/XML/SUBJECT/ROWSET/ROW/PULPIT[0]/text()')); 

--5
create or replace procedure findProcedure(word  in VARCHAR2, aa out VARCHAR2 ) 
is
begin
      select r.xm.GETSTRINGVAL() xml
      into aa from report r
      where r.xm.EXISTSNODE('/XML/SUBJECT/ROWSET/ROW[FACULTY='''||word||''']')=1;
end findProcedure;
-----------
select * from report;



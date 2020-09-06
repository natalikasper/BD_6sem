use publishing_house
go

--1.������� ������� (id, xml)
create table Report(
id INTEGER primary key identity(1,1),
xml_column XML
);

select * from Report;
select * from orders;
--2. ������� ��������� ��������� XML
--XML �.���.�-� ��� ������� 3 ����.����, ��������.����� � ����� �������
go
create procedure generateXML as
	declare @x XML 
	set @x = ( Select Name_client [��� �������], Address_client [������], GETDATE() [����] from client 
		join orders ord on client.Id_client = ord.Client join production prod on
			ord.Id_order = prod.Id_prod for xml auto)
	select @x [XML]
go
exec generateXML;

--3. ������� ��������� ������� ����� XML � Report
go
create procedure InsertInReport as
	declare @s XML
	set @s = ( Select Name_client [��� �������], Address_client [������], GETDATE() [����] from client 
		join orders ord on client.Id_client = ord.Client join production prod on
			ord.Id_order = prod.Id_prod for xml raw);
	insert into Report values (@s);
go
exec InsertInReport;
select * from Report;

--4. ������� ������ ��� XML-�������� � ������� Report
create primary xml index My_XML_Index on Report(xml_column)

create xml index Second_XML_Index on Report(xml_column)
using xml index My_XML_Index for path

--5. ������� ��������� ���������� ����.��-��� �/��� ��������� �� XML-�������
select * from Report;

go
create procedure SelectData
as
select xml_column.query('/row') from Report for xml auto, type;
go
exec SelectData;
select * from Report;




select xml_column.value('(/row/@����)[1]', 'nvarchar(max)') from Report for xml auto, type;

select r.Id,
	m.c.value('@����', 'nvarchar(max)') as [date]
from Report as r
	outer apply r.xml_column.nodes('/row') as m(c)

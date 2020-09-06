use publishing_house
go

--1.создать таблицу (id, xml)
create table Report(
id INTEGER primary key identity(1,1),
xml_column XML
);

select * from Report;
select * from orders;
--2. Создать процедуру генерации XML
--XML д.сод.д-е как минимум 3 соед.табл, промежут.итоги и штамп времени
go
create procedure generateXML as
	declare @x XML 
	set @x = ( Select Name_client [Имя клиента], Address_client [Адресс], GETDATE() [Дата] from client 
		join orders ord on client.Id_client = ord.Client join production prod on
			ord.Id_order = prod.Id_prod for xml auto)
	select @x [XML]
go
exec generateXML;

--3. создать процедуру вставки этого XML в Report
go
create procedure InsertInReport as
	declare @s XML
	set @s = ( Select Name_client [Имя клиента], Address_client [Адресс], GETDATE() [Дата] from client 
		join orders ord on client.Id_client = ord.Client join production prod on
			ord.Id_order = prod.Id_prod for xml raw);
	insert into Report values (@s);
go
exec InsertInReport;
select * from Report;

--4. создать индекс над XML-столбцом в таблице Report
create primary xml index My_XML_Index on Report(xml_column)

create xml index Second_XML_Index on Report(xml_column)
using xml index My_XML_Index for path

--5. создать процедуру извлечения знач.эл-тов и/или атрибутов из XML-сталбца
select * from Report;

go
create procedure SelectData
as
select xml_column.query('/row') from Report for xml auto, type;
go
exec SelectData;
select * from Report;




select xml_column.value('(/row/@Дата)[1]', 'nvarchar(max)') from Report for xml auto, type;

select r.Id,
	m.c.value('@Дата', 'nvarchar(max)') as [date]
from Report as r
	outer apply r.xml_column.nodes('/row') as m(c)

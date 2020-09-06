use master;
exec sp_configure 'clr enabled', 1;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE; 
EXEC sp_configure 'clr strict security', 0; 
RECONFIGURE;

use publishing_house;
create assembly my_assembly from 'F:\6 семестр\БД\Лабораторные\lab3\Database1\Database1\bin\Debug\Database1.dll';
go

create procedure GetOrders (@datastart datetime, @dataend datetime)
as external name my_assembly.StoredProcedures.AllOrders;
go

exec GetOrders @datastart = '17-02-2020', @dataend = '25-12-2020';
go

--
create type adres
external name my_assembly.SqlUserDefinedType1
go

declare @s adres
set @s = 'Щучин Заводская 7'
select @s.ToString();
go 

--
create procedure GetPivot
as external name my_assembly.StoredProcedures.SqlStoredProcedure2;
go

exec GetPivot;

select * from orders;
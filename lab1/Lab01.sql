--издательство
create database publishing_house;
drop database publishing_house;

use publishing_house; 

--др
create table Author(
Surname nvarchar(20) primary key,
birthday date,
Phone nvarchar(10)
)

create table Type_of_prod(
id int,
Type_prod nvarchar(15) primary key
)

create table production(
Id_prod int IDENTITY(1,1) primary key,
Type_prod nvarchar(15),
Title_prod nvarchar(50),
Author_prod nvarchar(20)
FOREIGN KEY (Author_prod) REFERENCES Author(Surname) on delete cascade,
FOREIGN KEY (Type_prod) REFERENCES Type_of_prod(Type_prod) on delete cascade
);

create table client(
Id_client int IDENTITY(1,1) primary key,
Name_client nvarchar(50),
--Telephone nvarchar(10),
Address_client nvarchar(50)
);

create table orders(
Id_order int IDENTITY(1,1) primary key,
Date_order_start date,
Date_order_end date,
Client int,
Production int,
Cost_order int,
FOREIGN KEY (Client) REFERENCES Client(Id_client) ON DELETE CASCADE,
FOREIGN KEY (Production) REFERENCES production(Id_prod) ON DELETE CASCADE
)

insert into Author values ('Казаков', '15-04-1995', '4152147');
insert into Author values ('Демьянчиков', '15-02-1980','8596241');
insert into Author values ('Блаженный', '04-06-1987', '1531265');
select * from Author;

insert into Type_of_prod values (1, 'newspaper');
insert into Type_of_prod values (2, 'magazine');
insert into Type_of_prod values (3, 'book');
select * from Type_of_prod;

insert into production values ('newspaper', '7 days', 'Лука');
insert into production values ('newspaper', 'Evening Grodno', 'Демьянчиков');
insert into production values ('newspaper', 'Grodno truth', 'Блаженный');
insert into production values ('newspaper', 'Our Cornfield', 'Казаков');
insert into production values ('magazine', 'Fashion people', 'Казаков');
insert into production values ('magazine', 'Fashion is my proffesion', 'Блаженный');
select * from production;

insert into client values ('Каспер Наталья', 'Белорусская 19');
insert into client values ('Чистякова Юлия', 'Белорусская 19');
insert into client values ('Ковалевский Андрей', 'Домбровского 27');
insert into client values ('Федорович Павел', 'Белорусская 21');
insert into client values ('Субоч Анжелика', 'Советская 15');
select * from client;


insert into orders values ('17-02-2020','17-03-2020', 1, 5, 300);
insert into orders values ('27-04-2020','27-05-2020', 2, 2, 200);
insert into orders values ('15-07-2020','17-08-2020', 3, 4, 500);
insert into orders values ('02-10-2020','17-12-2020', 4, 3, 450);
insert into orders values ('01-01-2020','17-12-2020', 5, 4, 450);
select * from orders;


-------------------
drop view order_view

go
create view order_view 
as 
select orders.Date_order_start, client.Name_client, production.Title_prod, production.Author_prod, orders.Cost_order 
		from ((orders inner join client on orders.Client=client.Id_client) 
		inner join production on orders.Production = production.Id_prod);
select * from order_view;


-------
drop procedure OrdersOfClient

go
create procedure OrdersOfClient(@datastarta date, @dataend date) 
as 
begin
	select Date_order_start, Date_order_end, Client, client.Name_client, Production, production.Title_prod, Cost_order 
		from ((orders inner join client on orders.Client = client.Id_client) inner join production on 
		orders.Production = production.Id_prod)
			where Date_order_start between @datastarta and @dataend; 
end;
exec OrdersOfClient '17-02-2020', '10-05-2020';


-------------
drop function countOrdersOfClient

go
create function countOrdersOfClient (@datastarta date,@dataend date)
	returns int
as
begin
	declare @ret int;
	select @ret = count(*) from orders 
		where Date_order_start between @datastarta and @dataend;
	if(@ret is null)
		set @ret = 0;
	return @ret;  
end;
select dbo.countOrdersOfClient('17-02-2020','25-05-2020');


create table user_log(
	u_date date not null, 
	u_time time not null, 
	operation text not null,
	table_name text not null
)
-------
drop trigger client_insert;

go
create trigger client_insert on client
for insert
as begin
	insert into user_log (u_date, u_time, operation, table_name) values (SYSDATETIME(), convert(time, SYSDATETIME()), 'insert', 'client');
end;

insert into client values ('kana' , 'dd', 'dr');
select * from user_log;

-------
go
create trigger client_delete on client
for delete
as begin
	insert into user_log (u_date, u_time, operation, table_name) values (SYSDATETIME(), convert(time, SYSDATETIME()), 'delete', 'client');
end;

delete from client where Name_client='kana';
select * from user_log;
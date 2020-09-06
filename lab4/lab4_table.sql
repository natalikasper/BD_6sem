use laba444;
select * from gadm36_blr_2;

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
Author_prod nvarchar(20),
city_prod int not null
foreign key (city_prod) references gadm36_blr_1(ogr_fid),
FOREIGN KEY (Author_prod) REFERENCES Author(Surname) on delete cascade,
FOREIGN KEY (Type_prod) REFERENCES Type_of_prod(Type_prod) on delete cascade
);

create table client(
Id_client int IDENTITY(1,1) primary key,
Name_client nvarchar(50),
Address_client nvarchar(50),
city_client int not null
foreign key (city_client) references gadm36_blr_1(ogr_fid)
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

insert into production values ('newspaper', '7 days', 'Казаков', 3);
insert into production values ('newspaper', 'Evening Grodno', 'Демьянчиков', 2);
insert into production values ('newspaper', 'Grodno truth', 'Блаженный', 3);
insert into production values ('newspaper', 'Our Cornfield', 'Казаков', 4);
insert into production values ('magazine', 'Fashion people', 'Казаков', 5);
insert into production values ('magazine', 'Fashion is my proffesion', 'Блаженный', 4);
select * from production;

insert into client values ('Каспер Наталья', 'Белорусская 19', 3);
insert into client values ('Чистякова Юлия', 'Белорусская 19', 1);
insert into client values ('Ковалевский Андрей', 'Домбровского 27', 3);
insert into client values ('Федорович Павел', 'Белорусская 21', 4);
insert into client values ('Бабкин Вячеслав', 'Суворова 1', 4);
insert into client values ('Субоч Анжелика', 'Советская 15', 5);
select * from client;

insert into orders values ('17-02-2020','17-03-2020', 1, 5, 300);
insert into orders values ('27-04-2020','27-05-2020', 2, 2, 200);
insert into orders values ('15-07-2020','17-08-2020', 3, 4, 500);
insert into orders values ('02-10-2020','17-12-2020', 4, 3, 450);
insert into orders values ('01-01-2020','17-12-2020', 5, 4, 450);
select * from orders;



create table product(
Id_prod int IDENTITY(1,1) primary key,
Type_prod nvarchar(15),
Title_prod nvarchar(50),
Author_prod nvarchar(20),
city_prod int not null
foreign key (city_prod) references gadm36_blr_1(ogr_fid),
FOREIGN KEY (Author_prod) REFERENCES Author(Surname) on delete cascade,
FOREIGN KEY (Type_prod) REFERENCES Type_of_prod(Type_prod) on delete cascade
);

create table clients(
Id_client int IDENTITY(1,1) primary key,
Name_client nvarchar(50),
--Telephone nvarchar(10),
Address_client nvarchar(50),
city_client int not null
foreign key (city_client) references gadm36_blr_2(ogr_fid)
);
select * from production;
insert into product values ('newspaper', '7 days', 'Казаков', 3);
insert into product values ('newspaper', 'Evening Grodno', 'Демьянчиков', 3);
insert into product values ('newspaper', 'Grodno truth', 'Блаженный', 1);
insert into product values ('newspaper', 'Our Cornfield', 'Казаков', 1);
insert into product values ('magazine', 'Fashion people', 'Казаков', 1);
insert into product values ('magazine', 'Fashion is my proffesion', 'Блаженный', 3);
select * from product;

insert into clients values ('Каспер Наталья', 'Белорусская 19', 49);
insert into clients values ('Чистякова Юлия', 'Белорусская 19', 3);
insert into clients values ('Ковалевский Андрей', 'Домбровского 27', 48);
insert into clients values ('Федорович Павел', 'Белорусская 21', 45);
insert into clients values ('Бабкин Вячеслав', 'Суворова 1', 15);
insert into clients values ('Субоч Анжелика', 'Советская 15', 9);
select * from clients;

create table Auth(
Surname nvarchar(20) primary key,
birthday date,
Phone nvarchar(10),
city_auth int not null
foreign key (city_auth) references gadm36_blr_1(ogr_fid),
)

insert into Auth values ('Казаков', '15-04-1995', '4152147', 3);
insert into Auth values ('Демьянчиков', '15-02-1980','8596241', 2);
insert into Auth values ('Блаженный', '04-06-1987', '1531265', 3);
select * from Auth;

select * from gadm36_blr_2;
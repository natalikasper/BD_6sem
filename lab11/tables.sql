create table production(
Id_prod int,
Type_prod nvarchar(15),
Title_prod nvarchar(50),
Author_prod nvarchar(20),
PRIMARY key (Id_prod),
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
Id_order int,
Date_order_start date,
Date_order_end date,
Client int,
Production int,
Cost_order int,
PRIMARY KEY (Id_order),
FOREIGN KEY (Client) REFERENCES Client(Id_client) ON DELETE CASCADE,
FOREIGN KEY (Production) REFERENCES production(Id_prod) ON DELETE CASCADE
)

create table Author(
Surname nvarchar(20) primary key,
birthday date,
Phone nvarchar(10)
)

create table Type_of_prod(
id int,
Type_prod nvarchar(15) primary key
)

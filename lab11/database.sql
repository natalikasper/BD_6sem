BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "clients" (
	"Id_client"	int,
	"Name_client"	nvarchar(50),
	"Address_client"	nvarchar(50)
);
CREATE TABLE IF NOT EXISTS "production" (
	"Id_prod"	int,
	"Type_prod"	nvarchar(15),
	"Title_prod"	nvarchar(50),
	"Author_prod"	nvarchar(20),
	FOREIGN KEY("Author_prod") REFERENCES "Author"("Surname") on delete cascade,
	PRIMARY KEY("Id_prod"),
	FOREIGN KEY("Type_prod") REFERENCES "Type_of_prod"("Type_prod") on delete cascade
);
CREATE TABLE IF NOT EXISTS "orders" (
	"Id_order"	int IDENTITY(1 , 1),
	"Date_order_start"	date,
	"Date_order_end"	date,
	"Client"	int,
	"Production"	int,
	"Cost_order"	int,
	PRIMARY KEY("Id_order"),
	FOREIGN KEY("Client") REFERENCES "Client"("Id_client") ON DELETE CASCADE,
	FOREIGN KEY("Production") REFERENCES "production"("Id_prod") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "client" (
	"Id_client"	int IDENTITY(1 , 1),
	"Name_client"	nvarchar(50),
	"Address_client"	nvarchar(50),
	PRIMARY KEY("Id_client")
);
CREATE TABLE IF NOT EXISTS "Type_of_prod" (
	"id"	int,
	"Type_prod"	nvarchar(15),
	PRIMARY KEY("Type_prod")
);
CREATE TABLE IF NOT EXISTS "Author" (
	"Surname"	nvarchar(20),
	"birthday"	date,
	"Phone"	nvarchar(10),
	PRIMARY KEY("Surname")
);
INSERT INTO "clients" ("Id_client","Name_client","Address_client") VALUES (6,'Лобач Диана','Заводская 5');
INSERT INTO "production" ("Id_prod","Type_prod","Title_prod","Author_prod") VALUES (1,'newspaper','Evening Grodno','Демьянчиков'),
 (2,'newspaper','Grodno truth','Блаженный'),
 (3,'newspaper','Our Cornfield','Казаков'),
 (4,'magazine','Fashion people','Казаков'),
 (5,'magazine','Fashion is my proffesion','Блаженный');
INSERT INTO "orders" ("Id_order","Date_order_start","Date_order_end","Client","Production","Cost_order") VALUES (1,'17-02-2020','17-03-2020',1,5,300),
 (2,'27-04-2020','27-05-2020',2,2,200),
 (3,'15-07-2020','17-08-2020',3,4,500),
 (4,'02-10-2020','17-12-2020',4,3,450),
 (5,'01-01-2020','17-12-2020',5,4,450);
INSERT INTO "client" ("Id_client","Name_client","Address_client") VALUES (1,'Каспер Наталья','Белорусская 19'),
 (2,'Чистякова Юлия','Белорусская 19'),
 (3,'Ковалевский Андрей','Домбровского 27'),
 (4,'Федорович Павел','Белорусская 21'),
 (5,'Субоч Анжелика','Советская 15'),
 (6,'Лобач Диана','Заводская 5');
INSERT INTO "Type_of_prod" ("id","Type_prod") VALUES (1,'newspaper'),
 (2,'magazine'),
 (3,'book');
INSERT INTO "Author" ("Surname","birthday","Phone") VALUES ('Казаков','15-04-1995','4152147'),
 ('Демьянчиков','15-02-1980','8596241'),
 ('Блаженный','04-06-1987','1531265');
CREATE TRIGGER tr_type_of_prod_Insert
before insert on client
for each row
begin
	insert into clients (Id_client, Name_client, Address_client)
	values (new.Id_client, new.Name_client, new.Address_client);
end;
CREATE VIEW order_view 
as 
select orders.Date_order_start, client.Name_client, production.Title_prod, production.Author_prod, orders.Cost_order 
		from ((orders inner join client on orders.Client=client.Id_client) 
		inner join production on orders.Production = production.Id_prod);
COMMIT;

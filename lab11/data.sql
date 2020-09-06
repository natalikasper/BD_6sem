
INSERT INTO "production" ("Id_prod","Type_prod","Title_prod","Author_prod") 
VALUES (1,'newspaper','Evening Grodno','Демьянчиков'),
 (2,'newspaper','Grodno truth','Блаженный'),
 (3,'newspaper','Our Cornfield','Казаков'),
 (4,'magazine','Fashion people','Казаков'),
 (5,'magazine','Fashion is my proffesion','Блаженный');
INSERT INTO "orders" ("Id_order","Date_order_start","Date_order_end","Client","Production","Cost_order") 
VALUES (1,'17-02-2020','17-03-2020',1,5,300),
 (2,'27-04-2020','27-05-2020',2,2,200),
 (3,'15-07-2020','17-08-2020',3,4,500),
 (4,'02-10-2020','17-12-2020',4,3,450),
 (5,'01-01-2020','17-12-2020',5,4,450);
INSERT INTO "client" ("Id_client","Name_client","Address_client") 
VALUES (1,'Каспер Наталья','Белорусская 19'),
 (2,'Чистякова Юлия','Белорусская 19'),
 (3,'Ковалевский Андрей','Домбровского 27'),
 (4,'Федорович Павел','Белорусская 21'),
 (5,'Субоч Анжелика','Советская 15'),
 (6,'Лобач Диана','Заводская 5');
INSERT INTO "Type_of_prod" ("id","Type_prod") VALUES 
(1,'newspaper'),
 (2,'magazine'),
 (3,'book');
INSERT INTO "Author" ("Surname","birthday","Phone") VALUES 
('Казаков','15-04-1995','4152147'),
 ('Демьянчиков','15-02-1980','8596241'),
 ('Блаженный','04-06-1987','1531265');


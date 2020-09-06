--------¿¬“Œ–€---------
use publishing_house
go
CREATE PROCEDURE add_author
    @surname nvarchar(20),
	@birthday nvarchar (max),
	@phone nvarchar(10)
AS
	BEGIN
		INSERT INTO Author(Surname, birthday, Phone) values(@surname, @birthday, @phone)
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_author
	@surname nvarchar (max)
AS
	BEGIN
	DELETE FROM Author where Surname = @surname;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_author
    @surname nvarchar(20),
	@birthday nvarchar (max),
	@phone nvarchar(10)
AS
	BEGIN
	update Author set Surname=@surname, birthday = @birthday, Phone = @phone 
		where Surname=@surname;
		SELECT 0;
	END
GO
----
create procedure  getAllAuthors
AS
select * from Author;

--------- À»≈Õ“€-------
use publishing_house
go
CREATE PROCEDURE add_client
    @name nvarchar(50),
	@adress nvarchar(50)
AS
	BEGIN
		INSERT INTO client(Name_client, Address_client) values(@name, @adress)
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_client
	@name nvarchar (50)
AS
	BEGIN
	DELETE FROM client where Name_client = @name;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_client
    @name nvarchar(20),
	@adress nvarchar(50)
AS
	BEGIN
	update client set Name_client=@name, Address_client=@adress
		where Name_client = @name
		SELECT 0;
	END
GO
----
create procedure  getAllClients
AS
select * from client


--------“»œ€ œ–Œƒ” ÷»»------
select * from Type_of_prod;
use publishing_house
go
CREATE PROCEDURE add_type
	@type nvarchar (50),
	@id_type int
AS
	BEGIN
		INSERT INTO Type_of_prod(id, Type_prod) values (@id_type, @type);
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_type
	@type nvarchar (50)
AS
	BEGIN
	DELETE FROM Type_of_prod where Type_prod = @type ;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_type
	@type nvarchar (50), 
	@id_type int
AS
	BEGIN
	update Type_of_prod set Type_prod = @type, id = @id_type
		where Type_prod = @type
		SELECT 0;
	END
GO
----
create procedure  getAllTypes
AS
select * from Type_of_prod


-------œ–Œƒ” ÷»ﬂ---------
select * from production;
go
CREATE PROCEDURE add_prod
	@type_prod nvarchar (50),
	@title_prod nvarchar (50),
	@author_prod nvarchar (50)
AS
	BEGIN
		INSERT INTO production (Type_prod, Title_prod, Author_prod) values (@type_prod, @title_prod, @author_prod);
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_prod
	@type_prod nvarchar (50)
AS
	BEGIN
	DELETE FROM production where Type_prod = @type_prod;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_prod
	@type_prod nvarchar (50),
	@title_prod nvarchar (50),
	@author_prod nvarchar (50)
AS
	BEGIN
	update production set Type_prod = @type_prod, Title_prod=@title_prod, Author_prod=@author_prod
		where Type_prod = @type_prod
		SELECT 0;
	END
GO
----
create procedure  getAllProd
AS
select * from production;


----------«¿ ¿«€-----------
use publishing_house;
select * from orders;
go
CREATE PROCEDURE add_order
	@date_start nvarchar (50),
	@date_end nvarchar (50),
	@client_order int,
	@production_order int,
	@cost_order int
AS
	BEGIN
		INSERT INTO orders (Date_order_start, Date_order_end, Client, Production, Cost_order ) values (@date_start, @date_end, @client_order, @production_order, @cost_order);
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_order
	@date_start nvarchar (50),
	@date_end nvarchar (50)
AS
	BEGIN
	DELETE FROM orders where Date_order_start = @date_start and Date_order_end = @date_end;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_order
	@date_start nvarchar (50),
	@date_end nvarchar (50),
	@client_order int,
	@production_order int,
	@cost_order int
AS
	BEGIN
	update orders set Date_order_start = @date_start, Date_order_end=@date_end, Client = @client_order, Production = @production_order, Cost_order = @cost_order
		where Date_order_start = @date_start and Date_order_end = @date_end;
		SELECT 0;
	END
GO
----
create procedure  getAllOrder
AS
select * from orders;


----
go
create procedure OrdersOfClient
	@datastarta nvarchar (50), 
	@dataend nvarchar (50)
as 
begin
	select Date_order_start, Date_order_end, Client, client.Name_client, Production, production.Title_prod, Cost_order 
		from ((orders inner join client on orders.Client = client.Id_client) inner join production on 
		orders.Production = production.Id_prod)
			where Date_order_start between @datastarta and @dataend; 
end;
create view order_view 
as 
select orders.Date_order_start, client.Name_client, production.Title_prod, production.Author_prod, orders.Cost_order 
		from ((orders inner join client on orders.Client=client.Id_client) 
		inner join production on orders.Production = production.Id_prod);

select * from order_view;
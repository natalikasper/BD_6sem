use publishing_house;

--вычислить объем выпуска
select Id_prod, production.Title_prod, sum(Cost_order) as sum_cost, count(Title_prod) as count_p, 
		ROW_NUMBER() over(partition by Id_prod order by Id_prod) as rows_n from production inner join orders 
	on orders.Production=production.Id_prod 
	group by production.Title_prod, Id_prod;

--сравнение с общим и пиковым объемом выпуска(К%)
declare @sum int;
set @sum =(select sum(Cost_Order) from orders)
declare @max int;
set @max = (select top(1) sum(Cost_Order) suma from orders group by Production order by suma desc)

SELECT O.Production as номер_продукции,
    sum(o.Cost_Order) as сумма_заказа,
	CAST(100. * sum(o.Cost_Order) /  @sum AS NUMERIC(5, 2)) AS общий,
	CAST(100. * sum(o.Cost_Order) / @max AS NUMERIC(5, 2)) AS максимальный
FROM orders AS O group by o.Production;


--для разбиения рез-тов напроса на окна
SELECT * , ROW_NUMBER() OVER(PARTITION BY Production ORDER BY Production) AS rownum
FROM orders;


--ROW_NUMBER() для удаления дубликатов
SELECT * FROM Type_of_prod;
insert into Type_of_prod values (3, 'books');

delete x from (
  select *, rn = row_number() over (partition by id order by id)
  from Type_of_prod) x
where rn > 1;

--вернуть для к.автора кол-во изданных книг за 6 месяцев помесячно
select 
	Author_prod as Автор, 
	month(Date_prod) as Месяц, 
	count(Type_prod) as Количество,
	rn=row_number() over (partition by month(Date_prod) order by month(Date_prod))
from production
	where Month(Date_prod) between month((select max(Date_prod) from production)) - 5
		and month((select max(Date_prod) from production))
	group by month(Date_prod), Author_prod;

select * from production;

--какой жанр пользовался наибольшей популярностью для опред.автора
select Type_prod as Тип_продукции, Author_prod as Автор, COUNT(Type_prod) as Количество,
	RANK() OVER(partition by Author_prod ORDER BY Count(Type_prod) DESC) AS Ранг_строки
	from production group by Author_prod, Type_prod order by Author_prod;

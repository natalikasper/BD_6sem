use publishing_house;

--��������� ����� �������
select Id_prod, production.Title_prod, sum(Cost_order) as sum_cost, count(Title_prod) as count_p, 
		ROW_NUMBER() over(partition by Id_prod order by Id_prod) as rows_n from production inner join orders 
	on orders.Production=production.Id_prod 
	group by production.Title_prod, Id_prod;

--��������� � ����� � ������� ������� �������(�%)
declare @sum int;
set @sum =(select sum(Cost_Order) from orders)
declare @max int;
set @max = (select top(1) sum(Cost_Order) suma from orders group by Production order by suma desc)

SELECT O.Production as �����_���������,
    sum(o.Cost_Order) as �����_������,
	CAST(100. * sum(o.Cost_Order) /  @sum AS NUMERIC(5, 2)) AS �����,
	CAST(100. * sum(o.Cost_Order) / @max AS NUMERIC(5, 2)) AS ������������
FROM orders AS O group by o.Production;


--��� ��������� ���-��� ������� �� ����
SELECT * , ROW_NUMBER() OVER(PARTITION BY Production ORDER BY Production) AS rownum
FROM orders;


--ROW_NUMBER() ��� �������� ����������
SELECT * FROM Type_of_prod;
insert into Type_of_prod values (3, 'books');

delete x from (
  select *, rn = row_number() over (partition by id order by id)
  from Type_of_prod) x
where rn > 1;

--������� ��� �.������ ���-�� �������� ���� �� 6 ������� ���������
select 
	Author_prod as �����, 
	month(Date_prod) as �����, 
	count(Type_prod) as ����������,
	rn=row_number() over (partition by month(Date_prod) order by month(Date_prod))
from production
	where Month(Date_prod) between month((select max(Date_prod) from production)) - 5
		and month((select max(Date_prod) from production))
	group by month(Date_prod), Author_prod;

select * from production;

--����� ���� ����������� ���������� ������������� ��� �����.������
select Type_prod as ���_���������, Author_prod as �����, COUNT(Type_prod) as ����������,
	RANK() OVER(partition by Author_prod ORDER BY Count(Type_prod) DESC) AS ����_������
	from production group by Author_prod, Type_prod order by Author_prod;

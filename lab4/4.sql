use laba444;
-- Найти пересечение, исключение или объединение данных.
	declare @poly1 geometry = 'POLYGON ((1 1, 1 4, 4 4, 4 1, 1 1))';
	declare @poly2 geometry = 'POLYGON ((2 2, 2 6, 6 6, 6 2, 2 2))';
	declare @inters geometry = @poly1.STIntersection(@poly2);
	declare @iskl geometry = @poly1.STDifference(@poly2);
	select	@inters.STAsText() as 'Пересечение', 
			@iskl.STAsText() as 'Исключение';

-- Найти расстояние между двумя объектами.
	declare @g geometry;
	declare @h geometry;
	declare @dist float;
	select @g = ogr_geometry.STAsText() from gadm36_blr_1 where ogr_fid=4;
	select @h = ogr_geometry.STAsText() from gadm36_blr_1 where ogr_fid=3;
	select @dist = @g.STDistance(@h);
	select @dist as 'Расстояние', (select name_1 from gadm36_blr_1 where ogr_fid=3) as 'Город1', 
			name_1 as 'Город2' from gadm36_blr_1 where ogr_fid=4;


-- Найти ближайших клиентов текущему поставщику
select Author_prod as 'автор', Title_prod as 'продукция',
		Name_client as 'клиент', g.name_1 as 'Город продукции', g.name_2 as 'город клиента'
		from production p 
			join clients c on p.city_prod = 3
			join gadm36_blr_2 g on c.city_client = g.ogr_fid
			where g.ogr_fid between 38 and 54;


-- Площадь, кот. охватывает продукция
select	Surname as 'автор', name_1 as 'Город', 
		ogr_geometry.STArea() as 'Площадь'
		from Auth d
			join gadm36_blr_2 r on d.city_auth = r.ogr_fid
		where d.Surname = 'Казаков';

select	Author_prod as 'автор', name_1 as 'Город', 
		ogr_geometry.STArea() as 'Площадь'
		from production d
			join gadm36_blr_1 r on d.city_prod = r.ogr_fid
		where d.Type_prod='newspaper';

-- Дать карту покрытия для опр. клиента
	declare @id_client int = 3;
	declare @ogr int;
	select @ogr = city_client from client c
		join gadm36_blr_1 r on r.ogr_fid = c.city_client
		where c.Id_client = @id_client;
	declare @geogr nvarchar(max);
	select @geogr = ogr_geometry.STAsText() from gadm36_blr_1 where ogr_fid=@ogr;
	
	DECLARE @p as GEOMETRY;
	select @p = geometry::STGeomFromText(@geogr, 0)
	SELECT	@p as geom, Name_client, city_client from client where Id_client=@id_client;

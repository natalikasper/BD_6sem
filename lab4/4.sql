use laba444;
-- ����� �����������, ���������� ��� ����������� ������.
	declare @poly1 geometry = 'POLYGON ((1 1, 1 4, 4 4, 4 1, 1 1))';
	declare @poly2 geometry = 'POLYGON ((2 2, 2 6, 6 6, 6 2, 2 2))';
	declare @inters geometry = @poly1.STIntersection(@poly2);
	declare @iskl geometry = @poly1.STDifference(@poly2);
	select	@inters.STAsText() as '�����������', 
			@iskl.STAsText() as '����������';

-- ����� ���������� ����� ����� ���������.
	declare @g geometry;
	declare @h geometry;
	declare @dist float;
	select @g = ogr_geometry.STAsText() from gadm36_blr_1 where ogr_fid=4;
	select @h = ogr_geometry.STAsText() from gadm36_blr_1 where ogr_fid=3;
	select @dist = @g.STDistance(@h);
	select @dist as '����������', (select name_1 from gadm36_blr_1 where ogr_fid=3) as '�����1', 
			name_1 as '�����2' from gadm36_blr_1 where ogr_fid=4;


-- ����� ��������� �������� �������� ����������
select Author_prod as '�����', Title_prod as '���������',
		Name_client as '������', g.name_1 as '����� ���������', g.name_2 as '����� �������'
		from production p 
			join clients c on p.city_prod = 3
			join gadm36_blr_2 g on c.city_client = g.ogr_fid
			where g.ogr_fid between 38 and 54;


-- �������, ���. ���������� ���������
select	Surname as '�����', name_1 as '�����', 
		ogr_geometry.STArea() as '�������'
		from Auth d
			join gadm36_blr_2 r on d.city_auth = r.ogr_fid
		where d.Surname = '�������';

select	Author_prod as '�����', name_1 as '�����', 
		ogr_geometry.STArea() as '�������'
		from production d
			join gadm36_blr_1 r on d.city_prod = r.ogr_fid
		where d.Type_prod='newspaper';

-- ���� ����� �������� ��� ���. �������
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

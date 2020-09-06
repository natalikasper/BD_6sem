use publishing_house;

alter table client add hid hierarchyid;
select * from client;

declare @Id hierarchyid --���������� ��������� ����
select @Id = MAX(hid) from client where hid.GetAncestor(1) = hierarchyid::GetRoot(); --GetAncestor � ������ hierarchyid ������
insert into client values('������ �������', '������ 39', hierarchyid::GetRoot().GetDescendant(@Id, null)); --GetDescendant � ������ hierarchyid �������

declare @Id hierarchyid
select @Id = MAX(hid) from client where hid.GetAncestor(1) = hierarchyid::GetRoot(); 
insert into client values('����� ��������', '������������ 12', hierarchyid::GetRoot().GetDescendant(@Id, null));
insert into client values('�� ������', '������ 4', hierarchyid::GetRoot().GetDescendant(@Id, null));

select hid.GetLevel() as [Level], * from client;


--2.������� ���������, ���.��������� ��� ����������� ���� � ����.��-�� �������� 
drop procedure SelectPodchRoot;

GO  
CREATE PROCEDURE SelectPodchRoot(@level int)    
AS   
BEGIN  
   select  hid.GetLevel() as [Level], * from client where hid.GetLevel() = @level;
END;
  
GO  
exec SelectPodchRoot 2;


--3. ������� ����., ���.������� ����������� ���� 
drop procedure AddEmp;
go
CREATE PROCEDURE AddEmp(@name_c nvarchar(50), @add nvarchar(50), @old_uzel int)
AS  
BEGIN  
	DECLARE @nold hierarchyid, @nnew hierarchyid  
	SELECT @nold = hid 
		FROM client 
		WHERE Id_client = @old_uzel; 
	BEGIN TRANSACTION  
		SELECT @nnew = max(hid) 
		FROM client 
		WHERE hid.GetAncestor(1) = @nold;
	
		INSERT client (Name_client, Address_client, hid)
			values (@name_c, @add, @nold.GetDescendant(@nnew, NULL))
	commit;
END ;  
GO  


--4. ����., ���.���������� ��� ����������� �����
GO
CREATE PROCEDURE MoveUnderTree(@oldMgr nvarchar(50), @newMgr nvarchar(50))
as
BEGIN
	DECLARE @nold hierarchyid, @nnew hierarchyid  
	SELECT @nold = hid 
		FROM client 
		WHERE Name_client = @oldMgr ;  
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE  
	BEGIN TRANSACTION  
		SELECT @nnew = hid 
			FROM client 
			WHERE Name_client = @newMgr ;  
		SELECT @nnew = @nnew.GetDescendant(max(hid), NULL)   
			FROM client 
			WHERE hid.GetAncestor(1)=@nnew ;  
		UPDATE client  
			SET hid = hid.GetReparentedValue(@nold, @nnew)  
				WHERE hid.IsDescendantOf(@nold) = 1;  
	COMMIT TRANSACTION  
END ;  
GO 

exec MoveUnderTree '������ �������', '����� ��������'

select hid.GetLevel() as [Level], * from client;

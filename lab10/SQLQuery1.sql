--логин
create Login Natasha_K with password='kasper';
--юзер привязанный к логину
use lab10;
create user Natasha_KUser for login Natasha_K;
--юзер
create user JustUser without login;
---роль
create role user_role;
--предоставление прав на выполнение тех-иных д-вий
grant select, insert, update, delete on orders to user_role;
revoke update on orders from user_role;
EXEC sp_addrolemember @rolename = 'user_role', @membername = 'Natasha_KUser';

--заимствование прав
use lab10;
go

create login John with password = 'john';
create login Jane with password = 'jane';
create user John for login John;
create user Jane for login Jane;
go

exec sp_addrolemember 'db_datareader', 'John';
exec sp_addrolemember 'db_ddladmin', 'John';
deny select on orders to Jane;
go

create procedure Us_GetOrders 
	with execute as 'John'
		as select * from orders;
go

alter authorization on Us_GetOrders to John;

grant execute on Us_GetOrders to Jane;

use lab10;

setuser 'Jane';
exec Us_GetOrders;

select * from orders;

setuser;


--АУДИТ 
use master;
go

create server audit CAudit 
to file(
	filepath = 'F:\6 семестр\БД\Лабораторные\lab10',
	maxsize = 0 mb,
	max_rollover_files = 0,
	reserve_disk_space = off
) with ( queue_delay = 1000, on_failure = continue);

create server audit PAudit to application_log;
create server audit AAudit to security_log;

select * from sys.server_audits;

--
create database lab14node;
drop database lab14node;
select * from [lab10].dbo.Type_of_prod;
delete from [lab10].dbo.Type_of_prod where id = 6;
insert top(200) into [lab10].dbo.Type_of_prod(id, Type_prod) values (6, 'rar');

-- Запустить аудит БД, продемонстрировать журнал аудита.
select statement from fn_get_audit_file('F:\6 семестр\БД\Лабораторные\lab10\*', null, null);	


--ШИФРОВАНИЕ
--ассиметричный ключ шифрования.
use lab10;
create asymmetric key SampleAKey
	with algorithm = rsa_2048
	encryption by password = 'Pas45!!~~';

--зашифровать и расшифровать данные при помощи этого ключа.
declare @plaintext nvarchar(21);
declare @ciphertext nvarchar (256);

set @plaintext = 'this is a sample text';
print @plaintext;

set @ciphertext = EncryptByAsymKey(AsymKey_ID('SampleAKey'), @plaintext);
print @ciphertext;

set @plaintext = DecryptByAsymKey(AsymKey_ID('SampleAKey'), @ciphertext, N'Pas45!!~~');
print @plaintext;

--сертификат.
use lab10;
go
create certificate SampleCert
	encryption by password = N'pa$$W0RD'
		with subject = N'Sample Certificate',
	expiry_date = N'31/10/2022';

--Зашифровать и расшифровать данные при помощи этого сертификата.
declare @plain_text nvarchar(58);
set @plain_text = 'this is certificate encryption text';
print @plain_text;

declare @cipher_text nvarchar(256);
set @cipher_text = EncryptByCert(Cert_ID('SampleCert'), @plain_text);
print @cipher_text;

set @plain_text = CAST(DecryptByCert(Cert_ID('SampleCert'), @cipher_text, N'pa$$W0RD') as nvarchar(58));
print @plain_text;
	
--симметричный ключ шифрования данных.
use lab10;
create symmetric key SKey
with algorithm = AES_256
encryption by password = N'PA$$W0RD';

open symmetric key SKey
decryption by password = N'PA$$W0RD';

create symmetric key SData
with algorithm = AES_256
encryption by symmetric key SKey;

open symmetric key SData
decryption by symmetric key SKey;

--Зашифровать и расшифровать данные при помощи этого ключа.
declare @plain_tex nvarchar(512);
set @plain_tex = 'open the symmetric key with which to encrypt the data';
print @plain_tex;

declare @cipher_tex nvarchar(1024);
set @cipher_tex = EncryptByKey(Key_GUID('SData'), @plain_tex);
print @cipher_tex;

set @plain_tex = CAST(DecryptByKey(@cipher_tex) as nvarchar(512));
print @plain_tex;

close symmetric key SData;
close symmetric key SKey;

--прозрачное шифрование базы данных.
use master;
go

create master key encryption by password = 'p@$$wOrd';
go

create certificate LabCert
	with subject = 'certificate to encrypt Lab10 DB ', 
	expiry_date = '31/10/2020';
go

--
use lab10;
go

create database encryption key
with algorithm = AES_256
encryption by server certificate LabCert;
go

alter database lab10 
set encryption on;
go

--состояние шифрование файла журнала
--3 - зашифрованное состояние в БД и жуналах
select encryption_state from sys.dm_database_encryption_keys;

--удалить шифрование из БД
alter database lab10 
set encryption off;
go

--хэширование (MD2, MD4, MD5, SHA1, SHA2)
select HashBytes('SHA1', 'open the symmetric key with which to encrypt the data');
select HashBytes('MD4', 'open the symmetric key with which to encrypt the data');

--19.	Продемонстрировать применение ЭЦП при помощи сертификата.
--подписывает текст сертификатом и возвращает подпись
select * from sys. certificates;
select SIGNBYCERT(256, N'natasha kasper', N'pa$$W0RD') as ЭЦП;	--сертификат
--0 - изменены, 1 - не изменены
select VERIFYSIGNEDBYCERT(256, 'natasha kasper', 0x0100050204000000E2CA174EADCCC2E91DDE3C1278D631A765652A1E41193568375F5A98D7CA07754D6C0A90DCAC72B61B56AB1F9F533F3AEFFAC2E625DC286F6CE40ED3B84FF8BB27741B00447D66EAE4E5BADDE526A312059342BD04A3D3886D2EE7F94AB70A244B6D7E2578526C6BD5B03D74FC0783C8FABDA349A96B7487F0CF9683B6E7833D8C9E65BD268C609FCA0F41D92AE5EF79846CD870B3D515176AA04D3AD46858AD2A53E42004DE8B44C6F4A9C72BCA3FF5506BB936138AD5BD17AFF9A7F8D26DEE9F57E25E2175C894FF5463AE6A2F2432E528CE62F45BDEB40E915889CD7659E04FBA3C406670EA34D3B1F788EA09A1C617860DFB871C21818756BDC1484D375C);
select * from sys. asymmetric_keys;
select SIGNBYASymKey(257, N'natasha kasper', N'Pas45!!~~') as ЭЦП;	--ас.ключ
select VERIFYSIGNEDBYASYMKEY(257, N'natasha kasper', 0x0100050204000000FF2D7D860275DD606E30C46088D0BE0DC550586E27421701B12A7B3C2AE5E9CDAEB3D24778AAE7A46FF3B3A45072B418231665DDD43806EE11B9CAD78D9EC0DAC91E93247FF72BFDC13FDD800377F398D23CA500FBE51C4AA9A4B8863E74808D89EA5FEF2CAB90CDD84488D95AE45E308C18748A608FDE069830197D1592C6FC8775D717F6FB5D10245E3B149F5B919B31035E814E7540E24207664ED6E816DED8BC049BB60F47432111206A7C7A138F965CC046AFDC365DE00FE9CFFAC85C9A756F96C52B740C2546B15D700B249435A266EF987E96E9D51BDB00BA5D7E6C7854990830EDD834A8896CACA5F615BAE02E3D738BF7F5AEE46BCBDEF373B32080);


--20.	Сделать резервную копию необходимых ключей и сертификатов.
backup certificate SampleCert
to file = N'F:\6 семестр\БД\Лабораторные\lab10\backup\BackupSampleCert.cer'
	with private key(
		file = N'F:\6 семестр\БД\Лабораторные\lab10\backup\BackupSampleCert.pvk',
		encryption by password = N'pa$$W0RD',
		decryption by password = N'pa$$W0RD');

use master;
BACKUP MASTER KEY TO FILE = 'F:\6 семестр\БД\Лабораторные\lab10\backup\BackupMasterKey.key' 
        ENCRYPTION BY PASSWORD = 'p@$$wOrd';

		
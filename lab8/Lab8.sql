--1. создать отдельное табл.пр-во для хранения LOB
drop tablespace first_blob;

create bigfile tablespace first_blob
datafile 'F:\first_lob.dbf'
size 50m autoextend on next 1m;

select * from v$tablespace;

--2.создать отдельную папку для хранения WORD(PDF) доков
drop directory BF;
create directory BF as 'F:\';

--3.FOTO BLOB: для хранения фотографии
  --DOC(PDF): для хранения внешних ворд(пдф) доков
drop table BigFiles;
create table BigFiles(
  id number(5) primary key,
  FOTO BLOB,
  the_file bfile)
tablespace first_blob;

--4.добавить (insert) фотки и доки в таблицу
insert into BigFiles values(2, utl_raw.cast_to_raw('F:\9.png'), BFILENAME('BF', 'ds.docx'));
select * from BigFiles;

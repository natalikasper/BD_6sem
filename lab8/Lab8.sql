--1. ������� ��������� ����.��-�� ��� �������� LOB
drop tablespace first_blob;

create bigfile tablespace first_blob
datafile 'F:\first_lob.dbf'
size 50m autoextend on next 1m;

select * from v$tablespace;

--2.������� ��������� ����� ��� �������� WORD(PDF) �����
drop directory BF;
create directory BF as 'F:\';

--3.FOTO BLOB: ��� �������� ����������
  --DOC(PDF): ��� �������� ������� ����(���) �����
drop table BigFiles;
create table BigFiles(
  id number(5) primary key,
  FOTO BLOB,
  the_file bfile)
tablespace first_blob;

--4.�������� (insert) ����� � ���� � �������
insert into BigFiles values(2, utl_raw.cast_to_raw('F:\9.png'), BFILENAME('BF', 'ds.docx'));
select * from BigFiles;

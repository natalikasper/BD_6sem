create trigger 
if not EXISTS
tr_type_of_book_Insert
before insert on Type_of_prod
for each row
begin
	insert into Type_of_prod (id, Type_prod)
	values (new.id, new.Author);
end;

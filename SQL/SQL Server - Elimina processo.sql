use master
declare @vcdbname varchar(50)

/* @vcdbname => Variavel para colocar o nome da base de dados */
Set @vcdbname = 'DATABASE'

set nocount on
declare Users cursor for
select spid
from master..sysprocesses
where db_name(dbid) = @vcdbname
declare @spid int, @str varchar(255)
open users
fetch next from users into @spid
while @@fetch_status <> -1
begin
if @@fetch_status = 0
begin
print @spid
set @str = 'kill ' + convert(varchar, @spid)
exec (@str)
end
fetch next from users into @spid
end
deallocate users



-- Rebuild All Indexes
PRINT('Reconstruindo �ndices')
GO

DECLARE @Database VARCHAR(255)  
DECLARE @Table VARCHAR(255)  
DECLARE @cmd NVARCHAR(500)  
DECLARE @fillfactor INT

SET @fillfactor = 90

DECLARE DatabaseCursor CURSOR FOR  
	SELECT	name FROM MASTER.dbo.sysdatabases  
	WHERE	name NOT IN ( 'master','msdb','tempdb','model','distribution' )
			AND name IN (select db_name())
	ORDER BY 1  

OPEN DatabaseCursor

FETCH NEXT FROM DatabaseCursor INTO @Database  
WHILE @@FETCH_STATUS = 0  
BEGIN  

   SET @cmd = 'DECLARE TableCursor CURSOR FOR SELECT ''['' + table_catalog + ''].['' + table_schema + ''].['' +
  table_name + '']'' as tableName FROM ' + @Database + '.INFORMATION_SCHEMA.TABLES
  WHERE table_type = ''BASE TABLE'''  

   -- create table cursor  
   EXEC (@cmd)  
   OPEN TableCursor  

   FETCH NEXT FROM TableCursor INTO @Table  
   WHILE @@FETCH_STATUS = 0  
   BEGIN  

       IF (@@MICROSOFTVERSION / POWER(2, 24) >= 9)
       BEGIN
           -- SQL 2005 or higher command
           SET @cmd = 'ALTER INDEX ALL ON ' + @Table + ' REBUILD WITH (FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ')'
           EXEC (@cmd)
       END
       ELSE
       BEGIN
          -- SQL 2000 command
          DBCC DBREINDEX(@Table,' ',@fillfactor)  
       END

       FETCH NEXT FROM TableCursor INTO @Table  
   END  

   CLOSE TableCursor  
   DEALLOCATE TableCursor  

   FETCH NEXT FROM DatabaseCursor INTO @Database  
END  
CLOSE DatabaseCursor  
DEALLOCATE DatabaseCursor 
GO











-- Shrinking:
PRINT 'Rodando shrink'
GO


declare @nome_bd as varchar(200)
declare @nome_log as varchar(200)

--select * from gestplus_abastece_comercio.[sys].[database_files] 
select @nome_bd	= name from [sys].[database_files] where type_desc = 'ROWS'
select @nome_log = name from [sys].[database_files] where type_desc = 'LOG'

print 'BASE: ' + @nome_bd
print 'LOG:  ' + @nome_log



-- SHRINKING --

print 'Alterando recovery para simple...'
exec ('alter database '+ @nome_bd + ' set recovery simple')

print 'Checkpoint...'
exec ('checkpoint')

print 'Alterando recovery para full...'
exec ('alter database '+ @nome_bd + ' set recovery full')

print 'Liberando log...'
exec ('dbcc shrinkfile ( '+ @nome_log + ' , 1)')

print 'Liberando dados...'
exec ('dbcc shrinkfile ( '+ @nome_bd + ' , 1)')

print 'Liberando log...'
exec ('dbcc shrinkfile ( '+ @nome_log + ' , 1)')


print 'Finalizado!'


GO



-- Liberar cache:
PRINT 'Liberando cache'
GO
DBCC FREESESSIONCACHE
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
DBCC FREESYSTEMCACHE ( 'ALL' )
GO

-- Update Statistics
PRINT('Atualizando estat�sticas')
GO
sp_updatestats
GO
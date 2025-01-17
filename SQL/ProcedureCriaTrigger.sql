USE [TesteAuditoria]
GO
/****** Object:  StoredProcedure [dbo].[USP_CriaTrigger]    Script Date: 28/11/2013 23:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[USP_CriaTrigger]
@Tabela varchar(50)
AS
Declare @SQL varchar(1000)=''
Set @SQL=@SQL+ ' CREATE TRIGGER tga_Audit_' + @Tabela + ' ON ' + @Tabela + ' FOR INSERT, UPDATE, DELETE AS ' 
Set @SQL=@SQL+ ' BEGIN ' 
Set @SQL=@SQL+ ' DECLARE @vn_ErrNo    INT, @vc_ErrMsg   VARCHAR(255) ' 
Set @SQL=@SQL+ '   SELECT * INTO #ins FROM inserted ' 
Set @SQL=@SQL+ '   SELECT * INTO #del FROM deleted ' 
Set @SQL=@SQL+ '   EXEC spu_Auditoria_Insere ''' + @Tabela + ''', NULL ' 
Set @SQL=@SQL+ '   DROP TABLE #ins ' 
Set @SQL=@SQL+ '   DROP TABLE #del ' 
Set @SQL=@SQL+ '   RETURN ' 
Set @SQL=@SQL+ ' END ' 

exec(@SQL)
CREATE PROCEDURE spu_Auditoria
( @pc_Tabela   VARCHAR(128),
  @pc_DataHora DATETIME )
AS
BEGIN
    SET NOCOUNT ON

	set concat_null_yields_null off
    
    DECLARE @vn_Error     INT,
            @vn_Trancount INT,
            @vn_Rowcount  INT,
            @vc_ErrMsg    VARCHAR(255)

    DECLARE @vb_Bit             INT,
            @vn_Col             INT,
            @vn_Colunas         INT,
            @vc_Char            INT,
            @vn_Colname         VARCHAR(128),
            @vn_xType           TINYINT,
            @vc_Identificador   VARCHAR(1000),
            @vc_Cmd             VARCHAR(2000), 
            @vc_Usuario         VARCHAR(128),
            @vc_Estacao         VARCHAR(128),
            @vc_DataHora        VARCHAR(21),
            @vc_Acao            CHAR(1),
            @vc_Identificadores VARCHAR(1000)

    -- Valida parâmetros
    IF ISNULL( @pc_Tabela, '' ) = ''
    BEGIN
        RAISERROR ( 'spu_Auditoria_Insere (%s) - O parâmetro @pc_Tabela deve ser informado!', 16, 1, @pc_Tabela )
        GOTO TrataErro
    END

    -- Data e Usuário
    SELECT  @vc_DataHora = CONVERT( VARCHAR(8), ISNULL( @pc_DataHora, GETDATE() ), 112 ) + ' ' + CONVERT( VARCHAR(12), ISNULL( @pc_DataHora, GETDATE() ), 114 ),
            @vc_Usuario  = ISNULL( NULLIF( dbo.fcn_BuscaValorLinha( HOST_NAME(), 'User' ), '' ), SYSTEM_USER ),
            @vc_Estacao  = ISNULL( NULLIF( dbo.fcn_BuscaValorLinha( HOST_NAME(), 'Workstation' ), '' ), HOST_NAME() )

    -- Verifica se as tabelas temporárias existem
    IF OBJECT_ID( 'tempdb..#ins' ) IS NULL OR
       OBJECT_ID( 'tempdb..#del' ) IS NULL 
    BEGIN
        RAISERROR ( 'spu_Auditoria_Insere (%s) - As tabelas #ins e #del devem ser criadas antes da execução desta procedure, baseadas nas tabeas "inserted" e "deleted" da trigger', 16, 1, @pc_Tabela )
        GOTO TrataErro
    END

    -- Ação
    IF EXISTS ( SELECT 1 FROM #ins )
        IF EXISTS ( SELECT 1 FROM #del )
            SELECT @vc_Acao = 'U'    -- UPDATE
        ELSE
            SELECT @vc_Acao = 'I'    -- INSERT
    ELSE
        SELECT @vc_Acao = 'D'        -- DELETE
 
    -- Busca o Identificar para o WHERE 
    -- Get primary key columns for full outer join
    --SELECT @vc_Identificador = COALESCE( @vc_Identificador + ' AND', ' ON') + ' i.' + c.name+ ' = d.' + c.name
	SELECT @vc_Identificador = COALESCE(' ON', @vc_Identificador + ' AND') + ' i.' + c.name+ ' = d.' + c.name
    FROM   sysobjects pk,
           sysindexes i,
           sysindexkeys k,
           syscolumns c
    WHERE  pk.parent_obj = OBJECT_ID(@pc_Tabela)
    AND    pk.xtype      = 'PK'
    AND    i.name        = pk.name
    AND    k.id          = i.id
    AND    k.indid       = i.indid
    AND    c.id          = k.id
    AND    c.colid       = k.colid

    -- Monta o Identificador para o SELECT
    SELECT @vc_Identificadores = COALESCE( @vc_Identificadores + '+', '' ) + '''' + c.name + '=''+CONVERT(VARCHAR(100), COALESCE(i.' + c.name +',d.' + c.name + ' ))+''|'''
    FROM   sysobjects pk,
           sysindexes i,
           sysindexkeys k,
           syscolumns c
    WHERE  pk.parent_obj = OBJECT_ID(@pc_Tabela)
    AND    pk.xtype = 'PK'
    AND    i.name   = pk.name
    AND    k.id     = i.id
    AND    k.indid  = i.indid
    AND    c.id     = k.id
    AND    c.colid  = k.colid

    IF @vc_Identificador IS NULL
    BEGIN
        RAISERROR ( 'spu_Auditoria_Insere (%s) - A Tabela "%s" nao possui chave identificadora (chave primária)', 16, 1, @pc_Tabela, @pc_Tabela )
        GOTO TrataErro
    END
 
    -- Controle de Transação
    SET @vn_Trancount = @@TRANCOUNT
    IF @@TRANCOUNT = 0 
       BEGIN TRANSACTION

    SELECT @vn_Col = 0, @vn_Colunas = MAX(colorder) FROM syscolumns WHERE id = OBJECT_ID(@pc_Tabela)

    WHILE @vn_Col < @vn_Colunas
    BEGIN
        SELECT TOP 1 @vn_Col     = colorder, 
                     @vn_Colname = name, 
                     @vn_xType   = xtype 
        FROM   syscolumns 
        WHERE  id = OBJECT_ID(@pc_Tabela) 
        AND    colorder > @vn_Col

        SELECT @vb_Bit  = ( @vn_Col - 1 ) % 8 + 1
        SELECT @vb_Bit  = POWER( 2, @vb_Bit - 1 )
        SELECT @vc_Char = ( ( @vn_Col - 1 ) / 8 ) + 1

        IF ( SUBSTRING( COLUMNS_UPDATED(), @vc_Char, 1 ) & @vb_Bit > 0 OR @vc_Acao IN ( 'I', 'D', 'U' ) ) AND
           @vn_xType NOT IN ( 34, 35, 99 ) -- image, text, ntext
        BEGIN
            SELECT @vc_Cmd =            'INSERT Auditoria (Acao, Tabela, Identificador, Coluna, ValorAntigo, ValorNovo, DataHora, Usuario, Estacao)'
            SELECT @vc_Cmd = @vc_Cmd +  ' SELECT ''' + @vc_Acao + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ',''' + @pc_Tabela + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ',' + @vc_Identificadores
            SELECT @vc_Cmd = @vc_Cmd +  ',''' + @vn_Colname + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ',CONVERT(VARCHAR(1000),d.' + @vn_Colname + ',121)'
            SELECT @vc_Cmd = @vc_Cmd +  ',CONVERT(VARCHAR(1000),i.' + @vn_Colname + ',121)'
            SELECT @vc_Cmd = @vc_Cmd +  ',''' + @vc_DataHora + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ',''' + @vc_Usuario + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ',''' + @vc_Estacao + ''''
            SELECT @vc_Cmd = @vc_Cmd +  ' FROM #ins i FULL OUTER JOIN #del d'
            SELECT @vc_Cmd = @vc_Cmd +  @vc_Identificador
            SELECT @vc_Cmd = @vc_Cmd +  ' WHERE i.' + @vn_Colname + ' <> d.' + @vn_Colname 
            SELECT @vc_Cmd = @vc_Cmd +  ' OR (i.' + @vn_Colname + ' IS NULL AND  d.' + @vn_Colname + ' IS NOT NULL)' 
            SELECT @vc_Cmd = @vc_Cmd +  ' OR (i.' + @vn_Colname + ' IS NOT NULL AND d.' + @vn_Colname + ' IS NULL)' 

            EXEC ( @vc_Cmd )
        END
    END

    IF @vn_Trancount = 0
       COMMIT TRANSACTION

    GOTO Saida
    
    TrataErro:
        IF @vn_Trancount = 0
    		ROLLBACK TRANSACTION
	
    Saida:

END

GO



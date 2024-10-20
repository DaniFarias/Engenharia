-- Executar os blocos individualmente
-- Executar os blocos individualmente
-- Executar os blocos individualmente
-- Executar os blocos individualmente
-- Executar os blocos individualmente
select * from Alter_Parcelas
select * from Tbl_Contas_Rec
select * from Tbl_Parcelas_Rec
select * from Tbl_Contas_Pag
select * from Tbl_Parcelas_Pag

ALTER TABLE Alter_Parcelas ADD Sequencia INT IDENTITY(1,1)
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'PARCELAS_NAO_IMPORTADAS')
	DROP VIEW PARCELAS_NAO_IMPORTADAS
GO

CREATE VIEW PARCELAS_NAO_IMPORTADAS AS 
SELECT * FROM ALTER_PARCELAS 
WHERE NrTitulo NOT IN (SELECT NrTitulo FROM TBL_PARCELAS_REC WHERE NrTitulo IS NOT NULL UNION ALL SELECT NrTitulo FROM TBL_PARCELAS_PAG WHERE NrTitulo IS NOT NULL)
AND NRTITULO IS NOT NULL 
GO

------------------------------------------------------------------
-- Conta a Receber
------------------------------------------------------------------
INSERT INTO Tbl_Contas_Rec (CodEmpresa, Documento, TipoDoc, ValorProd, Valor, DtEmissao, CodEmp, FornecCodEmp)
SELECT 1 AS CodEmpresa, 
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS Documento, 
'03' AS TipoDoc,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS ValorProd, 
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS Valor, 
Alter_Parcelas.DtEmissao, Tbl_Clientes.CodEmp, 
Tbl_Fornecedores.CodEmp AS FornecCodEmp
FROM Alter_Parcelas
INNER JOIN PARCELAS_NAO_IMPORTADAS ON Alter_Parcelas.IdFluxo = PARCELAS_NAO_IMPORTADAS.IdFluxo
AND Alter_Parcelas.CdFluxo = PARCELAS_NAO_IMPORTADAS.CdFluxo
AND Alter_Parcelas.IdPessoa = PARCELAS_NAO_IMPORTADAS.IdPessoa
AND Alter_Parcelas.IdTipoMovimento = PARCELAS_NAO_IMPORTADAS.IdTipoMovimento
LEFT JOIN Tbl_Clientes ON Alter_Parcelas.IdPessoa = Tbl_Clientes.IdPessoa
LEFT JOIN Tbl_Fornecedores ON Alter_Parcelas.IdPessoa = Tbl_Fornecedores.IdPessoa
WHERE Alter_Parcelas.TpTitulo = 'R'
AND Alter_Parcelas.NrTitulo IS NOT NULL
AND Alter_Parcelas.DtExclusao IS NULL
GO

------------------------------------------------------------------
-- Parcela a Receber
------------------------------------------------------------------
INSERT INTO Tbl_Parcelas_Rec (CodEmpresa, Documento, TipoDoc, NumParcela, DtVencto, Valor, DtReceb, ValorReceb, Quitada, DescForma, Obs, NrTitulo)

SELECT 1 AS CodEmpresa, 
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS Documento, '03' AS TipoDoc, 
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS NumParcela,
(CASE WHEN ISDATE(Alter_Parcelas.DtVencimento) = 1 THEN Alter_Parcelas.DtVencimento ELSE '01/01/1900' END) AS DtVencto,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS Valor, 
(CASE WHEN ISDATE(Alter_Parcelas.DtBaixa) = 1 THEN Alter_Parcelas.DtBaixa ELSE NULL END) AS DtReceb,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlPago, ',','.')) AS ValorReceb,
(CASE WHEN ISDATE(Alter_Parcelas.DtBaixa) = 1 THEN 1 ELSE 0 END) AS Quitada,
ISNULL( LEFT(LTRIM(RTRIM(Alter_Movimentacao.NmTpRecebimento)), 15), 'DINHEIRO') AS DescForma,
Alter_Parcelas.NrTitulo + SPACE(1) + ISNULL(Alter_Parcelas.NmObservacao, '') + SPACE(1) + ISNULL(Alter_Parcelas.DsHistorico, '') AS Obs, Alter_Parcelas.NrTitulo
FROM Alter_Parcelas
LEFT JOIN Alter_Movimentacao ON Alter_Parcelas.IdTipoMovimento = Alter_Movimentacao.IdTpRecebimento
INNER JOIN PARCELAS_NAO_IMPORTADAS ON Alter_Parcelas.IdFluxo = PARCELAS_NAO_IMPORTADAS.IdFluxo
AND Alter_Parcelas.CdFluxo = PARCELAS_NAO_IMPORTADAS.CdFluxo
AND Alter_Parcelas.IdPessoa = PARCELAS_NAO_IMPORTADAS.IdPessoa
AND Alter_Parcelas.IdTipoMovimento = PARCELAS_NAO_IMPORTADAS.IdTipoMovimento
WHERE Alter_Parcelas.TpTitulo = 'R'
AND Alter_Parcelas.NrTitulo IS NOT NULL
AND Alter_Parcelas.DtExclusao IS NULL
GO





------------------------------------------------------------------
-- Conta a Pagar
------------------------------------------------------------------
INSERT INTO Tbl_Contas_Pag (CodEmpresa, Documento, TipoDoc, CodEmp, FornecCodEmp, ValorProd, Valor, DtEmissao)

SELECT 1 AS CodEmpresa, 
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS Documento, 
'03' AS TipoDoc,
ISNULL(Tbl_Clientes.CodEmp, 0) AS CodEmp, 
ISNULL(Tbl_Fornecedores.CodEmp, 0) AS FornecCodEmp,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS ValorProd, 
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS Valor, 
Alter_Parcelas.DtEmissao
FROM Alter_Parcelas
INNER JOIN PARCELAS_NAO_IMPORTADAS ON Alter_Parcelas.IdFluxo = PARCELAS_NAO_IMPORTADAS.IdFluxo
AND Alter_Parcelas.CdFluxo = PARCELAS_NAO_IMPORTADAS.CdFluxo
AND Alter_Parcelas.IdPessoa = PARCELAS_NAO_IMPORTADAS.IdPessoa
AND Alter_Parcelas.IdTipoMovimento = PARCELAS_NAO_IMPORTADAS.IdTipoMovimento
LEFT JOIN Tbl_Clientes ON Alter_Parcelas.IdPessoa = Tbl_Clientes.IdPessoa
LEFT JOIN Tbl_Fornecedores ON Alter_Parcelas.IdPessoa = Tbl_Fornecedores.IdPessoa
WHERE Alter_Parcelas.TpTitulo = 'P'
AND Alter_Parcelas.NrTitulo IS NOT NULL
AND Alter_Parcelas.DtExclusao IS NULL
GO

------------------------------------------------------------------
-- Parcela a Pagar
------------------------------------------------------------------
INSERT INTO Tbl_Parcelas_Pag (CodEmpresa, Documento, TipoDoc, CodEmp, FornecCodEmp, NumParcela, DtVencto, Valor, DtPagto, ValorPagto, Quitada, DescForma, Obs, NrTitulo)

SELECT 1 AS CodEmpresa, 
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS Documento, '03' AS TipoDoc, 
ISNULL(Tbl_Clientes.CodEmp, 0) AS CodEmp, 
ISNULL(Tbl_Fornecedores.CodEmp, 0) AS FornecCodEmp,
'NI' + CONVERT(CHAR(6), 200000 + PARCELAS_NAO_IMPORTADAS.Sequencia) AS NumParcela,
Alter_Parcelas.DtVencimento AS DtVencto,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlTitulo, ',','.')) AS Valor, 
(CASE WHEN ISDATE(Alter_Parcelas.DtBaixa) = 1 THEN Alter_Parcelas.DtBaixa ELSE NULL END) AS DtPagto,
CONVERT(MONEY, REPLACE(Alter_Parcelas.VlPago, ',','.')) AS ValorPagto,
(CASE WHEN ISDATE(Alter_Parcelas.DtBaixa) = 1 THEN 1 ELSE 0 END) AS Quitada,
ISNULL( LEFT(LTRIM(RTRIM(Alter_Movimentacao.NmTpRecebimento)), 15), 'DINHEIRO') AS DescForma,
Alter_Parcelas.NrTitulo + SPACE(1) + ISNULL(Alter_Parcelas.NmObservacao, '') + SPACE(1) + ISNULL(Alter_Parcelas.DsHistorico, '') AS Obs, Alter_Parcelas.NrTitulo
FROM Alter_Parcelas
LEFT JOIN Alter_Movimentacao ON Alter_Parcelas.IdTipoMovimento = Alter_Movimentacao.IdTpRecebimento
INNER JOIN PARCELAS_NAO_IMPORTADAS ON Alter_Parcelas.IdFluxo = PARCELAS_NAO_IMPORTADAS.IdFluxo
AND Alter_Parcelas.CdFluxo = PARCELAS_NAO_IMPORTADAS.CdFluxo
AND Alter_Parcelas.IdPessoa = PARCELAS_NAO_IMPORTADAS.IdPessoa
AND Alter_Parcelas.IdTipoMovimento = PARCELAS_NAO_IMPORTADAS.IdTipoMovimento
LEFT JOIN Tbl_Clientes ON Alter_Parcelas.IdPessoa = Tbl_Clientes.IdPessoa
LEFT JOIN Tbl_Fornecedores ON Alter_Parcelas.IdPessoa = Tbl_Fornecedores.IdPessoa
WHERE Alter_Parcelas.TpTitulo = 'P'
AND Alter_Parcelas.NrTitulo IS NOT NULL
AND Alter_Parcelas.DtExclusao IS NULL
GO
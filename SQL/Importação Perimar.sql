 UPDATE Tbl_Produtos_Empresa SET
Estoque = QtEstoque
FROM Tbl_Produtos_Empresa
INNER JOIN (
SELECT Alter_Estoque.IdDetalhe, Alter_Estoque.DtReferencia, Alter_Estoque.QtEstoque, CdPrincipal, NmProduto
FROM Alter_Estoque
INNER JOIN (SELECT IdDetalhe, MAX(DtReferencia) AS DtReferencia FROM Alter_Estoque group by Alter_Estoque.IdDetalhe) AS Ultimo ON
Alter_Estoque.IdDetalhe = Ultimo.IdDetalhe
AND Alter_Estoque.DtReferencia = Ultimo.DtReferencia
INNER JOIN Alter_Detalhes ON Alter_Estoque.IdDetalhe = Alter_Detalhes.IdDetalhe
INNER JOIN Alter_Produtos ON Alter_Detalhes.IdProduto = Alter_Produtos.IdProduto) AS Estoques ON Tbl_Produtos_Empresa.CodProd = Estoques.CdPrincipal


select 'insert into Tbl_Inventario_Itens ( IdInventario, CodProd, Estoque, PrCusto, Prmedio ) values ( ' +
' 2, ' + cast( codprod as varchar( 10 ) ) + ', ' + cast(estoque as varchar(30)) + ', ' + cast(prmedio as varchar(30)) + ', ' + cast(prmedio as varchar(30)) + ' )'
from tbl_produtos_empresa

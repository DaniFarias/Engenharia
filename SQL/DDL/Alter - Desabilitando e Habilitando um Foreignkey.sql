ALTER TABLE TBL_CONTAS_REC
NOCHECK CONSTRAINT FK_TBL_CONTAS_REC_TBL_PEDIDOS_VENDA
GO

delete from TBL_PEDIDOS_VENDA
where DATAPED between '11/03/2013' and '31/12/2014'
and DATAFECHA is not null
GO

update tbl_contas_rec set numped = null
where numped not in ( select numped from tbl_pedidos_venda )
and numped is not null
GO

ALTER TABLE TBL_CONTAS_REC
CHECK CONSTRAINT FK_TBL_CONTAS_REC_TBL_PEDIDOS_VENDA
GO

Uma foreign key especfica
-- 1) Desabilita uma foreign key espec�fica de uma tabela SQL Server
ALTER TABLE [NomeDaTabela] NOCHECK CONSTRAINT [NomeDaConstraint]

-- 2) Habilita uma foreign key espec�fica de uma tabela SQL Server
ALTER TABLE [NomeDaTabela] CHECK CONSTRAINT [NomeDaConstraint]
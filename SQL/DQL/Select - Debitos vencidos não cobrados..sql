-- AUTOR: DANIEL FARIAS
-- DESCRIÇÃO: EXCLUIR OS DÉBITOS ANTIGOS, JA VENCIDOS, QUE NÃO FORAM COBRADOS E NÃO SÃO DO SAAE DO SISTEMA.
-- DATA INICIO 23/10/2017
-- DATA FIM 24/10/2017
-- OBSERVAÇÃO: FOI FEITO BACKUP NO ARQUIVO EXCEL DOS REGISTROS EXCLUÍDOS.  

select * from faturamento.debito_a_cobrar
where dbtp_id in( 
				select dbtp_id
				from faturamento.debito_tipo as dt
				where dbtp_tiporecebimento = 'X'
				)
and dbac_nnprestacaocobradas = 0
and dbac_amcobrancadebito < 201709
and dcst_idatual in (0,1,2)

begin transaction 

delete from faturamento.debito_a_cobrar
where dbtp_id in( 
				select dbtp_id
				from faturamento.debito_tipo as dt
				where dbtp_tiporecebimento = 'X'
				)
and dbac_nnprestacaocobradas = 0
and dbac_amcobrancadebito < 201709
and dcst_idatual in (0,1,2)

rollback transaction
commit transaction

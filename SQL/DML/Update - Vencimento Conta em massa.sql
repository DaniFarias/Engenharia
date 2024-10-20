-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: DANIEL FARIAS
-- DESCRICAO: https://app.clickup.com/t/1f1ujx
-- DATA INICIO 19/02/2020
-- DATA FIM 19/02/2020
-- OBSERVACAO: 


select 'update faturamento.conta set cnta_dtvencimentoconta = (cnta_dtvencimentoconta - interval ''1 month'')::date where cnta_id = '|| conta.cnta_id|| ' and imov_id = '||conta.imov_id || ';'
  from faturamento.conta 
  left outer join arrecadacao.pagamento p on p.cnta_id = conta.cnta_id
 inner join faturamento.conta canter on (canter.imov_id = conta.imov_id)
 where conta.cnta_amreferenciaconta =  202001
   and canter.cnta_amreferenciaconta =  201912
   and conta.ftgr_id in(24,25)
   and (conta.cnta_dtvencimentoconta  - current_date ) > 45 and p.cnta_id is null
   
begin transaction 

update faturamento.conta set cnta_dtvencimentoconta = (cnta_dtvencimentoconta - interval '1 month')::date where cnta_id = 8643898 and imov_id = 813443;
update faturamento.conta set cnta_dtvencimentoconta = (cnta_dtvencimentoconta - interval '1 month')::date where cnta_id = 8643885 and imov_id = 800260;

commit transaction
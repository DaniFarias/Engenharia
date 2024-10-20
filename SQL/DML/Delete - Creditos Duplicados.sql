select imov_id, crar_amreferenciacredito, crar_vlcredito, count(1) 
from faturamento.credito_a_realizar
where crar_tmatucredito between '2021-01-01 23:59' and '2021-05-30 00:00'
	and dcst_idatual = 0
		and crar_vlresidualmesanterior = 0
		and crar_nnprestacaorealizadas = 0
group by imov_id, crar_amreferenciacredito, crar_vlcredito
having count(1) > 1


begin transaction 

delete	
 from faturamento.credito_a_realizar a
where
	exists (
			select 
				1
			from 
				faturamento.credito_a_realizar as b
			where
				a.imov_id = b.imov_id
				and a.crar_amreferenciacredito = b.crar_amreferenciacredito
				and a.crar_vlcredito = b.crar_vlcredito
				and a.crar_tmatucredito between '2021-01-01 23:59' and '2021-05-30 00:00'
				and a.dcst_idatual = 0
				and a.crar_vlresidualmesanterior = 0
				and crar_nnprestacaorealizadas = 0
				and a.crar_tmatucredito < b.crar_tmatucredito
			);

commit transaction
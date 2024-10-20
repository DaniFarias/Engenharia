
-- Contas de 2018 que foram pagas no intervalo entre corte e religa.
select sum(cnta_vlagua + cnta_vlesgoto + cnta_vldebitos - cnta_vlcreditos) 
from faturamento.conta as c
left join arrecadacao.pagamento as p
on c.cnta_id = p.cnta_id
where cnta_amreferenciaconta between '201801' and '201812' 
and last_id = 5
and p.cnta_id is null

select b.bair_nmbairro as "Bairro",
	   i.imov_id as "Qtde Imovel",
	   c.cnta_amreferenciaconta as "MesReferencia", 
	   sum (c.cnta_nnconsumoagua) as "Consumo",
	   round(round (sum (c.cnta_nnconsumoagua),2) / count (i.imov_id),1) as "Consumo Medio",
	   sum ((c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos) - c.cnta_vlcreditos) as "Valor",
	   round(sum ((c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos) - c.cnta_vlcreditos) / count (i.imov_id),2) as "Valor Medio"
from cadastro.imovel i
inner join faturamento.conta c on (i.imov_id = c.imov_id)
inner join micromedicao.rota r on (i.rota_id = r.rota_id)
inner join cadastro.bairro b on   (b.bair_id = i.bair_id)
where i.stcm_id > 26 and 
	c.cnta_amreferenciaconta between '201611' and '201710'
	group by c.cnta_amreferenciaconta, b.bair_nmbairro, i.imov_id


select i.imov_id,
	   i.stcm_id as "Setor",
	   count (i.imov_id) as "Qtde Imovel",
	   c.cnta_amreferenciaconta as "MesReferencia", 
	   sum (c.cnta_nnconsumoagua) as "Consumo",
	   round(round (sum (c.cnta_nnconsumoagua),2) / count (i.imov_id),1) as "Consumo Medio",
	   sum ((c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos) - c.cnta_vlcreditos) as "Valor",
	   round(sum ((c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos) - c.cnta_vlcreditos) / count (i.imov_id),2) as "Valor Medio"
from cadastro.imovel i
inner join faturamento.conta c on (i.imov_id = c.imov_id)
where i.stcm_id in (26, 41, 31) and  
	c.cnta_amreferenciaconta between '201611' and '201710'
	group by c.cnta_amreferenciaconta, i.stcm_id, i.imov_id

26 baga 31 chon 41 sao v

select cnta_amreferenciaconta, la.last_dsligacaoaguasituacao
from faturamento.conta as c
inner join atendimentopublico.ligacao_agua_situacao as la
on c.last_id = la.last_id
where cnta_amreferenciaconta between '201901' and '201908'

select cnta_id, la.last_dsligacaoaguasituacao from faturamento.conta as c inner join atendimentopublico.ligacao_agua_situacao as la on c.last_id = la.last_id where cnta_amreferenciaconta between '201901' and '201908'

select orse_id, st.svtp_dsservicotipo,orse_amreferencia from atendimentopublico.ordem_servico as os inner join atendimentopublico.servico_tipo as st on os.svtp_id = st.svtp_id where os.svtp_id in (1282,1280,1281) and orse_amreferencia between '201901' and '201908'


select cnta_amreferenciaconta, sum(cnta_nnconsumoagua)
from faturamento.conta
where cnta_amreferenciaconta between '201901' and '201908'
group by cnta_amreferenciaconta
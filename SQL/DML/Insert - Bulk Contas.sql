select
'INSERT INTO micromedicao.medicao_historico (mdhi_id, imov_id, medt_id, mdhi_amleitura, mdhi_nnvezesconsecutivaanormalidade, mdhi_dtleituraanteriorfaturamento, mdhi_nnleituraanteriorfaturamento, mdhi_nnleituraanteriorinformada, mdhi_dtleituraatualinformada, mdhi_nnleituraatualinformada, mdhi_dtleituraatualfaturamento, mdhi_nnleituraatualfaturamento, mdhi_nnconsumomedidomes, mdhi_nnconsumoinformado, func_id, ltan_idleituraanormalidadeinformada, ltan_idleituraanormalidadefaturamento, ltst_idleiturasituacaoatual, ltst_idleiturasituacaoanterior, mdhi_tmultimaalteracao, hidi_id, lagu_id, mdhi_dtleituraprocessamentomovimento, mdhi_nnconsumomediohidrometro, mdhi_nnleituracampo, leit_id, usur_idalteracao, mdhi_icanalisado, mdhi_dtleituracampo, motp_id, ctmp_id, mdhi_nnleituraanteriorinformadabkp, mdhi_nnleituraanteriorfaturamentobkp, mdhi_nnleituraatualfaturamentobkp)
VALUES((select NEXTVAL(''micromedicao.sequence_medicao_historico'')),'||lagu_id||', 1, 202103, NULL, ''2021-02-23'', 0, 0, ''2021-03-29 00:00:00.000'', null, ''2021-03-29'', 6, null, NULL, NULL, NULL, NULL, 2, 2, now(), '||coalesce (hidi_id, 0)||','||lagu_id||', ''2021-04-13'', null, null, NULL, NULL, 2, ''2021-03-29'', NULL, NULL, NULL, NULL, NULL);'
from atendimentopublico.ligacao_agua
where
lagu_id in (
select c.imov_id from faturamento.conta c 
left join micromedicao.medicao_historico mh 
on c.imov_id = mh.lagu_id and c.cnta_amreferenciaconta = mh.mdhi_amleitura 
where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202103 and mh.mdhi_id is null);						

select
	imov_id
from
	cadastro.imovel i
where
	imov_icexclusao = 2
	and last_id in (3, 5)
	and i.rota_id in (
	select
		rota_id
	from
		micromedicao.rota r
	where
		ftgr_id = 26
		and rota_id not in (1323, 1334, 1335))
		
update cadastro.imovel set imov_icexclusao = 1 where imov_id in (917781,912712,913587,908402,907885,849332);


select * from micromedicao.medicao_historico mh where lagu_id = 406538


select lagu_id, count(lagu_id) 
from micromedicao.medicao_historico mh 
where  mdhi_amleitura = 202103 --and lagu_id =  397920
and lagu_id in (select
	imov_id
from
	cadastro.imovel i
where
	imov_icexclusao = 2
	and last_id in (3, 5)
		and i.rota_id in (
		select
			rota_id
		from
			micromedicao.rota r
		where
			ftgr_id = 26 and rota_id not in (1323, 1334, 1335)))
group by lagu_id 
having count(lagu_id)>1 
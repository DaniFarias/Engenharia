select lagu_id ,* from micromedicao.medicao_historico mh 
where mdhi_amleitura = 202104
and lagu_id in (select imov_id from cadastro.imovel i where rota_id in (1323,940,1331));


select lagu_id ,* 
from micromedicao.medicao_historico mh 
inner join cadastro.imovel i 
on mh.lagu_id = i.imov_id 
inner join micromedicao.rota r 
on i.rota_id = r.rota_id 
where r.ftgr_id = 26 
and mdhi_amleitura = 202104
and i.rota_id not in (1323,940,1331) and i.imov_id = 394530

select c.cnta_vlagua, cl.cntal_vlagua, c.cnta_vlesgoto, cl.cntal_vlesgoto, * from faturamento.conta c 
inner join (select cl.cnta_id, cl.imov_id, max(cl.cntal_vlagua) as cntal_vlagua, max(cl.cntal_vlesgoto) as cntal_vlesgoto
			from auditoria.conta_log cl
			group by cl.cnta_id, cl.imov_id) as cl
on c.cnta_id = cl.cnta_id and c.imov_id = cl.imov_id
where c.rota_id in (1323,940,1331) and c.cnta_amreferenciaconta = 202103 and c.cnta_vlagua <> cl.cntal_vlagua

select lagu_id, * from micromedicao.medicao_historico mh where lagu_id in (--584940)
select imov_id from cadastro.imovel i where i.rota_id in (select rota_id from micromedicao.rota r where ftgr_id = 26 ) and i.rota_id not in (1323,940,1331))
and mdhi_amleitura = 202104

delete from faturamento.conta 
where imov_id in (
select lagu_id from micromedicao.medicao_historico mh where lagu_id in (--584940)
select imov_id from cadastro.imovel i where i.rota_id in (select rota_id from micromedicao.rota r where ftgr_id = 26 ) and i.rota_id not in (1323,940,1331))
and mdhi_amleitura = 202104) and cnta_amreferenciaconta = 202104 


--IMOVEIS DA ROTA 26 SEM SEQUENCIA
select rota_id, imov_nnsequencialrota, * from cadastro.imovel i where rota_id in (select rota_id from micromedicao.rota r where ftgr_id = 26 and rota_id not in (1323,1334,1335)) and imov_nnsequencialrota is not null;
select rota_id ,imov_nnsequencialrota, * from cadastro.imovel i where imov_id = 923060;

--IMOVEIS INATIVOS/SUPRIMIDOS COM ESGOTO LIGADOS
select rota_id ,* from cadastro.imovel i last_id = 9 and lest_id = 3;
select rota_id ,* from cadastro.imovel i where last_id = 6 and lest_id = 3;

--IMOVEIS SEM SUBCATEGORIA CADASTRADA
select imov_id from cadastro.imovel i where rota_id in (select rota_id from micromedicao.rota r where ftgr_id = 26);
select i.imov_id 
from cadastro.imovel i 
inner join micromedicao.rota r
on i.rota_id = r.rota_id 
left join cadastro.imovel_subcategoria is2 
on i.imov_id = is2.imov_id 
where r.ftgr_id = 26 and is2.imov_id is null


-- DISTRITOS GRUPO 26
select  b.bair_id, b.bair_nmbairro, count(i.imov_id), r.rota_cdrota,r.rota_id 
from cadastro.imovel i 
inner join micromedicao.rota r
on r.rota_id = i.rota_id 
inner join cadastro.logradouro_bairro lb 
on i.lgbr_id = lb.lgbr_id 
inner join cadastro.bairro b 
on lb.bair_id = b.bair_id
where last_id in (3,5)
and r.ftgr_id = 26 
group by b.bair_nmbairro, r.rota_cdrota ,b.bair_id,r.rota_id

--RELATORIO DE CONTAS GERADAS GRUPO 26
select cnta_vlagua, i.imov_id, i.rota_id, c.rota_id, *
from faturamento.conta c
inner join cadastro.imovel i 
on c.imov_id = i.imov_id 
inner join micromedicao.rota r 
on i.rota_id = r.rota_id and i.rota_id not in (1323,940,1331)
where r.ftgr_id = 26 and cnta_amreferenciaconta = 202104 --and i.rota_id <> c.rota_id;  

--RELATORIO DE CONTAS GERADAS GRUPO 26
select b.bair_nmbairro ,mh.mdhi_nnleituraatualfaturamento,cc.ctcg_nnconsumoagua, cc.ctcg_qteconomia, cc.catg_id, cc.ctcg_vlagua, cnta_vlagua, cc.ctcg_vlesgoto, cnta_vlesgoto,*
from faturamento.conta c
inner join micromedicao.medicao_historico mh 
on c.imov_id = mh.lagu_id and c.cnta_amreferenciaconta = mh.mdhi_amleitura 
inner join cadastro.imovel i 
on c.imov_id = i.imov_id 
inner join cadastro.logradouro_bairro lb 
on i.lgbr_id = lb.lgbr_id 
inner join cadastro.bairro b 
on lb.bair_id = b.bair_id 
inner join faturamento.conta_categoria cc
on c.cnta_id = cc.cnta_id 
inner join micromedicao.rota r 
on i.rota_id = r.rota_id and c.rota_id not in (1323,940,1331)
where r.ftgr_id = 26 and cnta_amreferenciaconta = 202104 

begin transaction
update faturamento.conta_categoria cc set ctcg_nnconsumoagua = cnta_nnconsumoagua
from faturamento.conta c
where c.cnta_id = cc.cnta_id and c.rota_id  in (1323,940,1331) and cnta_amreferenciaconta = 202103
commit transaction 

--REMOVER CONTAS PROTOCOLADAS GRUPO 26
select * 
from faturamento.conta_protocolada 
where clie_id in (select imov_id from faturamento.conta where ftgr_id = 26 and cnta_amreferenciaconta = 202103);

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- DISTRITOS GRUPO 27
select  b.bair_id, b.bair_nmbairro, count(i.imov_id) as imoveis, r.rota_cdrota 
from cadastro.imovel i 
inner join micromedicao.rota r
on r.rota_id = i.rota_id 
inner join cadastro.logradouro_bairro lb 
on i.lgbr_id = lb.lgbr_id 
inner join cadastro.bairro b 
on lb.bair_id = b.bair_id 
where last_id in (3,5)
and r.ftgr_id = 27
group by b.bair_nmbairro,r.rota_cdrota,b.bair_id

--RELATORIO DE CONTAS GERADAS GRUPO 27
select cnta_vlagua, cnta_vlesgoto, c.*  
from faturamento.conta c
inner join cadastro.imovel i 
on c.imov_id = i.imov_id 
inner join micromedicao.rota r 
on i.rota_id = r.rota_id 
where r.ftgr_id = 27 and cnta_amreferenciaconta = 202103; 

--RELATORIO DE CONTAS GERADAS GRUPO 27
select mh.mdhi_nnleituraatualfaturamento,cc.ctcg_nnconsumoagua, cc.ctcg_qteconomia, cc.catg_id, cc.ctcg_vlagua, cnta_vlagua, cc.ctcg_vlesgoto, cnta_vlesgoto,*
from faturamento.conta c
inner join micromedicao.medicao_historico mh 
on c.imov_id = mh.lagu_id and c.cnta_amreferenciaconta = mh.mdhi_amleitura 
inner join cadastro.imovel i 
on c.imov_id = i.imov_id 
inner join faturamento.conta_categoria cc
on c.cnta_id = cc.cnta_id 
inner join micromedicao.rota r 
on i.rota_id = r.rota_id 
where r.ftgr_id = 27 and cnta_amreferenciaconta = 202103; 

--REMOVER CONTAS PROTOCOLADAS GRUPO 27
select * 
from faturamento.conta_protocolada 
where clie_id in (select imov_id from faturamento.conta where ftgr_id = 27 and cnta_amreferenciaconta = 202103);

select * from faturamento.conta c 
inner join micromedicao.medicao_historico mh 
on c.imov_id = mh.lagu_id and c.cnta_amreferenciaconta = mh.mdhi_amleitura 
where rota_id not in (1323,940,1331) and ftgr_id = 26 and cnta_amreferenciaconta = 202104;

select ftgr_id,rota_id , rota_cdrota, rota_amreferenciaprocessada from micromedicao.rota where ftgr_id IN (26,35);

select * from cadastro.imovel i where rota_id in (940,1331); 
select * from faturamento.conta c where imov_id =766720

----------------------------------------------------------------------------------------------------------------------------------------------------------
--CANCELA DEBITOS ANTERIORES A 202102 (VOLTA DA COBRANÇA DOS DISTRITOS) 1901 REGISTROS
begin transaction 
update faturamento.debito_a_cobrar dc set dcst_idanterior = dcst_idatual, dcst_idatual = 3
where dbac_id in (
select  dbac_id --sum(dbac_vldebito) ,i.imov_id 
from faturamento.debito_a_cobrar dc
inner join cadastro.imovel i 
on i.imov_id = dc.imov_id 
inner join cadastro.logradouro_bairro lb 
on i.lgbr_id = lb.lgbr_id 
where dbac_amreferenciadebito < 202102 and dcst_idatual = 3 and dbac_nnprestacaodebito<>dbac_nnprestacaocobradas
and i.rota_id in (select rota_id from micromedicao.rota r where ftgr_id = 26 and rota_id not in (1323,1334,1335))
);

update faturamento.conta  set cnta_vldebitos = 0, cnta_vlcreditos = 0 
where cnta_id in (select cnta_id  from faturamento.conta where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202102);

delete from faturamento.credito_realizado cr 
where cnta_id in (select cnta_id  from faturamento.conta where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202102);

delete from faturamento.debito_cobrado dc 
where cnta_id in (select cnta_id  from faturamento.conta where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202102);

select * from faturamento.credito_realizado cr 
where cnta_id in (select cnta_id  from faturamento.conta where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202102);

update faturamento.debito_a_cobrar set dbac_nnprestacaocobradas = 0, dbac_amcobrancadebito = 202103, dbac_amreferenciacontabil = 202103, dbac_amreferenciaprestacao = 202103
where dbac_id in (select dbac_id from faturamento.debito_a_cobrar dc where imov_id in (select imov_id from faturamento.conta where rota_id not in (1323,1334,1335) and ftgr_id = 26 and cnta_amreferenciaconta = 202102));

commit transaction 

--DEBITOS POR BAIRRO
select  b.bair_nmbairro, sum(dbac_vldebito) --,i.imov_id 
from faturamento.debito_a_cobrar dc
inner join cadastro.imovel i 
on i.imov_id = dc.imov_id 
inner join cadastro.logradouro_bairro lb 
on i.lgbr_id = lb.lgbr_id 
inner join cadastro.bairro b 
on lb.bair_id = b.bair_id --and b.bair_id = 7
where dbac_amreferenciadebito < 202103 and dcst_idatual = 3 and dcst_idanterior = 0 --and dbac_nnprestacaodebito<>dbac_nnprestacaocobradas
and i.rota_id in (select rota_id from micromedicao.rota r where ftgr_id in (26,27) and rota_id not in (1323,940,1331))
group by b.bair_nmbairro--,i.imov_id


select * from atendimentopublico.registro_atendimento ra order by rgat_id desc limit 5

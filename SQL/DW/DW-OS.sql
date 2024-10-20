CREATE SCHEMA bi AUTHORIZATION postgres;

--VW FATO OS
create view bi.vw_ftCorte 
as select
os.orse_id as OS,
os.svtp_id as id_servico,
coalesce (os.orse_vlservicooriginal,0)::decimal as valor,
os.amen_id as id_encerramento,
os.orse_cdsituacao as id_situacao,
os.orse_tmgeracao::date as DtGeracao,
os.orse_tmencerramento::date as DtExecucao,
os.orse_tmfechamento::date as DtFechamento,
i.imov_id as imovel,
i.last_id as id_agua,
i.iper_id as id_perfil,
s.catg_id as id_categoria,
i.imov_qteconomia as economia, 
coalesce (i.imov_nncoordenadax,-18.8623)::decimal as latitude, --Coordenada do SAAE
coalesce (i.imov_nncoordenaday,-41.9465)::decimal as longitude,--Coordenada do SAAE
b.divi_id as id_divisao
from atendimentopublico.ordem_servico as os
inner join cadastro.imovel as i 
on os.imov_id = i.imov_id
inner join cadastro.imovel_subcategoria as sc
on sc.imov_id = i.imov_id 
inner join cadastro.subcategoria as s
on s.scat_id = sc.scat_id 
inner join cadastro.logradouro_bairro as lb
on i.lgbr_id = lb.lgbr_id
inner join cadastro.bairro as b
on lb.bair_id = b.bair_id 
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
	and orse_tmgeracao between '2015-01-01 00:00:00' and now()
order by orse_tmgeracao asc;

--VW DIM SERVIÇO
create view bi.vw_dimServico 
as select 
svtp_id as id_servico,
svtp_dsservicotipo as Servico 
from atendimentopublico.servico_tipo st 
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
order by svtp_dsservicotipo;


--VW DIM ENCERRAMENTO
create view bi.vw_dimEncerramento
as select
amen_id as id_encerramento,
amen_dsmotivoencerramento as Encerramento
FROM atendimentopublico.atendimento_motivo_encerramento
order by amen_dsmotivoencerramento;

--DIM LIGACAO DE AGUA
create view bi.vw_dimLigacaoAgua
as select 
last_id as id_agua, 
last_dsligacaoaguasituacao as SitAgua
from atendimentopublico.ligacao_agua_situacao las
where last_id in 
(select last_id from cadastro.imovel i 
inner join atendimentopublico.ordem_servico os 
on i.imov_id = os.imov_id
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
	and orse_tmgeracao between '2015-01-01 00:00:00' and now())
order by last_dsligacaoaguasituacao; 


--DIM PERFIL
create view bi.vw_dimPerfil
as select 
iper_id as id_perfil, 
iper_dsimovelperfil as Perfil 
from cadastro.imovel_perfil
where iper_id in 
(select iper_id from cadastro.imovel i 
inner join atendimentopublico.ordem_servico os 
on i.imov_id = os.imov_id
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
	and orse_tmgeracao between '2015-01-01 00:00:00' and now())
order by iper_dsimovelperfil;


--DIM CATEGORIA
create view bi.vw_dimCategoria
as select 
catg_id as id_categoria, 
catg_dscategoria as Categoria
from cadastro.categoria	
where catg_id in (select catg_id from atendimentopublico.ordem_servico os
inner join cadastro.imovel_subcategoria sc
on sc.imov_id = os.imov_id
inner join cadastro.subcategoria as sb
on sb.scat_id = sc.scat_id 
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
	and orse_tmgeracao between '2015-01-01 00:00:00' and now())
order by catg_dscategoria;


--DIM DIVISAO
create view bi.vw_dimDivisao
as select 
divi_id as id_divisao,
divi_cor as Divisao
from cadastro.divisao d 
where divi_id in
(select divi_id from cadastro.imovel i 
inner join atendimentopublico.ordem_servico os 
on i.imov_id = os.imov_id
where svtp_id in (1280,1281,1282,1224,3010,1122,3229,3212,3211)
	and orse_tmgeracao between '2015-01-01 00:00:00' and now());


select 'select * from '||table_schema||'.'||table_name, 
		column_name,
		b.data_type,
        a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name like '%attp%'
      and a.reltuples <> 0
order by a.reltuples desc 

select * from atendimentopublico.atendimento_relacao_tipo

update atendimentopublico.ordem_servico
set orse_tmfechamento = orse_tmencerramento 
where orse_tmfechamento is null and orse_tmencerramento is not null
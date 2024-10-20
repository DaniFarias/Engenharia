create view bi.vw_fcfaturamento
as select --p.*,ab.*, am.*,
	c.cnta_id as id_conta, 
	c.dcst_idatual as id_tipocredito,
	c.cnta_icdebitoconta as debitoautomatico,
	c.imov_id as imovel,
	s.catg_id as id_categoria,
	c.iper_id as id_perfil,
	c.last_id as id_agua,
	(cnta_amreferenciaconta||'01')::date as dataemissao,
	c.ftgr_id as id_grupofaturamento, 
	c.cnta_nnconsumoagua as consumo,
	c.cnta_vlagua as valoragua,
	c.cnta_vlesgoto as valoresgoto,
	c.cnta_vldebitos as valordebito,
	c.cnta_vlcreditos as valorcredito,
	(( c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos ) - c.cnta_vlcreditos) as valorconta,
	coalesce (p.pgmt_vlpagamento,0) as valorpagamento,
	coalesce (ab.arrc_id,0) as id_banco
from
	faturamento.conta c
left join arrecadacao.pagamento as p on
	c.cnta_id = p.cnta_id
left join arrecadacao.aviso_bancario as ab on
	p.avbc_id = ab.avbc_id
left join arrecadacao.arrecadador_movimento as am on
	ab.armv_id = am.armv_id
left join cadastro.imovel_subcategoria as sc
on sc.imov_id = c.imov_id 
left join cadastro.subcategoria as s
on s.scat_id = sc.scat_id 
where
	c.dcst_idatual in (0,1,2,7) --and (( c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos ) - c.cnta_vlcreditos) = 0
	and cnta_amreferenciaconta between 201501 and 201912
order by
	c.cnta_id desc;

------------------------------------------------------------------------------------------------------------

--DIM TIPO DE CONTA
create view bi.vw_dimtipoconta as
select
	dcst_id as id_tipocredito,
	dcst_dsdebitocreditosituacao as credito
from
	faturamento.debito_credito_situacao
where
	dcst_id in (0,1,2,7)
order by dcst_dsdebitocreditosituacao;

------------------------------------------------------------------------------------------------------------

--DIM GRUPO DE FATURAMENTO
create view bi.vw_dimgrupofaturamento as
select
	ftgr_id as id_grupofaturamento,
	ftgr_dsabreviado as grupofaturamento
from
	faturamento.faturamento_grupo
where ftgr_id  in (8,11,4,7,9,10,15,6,26,12,24,19,25,21,14,3,17,20,22,13,1,5,18,2,16,27,29,23)
order by ftgr_dsabreviado;

------------------------------------------------------------------------------------------------------------

--DIM SETOR COMERCIAL
create view bi.vw_dimsetorcomercial
as select
	stcm_cdsetorcomercial as id_setorcoemrcial,
	stcm_nmsetorcomercial as setorcoemrcial
from
	cadastro.setor_comercial
where
	stcm_cdsetorcomercial in (18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,1,17,43,44,45,46,47,48,49,50,52,54,55,56,57,58,59,60)
order by stcm_nmsetorcomercial;

------------------------------------------------------------------------------------------------------------

--DIM BANCO
create view bi.vw_dimbanco
as select
	bnco_id as id_banco,
	bnco_nmbanco as banco 
from
	arrecadacao.banco
where
	bnco_id in (237,756,275,1,341,104,389,757)
order by bnco_nmbanco;
------------------------------------------------------------------------------------------------------------
/*inner join arrecadacao.arrecadador_movimento as am
on b.bnco_id = am.armv_cdbanco 
where armv_dtgeracao > '2015-01-01'
group by bnco_id */

update arrecadacao.aviso_bancario set arrc_id = 757 where arrc_id = 806
select * from arrecadacao.arrecadador
select * from faturamento.conta c limit 500



select cnta_id ,gpag_id, pgmt_vlpagamento, dbtp_id , arfm_id, dotp_id,* 
from arrecadacao.pagamento p
where pgmt_dtpagamento between '2015-01-01 00:00:00' and now() 
order by cnta_id desc
limit 999999

select * from arrecadacao.arrecadacao_forma
select * from cobranca.documento_tipo
select * from cadastro.imovel i where stcm_id = 43 left join micromedicao.rota r on i.rota_id = r.rota_id where ftgr_id is null

select * from arrecadacao.conta_bancaria
select * from arrecadacao.aviso_bancario --avbc_id


select 'select * from '||table_schema||'.'||table_name, 
		column_name,
		b.data_type,
        a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name like '%bnco_id%'
      and a.reltuples <> 0
order by a.reltuples desc

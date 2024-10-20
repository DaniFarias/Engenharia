--ALTER TABLE cadastro.imovel DROP CONSTRAINT fk_imovel_sitfaturamento
--ALTER TABLE faturamento.conta RENAME CONSTRAINT "fk_conta_nao_entrega" TO "fk_conta_naoentrega";

select * from cadastro.imovel where last_id not in (select last_id from atendimentopublico.ligacao_agua_situacao)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_sitagua FOREIGN KEY (last_id) REFERENCES atendimentopublico.ligacao_agua_situacao (last_id);

select * from cadastro.imovel where lest_id not in (select lest_id from atendimentopublico.ligacao_esgoto_situacao)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_sitesgot FOREIGN KEY (lest_id) REFERENCES atendimentopublico.ligacao_esgoto_situacao (lest_id);

select imov_id, last_id, lest_id, stcm_id from cadastro.imovel as i where not exists (select stcm_id from cadastro.setor_comercial as c where c.stcm_id = i.stcm_id)
update cadastro.imovel as i set stcm_id = c.stcm_id from cadastro.setor_comercial as c
where i.stcm_id = c.stcm_cdsetorcomercial and not exists (select cc.stcm_id from cadastro.setor_comercial as cc where cc.stcm_id = i.stcm_id)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_setcomercial FOREIGN KEY (stcm_id) REFERENCES cadastro.setor_comercial (stcm_id);

select qdra_id,* from cadastro.imovel as i where not exists (select qdra_id from cadastro.quadra as x where x.qdra_id = i.qdra_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Quadra FOREIGN KEY (qdra_id) REFERENCES cadastro.quadra (qdra_id);

select * from cadastro.imovel where iper_id not in (select iper_id from cadastro.imovel_perfil)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_perfil FOREIGN KEY (iper_id) REFERENCES cadastro.imovel_perfil (iper_id);

select * from cadastro.imovel as i where not exists (select loca_id from cadastro.localidade as l where i.loca_id = l.loca_id)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_local FOREIGN KEY (loca_id) REFERENCES cadastro.localidade (loca_id);

select pcal_id,* from cadastro.imovel as i where not exists (select pcal_id from cadastro.pavimento_calcada as pc where pc.pcal_id = i.pcal_id)
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_pavimento_calcada FOREIGN KEY (pcal_id) REFERENCES cadastro.pavimento_calcada (pcal_id);

select prua_id,* from cadastro.imovel as i where not exists (select prua_id from cadastro.pavimento_rua as pc where pc.prua_id = i.prua_id);
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_pavimento_rua FOREIGN KEY (prua_id) REFERENCES  cadastro.pavimento_rua (prua_id);

select pisc_id,* from cadastro.imovel as i where pisc_id is not null and not exists (select pisc_id from cadastro.piscina_volume_faixa as pc where pc.pisc_id = i.pisc_id);
--update cadastro.imovel set pisc_id = 1 where pisc_id = -1
ALTER table cadastro.imovel ADD CONSTRAINT fk_imovel_volumepiscina FOREIGN KEY (pisc_id) REFERENCES cadastro.piscina_volume_faixa (pisc_id);

select * from cadastro.imovel as i where ftst_id is not null and not exists (select ftst_id from faturamento.faturamento_situacao_tipo as fst where fst.ftst_id = i.ftst_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_SituacaoFaturamento FOREIGN KEY (ftst_id) REFERENCES  faturamento.faturamento_situacao_tipo (ftst_id);

select * from cadastro.imovel as i where poco_id is not null and not exists (select poco_id from cadastro.poco_tipo as x where x.poco_id = i.poco_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_PocoTipo FOREIGN KEY (poco_id) REFERENCES  cadastro.poco_tipo (poco_id);

select * from cadastro.imovel as i where eanm_id is not null and not exists (select eanm_id from cadastro.elo_anormalidade as x where x.eanm_id = i.eanm_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_EloAnormalidade FOREIGN KEY (eanm_id) REFERENCES cadastro.elo_anormalidade (eanm_id);

select * from cadastro.imovel as i where cocr_id is not null and not exists (select cocr_id from cadastro.cadastro_ocorrencia as x where x.cocr_id = i.cocr_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Ocorrencia FOREIGN KEY (cocr_id) REFERENCES cadastro.cadastro_ocorrencia (cocr_id);

select * from cadastro.imovel as i where hidi_id is not null and not exists (select hidi_id from micromedicao.hidrometro_instalacao_historico as x where x.hidi_id = i.hidi_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_HdrInstalacaoHistorico FOREIGN KEY (hidi_id) REFERENCES micromedicao.hidrometro_instalacao_historico (hidi_id);

select * from cadastro.imovel as i where ltan_id is not null and not exists (select ltan_id from micromedicao.leitura_anormalidade as x where x.ltan_id = i.ltan_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_LeituraAnormalidade FOREIGN KEY (ltan_id) REFERENCES micromedicao.leitura_anormalidade (ltan_id);

select * from cadastro.imovel as i where usur_id is not null and not exists (select usur_id from seguranca.usuario as x where x.usur_id = i.usur_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Usuario FOREIGN KEY (usur_id) REFERENCES seguranca.usuario (usur_id);

select * from cadastro.imovel as i where cstf_id is not null and not exists (select cstf_id from faturamento.consumo_tarifa as x where x.cstf_id = i.cstf_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_ConsumoTarifa FOREIGN KEY (cstf_id) REFERENCES faturamento.consumo_tarifa (cstf_id);

select * from cadastro.imovel as i where fttp_id is not null and not exists (select fttp_id from faturamento.faturamento_tipo as x where x.fttp_id = i.fttp_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_FaturamentoTipo FOREIGN KEY (fttp_id) REFERENCES faturamento.faturamento_tipo (fttp_id);

select * from cadastro.imovel as i where edrf_id is not null and not exists (select edrf_id from cadastro.endereco_referencia as x where x.edrf_id = i.edrf_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_EnderecoReferencia FOREIGN KEY (edrf_id) REFERENCES cadastro.endereco_referencia (edrf_id);

select logr_id,* from cadastro.imovel as i where logr_id is not null and not exists (select logr_id from cadastro.logradouro as x where x.logr_id = i.logr_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Logradouro FOREIGN KEY (logr_id) REFERENCES cadastro.logradouro (logr_id);

select * from cadastro.imovel as i where ftsm_id is not null and not exists (select ftsm_id from faturamento.faturamento_situacao_motivo as x where x.ftsm_id = i.ftsm_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_FaturamentoSituacaoMotivo FOREIGN KEY (ftsm_id) REFERENCES faturamento.faturamento_situacao_motivo (ftsm_id);

select * from cadastro.imovel as i where bair_id is not null and not exists (select bair_id from cadastro.bairro as x where x.bair_id = i.bair_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Bairro FOREIGN KEY (bair_id) REFERENCES cadastro.bairro (bair_id);

select * from cadastro.imovel as i where lgbr_id is not null and not exists (select lgbr_id from cadastro.logradouro_bairro as x where x.lgbr_id = i.lgbr_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_LogradouroBairro FOREIGN KEY (lgbr_id) REFERENCES cadastro.logradouro_bairro (lgbr_id);

select * from cadastro.imovel as i where lgcp_id is not null and not exists (select lgcp_id from cadastro.logradouro_cep as x where x.lgcp_id = i.lgcp_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_LogradouroCep FOREIGN KEY (lgcp_id) REFERENCES cadastro.logradouro_cep (lgcp_id);

select icte_id,* from cadastro.imovel as i where icte_id is not null and not exists (select icte_id from cadastro.imovel_conta_envio as x where x.icte_id = i.icte_id);
--update cadastro.imovel set icte_id = 2 where icte_id = 0
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_EnvioConta FOREIGN KEY (icte_id) REFERENCES cadastro.imovel_conta_envio (icte_id);

select * from cadastro.imovel as i where func_id is not null and not exists (select func_id from cadastro.funcionario as x where x.func_id = i.func_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Funcionario FOREIGN KEY (func_id) REFERENCES cadastro.funcionario (func_id);

select siac_id,* from cadastro.imovel as i where siac_id is not null and not exists (select siac_id from cadastro.situacao_atualizacao_cadastral as x where x.siac_id = i.siac_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_AtualizacaoCadastral FOREIGN KEY (siac_id) REFERENCES cadastro.situacao_atualizacao_cadastral (siac_id);

select cep_id,* from cadastro.imovel as i where cep_id is not null and not exists (select cep_id from cadastro.cep as x where x.cep_id = i.cep_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_Cep FOREIGN KEY (cep_id) REFERENCES cadastro.cep (cep_id);

select acon_id,* from cadastro.imovel as i where acon_id is not null and not exists (select acon_id from cadastro.area_construida_faixa as x where x.acon_id = i.acon_id);
ALTER table cadastro.imovel ADD CONSTRAINT FK_Imovel_AreaConstruida FOREIGN KEY (acon_id) REFERENCES cadastro.area_construida_faixa (acon_id);


select * from cadastro.imovel limit 500 


-- CONTA 
select * from faturamento.conta where imov_id not in (select imov_id from cadastro.imovel);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_imovel FOREIGN KEY (imov_id) REFERENCES cadastro.imovel (imov_id);

select * from faturamento.conta as c where not exists (select dcst_id from faturamento.debito_credito_situacao as x where c.dcst_idatual = x.dcst_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_situacao FOREIGN KEY (dcst_idatual) REFERENCES faturamento.debito_credito_situacao (dcst_id);

select * from faturamento.conta as c where c.dcst_idanterior is not null and not exists (select dcst_id from faturamento.debito_credito_situacao as x where c.dcst_idanterior = x.dcst_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_situacaoanterior FOREIGN KEY (dcst_idanterior) REFERENCES faturamento.debito_credito_situacao (dcst_id);

select * from faturamento.conta as c where not exists (select last_id from atendimentopublico.ligacao_agua_situacao as x where c.last_id = x.last_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_sitagua FOREIGN KEY (last_id) REFERENCES atendimentopublico.ligacao_agua_situacao (last_id);

select * from faturamento.conta as c where not exists (select lest_id from atendimentopublico.ligacao_esgoto_situacao as x where c.lest_id = x.lest_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_sitesgot FOREIGN KEY (lest_id) REFERENCES atendimentopublico.ligacao_esgoto_situacao (lest_id);

select * from faturamento.conta as c where mned_id is not null and not exists (select mned_id from faturamento.motivo_nao_entrega_documento as x where c.mned_id = x.mned_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_naoentrega FOREIGN KEY (mned_id) REFERENCES faturamento.motivo_nao_entrega_documento (mned_id);

select * from faturamento.conta as c where not exists (select loca_id from cadastro.localidade as x where c.loca_id = x.loca_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_local FOREIGN KEY (loca_id) REFERENCES cadastro.localidade (loca_id);

select * from faturamento.conta as c where not exists (select qdra_id from cadastro.quadra as x where c.qdra_id = x.qdra_id);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_quadra FOREIGN KEY (qdra_id) REFERENCES cadastro.quadra (qdra_id);

select * from faturamento.conta as c where cnta_cdsetorcomercial is not null and not exists (select cnta_cdsetorcomercial from cadastro.setor_comercial as x where c.cnta_cdsetorcomercial = c.cnta_cdsetorcomercial);
ALTER table faturamento.conta ADD CONSTRAINT fk_conta_setorcomercial FOREIGN KEY (qdra_id) REFERENCES cadastro.quadra (qdra_id);


select * from atendimentopublico.solicitacao_tipo_especificacao as ste

-- MICROMEDICAO 
select * from micromedicao.hidrometro_instalacao_historico as hi where not exists (select imov_id from cadastro.imovel as x where hi.lagu_id = x.imov_id);
ALTER table micromedicao.hidrometro_instalacao_historico ADD CONSTRAINT FK_HDInstalacaoHistorico_Imovel FOREIGN KEY (lagu_id) REFERENCES cadastro.imovel (imov_id);

select * from micromedicao.hidrometro_instalacao_historico as hi where not exists (select hidr_id from micromedicao.hidrometro as x where hi.hidr_id = x.hidr_id);
ALTER table micromedicao.hidrometro_instalacao_historico ADD CONSTRAINT FK_HDInstalacaoHistorico_Imovel FOREIGN KEY (lagu_id) REFERENCES cadastro.imovel (imov_id);

select lagu_id,* from micromedicao.hidrometro_instalacao_historico where lagu_id in 
(select lagu_id from micromedicao.hidrometro_instalacao_historico as hi where not exists (select hidr_id from micromedicao.hidrometro as x where hi.hidr_id = x.hidr_id))
and hidi_dtretiradahidrometro is null

select * from micromedicao.hidrometro where hidr_id = 955597 nnhidrometro = 'Y13G410377'
select * from micromedicao.hidrometro_log where hidr_id = 915455
select * from micromedicao.hidrometro_instalacao_historico where hidr_id = 937301

select hidr_id, count(hidr_id) 
from micromedicao.hidrometro_instalacao_historico as ch 
group by hidr_id
having count(hidr_id)>1

SELECT imov_tmultimaalteracao,imov_id, imha_id, impr_id, imco_id, imcb_id, qdfa_id
FROM cadastro.imovel where imha_id is not null 
order by imov_id desc limit 100

select 'select * from '||table_schema||'.'||table_name, 
		column_name,
        a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name like '%hidr_id%'
      and a.reltuples <> 0
order by a.reltuples desc

select * from cadastro.situacao_atualizacao_cadastral
select * from cadastro.quadra_face

select icte_id, icte_dscontaenvio,
(select count(1) from cadastro.imovel as i where i.icte_id = la.icte_id)
from cadastro.imovel_conta_envio as la



select * from faturamento.credito_realizado as cr where not exists (select cnta_id from faturamento.conta as c where cr.cnta_id = c.cnta_id)

select camreferenciadebito, count(1) from faturamento.credito_realizado as cr where not exists (select cnta_id from faturamento.conta as c where cr.cnta_id = c.cnta_id)

select * from faturamento.debito_cobrado as cr where not exists (select cnta_id from faturamento.conta as c where cr.cnta_id = c.cnta_id)

select dbcb_amreferenciadebito, count(1) from faturamento.debito_cobrado
as cr where not exists (select cnta_id from faturamento.conta as c where cr.cnta_id = c.cnta_id)
group by dbcb_amreferenciadebito

select * from faturamento.conta as c where not exists (select imov_id from cadastro.imovel as i where c.imov_id = i.imov_id)

select * from cadastro.imovel as i where not exists (select imov_id from faturamento.conta as c where c.imov_id = i.imov_id)

select * from public.contasaux as ac
left join faturamento.conta as c
on ac.imov = c.imov_id and ac.conta = c.cnta_amreferenciaconta
where c.cnta_id is null

select * from faturamento.debito_tipo
select * from cadastro.imovel_doacoes where imov_id in (912459)

select imov_id, imdo_vldoacao, imdo_amreferenciainicial, imdo_amreferenciafinal from cadastro.imovel_doacoes where usur_idadesao = 2514 and imdo_dtcancelamento is null

update cadastro.imovel_doacoes set imdo_amreferenciafinal = 202811
where imdo_id in (select imdo_id from cadastro.imovel_doacoes where imdo_amreferenciafinal = 201811 and usur_idadesao = 2514 and imdo_dtcancelamento is null)

update cadastro.imovel_doacoes set imdo_amreferenciafinal = 202902
where imdo_id in (select imdo_id from cadastro.imovel_doacoes where imdo_amreferenciafinal = 201902 and usur_idadesao = 2514 and imdo_dtcancelamento is null)


select imdo_amreferenciainicial, imdo_amreferenciafinal from cadastro.imovel_doacoes where imdo_amreferenciafinal is null

select cbst_id, cbst_dscobrancasituacao,cbst_icbloqueioparcel,cbst_icbloqueioinclusao,cbst_icbloqueioretirada,prof_id,ratv_id,cbst_icselecaopermissaoespecial,cbst_icprescreveparticular,cbst_icimpedirretificacao
from cobranca.cobranca_situacao where cbst_icuso = 1

select * from cadastro.imovel_cobranca_situacao
select * from cobranca.cobranca_situacao

select imov_id, imovl_nnsequencialrota,imovl_dataalteracao, usur_id,* from auditoria.imovel_log where rota_id = 1260 and usur_id is not null 
select * from seguranca.usuario where usur_id in(2489,2537,2561)

select * from cadastro.log_imovel_rota
select pisc_id, rota_id, imov_nnsequencialrota,* from cadastro.imovel order by imov_id desc limit 100
select * from cadastro.categoria
select * from cadastro.subcategoria
select * from cadastro.imovel_subcategoria

select * from atendimentopublico.ordem_servico

CREATE OR REPLACE VIEW atendimentopublico.vw_ordem_servico_mobile_2
AS SELECT translate ('insert into OrdemServico 
	(id,
	situacaoOS,
	idServicoTipo,
	dataGeracao,
	idGrupo,
	matriculaCliente,
	nomeCliente,
	tipoLogradouro,
	logradouro,
	numeroImovel,
	numeroCep,
	bairro,
	numerohidrometro,
	idHidrometroProtecao,
	idHidrometroLocalInstalacao,
	imovel,
	ligacaoAguaSituacao,
	ligacaoEsgotoSituacao)
values' || 
array((select '(''' || 
	os.orse_id || ''',''' || 
    os.orse_cdsituacao || ''',''' || 
    os.svtp_id || ''',''' || 
    os.orse_tmgeracao || ''',''' || 
    --ra.rgat_id || ''',''' || 
    r.ftgr_id || ''',''' || 
    c.clie_id || ''',''' || 
    c.clie_nmcliente || ''',''' || 
    cep.cep_dslogradourotipo|| ''',''' || 
    lg.logr_nmlogradouro || ''',''' || 
    i.imov_nnimovel || ''',''' || 
    cep.cep_cdcep || ''',''' || 
    b.bair_nmbairro || ''',''' || 
    coalesce (h.hidr_nnhidrometro,'INEXISTENTE') || ''',''' || 
    coalesce (hp.hipr_id,'9') || ''',''' || 
    coalesce (hli.hili_id,'9') || ''',''' || 
    os.imov_id || ''',''' || 
    i.last_id || ''',''' || 
    i.lest_id || ''')'
   
   FROM atendimentopublico.ordem_servico os
     LEFT JOIN atendimentopublico.servico_tipo st ON st.svtp_id = os.svtp_id
     --LEFT JOIN atendimentopublico.registro_atendimento ra ON ra.rgat_id = os.rgat_id
     LEFT JOIN cadastro.imovel i ON os.imov_id = i.imov_id
     LEFT JOIN micromedicao.rota r ON i.rota_id = r.rota_id
     LEFT JOIN ( SELECT max(cliente_imovel.clie_id) AS clie_id,
            cliente_imovel.imov_id
           FROM cadastro.cliente_imovel
          WHERE cliente_imovel.clim_icnomeconta = 1 AND cliente_imovel.clim_dtrelacaofim IS NULL
          GROUP BY cliente_imovel.imov_id) ci ON ci.imov_id = i.imov_id
     LEFT JOIN cadastro.cliente c ON c.clie_id = ci.clie_id
     LEFT JOIN cadastro.logradouro_bairro lb ON lb.lgbr_id = i.lgbr_id
     LEFT JOIN cadastro.bairro b ON b.bair_id = lb.bair_id
     LEFT JOIN cadastro.logradouro lg ON lg.logr_id = lb.logr_id
     LEFT JOIN ( SELECT logradouro_cep.logr_id,
            max(logradouro_cep.cep_id) AS cep_id
           FROM cadastro.logradouro_cep
          GROUP BY logradouro_cep.logr_id) lgc ON lgc.logr_id = lg.logr_id
     LEFT JOIN cadastro.cep cep ON cep.cep_id = lgc.cep_id
     LEFT JOIN ( SELECT max(hidrometro_instalacao_historico.hidi_id) AS hidi_id,
            hidrometro_instalacao_historico.lagu_id
           FROM micromedicao.hidrometro_instalacao_historico
             LEFT JOIN micromedicao.hidrometro_instalacao_historico hitemp ON hitemp.lagu_id = hidrometro_instalacao_historico.lagu_id AND hitemp.hidi_dtretiradahidrometro IS NULL
          WHERE hidrometro_instalacao_historico.hidi_dtretiradahidrometro IS NOT NULL AND hitemp.lagu_id IS NULL
          GROUP BY hidrometro_instalacao_historico.lagu_id) ultimohd ON ultimohd.lagu_id = i.imov_id
     LEFT JOIN micromedicao.hidrometro_instalacao_historico hih ON hih.lagu_id = i.imov_id AND (hih.hidi_dtretiradahidrometro IS NULL OR hih.hidi_id = ultimohd.hidi_id)
     LEFT JOIN micromedicao.hidrometro h ON h.hidr_id = hih.hidr_id
     LEFT JOIN micromedicao.hidrometro_protecao hp ON hp.hipr_id = hih.hipr_id
     LEFT JOIN micromedicao.hidrometro_local_instalacao hli ON hli.hili_id = hih.hili_id
  WHERE os.orse_cdsituacao = 1 AND ((r.ftgr_id <> ALL (ARRAY[26, 27, 28, 29])) OR (os.svtp_id <> ALL (ARRAY[1280, 1281, 1282]))) AND hih.hidi_dtretiradahidrometro IS NULL AND (os.svtp_id = ANY (ARRAY[10, 14, 1280, 1281, 1282, 3201, 3266])) OR os.orse_cdsituacao = 1 AND os.svtp_id = 3266 AND hih.hidi_dtretiradahidrometro IS NOT NULL
  ORDER BY os.orse_id))::text,'"{}','');

-- Permissions

ALTER TABLE atendimentopublico.vw_ordem_servico_mobile OWNER TO postgres;
GRANT ALL ON TABLE atendimentopublico.vw_ordem_servico_mobile TO postgres;

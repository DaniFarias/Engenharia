SELECT 
TRANSLATE('INSERT INTO OrdemServico (Id, SituacaoOS, IdServicoTipo, DataGeracao, idRegistroAtendimento, IdGrupo, MatriculaCliente, NomeCliente, TipoLogradouro, Logradouro, NumeroImovel, NumeroCep, Bairro, Numerohidrometro, IdHidrometroProtecao, IdHidrometroLocalInstalacao, Imovel, LigacaoAguaSituacao, LigacaoEsgotoSituacao, Equipe, Rota, SequenciaRota) VALUES' || 
ARRAY((SELECT '(''' || os.orse_id || ''',''' || os.orse_cdsituacao || ''',''' || os.svtp_id || ''',''' || os.orse_tmgeracao || ''',''' || COALESCE(ra.rgat_id, 0) || ''',''' || r.ftgr_id || ''',''' || c.clie_id || ''',''' || c.clie_nmcliente || ''',''' || COALESCE(cep.cep_dslogradourotipo, '') || ''',''' || lg.logr_nmlogradouro || ''',''' ||  i.imov_nnimovel || ''',''' || COALESCE(cep.cep_cdcep, 0) || ''',''' || b.bair_nmbairro || ''',''' || COALESCE(h.hidr_nnhidrometro, '') || ''',''' || COALESCE(hp.hipr_id, 0) || ''',''' || COALESCE(hli.hili_id, 0) || ''',''' || os.imov_id || ''',''' ||  i.last_id || ''',''' || i.lest_id || ''',''' || os.eqpe_id || ''',''' || i.rota_id || ''',''' || i.imov_nnsequencialrota || ''')' 
FROM atendimentopublico.ordem_servico os 
LEFT JOIN atendimentopublico.servico_tipo st ON st.svtp_id = os.svtp_id 
LEFT JOIN atendimentopublico.registro_atendimento ra ON ra.rgat_id = os.rgat_id 
LEFT JOIN cadastro.imovel i ON os.imov_id = i.imov_id 
LEFT JOIN micromedicao.rota r ON i.rota_id = r.rota_id 
LEFT JOIN (SELECT MAX(cliente_imovel.clie_id) AS clie_id, cliente_imovel.imov_id 
FROM cadastro.cliente_imovel WHERE 1 = 1 AND cliente_imovel.clim_icnomeconta = 1 
AND cliente_imovel.clim_dtrelacaofim IS NULL 
GROUP BY cliente_imovel.imov_id) ci ON ci.imov_id = i.imov_id 
LEFT JOIN cadastro.cliente c ON c.clie_id = ci.clie_id 
LEFT JOIN cadastro.logradouro_bairro lb ON lb.lgbr_id = i.lgbr_id 
LEFT JOIN cadastro.bairro b ON b.bair_id = lb.bair_id 
LEFT JOIN cadastro.logradouro lg ON lg.logr_id = lb.logr_id 
LEFT JOIN (SELECT logradouro_cep.logr_id, MAX(logradouro_cep.cep_id) AS cep_id 
FROM cadastro.logradouro_cep GROUP BY logradouro_cep.logr_id) lgc ON lgc.logr_id = lg.logr_id 
LEFT JOIN cadastro.cep cep ON cep.cep_id = lgc.cep_id 
LEFT JOIN (SELECT MAX(hidrometro_instalacao_historico.hidi_id) AS hidi_id, hidrometro_instalacao_historico.lagu_id 
FROM micromedicao.hidrometro_instalacao_historico 
LEFT JOIN micromedicao.hidrometro_instalacao_historico hitemp ON hitemp.lagu_id = hidrometro_instalacao_historico.lagu_id AND hitemp.hidi_dtretiradahidrometro IS NULL 
WHERE 1 = 1 AND hidrometro_instalacao_historico.hidi_dtretiradahidrometro IS NOT NULL 
AND hitemp.lagu_id IS NULL 
GROUP BY hidrometro_instalacao_historico.lagu_id) ultimohd ON ultimohd.lagu_id = i.imov_id 
LEFT JOIN micromedicao.hidrometro_instalacao_historico hih ON hih.lagu_id = i.imov_id AND (hih.hidi_dtretiradahidrometro IS NULL OR hih.hidi_id = ultimohd.hidi_id) 
LEFT JOIN micromedicao.hidrometro h ON h.hidr_id = hih.hidr_id 
LEFT JOIN micromedicao.hidrometro_protecao hp ON hp.hipr_id = hih.hipr_id 
LEFT JOIN micromedicao.hidrometro_local_instalacao hli ON hli.hili_id = hih.hili_id WHERE 1 = 1 
and (os.eqpe_id in (select f.eqpe_id from atendimentopublico.equipe_componentes f where f.func_id = :funcionario)) 
AND (os.orse_cdsituacao = 1 
AND ((r.ftgr_id NOT IN(26, 27, 28, 29)) OR (os.svtp_id NOT IN(1280, 1281, 1282))) 
AND hih.hidi_dtretiradahidrometro IS NULL 
AND (os.svtp_id IN(10, 14, 1280, 1281, 1282, 3201, 3266)) OR os.orse_cdsituacao = 1 
AND os.svtp_id = 3266 AND hih.hidi_dtretiradahidrometro IS NOT NULL) 
ORDER BY os.orse_id))\:\:TEXT,'"{}','');
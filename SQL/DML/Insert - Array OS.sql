
SELECT translate ('insert into OrdemServico 
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
		id || ''',''' || 
		situacaoOS || ''',''' || 
		idServicoTipo || ''',''' || 
		datageracao  || ''',''' || 
		idgrupo || ''',''' ||
		matriculacliente || ''',''' ||
		nomecliente || ''',''' ||
		tipologradouro || ''',''' ||
		logradouro || ''',''' ||
		numeroimovel || ''',''' ||
		numerocep || ''',''' ||
		bairro || ''',''' ||
		numerohidrometro || ''',''' ||
		idhidrometroprotecao || ''',''' ||
		idhidrometrolocalinstalacao || ''',''' ||
		imovel || ''',''' ||
		ligacaoaguasituacao || ''',''' ||
		ligacaoesgotosituacao ||
		''')' 
FROM
	atendimentopublico.vw_ordem_servico_mobile
ORDER BY 
	id limit 5))::text,'"{}','')

	create table public.OrdemServico(
	id varchar,
	situacaoOS varchar,
	idServicoTipo varchar,
	dataGeracao varchar,
	idGrupo varchar,
	matriculaCliente varchar,
	nomeCliente varchar,
	tipoLogradouro varchar,
	logradouro varchar,
	numeroImovel varchar,
	numeroCep varchar,
	bairro varchar,
	numerohidrometro varchar,
	idHidrometroProtecao varchar,
	idHidrometroLocalInstalacao varchar,
	imovel varchar,
	ligacaoAguaSituacao varchar,
	ligacaoEsgotoSituacao varchar
	)
	
insert into public.OrdemServico 
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
values  ('62632','1','10','2014-05-23 07:09:49.418','6','747874','SERMO SERVICOS DE ONCOLOGIA TL','Rua','HELTON HELIO QUINTAO','155','35022250','SANTOS DUMONT','D13C000001','9','11','747874','3','3'),
		('732382','1','1280','2016-07-28 08:30:07.613','15','218553','JURANETE VENTURA PEREIRA','Vla','SANITARIA VINTE','121','35052630','PALMEIRAS','A17N041742','9','11','218553','3','3'),
		('1086553','1','1281','2019-12-10 06:01:21.067','15','211010','RAFAELA NASCIMENTO DA PENHA','Rua','GENARIO CELESTINO SANTOS','121','35052010','VILA OZANAN','A05N064109','10','11','211010','5','3'),
		('1086555','1','1281','2019-12-10 06:01:21.075','15','211931','LEILA ALVES SERAFIM','Rua','JOAO MARIA DOS SANTOS','142','35052020','VILA OZANAN','A05N060997','10','11','211931','5','3'),
		('1087334','1','1281','2019-12-10 06:01:21.013','22','440167','MARINA TEIXEIRA DE SOUZA','Rua','DOIS','64','343','VILA UNIAO IPE','A06N075637','10','11','440167','5','3')

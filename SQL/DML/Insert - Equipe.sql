--CONSULTA EQUIPES
select * from atendimentopublico.equipe e 

--INSERE EQUIPE
insert
	into
	atendimentopublico.equipe (eqpe_id,
	eqpe_nmequipe,
	eqpe_nnplacaveiculo,
	eqpe_nncargatrabalhodia,
	eqpe_tmultimaalteracao,
	unid_id,
	sptp_id,
	eqpe_icuso)
values((
select
	NEXTVAL('atendimentopublico.sequence_equipe')),
'DIONIZIO-30', --DESCRIÇÃO DA EQUIPE
'12345678',
480,
now(),
90, -- ID DA UNIDADE
1,
1);

--CONSULTA EQUIPES COMPONENTES
select * from atendimentopublico.equipe_componentes ec 

--INSERE EQUIPES COMPONENTES
insert
	into
	atendimentopublico.equipe_componentes (eqme_id,
	eqpe_id,
	eqme_icresponsavel,
	eqme_nmcomponente,
	eqme_tmultimaalteracao,
	func_id)
values((
select
	NEXTVAL('atendimentopublico.sequence_equipe_componentes')),
28, --ID EQUIPE
1,
'',
NOW(),
559); -- ID FUNCIONARIO


select * from seguranca.usuario u where func_id =558;
select * from cadastro.funcionario f where func_id in (5580,559,542);
select * from seguranca.usuario u where func_id in (542,544)

select * from atendimentopublico.vw_ordem_servico_mobile vosm where eqpe_id = 13 and orse_id in (2057466)


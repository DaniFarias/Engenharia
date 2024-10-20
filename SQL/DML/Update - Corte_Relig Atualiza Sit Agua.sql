-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: MICHELINE
-- DESCRIÇÃO: Trello - https://trello.com/c/BEg9uoJb/370-atualiza%C3%A7%C3%A3o-da-situa%C3%A7%C3%A3o-de-%C3%A1gua-dos-im%C3%B3veis-que-t%C3%AAm-os-de-corte-encerrada-com-a-data-posterior-a-os-de-religa%C3%A7%C3%A3o
-- DATA INICIO 18/07/2018
-- DATA FIM 19/07/2018
-- OBSERVAÇÃO: 90 MATRICULAR A SEREM ATUALIZADAS PARA LIGADO

begin transaction;

update
	cadastro.imovel
set
	last_id = 3
where
	imov_id in ( select
		tblaux1.imov_id
	from
		( select
			os.imov_id, max ( os.orse_tmfechamento ) as orse_tmfechamento1
		from
			cadastro.imovel as i
		inner join atendimentopublico.ordem_servico as os on
				i.imov_id = os.imov_id
			inner join atendimentopublico.atendimento_motivo_encerramento ame on
					ame.amen_id = os.amen_id
				where
					last_id = 5
					and svtp_id in( 3010, 1224 )
					and ame.amen_icexecucao = 1
					and os.orse_cdsituacao = 2
					and os.orse_tmfechamento is not null
				group by
					os.imov_id ) as tblaux
	inner join ( select
			imov_id, max ( orse_tmemissao ) as orse_tmemissao2, max ( oos.orse_tmfechamento ) as orse_tmfechamento2
		from
			atendimentopublico.ordem_servico as oos
		inner join atendimentopublico.atendimento_motivo_encerramento ame on
				ame.amen_id = oos.amen_id
			where
				oos.svtp_id in ( 1281, 1282 )
				and ame.amen_icexecucao = 1
				and oos.orse_cdsituacao = 2
				and rgat_id is null
				and orse_tmfechamento is not null
			group by
				imov_id ) as tblaux1 on
			tblaux.imov_id = tblaux1.imov_id
			and tblaux.orse_tmfechamento1 < tblaux1.orse_tmfechamento2
			and tblaux.orse_tmfechamento1 > tblaux1.orse_tmemissao2 );

commit transaction;



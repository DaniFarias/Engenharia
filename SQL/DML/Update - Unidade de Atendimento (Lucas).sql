-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: MICHELINE (EMAIL- 17/01/2019 11:45)
-- DESCRIÇÃO: https://trello.com/c/SBPaLlO6/469-corre%C3%A7%C3%A3o-da-unidade-de-atendimento-dos-ras-gerado-pelo-servidor-lucas-giacomini-userid-2573
-- DATA INICIO 17/01/2019
-- DATA FIM 17/01/2019
-- OBSERVAÇÃO:


-- Alteração unidade do usuario Lucas para 33
select * from seguranca.usuario where usur_id = 2573
update seguranca.usuario set unid_id = 33 where usur_id = 2573

-- Alteração unidade do funcionario Lucas para 33
select * from cadastro.funcionario where func_id = 15721
update cadastro.funcionario set unid_id = 33 where func_id = 15721

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and unid_id = 39 and raun_tmultimaalteracao between '2019-01-01 00:00:00' and '2019-01-04 23:59:59' 

begin transaction

--Dias 01-04 de janeiro, atendimento na unidade 33 (Centro)
update atendimentopublico.registro_atendimento_unidade set unid_id = 33
where raun_id in (select raun_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and unid_id = 39 and raun_tmultimaalteracao between '2019-01-01 00:00:00' and '2019-01-04 23:59:59')

update atendimentopublico.registro_atendimento set unid_idatual = 33
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao between '2019-01-01 00:00:00' and '2019-01-04 23:59:59')

update atendimentopublico.ordem_servico set unid_idatual = 33
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao between '2019-01-01 00:00:00' and '2019-01-04 23:59:59')

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Dias 07-11 de janeiro, atendimento na unidade 40 (Vila Isa)
update atendimentopublico.registro_atendimento_unidade set unid_id = 40
where raun_id in (select raun_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and unid_id = 39 and raun_tmultimaalteracao between '2019-01-07 00:00:00' and '2019-01-11 23:59:59')

update atendimentopublico.registro_atendimento set unid_idatual = 40
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao between '2019-01-07 00:00:00' and '2019-01-11 23:59:59')

update atendimentopublico.ordem_servico set unid_idatual = 40
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao between '2019-01-07 00:00:00' and '2019-01-11 23:59:59')

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Dias 14 de janeiro, atendimento na unidade 33 (Centro)
update atendimentopublico.registro_atendimento_unidade set unid_id = 33
where raun_id in (select raun_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and unid_id = 39 and raun_tmultimaalteracao >= '2019-01-14 00:00:00')

update atendimentopublico.registro_atendimento set unid_idatual = 33
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao >= '2019-01-14 00:00:00')

update atendimentopublico.ordem_servico set unid_idatual = 33
where unid_idatual = 39 and rgat_id in (select distinct rgat_id from atendimentopublico.registro_atendimento_unidade
where usur_id = 2573 and raun_tmultimaalteracao >= '2019-01-14 00:00:00')

--rollback transaction
commit transaction
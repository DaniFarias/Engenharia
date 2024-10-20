select * from atendimentopublico.registro_atendimento order by rgat_id desc limit 50 


--VW FATO RA
create view bi.vw_ftRegistroAtendimento 
as select
ra.rgat_id as id_Atendimento,
ste.sotp_id as id_Solicitacao,
ra.step_id as id_Especificacao,
ra.amen_id as id_Encerramento,
ra.rgat_cdsituacao as id_Situacao,
ra.rgat_tmregistroatendimento::date as DtGeracao,
ra.rgat_tmencerramento::date as DtEncerramento,
rau.unid_id as id_Unidade,
rau.usur_id as id_Usuario,
rau.attp_id as id_Estado,
b.divi_id as id_Divisao,
b.bair_id as id_Bairro 
from atendimentopublico.registro_atendimento as ra
inner join (select rau.rgat_id, rau.unid_id, rau.usur_id, rau.attp_id
from atendimentopublico.registro_atendimento_unidade as rau
inner join (select max(raun_id) as raun_id, max(raun_tmultimaalteracao), attp_id, rgat_id from atendimentopublico.registro_atendimento_unidade group by attp_id, rgat_id) as rau2
on rau.raun_id = rau2.raun_id) as rau
on rau.rgat_id = ra.rgat_id 	
inner join atendimentopublico.solicitacao_tipo_especificacao ste 
on ra.step_id = ste.step_id 
inner join cadastro.logradouro_bairro as lb
on ra.lgbr_id = lb.lgbr_id
inner join cadastro.bairro as b
on lb.bair_id = b.bair_id 
where
	ra.rgat_tmregistroatendimento between '2015-01-01 00:00:00' and now()
order by rgat_tmregistroatendimento asc;


--VW DIMENSAO SOLICITACAO
create view bi.vw_dimSolicitacao
as select sotp_id as id_solicitacao, sotp_dssolicitacaotipo as Solicitacao
from atendimentopublico.solicitacao_tipo st 
order by sotp_dssolicitacaotipo;


--VW DIMENSAO ESPECIFICACAO 
create view bi.vw_dimEspecificacao
as select step_id as id_Especificacao, step_dssolicitacaotipoespecificacao as Especificacao
from atendimentopublico.solicitacao_tipo_especificacao ste 
order by step_dssolicitacaotipoespecificacao;

create view bi.vw_dimCountImovel
as select count (1) 
from cadastro.imovel i 
where last_id in (1,3,5)



--VW DIMENSAO BAIRRO 
create view bi.vw_dimbairro
as select 
	bair_id as id_Bairro, 
	bair_nmbairro as Bairro
from cadastro.bairro 
order by bair_nmbairro;


--VW DIMENSAO USUARO
create view bi.vw_dimusuario
as select usur_id as id_Usuario, usur_nmusuario as Usuario 
from seguranca.usuario u 
order by usur_nmusuario; 


--VW DIMENSAO UNIDADE
create view bi.vw_dimunidade
as select unid_id as id_Unidade, unid_dsunidade as Unidade
from cadastro.unidade_organizacional uo 
order by unid_dsunidade ; 

select *
from cadastro.unidade_organizacional uo 
order by unid_dsunidade ; 
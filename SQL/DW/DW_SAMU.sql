create view vw_bi_Atendimento
as 
select
o.ID_OCORRENCIA as id_Ocorrencia,
t.id_tipo_atendimento as id_TipoAtendimento,
o.ID_MOTIVO_ACIONAMENTO as id_MotivoAcionamento,
o.COD_OCORRENCIA as id_TipoOcorrencia, /*case when (o.COD_OCORRENCIA in (4) or o.STATUS_OCORRENCIA=15) then 'Trote' else case when o.COD_OCORRENCIA in (3) then 'Orientação médica' else case when o.COD_OCORRENCIA in (0,1,2) then 'Ocorrência' else '' end end end Tipo*/
case when COM_ATEDIMENTO='S' then 1 else 2 end as ComAtendimento,
sta.ID_SITUACAO_ATENDIMENTO as Id_SituacaoAtendimento,
convert(o.DATA_CRIACAO, date) as DataAtendimento, 
case when sex_paciente <> 0 then 1 else 0 end as id_Sexo, /*(case when sex_paciente<>0 and sex_paciente<>1 then 'Indefinido' when sex_paciente=0 then 'Feminino' else 'Masculino' end) Sexo*/
case when tipo_ambulancia <> 0 then 1 end as Id_TipoAmbulancia,
ceiling((case when o.idade > 110 then idade/360 else case when o.idade = -1 then 1 else o.IDADE end end)) as Idade,
case when o.idade between -1 and 1 then 1 else 
case when o.idade between 2 and 9 then 2 else
case when o.idade between 10 and 19 then 3 else 
case when o.idade between 20 and 40 then 4 else 
case when o.idade between 41 and 60 then 5 else
case when o.idade > 60 then 6
end end end end end end as id_FaixaEtaria, 
o.id_municipio as id_Municipio,
o.lat_pj9 as Latitude,
o.long_pj9 as Longitude
		from v_ocorrencia_historico o 
		inner join cliente c on c.PES_ID=o.PES_ID_USUARIO
 		inner join v_motivo_acionamento m on m.ID_MOTIVO_ACIONAMENTO = o.ID_MOTIVO_ACIONAMENTO 
		inner join v_tipo_atendimento t on t.id_tipo_atendimento=m.id_tipo_atendimento
		inner join v_situacao_atendimento sta on sta.id_situacao_atendimento=o.id_situacao_atendimento
		inner join v_municipio mun on mun.id_municipio=o.id_municipio
where o.DATA_CRIACAO>='2018-01-01' and o.PES_ID_USUARIO=22;

/*FATO ATENDIMENTO*/
create table bi_Atendimento
(
id_Ocorrencia int,
id_TipoAtendimento int,
id_MotivoAcionamento int,
id_TipoOcorrencia int,
ComAtendimento int,
Id_SituacaoAtendimento int,
DataAtendimento date,
id_Sexo int,
Id_TipoAmbulancia int,
Idade int,
id_FaixaEtaria int,
id_Municipio int,
Latitude decimal(10,8),
Longitude decimal(10,8)
);

insert into bi_Atendimento (select * from vw_bi_Atendimento); 
drop table bi_Atendimento
select count(*) from bi_Atendimento order by id_Ocorrencia desc limit 5 where id_FaixaEtaria is null
update bi_Atendimento set id_municipio = 422 where id_municipio = 395 and PES_ID_USUARIO=22/**/
update bi_Atendimento set id_TipoOcorrencia = 6 where id_TipoOcorrencia  in (-1,8)


/*------------------------------------------------------------------------------------------------------------------------------*/

/*DIM TIPO DO ATENDIMENTO*/
create view vw_bi_TipoAtendimento as
select
	ID_TIPO_ATENDIMENTO as id_TipoAtendimento,
	DES_TIPO_ATENDIMENTO as TipoAtendimento
from
	v_tipo_atendimento
order by

	ID_TIPO_ATENDIMENTO;
	
/*------------------------------------------------------------------------------------------------------------------------------*/

/*DIM MOTIVO DO ACIONAMENTO*/
create view vw_bi_MotivoAcionamento as
select
	ID_MOTIVO_ACIONAMENTO as id_MotivoAcionamento,
	replace (DES_MOTIVO_ACIONAMENTO,'
','') as MotivoAcionamento,
	MOTIVO_BOMBEIRO as Bombeiro
from
	v_motivo_acionamento
order by
	ID_MOTIVO_ACIONAMENTO;

/*------------------------------------------------------------------------------------------------------------------------------*/

/*DIM SITUACAO DO ATENDIMENTO*/
create view vw_bi_SituacaoAtendimento as
select
	ID_SITUACAO_ATENDIMENTO as Id_SituacaoAtendimento,
	DESCRICAO as Status
from
	v_situacao_atendimento
order by
	ID_SITUACAO_ATENDIMENTO;

/*------------------------------------------------------------------------------------------------------------------------------*/

/*DIM MUNICIPIO*/
create view vw_bi_Municipio as
select
	ID_MUNICIPIO as id_Municipio,
	NOM_MUNICIPIO as Municipio,
	mic.DESCRICAO as Regiao,
	'Minas Gerais, BR' as UF,
	HABITANTES
from
	v_municipio as m
inner join v_micro_regiao mic on
	mic.id_micro_regiao = m.id_micro_regiao
where ID_UF = 1
order by
	ID_MUNICIPIO;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- SCRIPT DE ATUALIZAÇÃO DE TAXAS E VALORES DE SERVIÇOS ANO DE 2020 (3.91%)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

--Analise para atualização do serviço em 3.91%
select svtp_id,svtp_dsservicotipo,svtp_vlservico, round((svtp_vlservico * 1.0391),2) as atualizado
from atendimentopublico.servico_tipo st 
where svtp_id in (1223,908,3268,3241,900,245,244,1280,1281,1224,1282,3010,910,3245,3242,726,3230,1253,3231,726,3232,2201,3233,3224,3267,909,940,939,938,936,937,3010)
order by svtp_dsservicotipo asc

select dbtp_id, dbtp_dsdebitotipo, dbtp_vlsugerido,round((dbtp_vlsugerido * 1.0391),2) as atualizado
from faturamento.debito_tipo dt 
where dbtp_id in (22,11,103,110,102,111,109,148,8120,8116,8112,8126,8124,325,8125,156,155,154,152,696,153,436,8119,143,151,8127,108,8123,105,435,35,391,104,1001)
order by dbtp_dsdebitotipo asc

select step_id, step_dssolicitacaotipoespecificacao, step_vldebito,round((step_vldebito * 1.0391),2) as atualizado 
from atendimentopublico.solicitacao_tipo_especificacao
where step_id in (224,1224,3010,3729,3718,3673,3726,3727,3722,3728,726,3683,1223,3662,225,3675,3676,3614,3672,3616,3671,18,1124,248,908,1253,3682,1101,2201,706,2103,3725,3724)
order by step_dssolicitacaotipoespecificacao asc

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Atualização das tarifas em 3.91% ano de 2020

--Solicitacao tipo especificacao - RA
update atendimentopublico.solicitacao_tipo_especificacao set step_vldebito = round(( step_vldebito * 1.0391),2) 
where step_id in (224,1224,3010,3729,3718,3673,3726,3727,3722,3728,726,3683,1223,3662,225,3675,3676,3614,3672,3616,3671,18,1124,248,908,1253,3682,1101,2201,706,2103,3725,3724)

--Servico tipo - OS
update atendimentopublico.servico_tipo set svtp_vlservico = round((svtp_vlservico * 1.0391),2) 
where svtp_id in (1223,908,3268,3241,900,245,244,1280,1281,1224,1282,3010,910,3245,3242,726,3230,1253,3231,726,3232,2201,3233,3224,3267,909,940,939,938,936,937,3010)

--Debito tipo
update faturamento.debito_tipo set dbtp_vlsugerido = round((dbtp_vlsugerido * 1.0391),2) 
where dbtp_id in (22,11,103,110,102,111,109,148,8120,8116,8112,8126,8124,325,8125,156,155,154,152,696,153,436,8119,143,151,8127,108,8123,105,435,35,391,104)

--Aviso de Débito 
update cadastro.sistema_parametros SET parm_vltaxaaviso = 2.16;


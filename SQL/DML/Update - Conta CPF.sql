begin transaction

update
faturamento.conta set
       dcst_idatual = 7 --Id 7 = ContasCPF
where
       cnta_id in (
                     select
                    c.cnta_id
                     from 
faturamento.conta as c
                     left join arrecadacao.pagamento as p 
on p.cnta_id = c.cnta_id
                     where
                    p.cnta_id is null
                    and c.dcst_idatual in (0,1,2)
                    and ( c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos ) - c.cnta_vlcreditos > 0
                    and c.imov_id in (672769,873624,553689,580260,290300,606367,694800,377937,827908,529346,914587,718505,232726,916341,915715,913606) --Informar imovel
and c.cnta_id in (
                                        select
                                        cc.cnta_id
                                        from
                                        cadastro.cliente_conta as cc
                                        inner join cadastro.cliente_imovel as ci
                                        on ci.clie_id = cc.clie_id
                                        where
                                        ci.clim_dtrelacaofim is not null -- Informar clie_id que encerrou a relação com imovel
                 ))
    
commit transaction
     
select
      cl.clie_nmcliente, cc.*
from cadastro.cliente_imovel as cc
inner join cadastro.cliente as cl
on cl.clie_id = cc.clie_id
                    where cc.imov_id = 909251  

select
      c.cnta_id||',', c.cnta_amreferenciaconta, cl.clie_id,cl.clie_nmcliente
from faturamento.conta as c
left join arrecadacao.pagamento as p 
on p.cnta_id = c.cnta_id
inner join cadastro.cliente_conta as cc
on c.cnta_id = cc.cnta_id
inner join cadastro.cliente as cl
on cl.clie_id = cc.clie_id
                    where
                    p.cnta_id is null
                    and c.dcst_idatual in (0,1,2)
                    and cc.clct_icnomeconta = 1
                    and c.imov_id = 773328


  909251
update faturamento.conta set dcst_idatual = 7 where cnta_id in (8425069,
8518083,
8611551,
8709279,
8737503)

select * from faturamento.conta where cnta_id = 7741859 and dcst_idatual = 7 
887404
select dcst_idatual,* from faturamento.conta where cnta_id = 8554791
select dcst_idatual,* from faturamento.conta where imov_id = 629120 and clct_icnomeconta = 1 
select * from cadastro.cliente_conta where clie_id = 19453
select * from cadastro.cliente_conta where cnta_id in (9640659,9541099)
8355754,
8456439,
8543218,
8636468,
8736505)
select * from cadastro.cliente_imovel where imov_id = 923216
select * from cadastro.cliente_imovel where cnta_id in (,)
select * from cadastro.cliente where clie_id = 277193
select * from faturamento.guia_pagamento gp  where imov_id =713120 
select * from atendimentopublico.ordem_servico 
select * from atendimentopublico.servico_tipo where svtp_id in (929,1001,3245,3242,3231,3230,3216,3220,3221,3222,1253)


select * from atendimentopublico.ordem_servico where imov_id = 842303  
select i.imov_id from cadastro.imovel i
inner join cadastro.imovel_cobranca_situacao ics on ics.imov_id = i.imov_id
where ics.cbst_id = 21 and ics.iscb_dtretiradacobranca is null;

select i.imov_id, dc.last_id, i.last_id, dc.dotp_id, os.svtp_id,os.* 
from atendimentopublico.ordem_servico os
inner join cobranca.cobranca_documento dc on dc.cbdo_id = os.cbdo_id
inner join cadastro.imovel as i
on i.imov_id = os.imov_id
where os.svtp_id in(1280,1281) 
and os.orse_localinstalacaomobile is not null;


select * from (SELECT i.imov_id FROM cadastro.imovel as i
				inner join cadastro.cliente_imovel as ci
				on i.imov_id = ci.imov_id
				where last_id in (3,5) and ci.crtp_id = 2 and ci.clim_dtrelacaofim is null) as t1
left join atendimentopublico.vw_integracao_janaina as ij
on t1.imov_id = ij.consumidor

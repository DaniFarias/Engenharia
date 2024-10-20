-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: JONAS 
-- DESCRIÇÃO: FAVOR ACERTAR A DATA DE LEITURA DAS MATRÍCULAS DA ROTA 420 DO GRUPO 14(CN). LEMBRANDO QUE TEM QUE ACERTAR A DATA DE LEITURA DO MÊS 201709 E A DATA DE LEITURA ANTERIOR PARA REFERÊNCIA 201710.
-- DATA INICIO 08/11/2017
-- DATA FIM 08/11/2017
-- OBSERVAÇÃO:

begin transaction

update micromedicao.medicao_historico 
set	mdhi_dtleituracampo = '2017-09-02',
	mdhi_dtleituraatualinformada ='2017-09-02',
	mdhi_dtleituraatualfaturamento = '2017-09-02'
where mdhi_id in (
	select mdhi_id
	from micromedicao.medicao_historico as mh
	inner join cadastro.imovel as i
	on mh.lagu_id = i.imov_id
	where i.rota_id = 1190 and mdhi_amleitura = 201709
) --Atualizados 325 registros

update micromedicao.medicao_historico 
set	mdhi_dtleituraanteriorfaturamento = '2017-09-02'
where mdhi_id in(
	select mdhi_id
	from micromedicao.medicao_historico as mh
	inner join cadastro.imovel as i
	on mh.lagu_id = i.imov_id
	where i.rota_id = 1190 and mdhi_amleitura = 201710
)--Atualizados 328 registros

rollback transaction
commit transaction

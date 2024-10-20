
select
	cnta_amreferenciaconta,
	extract(day from now() - min(c.cnta_dtvencimentoconta)) as Diasdeatraso,
	iai.iaci_nnfatoratualizacaomonetaria as Fator,
	sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos) as Conta,
	round(sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos) * (iai.iaci_nnfatoratualizacaomonetaria-1), 2) as Valorcorrecao,
	round ((sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)* 0.02),2) as multa2p,
 	round(((1 / 30::real*(extract(day from now()-min(c.cnta_dtvencimentoconta)))/ 100)*(sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)+(sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)*(iai.iaci_nnfatoratualizacaomonetaria-1))))::numeric, 2) as juros,
	round (sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos) + round ((sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)* 0.02),2) + sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos) * (iai.iaci_nnfatoratualizacaomonetaria-1) + round(((1 / 30::real*(extract(day from now()-min(c.cnta_dtvencimentoconta)))/ 100)*(sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)+(sum(c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)*(iai.iaci_nnfatoratualizacaomonetaria-1))))::numeric, 2),2) as atualizado
from
	faturamento.conta c
inner join cobranca.indices_acrescimos_impontualidade iai on
	c.cnta_amreferenciaconta = iai.iaci_amreferencia
left join arrecadacao.pagamento p on
	c.cnta_id = p.cnta_id
where
	p.cnta_id is null
	and dcst_idatual in (0,1,2)
	and c.cnta_amreferenciaconta between 201603 and 202102
	and (c.cnta_vlagua + c.cnta_vlesgoto + c.cnta_vldebitos-c.cnta_vlcreditos)<> 0
group by
	cnta_amreferenciaconta,
	iai.iaci_nnfatoratualizacaomonetaria;

select (sum(5+9)+sum(3+2));


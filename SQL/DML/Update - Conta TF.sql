--update
	faturamento.conta
set	
	cnta_vlagua = 18.66,
	cnta_vlesgoto = .0,
	cnta_tmultimaalteracao = now()
where
	cnta_id in (8162608,8164852,8165346,8165173,8164352,8164983,8165001)
	select
		cnta_id
	from
		faturamento.conta
	where
		iper_id = 4
		and cnta_amreferenciaconta = '201908'
		and cnta_nnconsumoagua <= 12
		and cnta_dtemissao >= '2019-08-28')

		
select s.ftgr_dsfaturamentogrupo, cnta_vlagua, cnta_vlesgoto,c.* 
from faturamento.conta as c
inner join faturamento.faturamento_grupo as s
on c.ftgr_id = s.ftgr_id
where
	iper_id = 4
	and cnta_amreferenciaconta = '201908'
	and cnta_nnconsumoagua <= 12
	and cnta_dtemissao >= '2019-08-28'
	and c.ftgr_id in(17,18,19)

select cnta_nnconsumoagua,cnta_vlagua,* from faturamento.conta where cnta_amreferenciaconta = '201908' and imov_id in (542091,283134,474681,867802,868108,871788,918837,691402)
	
update cadastro.imovel set rota_id = 8 where imov_id in (542091,283134,474681,867802,868108,871788,918837,691402)
select imov_id, i.rota_id from cadastro.imovel as i 
inner join micromedicao.rota as r
on i.rota_id = r.rota_id
where ftgr_id in (17,18,19) and iper_id = 4)


select cnta_vlagua, cnta_vlesgoto,* from faturamento.conta where imov_id = 888230 order by cnta_amreferenciaconta desc

select * 
from cadastro.tarifa_social_dado_economia tarifasoci0_ 
inner join cadastro.imovel imovel1_ on tarifasoci0_.imov_id=imovel1_.imov_id  
where 
1=1 
and (tarifasoci0_.tsde_dtexclusao is null or (tarifasoci0_.tsde_dtexclusao is not null) and tarifasoci0_.etsm_id=52) 
and imovel1_.imov_id=888230
and tarifasoci0_.tsde_dtvalidadecartao>='2019-09-05'
order by tarifasoci0_.tsde_dtvalidadecartao 
desc limit 1

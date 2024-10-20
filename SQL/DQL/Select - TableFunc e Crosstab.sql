-- UTILIZAÇÃO DA EXTENSAO TABLEFUNC - CROSSTAB

--CASO NÃO TENHA O PACOTE CONTRIB INSTALADO
--yum install postgresql10-contrib

--VERIFICA POSSIVEIS VERSOES ANTERIORES ISNTALADAS
select typname,typlen from pg_type where typname like '%tablefunc%' order by typname

--DROPA AS EXISTENTES
drop type tablefunc_crosstab_2;
drop type tablefunc_crosstab_3;
drop type tablefunc_crosstab_4;

--CRIA EXTENSAO NOVA
create extension tablefunc;

--VERIFICA VERSAO INSTALADA
select * from pg_available_extensions where "name" like '%tablefunc%';

--select cnta_amreferenciaconta, sum((cnta_vlagua + cnta_vlesgoto + cnta_vldebitos ) - cnta_vlcreditos) as soma from faturamento.conta where cnta_amreferenciaconta between '201801' and '201808' or cnta_amreferenciaconta between '201901' and '201908' group by cnta_amreferenciaconta
--select left (cnta_amreferenciaconta::text,4) as ano, right (cnta_amreferenciaconta::text,1) as mes, sum((cnta_vlagua + cnta_vlesgoto + cnta_vldebitos ) - cnta_vlcreditos) as soma from faturamento.conta where cnta_amreferenciaconta between '201801' and '201808' or cnta_amreferenciaconta between '201901' and '201908' group by ano, mes


-- TRANSFORMA COLUNAS EM LINHAS

--FATURADO
select 'FAT',* from crosstab(
	$$ select 
	left (cnta_amreferenciaconta::text,4) as ano, 
	case right (cnta_amreferenciaconta::text,2) 
	when '01' then 1
	when '02' then 2
	when '03' then 3
	when '04' then 4
	when '05' then 5
	when '06' then 6
	when '07' then 7
	when '08' then 8
	when '09' then 9
	when '10' then 10
	when '11' then 11
	when '12' then 12
	end as mes,
	--replace(right (cnta_amreferenciaconta::text,2),'0','')as mes, 
	sum((cnta_vlagua + cnta_vlesgoto + cnta_vldebitos ) - cnta_vlcreditos) as soma 
	from faturamento.conta as c 
	where 
	cnta_amreferenciaconta between '201901' and '202003'
	group by ano, mes $$,

	$$ select * 
	   from generate_series(1,12) $$ ) as t ( 
	ano int,
	jan float,
	fev float,
	mar float,
	abr float,
	mai float,
	jun float,
	jul float,
	ago float,
	set float,
	out float,
	nov float,
	dez float)
union all	
--RECEBIDO
select 'REC',* from crosstab(
	$$ select 
	left (cnta_amreferenciaconta::text,4) as ano, 
	case right (cnta_amreferenciaconta::text,2) 
	when '01' then 1
	when '02' then 2
	when '03' then 3
	when '04' then 4
	when '05' then 5
	when '06' then 6
	when '07' then 7
	when '08' then 8
	when '09' then 9
	when '10' then 10
	when '11' then 11
	when '12' then 12
	end as mes,
	--replace(right (cnta_amreferenciaconta::text,2),'0','')as mes, 
	sum((cnta_vlagua + cnta_vlesgoto + cnta_vldebitos ) - cnta_vlcreditos) as soma 
	from faturamento.conta as c 
	inner join arrecadacao.pagamento as p
	on c.cnta_id = p.cnta_id
	where 
	cnta_amreferenciaconta between '201901' and '202003'
	--or cnta_amreferenciaconta between '201801' and '201808' 
	--or cnta_amreferenciaconta between '201901' and '201908' 
	group by ano, mes $$,

	$$ select * 
	   from generate_series(1,12) $$ ) as t ( 
	ano int,
	jan float,
	fev float,
	mar float,
	abr float,
	mai float,
	jun float,
	jul float,
	ago float,
	set float,
	out float,
	nov float,
	dez float)
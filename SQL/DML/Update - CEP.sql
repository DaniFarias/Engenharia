select
	a.cep_id,
	b.cep_cdcep,
	b.cep_dsufsigla,
	b.cep_nmmunicipio,
	b.cep_nmbairro,
	b.cep_dslogradourotipo,
	b.cep_nmlogradouro,*
from
	cadastro.imovel as a 
	left join cadastro.cep as b 
	on a.cep_id = b.cep_id
where
	imov_id = 906573  

select * 
from cadastro.cep
where cep_cdcep = 35041380
cep_nmlogradouro like '%LESSA%'

select * from cadastro.bairro b where bair_id = 28
	
select logr_id, bair_id, cep_id, lgbr_id,lgcp_id,* 
from cadastro.imovel
where logr_id = 10080

select * from cadastro.imovel i 
where  imov_id = 915057

select * from cadastro.logradouro where logr_id =10080 
where logr_nmlogradouro like '%ANTONIO LEAO%'
	
select * from cadastro.bairro
where bair_nmbairro like '%CASTELO%'

select * from cadastro.logradouro_bairro lb 
where logr_id =10080

select * from cadastro.logradouro
where  logr_id = 10080 

select * from cadastro.logradouro_cep lc   10000031   9999156
where logr_id = 10080 cep_id  = 2172029 

select * from cadastro.cep where cep_nmlogradouro LIKE'%VIEIRA DOS SAN%'
select * from cadastro.cep where cep_cdcep = '35020350'
	
INSERT INTO cadastro.cep
(cep_id, cep_cdcep, cep_dsufsigla, cep_nmmunicipio, cep_nmbairro, cep_nmlogradouro, cep_dslogradourotipo, cep_icuso, cept_id, cep_tmultimaalteracao, cep_dsintervalonumeracao)
VALUES((select nextval('cadastro.sequence_cep')),'35100000', 'MG', 'GOVERNADOR VALADARES', 'LAGOA SANTA II', 'DAS AGUIAS', 'RUA', 1, 3, now(), NULL);

select * from cadastro.cep where cep_cdcep = 35100000

9999389
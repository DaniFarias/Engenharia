update 
cadastro.cliente_imovel 
set clim_icnomeconta = 1 
where
crtp_id = 2 and
imov_id in ( select imov_id from cadastro.cliente_imovel where
clim_dtrelacaofim is null and clim_icnomeconta = 1
group by imov_id
having count (imov_id) > 1)

update
cadastro.cliente_imovel 
set clim_icnomeconta = 2 
where
crtp_id = 1 and
imov_id in ( select imov_id from cadastro.cliente_imovel where
clim_dtrelacaofim is null and clim_icnomeconta = 1
group by imov_id
having count (imov_id) > 1)


select * 
from cadastro.cliente_imovel as i
where 
	imov_id in 
	(
		select ci.imov_id 
		from cadastro.cliente_imovel as ci
		where ci.clim_dtrelacaofim is null and ci.clim_icnomeconta = 1
		group by ci.imov_id 
		having count (ci.imov_id) > 1
	)
order by clim_tmultimaalteracao desc

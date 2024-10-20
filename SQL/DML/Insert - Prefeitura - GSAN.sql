CREATE TABLE public.logradouro_Auxiliar
(
  IdRua varchar(7) null,
  NomeRua varchar(100) null,
  Identific varchar(10) null
);

select * from public.logradouro_Auxiliar;

CREATE TABLE public.bairro_auxiliar 
(
	idbairro varchar(7) NULL,
	nomebairro varchar(100) NULL
);

select * from public.bairro_auxiliar;

CREATE TABLE public.Logradourobairro_auxiliar 
(
    idrua varchar(7) NULL,
    idbairro varchar(7) NULL,
	cep varchar(8) NULL	
);

select * from public.Logradourobairro_auxiliar 
where zona = '';

CREATE TABLE public.imovel_auxiliar
(
	ctm varchar (20) null,
    idzona varchar(10) NULL,
    idquadra varchar(10) NULL,
	idlote varchar(10) NULL,	
	idsubunidade varchar(10) NULL,  -- sub unidade 000 lote vago
	--
	idbairro varchar(10) NULL,
	idrua varchar(10) NULL,
	complemento varchar(20) NULL,
	numeroend varchar(10) null,
	--
	cpfcnpj varchar (20)null,
	nome varchar (100) null	
);

delete from public.imovel_auxiliar

select * from public.bairro_auxiliar
select * from public.logradouro_auxiliar
select * from public.logradourobairro_auxiliar
select count(*) from public.imovel_auxiliar











-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: JONAS
-- DESCRIÇÃO: TRELLO - https://trello.com/c/3nBzHC3e/417-auditagem-das-tabelas-do-banco-gsan
-- DATA INICIO 20/02/2018
-- DATA FIM /03/2018
-- OBSERVAÇÃO: DEBITO_A_COBRAR, CREDITO_A_REALIZAR, CREDITO_REALIZADO, OS, RA. 

-- PARA EXCLUSAO, USAR: 

-- CRIA TABELA DEBITO A COBRAR LOG
create TABLE faturamento.debito_a_cobrar_log (
	dbacl_id serial not null primary key,
	dbac_id int4 not null,
	imov_id int4 NOT NULL,
	dbtp_id int4 NOT NULL,
	dbacl_tmultimaalteracao timestamp NULL,
	dbacl_dataalteracao timestamp NOT NULL DEFAULT now(),
	dbacl_amreferenciadebito int4 NULL,
	dbacl_vldebitooriginal numeric(13,2) NOT NULL,
	dbacl_vldebitoalterado numeric(13,2) NULL,
	rgat_id int4 NULL,
	orse_id int4 NULL,
	usur_id int4 null,
	dbacl_evento char (1)
);

-- FUNÇÃO PARA ALTERACAO E DELECAO        --DROP FUNCTION public.log_debitoacobrar_update_delete() cascade;
CREATE OR REPLACE FUNCTION faturamento.fnc_debitoacobrar_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   
	    if (tg_op = 'UPDATE')
	    then
			INSERT INTO faturamento.debito_a_cobrar_log
	        (dbac_id, imov_id, dbtp_id, dbacl_tmultimaalteracao, dbacl_dataalteracao, dbacl_amreferenciadebito, dbacl_vldebitooriginal, dbacl_vldebitoalterado, rgat_id, orse_id, usur_id,dbacl_evento)
            VALUES 
			(old.dbac_id, old.imov_id, old.dbtp_id, old.dbac_tmultimaalteracao, now(), old.dbac_amreferenciadebito, old.dbac_vldebito, new.dbac_vldebito,old.rgat_id, old.orse_id, new.usur_id,'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
		INSERT INTO faturamento.debito_a_cobrar_log
	        (dbac_id, imov_id, dbtp_id, dbacl_tmultimaalteracao, dbacl_dataalteracao, dbacl_amreferenciadebito, dbacl_vldebitooriginal, dbacl_vldebitoalterado, rgat_id, orse_id, usur_id,dbacl_evento)
            VALUES 
			(old.dbac_id, old.imov_id, old.dbtp_id, old.dbac_tmultimaalteracao, now(), old.dbac_amreferenciadebito, old.dbac_vldebito, null ,old.rgat_id, old.orse_id, old.usur_id,'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

select * from faturamento.debito_a_cobrar
limit 1

-- CRIA TRIGGER PARA TABELA faturamento.debito_a_cobrar_log
create trigger tgr_debitoacobrar_update_delete before update or delete
        on
        faturamento.debito_a_cobrar for each row execute procedure faturamento.fnc_debitoacobrar_update_delete_log();	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CRIA TABELA OS_LOG
CREATE TABLE atendimentopublico.ordem_servico_log (
	orsel_id serial not null primary key,
	orse_id int4 NOT NULL,
	rgat_id int4 NULL,
	imov_id int4 null,
	svtp_id int4 NOT NULL,
	amen_id int4 NULL,
	orsel_cdsituacao int2 NOT NULL,
	orsel_tmemissao timestamp NULL,
	orsel_tmencerramento timestamp NULL,
	orsel_dsparecerencerramento varchar(400) NULL,
	orsel_dsobservacao varchar(200) NULL,
	orsel_vlservicooriginal numeric(13,2) NULL,
	orsel_vlservicoalterado numeric(13,2) NULL,
	orsel_tmultimaalteracao timestamp NOT NULL,
	orsel_dataalteracao timestamp NOT null default now(),
	orsel_usur varchar (20) not null,
	orsel_evento char (1) not null
);

-- FUNÇÃO PARA ALTERACAO E DELECAO 
CREATE OR REPLACE FUNCTION atendimentopublico.fnc_os_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   
	    if (tg_op = 'UPDATE')
	    then
			INSERT INTO atendimentopublico.ordem_servico_log
	        (orse_id, rgat_id, imov_id, svtp_id, amen_id, orsel_cdsituacao, orsel_tmemissao, orsel_tmencerramento, orsel_dsparecerencerramento, orsel_dsobservacao, orsel_vlservicooriginal, orsel_vlservicoalterado, orsel_tmultimaalteracao, orsel_dataalteracao, orsel_usur, orsel_evento)
            VALUES 
			(old.orse_id, old.rgat_id, old.imov_id, old.svtp_id, new.amen_id, old.orse_cdsituacao, old.orse_tmemissao, old.orse_tmencerramento, new.orse_dsparecerencerramento, old.orse_dsobservacao, old.orse_vlservicooriginal, new.orse_vlservicooriginal, old.orse_tmultimaalteracao, now(), current_user,'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO atendimentopublico.ordem_servico_log
	        (orse_id, rgat_id, imov_id, svtp_id, amen_id, orsel_cdsituacao, orsel_tmemissao, orsel_tmencerramento, orsel_dsparecerencerramento, orsel_dsobservacao, orsel_vlservicooriginal, orsel_vlservicoalterado, orsel_tmultimaalteracao, orsel_dataalteracao, orsel_usur, orsel_evento)
            VALUES 
			(old.orse_id, old.rgat_id, old.imov_id, old.svtp_id, old.amen_id, old.orse_cdsituacao, old.orse_tmemissao, old.orse_tmencerramento, old.orse_dsparecerencerramento, old.orse_dsobservacao, old.orse_vlservicooriginal, null, old.orse_tmultimaalteracao, now(), current_user,'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA atendimentopublico.ordem_servico
create trigger tgr_os_update_delete before update or delete
        on
        atendimentopublico.ordem_servico for each row execute procedure atendimentopublico.fnc_os_update_delete_log();	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CRIA TABELA RA_LOG
CREATE TABLE atendimentopublico.registro_atendimento_log (
	rgatl_id serial not null primary key,
	rgat_id int4 NOT NULL,
	imov_id int4 NULL,
	step_id int4 NOT NULL,
	amen_id int4 NULL,
	rgatl_cdsituacao int2 NOT NULL,
	rgatl_tmregistroatendimento timestamp NULL,
	rgatl_tmencerramento timestamp NULL,
	rgatl_dsobservacao varchar(400) NULL,
	rgatl_dslocalocorrencia varchar(200) NULL,
	rgatl_tmultimaalteracao timestamp NULL DEFAULT now(),
	rgatl_dataalteracao timestamp NOT null default now(),
	rgatl_dsparecerencerramento varchar(400) NULL,
	unid_idatual int4 NULL,
	rgatl_cdsetordiv int4 null,
	rgatl_usur varchar (20) not null,
	rgatl_evento char (1) not null
);

-- FUNÇÃO PARA ALTERACAO E DELECAO         
CREATE OR REPLACE FUNCTION atendimentopublico.fnc_ra_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   
	    if (tg_op = 'UPDATE')
	    then
			INSERT INTO atendimentopublico.registro_atendimento_log
	        (rgat_id, imov_id, step_id, amen_id, rgatl_cdsituacao, rgatl_tmregistroatendimento, rgatl_tmencerramento, rgatl_dsobservacao, rgatl_dslocalocorrencia, rgatl_tmultimaalteracao, rgatl_dataalteracao, rgatl_dsparecerencerramento, unid_idatual, rgatl_cdsetordiv, rgatl_usur, rgatl_evento)
            VALUES 
			(old.rgat_id, old.imov_id, old.step_id, old.amen_id, old.rgat_cdsituacao, old.rgat_tmregistroatendimento, new.rgat_tmencerramento, old.rgat_dsobservacao, old.rgat_dslocalocorrencia, old.rgat_tmultimaalteracao, now(), new.rgat_dsparecerencerramento, old.unid_idatual, old.rgat_cdsetordiv, current_user,'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO atendimentopublico.registro_atendimento_log
	        (rgat_id, imov_id, step_id, amen_id, rgatl_cdsituacao, rgatl_tmregistroatendimento, rgatl_tmencerramento, rgatl_dsobservacao, rgatl_dslocalocorrencia, rgatl_tmultimaalteracao, rgatl_dataalteracao, rgatl_dsparecerencerramento, unid_idatual, rgatl_cdsetordiv, rgatl_usur, rgatl_evento)
            VALUES 
			(old.rgat_id, old.imov_id, old.step_id, old.amen_id, old.rgat_cdsituacao, old.rgat_tmregistroatendimento, old.rgat_tmencerramento, old.rgat_dsobservacao, old.rgat_dslocalocorrencia, old.rgat_tmultimaalteracao, now(), old.rgat_dsparecerencerramento, old.unid_idatual, old.rgat_cdsetordiv, current_user,'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA  atendimentopublico.registro_atendimento
create trigger tgr_ra_update_delete before update or delete
        on
        atendimentopublico.registro_atendimento for each row execute procedure atendimentopublico.fnc_ra_update_delete_log();

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       

-- CRIA TABELA CREDITO REALIZADO LOG
create TABLE faturamento.credito_realizado_log (
	crrzl_id serial not null primary key,
	crrz_id int4 not null,
	crti_id int4 NULL,
	cnta_id int4 NOT NULL,
	lict_id int4 NOT NULL,
	crog_id int4 NOT NULL,
	crrzl_tmcreditorealizado timestamp NOT NULL,
	crrzl_vlcreditooriginal numeric(13,2) NOT NULL,
	crrzl_vlcreditoalterado numeric(13,2) NOT NULL,
	crrzl_amreferenciacredito int4 NULL,
	crrzl_tmultimaalteracao timestamp NOT NULL DEFAULT now(),
	crrzl_dataalteracao timestamp NOT NULL DEFAULT now(),
	crrzl_usur varchar (20) not null,
	crrzl_evento char (1)
);

-- FUNÇÃO PARA INSERÇÃO, ALTERACAO E DELECAO        
DROP FUNCTION faturamento.fnc_creditorealizado_update_delete_log() cascade;
CREATE OR REPLACE FUNCTION faturamento.fnc_creditorealizado_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   
		if (tg_op = 'UPDATE')	   
	    then
			INSERT INTO faturamento.credito_realizado_log
	        (crrz_id, crti_id, cnta_id, lict_id, crog_id, crrzl_tmcreditorealizado, crrzl_vlcreditooriginal, crrzl_vlcreditoalterado, crrzl_amreferenciacredito, crrzl_tmultimaalteracao, crrzl_dataalteracao, crrzl_usur, crrzl_evento)
            VALUES 
			(old.crrz_id, old.crti_id, old.cnta_id, old.lict_id, old.crog_id, old.crrz_tmcreditorealizado, old.crrz_vlcredito, new.crrz_vlcredito, old.crrz_amreferenciacredito, old.crrz_tmultimaalteracao, now(), current_user,'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO faturamento.credito_realizado_log
	        (crrz_id, crti_id, cnta_id, lict_id, crog_id, crrzl_tmcreditorealizado, crrzl_vlcreditooriginal, crrzl_vlcreditoalterado, crrzl_amreferenciacredito, crrzl_tmultimaalteracao, crrzl_dataalteracao, crrzl_usur, crrzl_evento)
            VALUES 
			(old.crrz_id, old.crti_id, old.cnta_id, old.lict_id, old.crog_id, old.crrz_tmcreditorealizado, old.crrz_vlcredito, old.crrz_vlcredito, old.crrz_amreferenciacredito, old.crrz_tmultimaalteracao, now(), current_user,'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA faturamento.credito_realizado
create trigger tgr_creditorealizado_update_delete before update or delete
        on
        faturamento.credito_realizado for each row execute procedure faturamento.fnc_creditorealizado_update_delete_log();

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CRIA TABELA CREDITO A REALIZAR LOG
create TABLE faturamento.credito_a_realizar_log (
	crarl_id serial not null primary key,
	crar_id int4 not null,
	rgat_id int4 null,
	imov_id int4 NULL,
	crti_id int4 NULL,
	lict_id int4 NULL,
	crog_id int4 NULL,
	dotp_id int4 NULL,
	crarl_tmatucredito timestamp NULL,
	crarl_vlcreditooriginal numeric(13,2) NULL,
	crarl_vlcreditoalterado numeric(13,2) NULL,
	crarl_tmultimaalteracao timestamp NULL,
	crarl_dataalteracao timestamp NOT NULL DEFAULT now(),
	usur_id varchar (20) null,
	crarl_evento char(1) not null
);

-- FUNÇÃO PARA ALTERACAO E DELECAO        --DROP FUNCTION faturamento.fnc_creditorealizado_update_delete_log() cascade;
CREATE OR REPLACE FUNCTION faturamento.fnc_creditoarealizar_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   		
	    if (tg_op = 'UPDATE')	   
	    then
			INSERT INTO faturamento.credito_a_realizar_log
	        (crar_id, rgat_id, imov_id, crti_id, lict_id, crog_id, dotp_id, crarl_tmatucredito, crarl_vlcreditooriginal, crarl_vlcreditoalterado, crarl_tmultimaalteracao, crarl_dataalteracao, usur_id, crarl_evento)
            VALUES 
			(old.crar_id, old.rgat_id, old.imov_id, old.crti_id, old.lict_id, old.crog_id, old.dotp_id, old.crar_tmatucredito, old.crar_vlcredito, new.crar_vlcredito, old.crar_tmultimaalteracao, now(), new.usur_id, 'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO faturamento.credito_a_realizar_log
	        (crar_id, rgat_id, imov_id, crti_id, lict_id, crog_id, dotp_id, crarl_tmatucredito, crarl_vlcreditooriginal, crarl_vlcreditoalterado, crarl_tmultimaalteracao, crarl_dataalteracao, usur_id, crarl_evento)
            VALUES 
			(old.crar_id, old.rgat_id, old.imov_id, old.crti_id, old.lict_id, old.crog_id, old.dotp_id, old.crar_tmatucredito, old.crar_vlcredito, old.crar_vlcredito, old.crar_tmultimaalteracao, now(), old.usur_id, 'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA faturamento.credito_a_realizar
create trigger tgr_creditoarealizar_update_delete before update or delete
        on
        faturamento.credito_a_realizar for each row execute procedure faturamento.fnc_creditoarealizar_update_delete_log();

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION  cadastro.fnc_clienteimovel_update_delete_log() cascade;
-- CRIA TABELA CLIENTE IMOVEL LOG
CREATE TABLE cadastro.cliente_imovel_log (
	climl_id serial not null primary key,
	clim_id int4 NOT NULL,
	clie_id int4 NOT NULL,
	imov_id int4 NOT NULL,
	climl_dtrelacaoinicio date NULL,
	climl_dtrelacaofim date NULL,
	cifr_id int4 NULL,
	crtp_id int4 NULL,
	climl_icnomeconta int2 NULL,
	climl_tmultimaalteracao timestamp NULL,
	climl_dataalteracao timestamp NOT NULL DEFAULT now(),
	usur_id varchar (20) null,
	climl_evento char(1) not null
);

-- FUNÇÃO PARA ALTERACAO E DELECAO        
CREATE OR REPLACE FUNCTION cadastro.fnc_clienteimovel_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   		
	    if (tg_op = 'UPDATE')	   
	    then
			INSERT INTO cadastro.cliente_imovel_log
	        (clim_id, clie_id, imov_id, climl_dtrelacaoinicio, climl_dtrelacaofim, cifr_id, crtp_id, climl_icnomeconta, climl_tmultimaalteracao, climl_dataalteracao, usur_id, climl_evento)
            VALUES 
			(old.clim_id, old.clie_id, old.imov_id, old.clim_dtrelacaoinicio, old.clim_dtrelacaofim, old.cifr_id, old.crtp_id, old.clim_icnomeconta, old.clim_tmultimaalteracao, now(), current_user, 'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO cadastro.cliente_imovel_log
	        (clim_id, clie_id, imov_id, climl_dtrelacaoinicio, climl_dtrelacaofim, cifr_id, crtp_id, climl_icnomeconta, climl_tmultimaalteracao, climl_dataalteracao, usur_id, climl_evento)
            VALUES 
			(old.clim_id, old.clie_id, old.imov_id, old.clim_dtrelacaoinicio, old.clim_dtrelacaofim, old.cifr_id, old.crtp_id, old.clim_icnomeconta, old.clim_tmultimaalteracao, now(), current_user, 'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA cadastro.cliente_imovel
create trigger tgr_clienteimovel_update_delete before update or delete
        on
        cadastro.cliente_imovel for each row execute procedure cadastro.fnc_clienteimovel_update_delete_log();

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ALTERANDO LOG DE IMOVEL_ROTA
ALTER TABLE cadastro.imovel_log RENAME TO imovel_rota_log;

DROP FUNCTION public.imovel_update_delete() cascade;

CREATE OR REPLACE FUNCTION cadastro.fnc_imovelrota_update_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin    
           if coalesce(old.imov_nnsequencialrota,0)<>coalesce(new.imov_nnsequencialrota,0) or coalesce(old.rota_id,0)<>coalesce(new.rota_id,0)
           then
                INSERT INTO cadastro.imovel_rota_log(
                   imov_id,imov_nnsequencialrota,rota_id)
              VALUES (old.imov_id,old.imov_nnsequencialrota,old.rota_id);
       end if;
             RETURN NEW;
    END;
$function$;

create trigger tgr_imovelrota_update before update
        on
        cadastro.imovel for each row execute procedure cadastro.fnc_imovelrota_update_log();

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CRIA TABELA IMOVEL LOG
CREATE TABLE cadastro.imovel_log (
	imovl_id serial not null primary key,
	imov_id int4 NOT NULL,
	imovl_situacao int4 NOT NULL,
	stcm_id int4 NOT NULL,
	last_id int4 NOT NULL,
	lest_id int4 NOT NULL,
	iper_id int4 NOT NULL,
	lgbr_id int4 NOT NULL,
	lgcp_id int4 NOT NULL,
	imovl_nnimovel bpchar(5) NOT NULL,
	imovl_dscomplementoendereco varchar(35) NULL,
	imovl_qteconomia int2 NULL,
	rota_id int4 NULL,
	imovl_nnsequencialrota int4 NULL,
	imovl_icdebitoconta int2 NOT NULL,
	imovl_cddebitoautomatico int4 NULL,
	imovl_ddvencimento int2 NULL,
	imovl_tmultimaalteracao timestamp NULL,
	imovl_dataalteracao timestamp NOT NULL DEFAULT now(),
	usur_id int4 null,
	imovl_evento char(1) not null
);      

--DROP FUNCTION  cadastro.fnc_imovel_update_delete_log() cascade;
-- FUNÇÃO PARA ALTERACAO E DELECAO        
CREATE OR REPLACE FUNCTION cadastro.fnc_imovel_update_delete_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    begin   		
	    if (tg_op = 'UPDATE')	   
	    then
			INSERT INTO cadastro.imovel_log
	        (imov_id, imovl_situacao, stcm_id, last_id, lest_id, iper_id, lgbr_id, lgcp_id, imovl_nnimovel, imovl_dscomplementoendereco, imovl_qteconomia, rota_id, imovl_nnsequencialrota, imovl_icdebitoconta, imovl_cddebitoautomatico, imovl_ddvencimento, imovl_tmultimaalteracao, imovl_dataalteracao, usur_id, imovl_evento)
            VALUES 
			(old.imov_id, old.imov_situacao, old.stcm_id, old.last_id, old.lest_id, old.iper_id, old.lgbr_id, old.lgcp_id, old.imov_nnimovel, old.imov_dscomplementoendereco, old.imov_qteconomia, old.rota_id, old.imov_nnsequencialrota, old.imov_icdebitoconta, old.imov_cddebitoautomatico, old.imov_ddvencimento, old.imov_tmultimaalteracao, now(), new.usur_id, 'U');
             RETURN NEW;

		elseif (tg_op = 'DELETE')
		then 
			INSERT INTO cadastro.imovel_log
	        (imov_id, imovl_situacao, stcm_id, last_id, lest_id, iper_id, lgbr_id, lgcp_id, imovl_nnimovel, imovl_dscomplementoendereco, imovl_qteconomia, rota_id, imovl_nnsequencialrota, imovl_icdebitoconta, imovl_cddebitoautomatico, imovl_ddvencimento, imovl_tmultimaalteracao, imovl_dataalteracao, usur_id, imovl_evento)
            VALUES 
			(old.imov_id, old.imov_situacao, old.stcm_id, old.last_id, old.lest_id, old.iper_id, old.lgbr_id, old.lgcp_id, old.imov_nnimovel, old.imov_dscomplementoendereco, old.imov_qteconomia, old.rota_id, old.imov_nnsequencialrota, old.imov_icdebitoconta, old.imov_cddebitoautomatico, old.imov_ddvencimento, old.imov_tmultimaalteracao, now(), old.usur_id, 'D');
             RETURN old;
		end if;
		return null;
    END;
$function$;

-- CRIA TRIGGER PARA TABELA cadastro.cliente_imovel
create trigger tgr_imovel_update_delete before update or delete
        on
        cadastro.imovel for each row execute procedure cadastro.fnc_imovel_update_delete_log();


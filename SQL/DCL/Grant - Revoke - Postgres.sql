-- AUTOR: DANIEL FARIAS
-- SOLICITANTE: MARCOS TI SAAE (EMAIL-07/08/2018)
-- DESCRIÇÃO: Trello - https://trello.com/c/UdTfXgOj/383-criar-acesso-ao-banco-gsancomercialsaae-no-srv-de-homologacao-para-empresa-gempi
-- DATA INICIO 07/08/2018
-- DATA FIM 07/08/2018
-- OBSERVAÇÃO: CRIADO PARA O SRV DE HOMOLOGACÃO IP-44

--CRIA USUARIO
create user gempi with encrypted password 'gempi';

--RENOMEIA USUARIO
alter user marcos rename to scriptcase
alter user scriptcase with password 'scriptcase'

--EXCLUI USUARIO
drop user gempi cascade;

--CONCEDE PERMISSAO PARA O BANCO
grant connect on database gsan_comercial_saae to gempi;

--RETIRA PERMISSAO PARA O BANCO
revoke connect on database gsan_comercial_saae from gempi;

--CONCEDE PERMISSAO PARA O SCHEMA
grant usage on schema atendimentopublico to gempi;

--RETIRA PERMISSAO PARA O SCHEMA
revoke all privileges on schema atendimentopublico from gempi;

-- CONCEDE PERMISSAO NA VIEW 
grant select on atendimentopublico.vw_integracao_janaina to gempi;

--RETIRA PERMISSAO NA VIEW 
revoke select on atendimentopublico.vw_integracao_janaina from gempi;

--CONCEDE PERMISSAO PARA TODAS AS TABELAS DO SCHEMA
grant select on all tables in schema atendimentopublico to gempi;

--RETIRA PERMISSAO PARA TODAS AS TABELAS DO SCHEMA
revoke select on all tables in schema atendimentopublico from gempi;


GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO daniel;
GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO eraldo;
GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO jonas;
GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO jony;
GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO scriptcase;
GRANT SELECT ON TABLE atendimentopublico.vw_integracao_janaina_servicos TO gempi;

/*CREATE USER readonly  WITH ENCRYPTED PASSWORD 'readonly';
GRANT USAGE ON SCHEMA public to gempi;
ALTER DEFAULT PRIVILEGES IN SCHEMA operacional GRANT SELECT ON TABLES TO gempi;
-- repita o codigo abaixo para cada banco de dados
GRANT CONNECT ON DATABASE foo to readonly;
-- o codigo abaixo concede o privilegio em novas tabelas geradas no banco "foo"
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO readonly;
GRANT USAGE ON SCHEMA public to readonly; 
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;*/

-- Cria usuario
create user geo with password 'geo' valid until '01-01-2020';
create user jonas with password 'jonas' SUPERUSER valid until '01-01-2025';
create user eraldo with password 'eraldo' SUPERUSER valid until '01-01-2025';
create user daniel with password 'daniel' SUPERUSER valid until '01-01-2025';
create user jony with password 'jony' SUPERUSER valid until '01-01-2025';


-- Permissao no schema
grant usage on schema atendimentopublico to geo;
-- Permissao na view
grant select on atendimentopublico.vw_integracao_janaina to geo;
-- todas as tabelas do schema arrecadacao
grant select on all tables in schema faturamento to geo; 

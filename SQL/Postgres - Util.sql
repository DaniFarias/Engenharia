select version(); -- Vers„o PostgresSQL

select ascii('D') 

select CHR(67)||CHR(39)||CHR(65)||CHR(44)||CHR(84) as chrexemplo
-- Resultado = C'A,T
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select length('daniel matos farias'); -- Conta a quantidade de caracteres na string 
-- Resultado = 19
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select initcap ('daniel matos farias') as initcapexemplo -- Primeira letra da palavra maiuscula
-- Resultado = Daniel Matos Farias 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select lower ('DAINEL MATOS FARIAS') as lowerexemplo -- Deixa a string com todas as letras minusculas
-- Resultado = dainel matos farias
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select upper ('dainel matos farias') as upperexemplo -- Deixa a string com todas as letras maiusucla
-- Resultado = DAINEL MATOS FARIAS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select lpad ('Daniel',10,'x') as lpadexemplo -- Passado 3 parametros. 1 - Campo, 2 - quantidade de characteres, 3 - com o que ser„o preenchido comeÁando pelo lado esquerdo.
-- Resultado = xxxxDaniel
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select rpad ('Daniel',10,'x') as rpadexemplo -- Passado 3 parametros. 1 - Campo, 2 - quantidade de characteres, 3 - com o que ser„o preenchido comeÁando pelo lado direito.
-- Resultado = Danielxxxx
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select ltrim ('   Daniel Matos Farias   ','   Dan') as ltrimexemplo -- Passado 2 parametros. 1 - Campo, 2 - o que ser· cortado comeÁando pelo lado esquerdo.
-- Resultado = 'iel Matos Farias   '
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select rtrim ('   Daniel Matos Farias   ','aris   ') as rtrimexemplo -- Passado 2 parametros. 1 - Campo, 2 - o que ser· cortado comeÁando pelo lado direito.
-- Resultado = '   Daniel Matos F'
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select trim (' ' from '      Daniel Matos Farias   ') as trimexemplo
select trim (leading '   Da' from '   Daniel Matos Farias   ') as trimexemplo
select trim (trailing '   as' from '   Daniel Matos Farias   ') as trimexemplo
select trim (both '  xx  ' from '  xxDaniel Matos Fariasxx  ') as trimexemplo
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select overlay ('D4ni3l' placing 'anie' from 2 for 4) -- SobreposiÁ„o de caracteres.
--Resultado = Daniel
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select replace ('Daniel Matos Farias', 'a', 'x' ) as replaceexemplo -- Passado 3 parametros. 1 - Texto, 2 - o que substituir, 3 - pelo que substituir.
-- Resultado = Dxniel Mxtos Fxrixs
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select substr ('Daniel Matos Farias',8,9) as substringexemplo -- Resultado = Matos Far 
select substr(imov_tmultimaalteracao::varchar,12,5)||' do dia '||to_char(imov_tmultimaalteracao, 'DD/MM/YYYY'), imov_tmultimaalteracao from cadastro.imovel
select SUBSTRING ('PostgreSQL' FROM '.......'); -- Retorna Postgre
select SUBSTRING ('PostgreSQL' FROM '..$'); --Retorna SQL 

------------------------------------------------------------------------------------------------------------------------------------------------------------------
select translate ('Daniel Matos Farias','ieF','134') as translateexemplo --
-- Resultado = Dan13l Matos 4ar1as
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select translate('2KRW229', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', '0123456789') as translateexemplo2 --
-- Resultado = 2229

-- No postgres o :: faz a funcao do CAST
select '22-01-2018'::date 
select ('9223372036854775800'::int8) + 7
select DATE_PART('year', '2018-01-01'::date) - DATE_PART('year', '2011-10-02'::date);
select '{apple,cherry apple, avocado}'::text[]

-- CONVERT data
BETWEEN to_timestamp('2016-04-22 00.00.00', 'YYYY-MM-DD HH24.MI.SS') AND to_timestamp('2016-04-22 23.59.59', 'YYYY-MM-DD HH24.MI.SS')
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT now() - INTERVAL '5 month' as intervalexemplo -- Fun√ß√£o interval manipula campo data, adicionando ou removendo dias, meses, anos para tratamento na clausula where. 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select age(timestamp '2017-11-28',timestamp '1990-11-28'); -- extrai idade 2 parametros 
--27 years 0 mons 0 days 0 hours 0 mins 0.00 secs
select age(timestamp '1990-11-28'); -- extrai idade atual 1 parametro
--27 years 5 mons 5 days 0 hours 0 mins 0.00 secs

--Retorno de parte/data
select date_part('year', timestamp 'now()')
select date_part('month', timestamp 'now()')
select date_part('day', timestamp 'now()')
select date_part('hour', timestamp 'now()')
select date_part('minute', timestamp 'now()')
select date_part('second', timestamp 'now()')
select date_part('millisecond', timestamp 'now()')
select extract(millisecond from timestamp 'now()') -- O comando extract tbm pode ser usado 

select date_trunc('day', timestamp '2001-02-16 20:38:48') -- Trunca data
select date_trunc('hour', timestamp '2001-02-16 20:38:48') -- Trunca data
select date_trunc('minute', timestamp '2001-02-16 20:38:48') -- Trunca data

select timeofday()
select isfinite(interval '1 hours')

SELECT (DATE '2001-02-16', DATE '2001-12-21') overlaps (DATE '2002-10-30', DATE '2002-10-30');

select current_user; -- usu√°rio logado
select current_database(); -- base de dados selecionada
select current_timestamp; -- data/hora
select current_date; -- data
select current_time; -- hora

--ARREDONDAMENTO
truncate
round
ceiling
floor
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pg_size_pretty(pg_database_size('gsan_comercial_saae')) -- Tamanho do banco de dados.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pg_size_pretty(pg_relation_size('nome_do_indice')) -- Tamanho do √≠ndice.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pg_size_prettY(pg_relation_size('atendimentopublico.registro_atendimento_anexo')) -- Tamanho da tabela sem indice.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pg_size_pretty(pg_total_relation_size('atendimentopublico.registro_atendimento_anexo')) -- Tamanho da tabela com indice.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from concat ('Testando ','a ','funcao ','concat'); --Concatena strings.
--Resultado = Testando a funcao concat
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from concat ('Testando nullif. ', nullif (null, 'Deu ok!')); -- Substitui o resultado null pelo paramentro.
--Resultado = Testando ifnull. Deu ok!
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from concat ('Testando coalesce. ', coalesce(null, null, 'Deu ok!', null)); --Retorna o primeiro valor n√£o-nulo passado no parametro, * aceita multiplas colunas, √© o padrao sql.
--Resultado = Testando coalesce. Deu ok!
SELECT COALESCE (NULL, NULL);
SELECT COALESCE (CAST (NULL AS INT), NULL)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from pg_stat_activity -- Status dos processos POSTGRESQL.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select pg_terminate_backend('NumerodoPID') -- Elimina o processo (select pid from pg_stat_activity) ativo. 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT pg_terminate_backend(procpid) FROM pg_stat_activity WHERE procpid  pg_backend_pid() -- Elimina todas os processos menos esta.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select 'update cadastro.bairro set bair_nmbairro = ' ||CHR(39)||bair_nmbairro||CHR(39)||' where bair_id = '||bair_id||';' as UpdatePeloSelect from cadastro.bairro -- update gerado por um select
-- Resultado = update cadastro.bairro set bair_nmbairro = 'CENTRO A' where bair_id = 1;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
select row_number()over(partition by stcm_id order by imov_id asc)*10,imov_id, stcm_id from cadastro.imovel
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Criando tabela com arrays com o recurso unnest(array[]). Utiliza√ß√£o do recurso limit e offset. Limite de 5 registros come√ßando a contar do registro 3.
SELECT UNNEST(ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]),  UNNEST(ARRAY[100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100]),  UNNEST(ARRAY['a', 'b', 'c','a', 'b', 'c','a', 'b', 'c','a', 'b'])
limit 6 offset 3
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Funcoes Alter Table
--Adicionar coluna
ALTER TABLE Tabela ADD COLUMN Coluna text;
ALTER TABLE Tabela ADD COLUMN Coluna text CHECK (Coluna <> '');
--Remover coluna
ALTER TABLE Tabela DROP COLUMN Coluna;
ALTER TABLE Tabela DROP COLUMN Coluna CASCADE;
--Adicionar restricao
ALTER TABLE Tabela ADD CHECK (Coluna <> '');
ALTER TABLE Tabela ADD CONSTRAINT unq_cod_prod UNIQUE (Coluna);
ALTER TABLE Tabela ADD FOREIGN KEY (Nome_da_FK) REFERENCES Coluna;
ALTER TABLE Tabela ALTER COLUMN Coluna SET NOT NULL;
--Remover restricao
ALTER TABLE Tabela DROP CONSTRAINT nome_da_restri√ß√£o;
ALTER TABLE Tabela ALTER COLUMN Coluna DROP NOT NULL;
--Mudar valor padrao da coluna
ALTER TABLE Tabela ALTER COLUMN Coluna SET DEFAULT 7.77;
ALTER TABLE Tabela ALTER COLUMN Coluna DROP DEFAULT;
--Mudar o tipo de dado da coluna
ALTER TABLE Tabela ALTER COLUMN Coluna TYPE numeric(10,2);
--Mudar nome de coluna
ALTER TABLE Tabela RENAME COLUMN Coluna TO Coluna2;
--Mudar nome de tabela
ALTER TABLE Tabela RENAME TO Tabela2;

-- Cria usuario
create user geo with password 'geo' valid until '01-01-2020';
create user marcos with password 'marcos' SUPERUSER valid until '01-01-2025';
create user jonas with password 'jonas' SUPERUSER valid until '01-01-2025';
create user eraldo with password 'eraldo' SUPERUSER valid until '01-01-2025';
create user daniel with password 'daniel' SUPERUSER valid until '01-01-2025';
alter user jony with password 'DIGITE SUA SENHA AQUI';
alter user marcos rename to scriptcase
alter user scriptcase with password 'scriptcase'

-- Permissao no schema
grant usage on schema atendimentopublico to geo;
-- Permissao na view
grant select on atendimentopublico.vw_integracao_janaina to geo;
-- todas as tabelas do schema arrecadacao
grant select on all tables in schema faturamento to geo; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- registros por tabela
select b.TABLE_SCHEMA,
        b.TABLE_NAME,
        a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name = 'clie_id'
      and a.reltuples <> 0
order by a.reltuples desc

-- MB por tabela
SELECT esquema, tabela,
       pg_size_pretty(pg_relation_size(esq_tab)) AS tamanho,
       pg_size_pretty(pg_total_relation_size(esq_tab)) AS tamanho_total
FROM (SELECT tablename AS tabela,
               schemaname AS esquema,
               schemaname||'.'||tablename AS esq_tab
          FROM pg_catalog.pg_tables
          WHERE schemaname NOT
             IN ('pg_catalog', 'information_schema', 'pg_toast') ) AS x
          where tabela like '%_log%'  
ORDER BY pg_total_relation_size(esq_tab) DESC;

-- Contador de rows por tabela
select b.TABLE_SCHEMA,
       b.TABLE_NAME,
       a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name = 'clie_id'
      and a.reltuples <> 0
order by a.reltuples DESC


select * from pg_stat_activity
  
select pg_terminate_backend(22480)

  SELECT pg_terminate_backend(pid) 
   FROM pg_stat_activity 
  WHERE pid <> pg_backend_pid();

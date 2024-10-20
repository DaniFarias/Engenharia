SELECT 'SELECT setval(''' || n.nspname || '.' ||
replace(replace(replace(replace(replace(replace(replace(replace(a.adsrc,
'(',''),')',''),'::',''),'textregclass',''),'nextval',''),'regclass',''),'''',''),
n.nspname||'.','')||''',(SELECT MAX('||ab.attname||') FROM '||
n.nspname|| '.'||c.relname||'),true);' as seqname
FROM pg_class c
JOIN pg_attrdef a ON c.oid=a.adrelid
JOIN pg_namespace n ON c.relnamespace = n.oid AND n.nspname NOT LIKE 'pg_%'
JOIN pg_index i ON i.indrelid=c.oid AND i.indisprimary='t'
JOIN pg_attribute ab ON ab.attrelid=c.oid AND ab.attisdropped='f' AND ab.atthasdef='t' AND i.indkey[0]=ab.attnum AND i.indkey[1] IS NULL
Where a.adsrc like 'nextval%';

select oid,* from pg_class where oid = 669127 or oid = 669156
select oid,* from pg_class where relnamespace = 665215
select * from pg_index
select * from pg_namespace
select * from pg_attribute
select * from pg_catalog.pg_sequence

CREATE OR REPLACE FUNCTION atualizarTodosSequenciais() RETURNS integer AS $$
DECLARE
tupla RECORD;
BEGIN
FOR tupla IN (
-- ### Query que monta um sql para cada sequencial ###--
SELECT DISTINCT
'SELECT setval(''' || n.nspname || '.' || c.relname
||''',COALESCE((SELECT MAX('||ab.attname||') FROM '|| n.nspname|| '.'||c.relname||'),1),true);'
as query
FROM pg_catalog.pg_class c
JOIN pg_namespace n ON c.relnamespace = n.oid AND n.nspname NOT LIKE 'pg_%'
JOIN pg_index i ON i.indrelid=c.oid and i.indisprimary='t'
JOIN pg_attribute ab on ab.attrelid=c.oid and ab.attisdropped='f' AND i.indkey[0]=ab.attnum AND i.indkey[1] IS NULL
WHERE c.relkind = 'S' and c.relname like 'sequence_%'
-- ### Fim query ###--
) LOOP
EXECUTE tupla.query;
END LOOP
RETURN 1;
END;
$$ LANGUAGE plpgsql;

  INNER JOIN pg_attribute a ON (c.oid = a.attrelid)
  INNER JOIN pg_index i ON (c.oid = i.indrelid)

SELECT setval('atendimentopublico.SEQUENCE_servico_tipo',COALESCE((SELECT MAX(svtp_id) FROM atendimentopublico.servico_tipo),1),true);

select oid,* from pg_catalog.pg_class
select * from pg_attribute where attname = 'imov_id'
select indkey,indrelid,* from pg_index
select * from pg_attrdef

SELECT c.relname,*
     FROM pg_catalog.pg_class c, pg_catalog.pg_namespace n
     WHERE c.relnamespace=n.oid
     AND c.relkind = 'S'
     and c.relname like 'sequence_%'
     ORDER BY c.relname

---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION reset_sequence() RETURNS void AS 
$BODY$
DECLARE _sql VARCHAR := '';
DECLARE result threecol%rowtype; 
BEGIN
FOR result IN 
WITH fq_objects AS (SELECT c.oid,n.nspname || '.' ||c.relname AS fqname ,c.relkind, c.relname AS relation FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace ),
    sequences AS (SELECT oid,fqname FROM fq_objects WHERE relkind = 'S'),
    tables    AS (SELECT oid, fqname FROM fq_objects WHERE relkind = 'r' )
SELECT
       s.fqname AS sequence,
       t.fqname AS table,
       a.attname AS column
FROM
     pg_depend d JOIN sequences s ON s.oid = d.objid
                 JOIN tables t ON t.oid = d.refobjid
                 JOIN pg_attribute a ON a.attrelid = d.refobjid and a.attnum = d.refobjsubid
WHERE
     d.deptype = 'a' 
LOOP
     EXECUTE 'SELECT setval('''||result.col1||''', COALESCE((SELECT MAX('||result.col3||')+1 FROM '||result.col2||'), 1), false);';
END LOOP;
END;$BODY$ LANGUAGE plpgsql;

SELECT * FROM reset_sequence();

select 'select * from '||table_schema||'.'||table_name, 
		column_name,
        a.reltuples 
from pg_class as a 
inner join information_schema.columns as b 
on a.relname = b.table_name 
where column_name like '%parc_id%'
      and a.reltuples <> 0
order by a.reltuples desc


-- AUTOR: DANIEL FARIAS
-- DESCRIÇÃO: IMÓVEIS MCMV; IMÓVEIS INADIMPLENTES MINHA CASA MINHA VIDA; IMÓVEIS MCMV COM TAXA MINIMA DE CONSUMO; RELAÇÃO DE PAGAMENTO DOS ULTIMOS 4 MESES
-- DATA INICIO 09/10/2017
-- DATA FIM 16/10/2017
-- OBSERVAÇÃO: FOI DESENVOLVIDO 7 RELATORIOS DE ACORDO COM AS SOLICITAÇÕES PEDIDAS.

-- Relatorio Jonas
-- Relatorios Imoveis MCMV. 
SELECT distinct i.imov_id as Imovel,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento,
       las.last_dsligacaoaguasituacao as Situacao
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb 
	ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b 
	ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l 
	ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las
	on i.last_id = las.last_id	
WHERE (lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068')
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco
       	 
       	        	  
-- Relatorios Imoveis  MCMV inadimplentes.
SELECT distinct i.imov_id as Imovel,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento,
       las.last_dsligacaoaguasituacao as Situacao
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb 
	ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b 
	ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l 
	ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las
	on i.last_id = las.last_id
WHERE ((lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068'))
  AND i.imov_id IN
			    (select distinct c.imov_id
				 from faturamento.conta as c
				 left join arrecadacao.pagamento as p
				 	on c.cnta_id = p.cnta_id
				 where p.cnta_id is null 
				   and dcst_idatual IN(0, 1, 2)
				   and c.cnta_dtvencimentoconta < '2017-10-01')
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco
       	 

--Relação de imóveis MCMV pagando taxa mínima. Quantidade de economia * consumo tem que ser menor que 6.   
SELECT distinct i.imov_id as Imovel,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento,
       las.last_dsligacaoaguasituacao as Situacao
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb 
	ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b 
	ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l 
	ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las
	on i.last_id = las.last_id
WHERE ((lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068'))
  AND i.imov_id IN
			    (SELECT DISTINCT i.imov_id
			     FROM micromedicao.consumo_historico ch
			     INNER JOIN cadastro.imovel AS i 
			     	ON i.imov_id = ch.imov_id
			     WHERE (cshi_nnconsumofaturadomes) <= i.imov_qteconomia * 6
			       AND cshi_amfaturamento = '201709')
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco
   
       	 
-- Relatorio Jony
-- Relação MCMV completo de pagamento 
SELECT distinct i.imov_id AS Imovel,
	  (SELECT c2.clie_nmcliente
	   FROM cadastro.cliente_imovel AS ci2
	   INNER JOIN cadastro.cliente AS c2 ON ci2.clie_id = c2.clie_id AND ci2.imov_id = i.imov_id
	   WHERE crtp_id = 1 LIMIT 1) AS Proprietario,
	  (SELECT c2.clie_nmcliente
	   FROM cadastro.cliente_imovel AS ci2
	   INNER JOIN cadastro.cliente AS c2 ON ci2.clie_id = c2.clie_id AND ci2.imov_id = i.imov_id
	   WHERE crtp_id = 2 LIMIT 1) AS Usuario,
       b.bair_nmbairro AS Bairro,
       l.logr_nmlogradouro AS Rua,
       i.imov_nnimovel AS NumeroImovel,
       i.imov_dscomplementoendereco AS Complemento,
       las.last_dsligacaoaguasituacao AS Situacao,
       ch.cshi_amfaturamento AS MesFaturamento,
       CASE
           WHEN p.cnta_id IS NULL THEN 'Nao Paga'
           ELSE 'Paga'
       END AS CntaPaga,
       ch.cshi_nnconsumofaturadomes AS consumomes,
       ip.iper_dsimovelperfil as Classificacao,
       CASE
           WHEN ch.cshi_nnconsumofaturadomes BETWEEN 0 AND 12 AND i.iper_id = 4 AND i.imov_qteconomia = 1 THEN 'Tarifa Social'
           WHEN ch.cshi_nnconsumofaturadomes <= 6 THEN 'Taxa Minima'
           ELSE 'Tarifa Normal'
       END AS ClassificacaoFatu
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l ON lb.logr_id = l.logr_id
INNER JOIN atendimentopublico.ligacao_agua_situacao AS las ON i.last_id = las.last_id
INNER JOIN micromedicao.consumo_historico AS ch ON i.imov_id = ch.imov_id
INNER JOIN faturamento.conta AS c ON i.imov_id = c.imov_id AND c.cnta_amreferenciaconta = ch.cshi_amfaturamento
INNER JOIN cadastro.cliente_imovel AS ci ON ci.imov_id = i.imov_id 
INNER JOIN cadastro.cliente AS cli ON ci.clie_id = cli.clie_id
inner join cadastro.imovel_perfil as ip on i.iper_id = ip.iper_id
LEFT JOIN arrecadacao.pagamento AS p ON c.cnta_id = p.cnta_id
WHERE ((lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
    OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
    OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068'))
    AND ch.cshi_amfaturamento BETWEEN 201705 AND 201708
    AND dcst_idatual IN(0,1,2)
ORDER BY b.bair_nmbairro,
         l.logr_nmlogradouro,
         i.imov_nnimovel,
         i.imov_dscomplementoendereco,
         i.imov_id,
         ch.cshi_amfaturamento
         
--------------------------------------------------------------------------------------------------------------------------------------------
-- Relatorios Marcos
-- Dados dos consumidores ligados. 
SELECT distinct i.imov_id as Imovel,
	  (SELECT c2.clie_nmcliente
	   FROM cadastro.cliente_imovel AS ci2
	   INNER JOIN cadastro.cliente AS c2 ON ci2.clie_id = c2.clie_id AND ci2.imov_id = i.imov_id
	   WHERE crtp_id = 1 LIMIT 1) AS Proprietario,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las on i.last_id = las.last_id	
WHERE (lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068')
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco
       	 
-- Unidades inadimplentes nos ultimos meses mais de 02 meses
SELECT distinct i.imov_id as Imovel,
	  (SELECT c2.clie_nmcliente
	   FROM cadastro.cliente_imovel AS ci2
	   INNER JOIN cadastro.cliente AS c2 ON ci2.clie_id = c2.clie_id AND ci2.imov_id = i.imov_id
	   WHERE crtp_id = 1 LIMIT 1) AS Proprietario,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento,
       ch.cshi_amfaturamento as DataFaturamento,
       (cnta_vlagua+cnta_vlesgoto+cnta_vldebitos-cnta_vlcreditos) as Valor, 
       ch.cshi_nnconsumofaturadomes as Metro3
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las on i.last_id = las.last_id
INNER JOIN micromedicao.consumo_historico AS ch ON i.imov_id = ch.imov_id
INNER JOIN faturamento.conta AS c ON i.imov_id = c.imov_id AND c.cnta_amreferenciaconta = ch.cshi_amfaturamento
LEFT JOIN arrecadacao.pagamento AS p ON c.cnta_id = p.cnta_id
WHERE ((lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068'))
   AND ch.cshi_amfaturamento BETWEEN 201708 AND 201709
   and p.cnta_id is null
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco     
       	 
-- Unidades com consumo de taxa minima
SELECT distinct i.imov_id as Imovel,
	  (SELECT c2.clie_nmcliente
	   FROM cadastro.cliente_imovel AS ci2
	   INNER JOIN cadastro.cliente AS c2 ON ci2.clie_id = c2.clie_id AND ci2.imov_id = i.imov_id
	   WHERE crtp_id = 1 LIMIT 1) AS Proprietario,
       b.bair_nmbairro as Bairro,
       l.logr_nmlogradouro as Rua,
       i.imov_nnimovel as NumeroImovel,
       i.imov_dscomplementoendereco as Complemento,
       ch.cshi_nnconsumofaturadomes
FROM cadastro.imovel AS i
INNER JOIN cadastro.logradouro_bairro AS lb ON i.lgbr_id = lb.lgbr_id
INNER JOIN cadastro.bairro AS b ON lb.bair_id = b.bair_id
INNER JOIN cadastro.logradouro l  ON lb.logr_id = l.logr_id
inner join atendimentopublico.ligacao_agua_situacao las on i.last_id = las.last_id
INNER JOIN micromedicao.consumo_historico AS ch ON i.imov_id = ch.imov_id
WHERE ((lb.lgbr_id = 9999165 AND i.imov_nnimovel = '725')
   OR (lb.lgbr_id = 9999156 AND i.imov_nnimovel = '174')
   OR (lb.lgbr_id = 833025  AND i.imov_nnimovel = '1068'))
   and ch.cshi_amfaturamento = '201709'
   AND i.imov_id IN
			    (SELECT DISTINCT i.imov_id
			     FROM micromedicao.consumo_historico ch
			     INNER JOIN cadastro.imovel AS i 
			     	ON i.imov_id = ch.imov_id
			     WHERE (cshi_nnconsumofaturadomes) <= i.imov_qteconomia * 6
			       AND cshi_amfaturamento = '201709')
order by b.bair_nmbairro,
      	 l.logr_nmlogradouro,
       	 i.imov_nnimovel,
       	 i.imov_dscomplementoendereco  
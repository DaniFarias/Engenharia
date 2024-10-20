SELECT
	A.VBELN AS Documento_faturamento,
	A.POSNR AS Item_faturamento,
	A.FKIMG AS Quantidade_faturada,
	A.LMENG AS Quantidade_pedida,
	A.VGBEL AS Remessa,
	A.MATNR AS Material,
	A.ARKTX AS Desc_material,
	A.KZWI1 AS Valor,
	A.ERDAT AS Data_faturado,
	A.AUBEL AS Ordem_vendas,
	C.ERNAM AS Criado_por,
	D.BEZEI AS Origem_verba,
	E.BEZEI AS Tipo_verba
FROM SAPS4P.VBRP AS A
INNER JOIN SAPS4P.TVM1T AS D
ON A.MVGR1 = D.MVGR1
INNER JOIN SAPS4P.TVM2T AS E
ON A.MVGR2 = E.MVGR2
INNER JOIN SAPS4P.VBAK AS C
ON A.AUBEL = C.VBELN
WHERE C.ERNAM = 'MCFARIA'
AND D.SPRAS = 'P'
AND D.MANDT = 400
AND E.SPRAS = 'P'
AND E.MANDT = 400
AND A.VBELN = 90252203
ORDER BY A.AUBEL 


SELECT
	A.VBELN AS Documento_faturamento,
	A.POSNR AS Item_faturamento,
	A.FKIMG AS Quantidade_faturada,
	A.LMENG AS Quantidade_pedida,
	A.VGBEL AS Remessa,
	A.MATNR AS Material,
	A.ARKTX AS Desc_material,
	A.KZWI1 AS Valor,
	A.ERDAT AS Data_faturado,
	A.AUBEL AS Ordem_vendas,
	C.ERNAM AS Criado_por,
	A.MVGR1 AS Origem_verba,
	A.MVGR2 AS Tipo_verba
FROM SAPS4P.VBRP AS A
INNER JOIN SAPS4P.VBAK AS C
ON A.AUBEL = C.VBELN
WHERE C.ERNAM = 'MCFARIA'
ORDER BY A.AUBEL 

	

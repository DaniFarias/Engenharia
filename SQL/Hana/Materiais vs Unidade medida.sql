SELECT DISTINCT  
A.MATNR AS COD_MATERIAL,
B.MAKTX AS DESC_MATERIAL,
A.UMREZ AS MULTIPLO,
CASE A.MEINH
			WHEN 'KI' THEN 'CX'
			WHEN 'PAK' THEN 'PAC'
			WHEN 'PAL' THEN 'PALLET'
			WHEN 'UN' THEN 'UN'
			WHEN 'KG' THEN 'KG'
			ELSE 'VAZIO'
		END AS UNIDADE_MEDIDA,
A.EAN11 AS EAN,
C.MTART AS TIPO_MATERIAL,
D.MTBEZ AS DESC_TIPO
FROM SAPS4P.MARM AS A
INNER JOIN SAPS4P.MAKT AS B 
ON A.MATNR = B.MATNR 
INNER JOIN SAPS4P.MARA AS C 
ON A.MATNR = C.MATNR 
INNER JOIN SAPS4P.T134T AS D
ON C.MTART = D.MTART 
WHERE A.MANDT = 400 AND B.SPRAS = 'P' AND D.SPRAS = 'P'
AND C.MTART IN ('ZHIB', 'ZHAW', 'ZHAL', 'ZFER')
ORDER BY A.MATNR 
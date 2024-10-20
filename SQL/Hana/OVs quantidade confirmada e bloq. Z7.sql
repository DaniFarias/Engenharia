//OVs com bloqueio de remessa Z7, quantidade confirmada divisão de remessa e consumindo saldo de estoque CO09 (VBBE)

SELECT
A.VBELN AS "Doc vendas", 
A.POSNR AS "Item", 
A.BMENG AS "Qtd Confirmada",
A.LIFSP AS "Bloqueio de remessa"
FROM SAPS4P.VBEP AS A
INNER JOIN SAPS4P.VBBE AS B
ON A.VBELN = B.VBELN AND A.POSNR = B.POSNR
WHERE A.MANDT = 400
AND A.BMENG <> 0
AND A.LIFSP = 'Z7'

//A mesma coisa do anterior mas confere o motivo de recusa ao invés do bloqueio de remessa
SELECT
A.VBELN AS "Doc vendas", 
A.POSNR AS "Item", 
A.BMENG AS "Qtd Confirmada",
C.ABGRU AS "Motivo recusa"
FROM SAPS4P.VBEP AS A
INNER JOIN SAPS4P.VBBE AS B
ON A.VBELN = B.VBELN AND A.POSNR = B.POSNR
INNER JOIN SAPS4P.VBAP AS C
ON A.VBELN = C.VBELN AND C.ABGRU <> '' AND A.POSNR = C.POSNR
WHERE A.MANDT = 400
AND A.BMENG <> 0
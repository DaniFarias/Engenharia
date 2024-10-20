SELECT
 A.Agr_Name AS "Codigo do Perfil", 
 A.AGR_NAME AS "Descricao do Perfil", 
 'SAP' AS Sistema,
 B.TCODE AS Transacao,
 B.PGMNA AS "Descricao da Transacao", 
 'N/A' AS "Codigo do Responsavel",
 'N/A' AS "Nome do Responsavel",
 'N/A' AS "E-Mail do Responsavel"
FROM SAPS4P.AGR_1251 AS A
 INNER JOIN SAPS4P.TSTC AS B ON A.LOW = B.TCODE
 AND A.OBJECT = 'S_TCODE' AND A.FIELD = 'TCD'
 
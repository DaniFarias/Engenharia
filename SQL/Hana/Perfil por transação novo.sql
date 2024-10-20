
//perfil_transacao

//v1
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
 WHERE 
 A.MANDT = 400 AND
 A.Agr_Name LIKE 'Z%' 
 
 
 //v2
 SELECT
 A.Agr_Name AS "Codigo do Perfil", 
 A.AGR_NAME AS "Descricao do Perfil", 
 B.TCODE AS "Transacao",
 B.PGMNA AS "Programa", 
 C.TTEXT AS "Texto Transação"
FROM SAPS4P.AGR_1251 AS A
 INNER JOIN SAPS4P.TSTC AS B ON A.LOW = B.TCODE
 INNER JOIN SAPS4P.TSTCT AS C ON C.TCODE = B.TCODE 
 AND A.OBJECT = 'S_TCODE' AND A.FIELD = 'TCD'
 WHERE 
 A.MANDT = 400 AND
 C.SPRSL = 'P' AND
 A.Agr_Name LIKE 'Z%' 
 ORDER BY A.AGR_NAME ASC
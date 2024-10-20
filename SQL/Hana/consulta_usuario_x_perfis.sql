//Consulta Usuário x Perfil

SELECT
 C.UNAME AS "Codigo do Usuario"
 , B.NAME_TEXTC AS "Descricao do Usuario"
 , 'N/A' AS "Documento de Identificacao"
 , C.AGR_NAME AS "Codigo do Perfil"
 , C.AGR_NAME AS "Descricao do Perfil"
 , 'SAP' AS Sistema
 , 'N/A' AS "Codigo do Gestor"
 , 'N/A' AS "Nome do Gestor"
 , 'N/A' AS "E-Mail"
 , 'N/A' AS "Area do Usuario"
 , 'N/A' AS "Codigo do Responsavel"
 , 'N/A' AS "Nome do Responsavel"
 , 'N/A' AS "E-Mail do Responsavel"
 FROM SAPS4P.USR02 AS A
 JOIN SAPS4P.USER_ADDR AS B ON A.BNAME = B.BNAME
 JOIN SAPS4P.AGR_USERS AS C ON B.BNAME = C.UNAME
 WHERE A.MANDT = '400' AND C.AGR_NAME <> 'Z_SAP_ALL'
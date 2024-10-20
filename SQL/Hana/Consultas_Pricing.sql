--Centro/Cliente/Material
SELECT 
A950.KAPPL AS "Aplicacao",
A950.KSCHL AS "Tp_condicao",
A950.KUNNR AS "Cliente",
A950.WERKS AS "Centro",
A950.MATNR AS "Material",
A950.DATBI AS "Fim_validade",
A950.DATAB AS "Inicio_validade",
A950.KNUMH AS "Num_reg_cond",
KONP.KBETR AS "Montante",
KONP.MXWRT AS "Limite_inferior",
KONP.GKWRT AS "Limite_superior"
FROM SAPS4P.A950
INNER JOIN SAPS4P.KONP
ON A950.KNUMH = KONP.KNUMH
WHERE A950.MANDT = '400'
AND A950.KSCHL = 'ZD01'
AND A950.DATBI >= 20220713

--Centro/Material
SELECT 
A406.KAPPL AS "Aplicacao",
A406.KSCHL AS "Tp_condicao",
A406.WERKS AS "Centro",
A406.MATNR AS "Material",
A406.DATBI AS "Fim_validade",
A406.DATAB AS "Inicio_validade",
A406.KNUMH AS "Num_reg_cond",
KONP.KBETR AS "Montante",
KONP.MXWRT AS "Limite_inferior",
KONP.GKWRT AS "Limite_superior"
FROM SAPS4P.A406
INNER JOIN SAPS4P.KONP
ON A406.KNUMH = KONP.KNUMH
WHERE A406.MANDT = '400'
AND A406.KSCHL = 'ZD01'
AND A406.DATBI = 99991231


--Centro/Cliente
SELECT 
A953.KAPPL AS "Aplicacao",
A953.KSCHL AS "Tp_condicao",
A953.WERKS AS "Centro",
A953.KUNNR AS "Cliente",
A953.DATBI AS "Fim_validade",
A953.DATAB AS "Inicio_validade",
A953.KNUMH AS "Num_reg_cond",
KONP.KBETR AS "Montante",
KONP.MXWRT AS "Limite_inferior",
KONP.GKWRT AS "Limite_superior"
FROM SAPS4P.A953
INNER JOIN SAPS4P.KONP
ON A953.KNUMH = KONP.KNUMH
WHERE A953.MANDT = '400'
AND A953.KSCHL = 'ZD01'
AND A953.DATBI = 99991231


--Centro/grupo de clientes/material
SELECT 
A954.KAPPL AS "Aplicacao",
A954.KSCHL AS "Tp_condicao",
A954.WERKS AS "Centro",
A954.KDGRP AS "Grupo de clientes",
A954.MATNR AS "Material",
A954.DATBI AS "Fim_validade",
A954.DATAB AS "Inicio_validade",
A954.KNUMH AS "Num_reg_cond",
KONP.KBETR AS "Montante",
KONP.MXWRT AS "Limite_inferior",
KONP.GKWRT AS "Limite_superior"
FROM SAPS4P.A954
INNER JOIN SAPS4P.KONP
ON A954.KNUMH = KONP.KNUMH
WHERE A954.MANDT = '400'
AND A954.KSCHL = 'ZD01'
AND A954.DATBI = 99991231


--Centro/grupo de clientes
SELECT 
A973.KAPPL AS "Aplicacao",
A973.KSCHL AS "Tp_condicao",
A973.WERKS AS "Centro",
A973.KDGRP AS "Grupo de clientes",
A973.DATBI AS "Fim_validade",
A973.DATAB AS "Inicio_validade",
A973.KNUMH AS "Num_reg_cond",
KONP.KBETR AS "Montante",
KONP.MXWRT AS "Limite_inferior",
KONP.GKWRT AS "Limite_superior"
FROM SAPS4P.A973
INNER JOIN SAPS4P.KONP
ON A973.KNUMH = KONP.KNUMH
WHERE A973.MANDT = '400'
AND A973.KSCHL = 'ZD01'
AND A973.DATBI = 99991231












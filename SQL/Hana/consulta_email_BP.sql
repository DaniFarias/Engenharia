SELECT 
A.KUNNR AS "Cod_cliente",
A.NAME1 AS "Nome_cliente",
A.TELF1 AS "Telefone_1",
A.TELF2 AS "Telefone_2",
--A.ADRNR,
--B.ADDRNUMBER,
B.CONSNUMBER AS "Numerador_email",
B.REMARK AS "Tipo_email",
C.SMTP_ADDR AS "Email",
D.VTWEG AS "Canal_Distribuição",
D.SPART AS "Setor_Atividade",
D.VKGRP AS "Equipe_vendas",
E.BEZEI AS "Desc_equipe_vendas",
D.VKBUR AS "Escritorio_vendas",
F.BEZEI AS "Desc_escritorio_vendas"
FROM SAPS4P.KNA1 AS A --Tabela Mestre de clientes (geral)
INNER JOIN SAPS4P.ADRT AS B -- Tabela textos de e-mail
ON A.ADRNR = B.ADDRNUMBER -- JOIN do numerador de endereço que tem nas 2 tabelas
INNER JOIN SAPS4P.ADR6 AS C -- Tabela central com dados de comunicação
ON A.ADRNR = C.ADDRNUMBER AND B.CONSNUMBER = C.CONSNUMBER -- JOIN do numerador de endereço da KNA1 com ADR6 + JOIN do numerador do e-mail
INNER JOIN SAPS4P.KNVV AS D -- Tabela com os dados de vendas do cliente
ON A.KUNNR = D.KUNNR 
INNER JOIN SAPS4P.TVGRT AS E --Tabela de texto dos vendedores/equipe de vendas
ON D.VKGRP = E.VKGRP 
INNER JOIN SAPS4P.TVKBT AS F --Tabela de texto do escritorio de vendas
ON D.VKBUR = F.VKBUR 
--WHERE A.KUNNR = 112238 --AND C.FLG_NOUSE = ''
WHERE A.KUNNR = 135285


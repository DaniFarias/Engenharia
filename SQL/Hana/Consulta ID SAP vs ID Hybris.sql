// Consulta ID SAP vs ID Hybris

SELECT tbl4.KUNNR AS COD_CLIENTE
        , tbl5.NAME1 AS NOME_CLIENTE
        , tbl3.objkey AS OV
        , tbl1.objkey AS idc4
FROM saps4p.srrelroles AS tbl1
             INNER JOIN saps4p.smzb_binrel AS tbl2 ON tbl2.role_a = tbl1.roleid
             INNER JOIN saps4p.srrelroles  AS tbl3 ON tbl3.roleid = tbl2.role_b
             INNER JOIN saps4p.vbak AS tbl4 ON tbl3.OBJKEY = tbl4.VBELN
             INNER JOIN saps4p.kna1 AS tbl5 ON tbl4.KUNNR = tbl5.KUNNR
WHERE tbl3.roletype = 'COD_REPL'
            AND tbl4.ERDAT >= '20220829'
            AND tbl4.ERNAM = 'CODINTG'
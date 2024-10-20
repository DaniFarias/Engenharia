SELECT
	
    j_1bnfdoc.nfenum AS NUMERO_NF,
    (SELECT COUNT(*) FROM SAPS4P.ZSDT_EMB_FRAC WHERE VBELN = LIPS.VBELN) AS VOLUME_NF,
    j_1bnfdoc.brgew AS PESO_BRUTO,
    j_1bnfdoc.ntgew AS PESO_LIQUIDO,
    j_1bnfdoc.gewei AS UNIDADE_PESO,
    j_1bnfdoc.nftot AS VALOR_TOTAL_NOTA,
    j_1bnflin.matnr AS CODIGO_MATERIAL,
    j_1bnflin.maktx AS DESCRICAO_MATERIAL,
    j_1bnfdoc.pstlz AS CEP_DESTINO,
    lips.vgbel AS OV
    
	FROM 
	
	SAPS4P.j_1bnfdoc
    JOIN SAPS4P.j_1bnflin
      ON j_1bnflin.docnum = j_1bnfdoc.docnum
    JOIN SAPS4P.vbrp
      ON vbrp.vbeln = j_1bnflin.refkey AND vbrp.posnr = j_1bnflin.refitm
    JOIN SAPS4P.lips
      ON lips.vbeln = vbrp.vgbel AND lips.posnr = vbrp.vgpos
    JOIN SAPS4P.vbak
      ON lips.vgbel = vbak.vbeln AND vbak.auart = 'ZVEC'	
	 
	
	WHERE 
	 j_1bnfdoc.cancel = ''
    AND j_1bnfdoc.DOCSTAT = '1'
    AND j_1bnfdoc.DOCTYP = '1'
    AND j_1bnfdoc.DIRECT = '2'
	AND LIPS.ERDAT BETWEEN '20210108' AND '20210408' 
	
	



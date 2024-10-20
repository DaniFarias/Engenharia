//pegar ordem de vendas a partir de nota fiscal

SELECT
    j_1bnfdoc.docnum,
    j_1bnfdoc.nfe,
    j_1bnfdoc.nfenum,
    j_1bnfdoc.nfnum,
    j_1bnflin.refkey,
    j_1bnflin.refitm,
    vbrp.posnr,
    lips.vbeln AS REMESSA,
    vbrp.vbeln AS DOC_FATURAMENTO,
    vbrp.vgbel AS REMESSA,
    lips.vgbel AS OV
    
  
  FROM
    SAPS4P.j_1bnfdoc
    JOIN SAPS4P.j_1bnflin
      ON j_1bnflin.docnum = j_1bnfdoc.docnum
    JOIN SAPS4P.vbrp
      ON vbrp.vbeln = j_1bnflin.refkey AND vbrp.posnr = j_1bnflin.refitm
    JOIN SAPS4P.lips
      ON lips.vbeln = vbrp.vgbel AND lips.posnr = vbrp.vgpos
    JOIN SAPS4P.likp
      ON likp.vbeln = lips.vbeln
   
    
    
  WHERE
    j_1bnfdoc.cancel = ''
    AND j_1bnfdoc.DOCSTAT = '1'
    AND j_1bnfdoc.DOCTYP = '1'
    AND j_1bnfdoc.DIRECT = '2'
    AND j_1bnfdoc.nfenum IN('000427637',
'000427638',
'000427639')
    
    
 
 GROUP BY
 j_1bnfdoc.docnum,
    j_1bnfdoc.nfe,
    j_1bnfdoc.nfenum,
    j_1bnfdoc.nfnum,
    lips.vbeln,
    vbrp.vbeln ,
    vbrp.vgbel,
    lips.vgbel

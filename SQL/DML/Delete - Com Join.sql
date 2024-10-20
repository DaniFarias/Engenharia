select * from tbl_parcelas_rec as a
inner join tbl_contas_rec as b
on a.documento = b.documento
where b.codcarga = 1786 and a.tipodoc = '01'

delete tbl_parcelas_rec
from tbl_parcelas_rec 
inner join tbl_contas_rec 
on tbl_parcelas_rec.documento = tbl_contas_rec.documento
where tbl_contas_rec.codcarga = 1786 and tbl_parcelas_rec.tipodoc = '01'
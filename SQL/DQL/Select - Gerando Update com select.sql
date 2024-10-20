select 
upper ('update tbl_cargas set DTENCERRADA = ' + 
CHAR(39) + convert(VARCHAR(10),  dtencerrada,103) + CHAR(39)+ 
' where codcarga = ' + CONVERT (VARCHAR(10), codcarga))
from tbl_cargas
where DTENCERRADA is not null





create table public.AtendimentoMotivoEncerramento (
	id int4 NOT NULL,
	Descricao varchar not null
);

INSERT INTO AtendimentoMotivoEncerramento (Id, Descricao)  
select amen_id, amen_dsmotivoencerramento 
from atendimentopublico.atendimento_motivo_encerramento
WHERE amen_icuso = 1		
ORDER BY amen_id


SELECT translate ('INSERT INTO AtendimentoMotivoEncerramento (Id, Descricao) VALUES' || 
array((select '(''' || ame.amen_id || ''',''' || ame.amen_dsmotivoencerramento || ''')' FROM
	atendimentopublico.atendimento_motivo_encerramento ame
WHERE ame.amen_icuso = 1		
ORDER BY ame.amen_id))::text,'"{}','')


select * from public.AtendimentoMotivoEncerramento

drop table public.AtendimentoMotivoEncerramento

 

--count how many parts in NYC have more than 70 parts on_hand
select count(*)
from part_nyc
where on_hand > 70;

--select count(*) of the following:
--red parts on_hand in part_nyc
--union
--red parts on hand in part_sfo

select SUM(on_hand) from ( 
select on_hand
from part_nyc PNYC, color C1
where PNYC.color = C1.color_id and C1.color_name = 'Red'

union all

select on_hand
from part_sfo PSFO, color C2
where PSFO.color = C2.color_id and C2.color_name = 'Red'
) as foo;



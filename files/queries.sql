DROP TABLE IF EXISTS sumnyc, sumsfo;
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

--union all since the part_number is not
--unique per part (as mentioned)
--and we want to include all in the sum
union all


select on_hand
from part_sfo PSFO, color C2
where PSFO.color = C2.color_id and C2.color_name = 'Red'
) as foo;



--List all the suppliers that have more total on hand parts in NYC than 
--they do in SFO

SELECT supplier, SUM(on_hand) AS total
INTO sumnyc
FROM part_nyc
GROUP BY supplier;

SELECT supplier, SUM(on_hand) AS total
INTO sumsfo
FROM part_sfo
GROUP BY supplier;

SELECT supplier.supplier_name, SN.supplier, SN.total AS NY_total
FROM sumnyc SN, supplier
WHERE (SN.total >	   (SELECT SSF.total
					FROM sumsfo SSF
					WHERE SN.supplier = SSF.supplier)) 
		AND supplier.supplier_id = SN.supplier;
					
DROP TABLE sumsfo;
DROP TABLE sumnyc;
					
					
--list all suppliers that supply parts in NYC that are not supplied in SFO
--essentially, find all parts in NYC that are not in SFO and get suppliers for those parts
SELECT PN.supplier
FROM part_nyc PN
WHERE PN.part_number NOT IN
                (SELECT SF.part_number
		FROM part_sfo SF);


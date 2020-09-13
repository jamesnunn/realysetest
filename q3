/*
Use unnest to stack the columns and average/group by the zone with a filter on measure
*/

select 
  unnest(array[sector, district, area]) as zone,
  avg(measure)
from indicator_data
where measure > 5
group by zone
order by zone

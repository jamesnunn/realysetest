-- Join and coalesce

select * from 
(select
  a.id, price,
  coalesce(b.bedrooms, c.bedrooms) bedrooms
  from a
  left join b on a.id = b.id
  left join c on a.id = c.id) beds
 where bedrooms is not null

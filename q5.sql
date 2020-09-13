select
  id,
  min(distance) FILTER (WHERE place_type = 'Hospital') closest_hospital,
  min(distance) FILTER (WHERE place_type in ('Restaurant', 'Cafe')) closest_restaurat_cafe,
  count(distance) FILTER (WHERE place_type in ('Restaurant', 'Cafe') and distance <= 3000) number_restaurant_3k,
  count(distance) FILTER (WHERE place_type in ('Restaurant', 'Cafe') and distance <= 5000) number_restaurant_5k
from property_poi_distances
group by id
order by id

1. Use generate_series to create the entire month records. Join by date to indicator_data then use lag with order by month asc to get the last non-null value from the previous month.

2. Use regex to extract capitalised as first name and lower as last name. Assumes <FIRSTNAME Lastname> and only two substrings.
This'll get all alpha strings. (\b[A-Za-z]+\b) 
Then just identify the fully capitalised string as the first name (if name.upper() == name). Probably a way to match the strings out of order but I don't know a way to do that yet

3. I think use unnest then average on the measure group by the unnested values

4. Join A, B and C on id then coalesce(B.bedrooms, C.bedrooms) as bedrooms. Exclude null bedrooms from the result WHERE bedrooms is not null.

5. Hardcoded column names, aggregate using min(), count() and use aggregate expression to filter on max/min distance for restaurant counts. 

6. Using postgis create function that takes 1 polygon and points, select st_intersects(polygon, point)

7. Not sure if Spark or Postgres (after data is imported) is faster but either way, create index on ID and join.

- Maybe we're expecting a function here? In this case I'd expect the input as text and split the string and reform as WKT.

select 
    ST_Intersects('POLYGON((10 11, 10 9, 11 9, 14 9, 14 10, 10 11))'::geometry, 'POINT(9 3)'::geometry) or 
    ST_Intersects('POLYGON((10 11, 10 9, 11 9, 14 9, 14 10, 10 11))'::geometry, 'POINT(12 10)'::geometry) as intersects

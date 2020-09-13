/*

Postgres for this one since I anticipated it being easier to generate missing time series then filling forward in sql but didn't 
realise first_value in PG doesn't ignore nulls like Spark. Using the sum function in the subquery makes ffill possible here. 
I suspect spark might be better for this one after all.

*/

SELECT 
  postcode, 
  month AS month_ts, 
  first_value(pmindicator) OVER (PARTITION BY postcode, value_partition, pmindicator) indicator_cat,
  first_value(measure) OVER (partition by postcode, value_partition, pmindicator) measure 
FROM
    (SELECT 
      postcode_months.postcode,
      month,
      indicator_data.indicator_cat,
      postcode_months.indicator_cat pmindicator,
      sum(CASE WHEN indicator_data.indicator_cat IS NULL THEN 0 ELSE 1 END) 
        OVER (partition by postcode_months.postcode, postcode_months.indicator_cat ORDER BY month) AS value_partition,
      measure
    FROM indicator_data
    RIGHT JOIN (
      SELECT 
        postcode, 
        indicator_cat,
        generate_series(min(month_ts), max(month_ts), '1 month'::interval) AS month
      FROM indicator_data
      GROUP BY postcode, indicator_cat
      ) AS postcode_months ON 
        indicator_data.postcode = postcode_months.postcode AND 
        indicator_data.month_ts = postcode_months.month AND 
        indicator_data.indicator_cat = postcode_months.indicator_cat
    ) indicators
ORDER BY postcode, pmindicator, month
 
 
 

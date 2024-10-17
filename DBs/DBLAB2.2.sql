DROP VIEW IF EXISTS stock_moving_average;

CREATE VIEW stock_moving_average AS
SELECT 
    s."Date", 
    s."Stock", 
    s."Close", 
    s."Volume",
    -- Calculate 5-day moving average using LAG to get the previous 4 closes
    (s."Close" + 
     LAG(s."Close", 1) OVER (PARTITION BY s."Stock" ORDER BY s."Date") +
     LAG(s."Close", 2) OVER (PARTITION BY s."Stock" ORDER BY s."Date") +
     LAG(s."Close", 3) OVER (PARTITION BY s."Stock" ORDER BY s."Date") +
     LAG(s."Close", 4) OVER (PARTITION BY s."Stock" ORDER BY s."Date")) / 5 AS moving_avg_5day
FROM 
    stocks s;
   
-- select * from stock_moving_average;

select 
    s."Stock", max(s."Close") as maximum, min(s."Close") as minimum
from stocks s
where s."Date" < '2020-01-01' and s."Date" > '2018-12-31'
group by s."Stock";

--Which stock gained the most percent increase value in 2019
--1. Need to find the first and last instance of a stock in 2019
--2. Calculate (close-open)/open*100 and save to table
--3. Find the max in that table
 
/*
select s."Stock", min(s."Date") as first, max(s."Date") as last
from stocks s
where s."Date" between '2019-01-01' and '2019-12-31'
group by s."Stock";
*/

select q."Stock"
from (
    select 
        s1."Stock", 
        (s2."Close" - s1."Close") / s1."Close" * 100 as percentage
    from 
        stocks s1
    join 
        stocks s2 on s1."Stock" = s2."Stock"
    where 
        s1."Date" = (select min(s."Date") from stocks s where s."Stock" = s1."Stock" and s."Date" between '2019-01-01' and '2019-12-31')
        and s2."Date" = (select max(s."Date") from stocks s where s."Stock" = s1."Stock" and s."Date" between '2019-01-01' and '2019-12-31')
    order by 
        percentage desc
) q
limit 1;

--for each day and for each stock, if the stock went up or down compared to the previous day.
select s.*, case when s."Close" - lag(s."Close") over (partition by s."Stock" order by s."Date") > 0 then 1 else 0 end as gain
from stocks s
order by s."Stock", s."Date";

--Amount of days of gain for Apple in 2019
select count(q."gain")
from (select s.*, case when s."Close" - lag(s."Close") over (partition by s."Stock" order by s."Date") > 0 then 1 else 0 end as gain
from stocks s
order by s."Stock", s."Date") q
where q."Stock" = 'AAPL' and q."gain" = 1 and q."Date" between '2019-01-01' and '2019-12-31';






   

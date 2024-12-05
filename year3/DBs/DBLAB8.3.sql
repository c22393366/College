select * from europe_capital_cities;
alter table europe_capital_cities add coord geography(point);
update europe_capital_cities set coord = ST_GeomFromText('POINT(' || capital_lat ||' ' ||capital_lng ||')',4326);

--Calculate distances between Paris and every other capital
SELECT a.capital AS orig, b.capital AS dest, ST_Distance(a.coord, b.coord), ST_Distance(a.coord, b.coord)
FROM europe_capital_cities a
CROSS JOIN europe_capital_cities b
WHERE a.capital = 'Paris';

--Calculate distances between every capital with 500km of each other
SELECT a.capital AS orig, b.capital AS dest, ST_Distance(a.coord, b.coord)/1000 AS dist
FROM europe_capital_cities a
CROSS JOIN europe_capital_cities b
WHERE ST_Distance(a.coord, b.coord)<500000 and ST_Distance(a.coord, b.coord)>0;

--Stores all distances between capital cities
drop table if exists distances;
create table distances as
SELECT a.capital AS orig, b.capital AS dest, ST_Distance(a.coord, b.coord)/1000 AS dist
FROM europe_capital_cities a
CROSS JOIN europe_capital_cities b
WHERE ST_Distance(a.coord, b.coord)>0;

--Finds the city with smallest average distance from all other capitals
select orig, avg(dist)/1000 as closeness from distances group by orig order by closeness asc;

--(a) Distance between Dublin and London in KM
select ST_Distance(
    (select coord from europe_capital_cities where capital = 'Dublin'),
    (select coord from europe_capital_cities where capital = 'London')
)/1000 AS dublin_to_london;

--(b) Capitals within 1000km from Dublin
select b.capital as dest, ST_Distance(a.coord, b.coord)/1000 as distance_in_km
from europe_capital_cities a
join europe_capital_cities b on a.capital != b.capital
where ST_Distance(a.coord, b.coord) < 1000000 and a.capital = 'Dublin';

--(c) Most distant European Capital from Dublin
select b.capital as dest, ST_Distance(a.coord, b.coord)/1000 as distance_in_km
from europe_capital_cities a
join europe_capital_cities b on a.capital != b.capital
where a.capital = 'Dublin'
order by ST_Distance(a.coord, b.coord) desc
limit 1;

--(d) Find a European capital that can reach the most capitals in less than 500km
select a.capital, count(b.capital) as reachable_capitals
from europe_capital_cities a
join europe_capital_cities b on a.capital != b.capital
where ST_Distance(a.coord, b.coord) < 500000
group by a.capital 
order by reachable_capitals desc 
limit 1;

--(e) City with minimum average distance from all other European capitals
select orig, AVG(dist) / 1000 as avg_distance_km
from distances
group by orig
order by avg_distance_km asc
limit 1;











drop view if exists rankings_by_event;
create view rankings_by_event as
select p.participant_name, p.participant_country, p.event_name, p.gender, p.result_type, p.result,
rank() over(partition by p.gender, p.event_name order by case when p.result_type = 'DISTANCE' then -p.result when p.result_type = 'TIME' then p.result end) as rank
from paris p;

select * from rankings_by_event 
where participant_country = 'Italy'
order by rank 
limit 5;

select r.rank
from rankings_by_event r
where event_name = 'Men''s Marathon' and r.result > 
(select r.result from rankings_by_event r where event_name = 'Women''s Marathon' order by rank limit 1)
limit 1;

drop table if exists medals;
create table medals(
	participant_country_code varchar(50),
	gold int default 0,
	silver int default 0,
	bronze int default 0
);

INSERT INTO medals(participant_country_code, gold, silver, bronze)
SELECT 
    r.participant_country,
    SUM(CASE WHEN r.rank = 1 THEN 1 ELSE 0 END) AS gold,
    SUM(CASE WHEN r.rank = 2 THEN 1 ELSE 0 END) AS silver,
    SUM(CASE WHEN r.rank = 3 THEN 1 ELSE 0 END) AS bronze
FROM 
    rankings_by_event r  
GROUP BY 
    r.participant_country
ORDER BY 
    gold DESC, silver DESC, bronze DESC;
   
select * from medals
order by participant_country_code;

select count(r.rank)
from rankings_by_event r
where r.rank = 1 and r.participant_country = 'Italy';




-- Creating a join table
select *
from absenteeism_at_work a
left join compensation c
on a.ID=c.ID
left join reasons r on
a.`reason for absence`=r.number	;

-- find the healthiest employees for the bonus
select * from absenteeism_at_work
where `Social drinker` =0 AND `Social smoker`=0
 AND `Body mass index`<25
 AND `absenteeism time in hours`< (select avg(`absenteeism time in hours`) from absenteeism_at_work) ;
 
 -- compensation for non smokers /budget 983,221 so .68 cent per hour / $1,414.4 per year
 select count(*) as non_smokers from absenteeism_at_work
 where `Social smoker`=0;
 
 
 -- Optimize this query
 select a.ID,r.reason,`Month of absence`,`body mass index`,
 CASE WHEN `Body mass index` < 18.5 THEN 'Underweight'
 WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN 'Healthy'
 WHEN `Body mass index` BETWEEN 25 AND 30 THEN 'Overweight'
  WHEN `Body mass index` > 30 THEN 'Obese'
 ELSE 'Unknown'
 END as Bmi_category,
CASE WHEN `Month of absence` IN (12,1,2) THEN 'Winter'
	WHEN `Month of absence` IN (3,4,5) THEN 'Spring'
    WHEN `Month of absence` IN (6,7,8) THEN 'Summer'
    WHEN `Month of absence` IN (9,10,11) THEN 'Fall'
    ELSE 'Unknown'
    END as Season_names,
    `Day of the week`,
    `Transportation expense`
from absenteeism_at_work a
left join compensation c
on a.ID=c.ID
left join reasons r on
a.`reason for absence`=r.number	;

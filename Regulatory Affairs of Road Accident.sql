create database rc;
use rc;
SELECT * FROM`regulatory affairs of road accident data 2020 india`;

# Chcek Data Types 
describe `regulatory affairs of road accident data 2020 india`;

# Chcek Null values in columns 
select * from `regulatory affairs of road accident data 2020 india`
where `Million Plus Cities` is null or `Cause category` is null or `Cause Subcategory` or 
`Outcome of Incident` is null or TRIM(`Count`) is null ; 
-- OR
select * from `regulatory affairs of road accident data 2020 india`
where `Million Plus Cities` = ' ' or `Cause category` = ' ' or `Cause Subcategory` or 
`Outcome of Incident`= ' ' or `Count` = ' ' ; 

# Rename Table name 
rename table `regulatory affairs of road accident data 2020 india` to `road_accident`;
select * from road_accident;


-- 1] Top Cities with the Highest Incident Count
select `Million Plus Cities`, count(*) as Highest_Incident_Count_cities
from road_accident 
group by `Million Plus Cities` 
order by  Highest_Incident_Count_cities desc;

-- Agra Incident Count 
Select `Million Plus Cities`, count(*) AS incident_count
from road_accident 
where `Million Plus Cities` = "Agra"
group by `Million Plus Cities`;


-- 2] Distribution of "Minor Injury" Incident Outcomes Across Cities (Greater Than 15)
Select `Million Plus Cities`,`Outcome of Incident`,count(*) AS incident_count
from road_accident 
where `Outcome of Incident`= "Minor Injury"
group by `Million Plus Cities`,`Outcome of Incident`
having incident_count > 15
order by `Million Plus Cities`,incident_count desc;

-- 3]Top Cities for Each Specific Cause Category
 with Rankcities as( 
 select`Million Plus Cities`, `Cause category`,count(*) as Cities_Each_Cause_Category,
 row_number() over (partition by `Cause category` order by count(*) desc ) as rnk 
 from road_accident 
 group by `Million Plus Cities` ,  `Cause category` )
 select `Million Plus Cities`, `Cause category`,Cities_Each_Cause_Category
 from Rankcities 
 where rnk = 1;

-- 4] Most Common Outcome of Incidents Across All Cities
select `Outcome of Incident` , count(*) as outcome_count 
from road_accident 
group by `Outcome of Incident`
order by outcome_count desc
limit 1 ;
# if i get multiple output then i will use rank function to get ony one outcome 

-- 5] City-wise Distribution of Incident Causes
select `Million Plus Cities`, `Cause category` , count(*) as City_wise_Distribution_Incident
from road_accident 
group by `Million Plus Cities`,  `Cause category`
order by City_wise_Distribution_Incident desc;

-- 6] Total Incident Count by Cause Category and Subcategory
select `Cause category`, `Cause Subcategory` , count(*) as incident_count
from road_accident 
group by `Cause category`,  `Cause Subcategory`
order by incident_count desc;

-- 7] Percentage of Each Outcome Type in Total Incidents
select `Outcome of Incident`, count(*) as Total_count,
(count(*) * 100.0 / sum(count(*)) over()) as output_percentage 
from road_accident 
group by `Outcome of Incident`
order by output_percentage desc;

-- 8] City with the Highest Incidents for a Specific Cause Category
select `Million Plus Cities`, count(*) as incident_count,
rank () over (order by count(*) desc) as city_rank 
from road_accident 
group by `Million Plus Cities`
order by city_rank;

-- 9] Identify Cities with the Lowest Number of Incidents
select `Million Plus Cities`, count(*) as incident_count
from road_accident 
group by `Million Plus Cities`
order by incident_count asc
limit 5;


-- 10] Find the Most Frequent Cause-Outcome Pair Across Cities
select `Cause category`, `Outcome of Incident`, count(*) as frequency
From road_accident
group by `Cause category`, `Outcome of Incident`
order by frequency desc
limit 1;

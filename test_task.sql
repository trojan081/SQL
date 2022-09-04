-- create table "table 1"
-- ("Account ID" varchar(255),
--  "Campaign ID" varchar(255) primary key,
--  "Channel" varchar(255)
-- )


-- create table "table 3"
-- (Date date,
--  "Campaign ID" varchar(255) references "table 1"("Campaign ID"),
--  "Start Date" date,
--  "End Date" date,
--  Clicks numeric,
--  "Views" numeric
-- );

-- insert into "table 1" values 
-- (1, 'fbn_12312432', 'Chn1'),
-- (2, 'gsn_12443432', 'Chn2'),
-- (3, 'gsn_12122122', 'Chn3'),
-- (4, 'fbn_17782432', 'Chn4'),
-- (5, 'fbn_12312662', 'Chn5'),
-- (6, 'gsn_12777432', 'Chn6'),
-- (7, 'fbn_12310099', 'Chn7'),
-- (8, 'gsn_09812432', 'Chn8'),
-- (9, 'gsn_63212432', 'Chn9'),
-- (10, 'fbn_11112432', 'Chn10'),
-- (11, 'fbn_22222432', 'Chn11'),
-- (12, 'gsn_33333332', 'Chn12');


with date as (
select to_char(date, 'Day') as "Day of the week"
from "table 2"
)
select * from
"table 2", date



-- (current_date, 'fbn_12312432', '2021-02-22', '2021-05-12', 520, 314),

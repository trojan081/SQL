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

-- CREATE TABLE DEPARTMENTS (
-- 	ID_DEPARTMENT serial primary key,
-- 	V_NAME varchar(255)	
-- )
-- create table CONTRACTS (
-- 	ID_CONTRACT_INST serial primary key,
-- 	ID_DEPARTMENT int references DEPARTMENTS (ID_DEPARTMENT)
-- )
-- update contracts
-- CREATE TABLE DEPARTMENTS (
-- 	ID_DEPARTMENT serial primary key,
-- 	V_NAME varchar(255)	
-- )
-- create table CONTRACTS (
-- 	ID_CONTRACT_INST serial primary key,
-- 	ID_DEPARTMENT int references DEPARTMENTS (ID_DEPARTMENT)
-- )

-- SELECT dt_reg AS "Дата регистрации", COUNT (dt_reg) AS "Количество контрактов"
-- FROM contracts
-- WHERE dt_reg > (NOW() - INTERVAL '5 DAYS')
-- GROUP BY dt_reg

-- SELECT V_STATUS AS "Статус контракта",
-- CASE
-- WHEN V_STATUS = 'A' THEN 'Активен'
-- WHEN V_STATUS = 'B' THEN 'Заблокирован'
-- WHEN V_STATUS = 'C' THEN 'Расторгнут'
-- END
-- AS "Расшифровка",
-- COUNT (V_STATUS) AS "Количество контрактов"
-- FROM contracts
-- GROUP BY V_STATUS
-- select v_name from departments
-- inner join contracts on (V_EXT_IDENT is null)
-- where 

-- SELECT v_name AS "Филиалы без контракта" FROM departments
-- WHERE id_department NOT IN (SELECT id_department FROM contracts WHERE v_status = 'A')

-- select sum(cast (f_sum as int)) from bills

-- CREATE OR REPLACE FUNCTION debt (pDate date)
-- RETURNS bigint AS $$
-- SELECT SUM(CAST (f_sum AS int)) FROM bills WHERE (dt_event >= pDate);
-- $$ LANGUAGE sql;

-- SELECT v_name AS "Уникальные услуги" FROM service 
-- WHERE id_service in (SELECT id_service FROM services
-- WHERE id_contract_inst in (select distinct id_contracts_inst from contracts where id_department  )
-- SELECT v_name AS "Уникальные услуги" FROM service 
-- WHERE id_service in

-- select id_service, count (id_department) from services join 
-- 	  contracts on contracts.id_contract_inst = services.id_contract_inst
-- group by id_service
-- having count(count)=1

-- SELECT v_name AS "Тарифные планы топ-5 услуг" FROM tariff_plan 
-- WHERE id_tariff_plan IN
-- (SELECT id_tariff_plan FROM (SELECT id_tariff_plan, id_service FROM services, contracts
-- WHERE contracts.id_contract_inst = services.id_contract_inst
-- GROUP BY id_tariff_plan) tariff
-- WHERE COUNT = 1);

-- SELECT v_name AS "Тарифные планы топ-5 услуг" FROM tariff_plan 
-- JOIN
-- (select id_service from
-- (select id_service, count(id_service) from services
-- group by id_service
-- order by count DESC) cnt
-- LIMIT 5)
-- tariff_plan.v_name AS "Тарифный план" FROM service

-- SELECT v_name AS "Тарифные планы топ-5 услуг" 
-- from 
-- (select id_service, t.v_name
-- from services s
-- join tariff_plan t on t.id_tariff_plan=s.id_tariff_plan
-- WHERE id_service in (select id_service from
-- (select id_service, count(id_service) from services
-- group by id_service
-- order by count DESC
-- limit 5)a))b

-- SELECT v_name AS "Тарифные планы топ-5 услуг" 
-- from 
-- (select id_service, t.v_name
-- from services s
-- join tariff_plan t on t.id_tariff_plan=s.id_tariff_plan
-- WHERE id_service in (select id_service from
-- (select id_service, count(id_service) from services
-- group by id_service
-- order by count DESC
-- limit 5)a))b

	
-- select id_service, id_tariff_plan from
-- (select id_service, count(id_service) from services
-- group by id_service
-- order by count DESC
-- limit 5) a 
-- join tariff_plan


-- create or replace function serv_id(pID int default null)
-- returns table (id_service int, v_name varchar, cnt bigint)
-- AS $$ 
-- begin
-- return query
-- 		select distinct s.id_service, s.v_name,
-- 		count(id_contract_inst) over (partition by s.id_service) cnt
-- 		from service s
-- 		join services sc on s.id_service=sc.id_service
-- 		where 
-- 		case when pID <> 0 then
-- 		s.id_service = pID
-- 		when pID isnull then true end
-- 		order by id_service;
-- END
-- $$ language plpgsql;

-- select * from serv_id();


-- create or replace function inp ()
-- returns void
-- AS $$
-- declare
-- 	CUR cursor for (select current_date);
-- 	rec record;
-- begin
-- 	for rec in
-- 		select * from (select dt_stop from services
-- 		where id_service in
-- 		(select id_service
-- 		from services
-- 		where 
-- 		id_service != 1 and id_tariff_plan = 1))a
-- 		for update
-- 	loop
-- 		fetch cur into rec;
-- 		exit when not found;
-- 		update id_service set dt_stop = current_date;
-- 	end loop;
-- END
-- $$ language plpgsql;

-- select inp()

-- DO $$
-- DECLARE
-- cur refcursor;
-- rec record;
-- BEGIN
-- FOR rec IN 
-- 		SELECT dt_stop FROM services
-- 		WHERE id_service IN
-- 		(SELECT id_service
-- 		FROM services
-- 		WHERE 
-- 		id_service != 1 AND id_tariff_plan = 3)
-- 	LOOP
-- 		FETCH cur into rec;
-- 		EXIT WHEN NOT FOUND;
-- 		UPDATE services SET dt_stop = '2021-07-11';
-- 	END LOOP;
-- END
-- $$ LANGUAGE plpgsql;

-- DO $$
-- DECLARE
-- cur refcursor;
-- rec record;
-- BEGIN
-- FOR rec IN 
-- 		SELECT dt_stop FROM services
-- 		WHERE id_service IN
-- 		(SELECT id_service
-- 		FROM services
-- 		WHERE 
-- 		id_service != 1 AND id_tariff_plan = 3)
-- 	LOOP
-- 		FETCH cur into rec;
-- 		EXIT WHEN NOT FOUND;
-- 		UPDATE services SET dt_stop = '2021-07-11';
-- 	END LOOP;
-- END
-- $$ LANGUAGE plpgsql;

-- DO $$
-- DECLARE
-- cur refcursor;
-- rec record;
-- BEGIN
-- OPEN cur for SELECT dt_stop FROM services
-- 		WHERE id_service IN
-- 		(SELECT id_service
-- 		FROM services
-- 		WHERE 
-- 		id_tariff_plan = 2)
-- 		FOR UPDATE;
-- LOOP
-- 		FETCH cur INTO rec;
-- 		EXIT WHEN NOT FOUND;
-- 		UPDATE services SET dt_stop = '2021-07-20' WHERE CURRENT OF cur;
-- 		END LOOP;
-- 		CLOSE cur;
-- END
-- $$ LANGUAGE plpgsql;

-- select * from services

DO $$
DECLARE
cur cursor for SELECT dt_stop FROM services
		WHERE id_service IN
		(SELECT id_service
		FROM services
		WHERE 
		id_tariff_plan = 2) for update;
begin
for I in cur
LOOP
UPDATE services SET dt_stop = '2021-07-21' WHERE CURRENT OF cur;
end loop;
END;
$$ LANGUAGE plpgsql;

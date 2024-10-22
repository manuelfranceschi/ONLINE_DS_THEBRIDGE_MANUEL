-- 1. A crime has taken place and the detective needs your help. 
--The detective gave you the crimescene report, but you somehow lost it.
--You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018
--and that it tookplace in SQL City. Start by retrieving the corresponding crime scene report 
--from the police department’s database.

select date,description
from crime_scene_report
where date = '20180115' and city = 'SQL City' and type = 'murder';

--2. Security footage shows that there were 2 witnesses. 
--The first witness lives at the last house on "Northwestern Dr". 
--The second witness, named Annabel, lives somewhere on "Franklin Ave".

select * 
from person
where address_street_name = 'Northwestern Dr'
order by address_number desc
limit 1;

select * 
from person
where address_street_name = 'Franklin Ave' AND name LIKE 'annabel%';

-- 3. Buscar la entrevista a estos testigos
-- Morty Schapiro, id 14887
select * 
from interview
where person_id = 14887;

-- Annabel Miller, id 16371
select * 
from interview
where person_id = 16371;

-- 4.1 I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
--The membership number on the bag started with "48Z". 
--Only gold members have those bags. The man got into a car with a plate that included "H42W".
select *
from get_fit_now_member
where id like '48Z%' AND membership_status = 'gold';

-- estas dos personas que aparecen tienen membresia gold y la placa empieza por H42W

-- 4.2 I saw the murder happen, and I recognized the killer from my gym when I was working out last 
--week on January the 9th.

select * 
from get_fit_now_check_in
where membership_id in ('48Z7A', '48Z55');

-- Los dos entraron el mismo dia, uno media hora más tarde y salió media hora más tarde

-- 4.3 si unimos las dos pistas que nos dan los testigos, concluimos que
select p.name,p.id, dl.plate_number
from get_fit_now_member as gt
inner join person as p on p.id = gt.person_id
inner join drivers_license as dl on dl.id = p.license_id
--where gt.id in ('48Z7A', '48Z55');
where plate_number like '%H42W%';
-- El que tiene el coche es Jeremy Bowers! busquemoslo en facebook

select f.* 
from facebook_event_checkin as f
inner join person as p on p.id = f.person_id
where p.id = '67318' and date = '20180115';

-- Vemos que el día de este evento es justo el dia del asesinato, podemos confirmar que es el
-- al buscar du dni

select *
from get_fit_now_member
where person_id in (67318);
-- Cumple tambien con tener membresia gold

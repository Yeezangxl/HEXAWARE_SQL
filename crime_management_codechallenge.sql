create database CRIME_MANAGEMENT_SYSTEM  ----creation of database

use CRIME_MANAGEMENT_SYSTEM  --- using database

----table creation 

---crime table

create table crime (
crimeid int primary key,
incidenttype varchar(255),
incidentdate date,
location varchar(255),
description text,
status varchar(20)
);

----victim table
create table victim (
victimid int primary key,
crimeid int,
name varchar(255),
contactinfo varchar(255),
injuries varchar(255),
foreign key (crimeid) references crime(crimeid)
);

----suspect table 
create table suspect (
suspectid int primary key,
crimeid int,
name varchar(255),
description text,
criminalhistory text,
foreign key (crimeid) references crime(crimeid)
);


-----value insertion into crime
insert into crime (crimeid, incidenttype, incidentdate, location, description, status)
values
(1, 'robbery', '2023-08-10', 'chennai', 'armed robbery', 'open'),
(2, 'homicide', '2023-09-15', 'madurai', 'suspected murder', 'under investigation'),
(3, 'fraud', '2023-09-15', 'coimbatore', 'bank fraud card scam', 'closed'),
(4, 'kidnapping', '2023-10-01', 'trichy', 'child reported missing from school', 'open'),
(5, 'assault', '2023-10-03', 'salem', 'physical assault at a public park', 'pending'),
(6, 'cybercrime', '2023-11-20', 'vellore', 'unauthorized access to private accounts', 'resolved'),
(7, 'arson', '2023-11-20', 'tirunelveli', 'intentional fire ', 'closed'),
(8, 'theft', '2023-12-25', 'karur', 'shoplifting reported at local mall', 'under investigation');

 
 ---value vivtim into victim

 insert into victim (victimid, crimeid, name, contactinfo, injuries)
values (1, 1, 'uma', 'uma@gmail.com', 'minor injuries'),
(2, 2, 'siva', 'siva@gmail.com', 'deceased'),
(3, 3, 'jaya', 'jaya@gmail.com', 'no injuries'),
(4, 1, 'murali', 'murali@gmail.com', 'missing'),
(5, 5, 'harish', 'harish@gmail.com', 'head injury'),
(6, 6, 'hari', 'hari@gmail.com', 'deceased'),
(7, 7, 'suba', 'suba@gmail.com', 'burn injury'),
(8, 8, 'venu', 'venu@gmail.com', 'minor injuries');


----suspects
insert into suspect (suspectid, crimeid, name, description, criminalhistory)
values (1, 1, 'robber 1', 'armed and masked robber', 'previous robbery convictions'),
(2, 2, 'unknown', 'investigation ongoing', null),
(3, 3, 'suspect 1', 'involved in credit card scam', 'prior fraud case'),
(4, 4, 'suspect x', 'suspected kidnapper spotted near school', null),
(5, 5, 'john ', 'suspect in public park assault', 'history of violent behavior'),
(6, 6, 'cyber', 'suspected hacker behind the breach', 'multiple cybercrime reports'),
(7, 7, 'flame man', 'set fire to warehouse', 'known'),
(8, 8, 'shoplifter 1', 'caught on camera shoplifting', 'prior shoplifting arrests');

select * from crime
select * from victim
select * from suspect

-----questions
---1. select all open incidents

select * from crime 
where status ='open'

--2. find the total number of incidents.
select count(*) as total_incidents from crime

-----3. list all unique incident types.
select distinct incidenttype from crime

----4. retrieve incidents that occurred between '2023-09-01' and '2023-09-10'
select * from crime
where incidentdate between '2023-08-10' and '2023-09-15'

---5. list persons involved in incidents in descending order of age
alter table suspect
add age int;

update suspect set age = 35 where suspectid = 1;
update suspect set age = 40 where suspectid = 2;
update suspect set age = 28 where suspectid = 3;
update suspect set age = 30 where suspectid = 4;
update suspect set age = 38 where suspectid = 5;
update suspect set age = 25 where suspectid = 6;
update suspect set age = 45 where suspectid = 7;
update suspect set age = 30 where suspectid = 8;

select name,age from suspect order by age desc

----6. find the average age of persons involved in incidents.

select avg(age) as avg_age from suspect

----7. list incident types and their counts, only for open cases.
select incidenttype, count(*) as count from crime
where status = 'open'
group by incidenttype

----8. find persons with names containing 'doe'.
insert into victim (victimid, crimeid, name, contactinfo, injuries)
values (9, 1, 'jane doe', 'jane@gmail.com', 'minor injuries')

select * from victim
where name like '%doe%'

----9. retrieve the names of persons involved in open cases and closed cases.
select v.name, c.status from victim v
join crime c on v.crimeid = c.crimeid
where c.status in ('open', 'closed')

select * from crime
select * from victim
select * from suspect

----10. list incident types where there are persons aged 30 or 35 involved.

select c.incidenttype ,s.age from crime c
join suspect s on c.crimeid = s.crimeid
where s.age in (30, 35)

---11. find persons involved in incidents of the same type as 'robbery'.
select v.victimid, v.crimeid from victim v
join crime c on v.crimeid = c.crimeid
where c.incidenttype = 'robbery'


---12. list incident types with more than one open case.
select incidenttype, count(*) as open_case from crime
where status = 'open'
group by incidenttype
having count(*) > 1

----13. list all incidents where suspects whose names also appear as victims in other incidents.
select c.crimeid, c.incidenttype from crime c
join suspect s on c.crimeid = s.crimeid
where s.name in (select name from victim)

---14. find incidents linked with victim and suspect details.
select c.crimeid,c.incidenttype from  crime c
inner join victim v on c.crimeid = v.crimeid
inner join suspect s on c.crimeid = s.crimeid;

----15. find incidents where the suspect is older than any victim.
alter table victim
add age int;

update victim set age = 22 where victimid = 1;
update victim set age = 34 where victimid = 2;
update victim set age = 25 where victimid = 3;
update victim set age = 40 where victimid = 4;
update victim set age = 29 where victimid = 5;
update victim set age = 23 where victimid = 6;
update victim set age = 30 where victimid = 7;
update victim set age = 26 where victimid = 8;

select c.crimeid, c.incidenttype from crime c
join suspect s on c.crimeid = s.crimeid
where s.age > all (select v.age from victim v where v.crimeid = c.crimeid)

---16. find incidents with multiple suspects.
insert into suspect (suspectid, crimeid, name, description, criminalhistory)
values (9, 1, 'robber 1', 'armed and masked robber', 'previous robbery convictions')

select s.crimeid from suspect s
group by s.crimeid
having count(*) > 1

----17. list incidents with no suspects involved.
insert into crime (crimeid, incidenttype, incidentdate, location, description, status)
values (10, 'robbery', '2023-08-10', 'chennai', 'armed robbery near central station', 'open')

use CRIME_MANAGEMENT_SYSTEM

select * from crime
where crimeid not in (select crimeid from suspect);

---18. list all cases where at least one incident is of type 'homicide' and all others are of type 'robbery'.
select * from crime
where incidenttype in ('robbery', 'homicide')


----19. retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'no suspect' if there are none.
select c.crimeid, c.incidenttype, isnull (s.name, 'no suspect') as suspect_name from crime c
left join suspect s on c.crimeid = s.crimeid;


----20. list all suspects who have been involved in incidents with incident types 'robbery' or 'assault'.
select s.suspectid, s.crimeid, s.name  from suspect s
join crime c on s.crimeid = c.crimeid
where c.incidenttype in ('robbery', 'assault')



























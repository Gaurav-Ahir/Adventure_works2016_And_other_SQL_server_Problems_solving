
--create week1 database
create database week1
use week1

--create student table
--also add check constraint to dob column
--And unique constraint to mobile_no column
--except these 2 other column are not null

create table student(stud_id int not null, stud_name varchar(50) not null, 
college_code int not null, dob date not null check(dob > '1995-01-01'),
mobile_no int not null unique)


--create college table
--university column have default constraint
create table college(college_code int not null,
university varchar(50) default 'sppu')


--add new column college_name in college table
alter table college add college_name varchar(50)

--code for delete college_name column from college table
alter table college drop column college_name

--applying primary key as stud_id And college_code
alter table student add primary key(stud_id)
alter table college add primary key(college_code)

--applying foreign key constraint to college_code
--column in student table.
alter table student add foreign key(college_code)
references college(college_code)

--add records to college table.
--value for university column will take from default constraint
insert into college (college_code, college_name) values(1012,'sinhgad vadgaon')
insert into college (college_code, college_name) values(1013,'sinhgad lonavala')
insert into college (college_code, college_name) values(1014,'gov engg pune')
insert into college (college_code, college_name) values(1015,'DY patil pune')

--insert records in student table
insert into student values(1, 'gaurav ahir', 1012, '2000-01-01', 123456)
insert into student values(2, 'pawan pandey', 1013, '1999-12-01', 1000232)
insert into student values(3, 'rahul more', 1014, '2001-11-30', 222222)
insert into student values(4, 'shubham patil', 1012, '2000-02-28', 555555)

--delete all records from student
truncate table student

--drop student table
drop table student

--update record from student table
update student set mobile_no = 901199 where stud_id = 1	

--delete record from student table
delete from student where stud_id = 1

--select all the data of student whose birth date before 01 January 2000
select * from student where dob < '2000-01-01'

--select all the data for college if college name is [DY patil pune]
select * from college where college_name = 'DY patil pune'

--select all the data of student whose birth date between 01 Jan 2000 and 01 Jan 2001
select * from student where dob between '2000-01-01' and  '2001-01-01'

--select all the data for college if college code is 1012 or 1014
select * from college where college_code = 1012 or college_code = 1014

--select all the data for college if college name starts with character "s"
select * from college where college_name like 's%'

--select all the data of student if student id is 1 or 2 or 3.
select * from student where stud_id in(1,2,3)

select stud_id, stud_name,
case 
when(dob > '2000-01-01') then 'Regular student'
when(dob between '1999-01-01' and '2000-01-01') then '1 year Gap student'
when(dob between '1998-01-01' and '1999-01-01') then '2 year Gap student'
else 'more than 2 years gap student'
end as [student status]
from student

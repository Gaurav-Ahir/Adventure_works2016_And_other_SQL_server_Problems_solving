

--create procedure Count_Students_incourse 
create procedure Count_Students_incourse
@course_id integer
as
begin
select c.cource_id,cource_name,
count(c.cource_id) as count_of_students_incourse from student s
inner join department d
on s.deptno = d.deptno
inner join course c
on d.cource_id = c.cource_id
where c.cource_id = @course_id
group by c.cource_id,cource_name
end

exec Count_Students_incourse 102


--student timetable
alter procedure student_timetable 
@stud_id integer
as
begin
select  s.stud_id,s.name,c.deptno,c.classno,c.class_name,f.faculty_name,
f.subject,f.subject_code from student s
join class c
on s.deptno = c.deptno
join faculty f
on c.deptno = f.deptno
where s.stud_id = @stud_id
end

exec student_timetable 2
sp_helptext student_timetable
select * from college
select * from department
--student department & cource details
create procedure student_details
@stud_id integer
as
begin
select s.stud_id,s.name,d.deptno,d.deptname,c.cource_id,c.cource_name
from student s
join department  d
on s.deptno = d.deptno
join cource c
on d.cource_id = c.cource_id
where stud_id = @stud_id
end

exec student_details 1 

select * from class
select * from department

--department wise classrooms count 
create procedure classroom_details
@deptno integer
as
begin
select c.deptno,d.deptname,count(c.deptno)as classroom_count from 
class c
join department d
on c.deptno = d.deptno
group by c.deptno,d.deptname
having c.deptno = @deptno
end

exec classroom_details 12

--Count_faculty_incourse 
create procedure Count_faculty_incourse
@course_id integer
as
begin
select c.cource_id,cource_name,
count(c.cource_id) as count_of_faculties_incourse from faculty f
inner join department d
on f.deptno = d.deptno
inner join course c
on d.cource_id = c.cource_id
where c.cource_id = @course_id
group by c.cource_id,cource_name
end

exec Count_faculty_incourse 102
--insert,update & delete on student table
alter procedure iud_on_student 
	@stud_id integer,
	@name varchar(200), 
	@mobile_no varchar(200),
	@age integer,
	@deptno integer,
	@college_code integer,
	@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into student values(@stud_id,@name,@mobile_no,@age,@deptno,@college_code)
	 else if @operation = 'update'
	 update student set name = @name where stud_id = @stud_id
	 else if @operation = 'delete'
	 delete from student where stud_id = @stud_id
	  else if @operation = 'select'
	  select * from student
	 else
	 print null
end

--exec iud_on_student 

--insert,update & delete on faculty table
alter procedure iud_on_faculty 
@faculty_id integer,
@faculty_name varchar(200),
@subject varchar(200),
@subject_code integer,
@deptno integer,
@college_code integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into faculty values(@faculty_id,@faculty_name,@subject,@subject_code,
		@deptno,@college_code)
	 else if @operation = 'update'
	 update faculty set faculty_name = @faculty_name where faculty_id = @faculty_id
	 else if @operation = 'delete'
	 delete from faculty where faculty_id = @faculty_id
	 else if @operation = 'select'
	  select * from faculty
	 else
	 print null
end

--insert,update & delete on department table
alter procedure iud_on_department
@deptno integer ,
@deptname varchar(200),
@cource_id integer,
@college_code integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into department values(@deptno,@deptname,@cource_id,@college_code)
	 else if @operation = 'update'
	 update department set deptname = @deptname where deptno = @deptno
	 else if @operation = 'delete'
	 delete from department where deptno = @deptno
	 else if @operation = 'select'
	  select * from department
	 else
	 print null
end

--insert,update & delete on course table
alter procedure iud_on_course
@cource_id integer,
@cource_name varchar(200),
@duration integer,
@college_code integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into course values(@cource_id,@cource_name,@duration,@college_code)
	 else if @operation = 'update'
	 update course set cource_name = @cource_name where cource_id = @cource_id
	 else if @operation = 'delete'
	 delete from course where cource_id = @cource_id
	 else if @operation = 'select'
	  select * from course
	 else
	 print null
end

--insert,update & delete on class table
alter procedure iud_on_class
@classno integer,
@class_name varchar(200),
@deptno integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into class values(@classno,@class_name,@deptno)
	 else if @operation = 'update'
	 update class set class_name = @class_name where classno = @classno
	 else if @operation = 'delete'
	 delete from class where classno = @classno
	 else if @operation = 'select'
	  select * from class
	 else
	 print null
end

--insert,update & delete on timetable table
alter procedure iud_on_timetable
@subject_code integer,
@classno integer,
@deptno integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into timetable values(@subject_code,@classno,@deptno)
	 else if @operation = 'update'
	 update timetable set subject_code = @subject_code where classno = @classno
	 else if @operation = 'delete'
	 delete from timetable where subject_code = @subject_code
	 else if @operation = 'select'
	  select * from timetable
	 else
	 print null
end

--insert,update & delete on college table
alter procedure iud_on_college
@college_code integer,
@college_name nvarchar(200),
@district varchar(100),
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into college values(@college_code,@college_name,@district)
	 else if @operation = 'update'
	 update college set college_name = @college_name where college_code = @college_code
	 else if @operation = 'delete'
	 delete from college where college_code = @college_code
	 else if @operation = 'select'
	  select * from college
	 else
	 print null
end

EXECUTE	iud_on_student
		@stud_id = 11,
		@name = 'shalu jadhav',
		@mobile_no = '91-535366',
		@age = 22,
		@deptno = 17,
		@college_code = 1241,
		@operation = 'insert'
		--6	mayuri jadhav	91-535366	22	17	1241
		SELECT * FROM course
		select * from department
		select * from faculty
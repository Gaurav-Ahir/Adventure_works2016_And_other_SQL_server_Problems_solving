
--------------------------------------------Views------------------------------------

--------------------------code for create view to get the Count Students in each course------------------------------

create view Count_Students_incourse
as
select c.cource_id,cource_name,
count(c.cource_id) as count_of_students_incourse from student s
inner join department d
on s.deptno = d.deptno
inner join course c
on d.cource_id = c.cource_id
group by c.cource_id,cource_name

select * from Count_Students_incourse



-------------------------code for create view for get student wise timetable----------------------------
create view student_timetable 
as
select  s.stud_id, s.name, c.deptno, c.classno,c.class_name,f.faculty_name,
f.subject,f.subject_code from student s
join class c
on s.deptno = c.deptno
join faculty f
on c.deptno = f.deptno

select * from student_timetable



---------------------code for create view for get the department & cource details for student---------------------------
create view student_details

as
select s.stud_id,s.name,d.deptno,d.deptname,c.cource_id,c.cource_name
from student s
join department  d
on s.deptno = d.deptno
join course c
on d.cource_id = c.cource_id

select * from student_details

----------------------------code for create view for get department wise classrooms count------------------------

create view classroom_details
as
select c.deptno,d.deptname,count(c.deptno)as classroom_count from 
class c
join department d
on c.deptno = d.deptno
group by c.deptno,d.deptname

select * from classroom_details

-------------------------code for create view for Count faculties incourse------------------------
create view Count_faculty_incourse
as
select c.cource_id,cource_name,
count(c.cource_id) as count_of_faculties_incourse from faculty f
inner join department d
on f.deptno = d.deptno
inner join course c
on d.cource_id = c.cource_id
group by c.cource_id,cource_name

select * from Count_faculty_incourse

-------------------------------------Stored Procedures---------------------------------------------------
--------------------------------------code for insert,update & delete on student table----------------------------------

create procedure insert_update_delete_on_student 
	@stud_id integer,
	@name varchar(200), 
	@mobile_no varchar(200),
	@age integer,
	@deptno integer,
	@college_code integer,
	@admission_date date,
	@status varchar(200),
	@leaving_date date,
	@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into student values(@stud_id,@name,@mobile_no,@age,@deptno,@college_code,@admission_date,@status,@leaving_date)
	 else if @operation = 'update'
	 update student set name = @name where stud_id = @stud_id
	 else if @operation = 'delete'
	 delete from student where stud_id = @stud_id

	 else
	 print null
end


------------------------------------code for insert,update & delete on faculty table-------------------------------------

create procedure insert_update_delete_on_faculty 
@faculty_id integer,
@faculty_name varchar(200),
@subject varchar(200),
@subject_code integer,
@deptno integer,
@college_code integer,
@HOD integer,
@operation varchar(200)
as
begin
	if @operation = 'insert'
		insert into faculty values(@faculty_id,@faculty_name,@subject,@subject_code,
		@deptno,@college_code,@HOD)
	 else if @operation = 'update'
	 update faculty set faculty_name = @faculty_name where faculty_id = @faculty_id
	 else if @operation = 'delete'
	 delete from faculty where faculty_id = @faculty_id

	 else
	 print null
end


---------------------------code for insert,update & delete on department table-------------------
alter procedure insert_update_delete_on_department
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

	 else
	 print null
end


------------------code for insert,update & delete on course table---------------------------
alter procedure insert_update_delete_on_course
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

	 else
	 print null
end


---------------------code for insert,update & delete on class table--------------------------------------
alter procedure insert_update_delete_on_class
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

	 else
	 print null
end


-----------------------code for insert,update & delete on timetable table-----------------------
alter procedure insert_update_delete_on_timetable
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

	 else
	 print null
end


-----------------------------------code for insert,update & delete on college table----------------------
alter procedure insert_update_delete_on_college
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

	 else
	 print null
end


-------------------------perform insert update delete on student table--------------------------

EXECUTE	insert_update_delete_on_student
		@stud_id = 11,
		@name = 'shalu jadhav',
		@mobile_no = '91-535366',
		@age = 22,
		@deptno = 17,
		@college_code = 1241,
		@operation = 'select'
		--6	mayuri jadhav	91-535366	22	17	1241


-------------------------------Views----------------------------------------------
		
------------------------code for get details of which faculty assign to which course------------------------

		alter view which_faculty_assign_to_which_course
		as
		select f.faculty_id,f.faculty_name,d.cource_id,c.cource_name,d.deptname
		from faculty f
		join department d
		on f.deptno = d.deptno
		join course c
		on d.cource_id = c.cource_id


-----------------code for create view to select all data from student table-------------------------
			create view select_data_from_student
			as 
			select * from student
----------------getting all the records from student table by executing view------------------------
			select * from select_data_from_student


-----------------code for create view to select all data from faculty table-------------------------
			create view select_data_from_faculty
			as
			select * from faculty
----------------getting all the records from faculty table by executing view------------------------
			select * from select_data_from_faculty


-----------------code for create view to select all data from department table-------------------------

			create view select_data_from_department
			as
			select * from department
----------------getting all the records from department table by executing view------------------------
			select * from select_data_from_department

-----------------code for create view to select all data from course table-------------------------

			create view select_data_from_course
			as
			select * from course
----------------getting all the records from course table by executing view------------------------
			select * from select_data_from_course

-----------------code for create view to select all data from class table-------------------------
			
			create view select_data_from_class
			as
			select * from class
----------------getting all the records from class table by executing view------------------------
			select * from select_data_from_class

-----------------code for create view to select all data from timetable table-------------------------
			
			create view select_data_from_timetable
			as
			select * from timetable
----------------getting all the records from timetable table by executing view------------------------
			select * from select_data_from_timetable

-----------------code for create view to select all data from college table-------------------------

			create view select_data_from_college
			as
			select * from college

----------------code for getting all the records from college table by executing view------------------------
			select * from select_data_from_college

			alter table faculty add HOD integer;

			alter table department drop column HOD

			update faculty set hod = 2024 where faculty_id = 2031
			select * from faculty

---------------------------code for create procedure to find which faculty repots which hod in department table--------------
			create procedure which_faculty_report_to_whom
			as
			begin
			select t1.faculty_name,t2.faculty_name from faculty t1
			join faculty t2
			on t1.hod = t2.faculty_id
			end

--------------------------code for execute stored procedure which find which faculty repots which hod in department table-----------
		exec which_faculty_report_to_whom




------------------------code for adding new columns to student table---------------------------------------------

					alter table student add admission_date date
					alter table student add status varchar(200)
					alter table student add leaving_date varchar(200)
									

--------code to ctreate view to which students details need to update after he succefully completed the course-----------

				create view to_check_which_student_details_needs_to_update_after_successful_course_completion
				as
				select * from student where  status = 'persuing'
			

-----------code for execute the view to find which students details need to update after he succefully completed the course---------

				select *from to_check_which_student_details_needs_to_update_after_successful_course_completion

---------------code for create stored procedure to update student details who leaves the college----------------------

			create procedure update_student_after_he_leaves_the_college
			@stud_id integer,
			@leaving_date date,
			@status varchar(200)
			as
			update student set leaving_date = @leaving_date, status = @status where stud_id =  @stud_id

-------------execute stored procedure to update student details who leaves the college----------------------

			exec update_student_after_he_leaves_the_college
			@stud_id = 1,
			@leaving_date = '02/10/2023',
			@status = 'completed'

--------------using if exists--------------


alter procedure if_exist_example
	@stud_id integer,
	@name varchar(200), 
	@mobile_no varchar(200),
	@age integer,
	@deptno integer,
	@college_code integer,
	@admission_date date,
	@status varchar(200),
	@leaving_date date

as
begin
if exists (select 1 from student where stud_id = @stud_id)
begin
	 update student set name = @name where stud_id = @stud_id
end
else
begin
		insert into student values(@stud_id,@name,@mobile_no,@age,@deptno,@college_code,@admission_date,@status,@leaving_date)
end
end
select * from student


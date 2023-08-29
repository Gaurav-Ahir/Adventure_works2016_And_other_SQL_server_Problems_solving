
----------------code for create the college management system database---------------------------------

create database college_management_system
use college_management_system

-------------------------------code for create student table----------------------------------
create table student(stud_id integer primary key not null,
name varchar(200), mobile_no varchar(200),age integer not null,
deptno integer not null,college_code integer not null)

select * from student

-------------------------------code for create college table---------------------------------
create table college(college_code integer primary key not null,college_name
nvarchar(200) not null,district varchar(100) not null,
course_offered varchar(200) not null)


-------------------------------code for create faculty table---------------------------------
create table faculty(faculty_id integer primary key not null,
faculty_name varchar(200) not null,subject varchar(200) not null,
subject_code integer unique,
deptno integer not null,college_code integer not null)


---------------------------code for create cource table---------------------------
create table cource(cource_id integer primary key not null,cource_name varchar(200)
not null,duration integer not null,college_code integer not null)

----------------------------code for create department table--------------------
create table department(deptno integer primary key not null,deptname varchar(200)
not null,cource_id integer not null,college_code integer not null)

----------------------------code for create class table------------------------
create table class(classno integer primary key not null,class_name varchar(200)
not null,deptno integer not null)

--------------------------adding constraints------------------------------------
alter table student add foreign key(college_code) references 
college(college_code)

alter table student add foreign key(deptno) references 
department(deptno)

alter table faculty add foreign key(college_code) references 
college(college_code)

alter table faculty add foreign key(deptno) references 
department(deptno)

alter table course add foreign key(college_code) references 
college(college_code)

alter table department add foreign key(cource_id) references 
course(cource_id)

alter table department add foreign key(college_code) references 
college(college_code)

alter table class add foreign key(deptno) references 
department(deptno)



---------------------code for create view to get the department & cource details-----------------------------

create view department_wise_course_details

as
select d.deptno,d.deptname,c.cource_id,c.cource_name from
 department  d

join course c
on d.cource_id = c.cource_id

select * from department_wise_course_details

----------------------------code for create view to get department wise classrooms count------------------------

create view classroom_details
as
select c.deptno,d.deptname,count(c.deptno)as classroom_count from 
class c
join department d
on c.deptno = d.deptno
group by c.deptno,d.deptname

select * from classroom_details


-------------------------code for create view to Count faculties incourse------------------------

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

-----------------code for create view to select all data from student table-------------------------
create view select_data_from_student
			as 
			select * from student


						select * from select_data_from_student

-----------------code for create view to select all data from faculty table-------------------------
			create view select_data_from_faculty
			as
			select * from faculty


			select * from select_data_from_faculty

-----------------code for create view to select all data from department table-------------------------

			create view select_data_from_department
			as
			select * from department


			select * from select_data_from_department

-----------------code for create view to select all data from course table-------------------------

			create view select_data_from_course
			as
			select * from course

			select * from select_data_from_course


-----------------code for create view to select all data from class table-------------------------
			
			create view select_data_from_class
			as
			select * from class

			select * from select_data_from_class



-----------------code for create view to select all data from college table-------------------------

			create view select_data_from_college
			as
			select * from college

			select * from select_data_from_college

--------code for ctreate view, which students details need to update after he succefully completed the course-----------

				alter view check_student_details_needs_to_update
				as
				select * from student where  status = 'persuing'
			


				select *from check_student_details_needs_to_update


-------------------------------------Stored Procedures---------------------------------------------------

---------------code for create stored procedure to update student details who leaves the college----------------------

			create procedure update_student_status

			@stud_id integer,
			@leaving_date date,
			@status varchar(200)
			as
			update student set leaving_date = @leaving_date, status = @status where stud_id =  @stud_id


			exec update_student_status
			@stud_id = 1,
			@leaving_date = '02/10/2023',
			@status = 'completed'

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

-------------------------------------------------------------------------------------------------
	EXECUTE	insert_update_delete_on_student
		@stud_id = 11,
		@name = 'shalu jadhav',
		@mobile_no = '91-535366',
		@age = 22,
		@deptno = 17,
		@college_code = 1241,
		@admission_date = null,
		@status = null,
		@leaving_date = null,
		@operation = 'update'

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

--------------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_faculty
		@faculty_id = 2034,
		@faculty_name = 'vishvjeet',
		@subject = 'math',
		@subject_code = 345,
		@deptno = 17,
		@college_code = 1241,
		@HOD = 2022,
		@operation = 'insert'

	
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

--------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_department
		@deptno = 17,
		@deptname = 'cs',
		@cource_id = NULL,
		@college_code = NULL,
		@operation = 'update'

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
------------------------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_course
		@cource_id = 101,
		@cource_name = 'BSC',
		@duration = NULL,
		@college_code = NULL,
		@operation = 'update'

------------------------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_course
		@cource_id = 102,
		@cource_name = NULL,
		@duration = NULL,
		@college_code = NULL,
		@operation = 'insert'

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
-----------------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_class
		@classno = 58,
		@class_name = 'BB-58',
		@deptno = NULL,
		@operation = 'update'
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
----------------------------------------------------------------------------------------------------
		EXEC	sp_insert_update_delete_on_college
		@college_code = 1241,
		@college_name = 'Sinhgad Vadgaon',
		@district = NULL,
		@operation = 'update'

---------------------------code for create procedure to find which faculty repots which hod in department table--------------
			create procedure which_faculty_report_to_whom
			as
			begin
			select t1.faculty_name,t2.faculty_name from faculty t1
			join faculty t2
			on t1.hod = t2.faculty_id
			end


		exec which_faculty_report_to_whom




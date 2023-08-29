
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

----------------------------code for create timetable table-----------------------
create table timetable(subject_code integer not null,
classno integer not null,deptno integer not null)

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

alter table timetable add foreign key(subject_code) references 
faculty(subject_code)

alter table timetable add foreign key(classno) references 
class(classno)

alter table timetable add foreign key(deptno) references 
department(deptno)

--------------------inserting data into college table------------------------

insert into college values(1241,'Sinhgad Lonavala','UG')

--------------------inserting data into department table------------------------

insert into department values
(13,'information technology',102,1241),
(14,'civil engineering',103,1241),
(15,'chemical engineering',104,1241),
(16,'bio technology',104,1241),
(17,'automobile engineering',105,1241)

--------------------inserting data into course table------------------------

insert into course values
(102,'BE',4,1241),
(103,'BE',4,1241),
(104,'BE',4,1241),
(105,'BE',4,1241),
(106,'BE',4,1241)

--------------------inserting data into student table------------------------

insert into student values
(1,'Gaurav Ahir','91-21536456',22,12,1241),
(2,'shyam rathod','91-4366445',21,13,1241),
(3,'rahul more','91-125007',24,14,1241),
(4,'keshav sabale','91-669690',22,15,1241),
(5,'satish mohe','91-234253',21,16,1241),
(6,'mayuri jadhav','91-535366',22,17,1241),
(7,'kamlesh bhojane','91-568745',22,12,1241),
(8,'sachin raut','91-123144',23,12,1241),
(9,'mayur patil','91-423425',20,13,1241),
(10,'sushant rajput','91-45645',21,14,1241)

--------------------inserting data into faculty table------------------------

insert into faculty values
(2022,'ram','english','333',12,1241),
(2023,'James','Maths','334',13,1241),
(2024,'Robert','Science','335',14,1241),
(2025,'John','Social Sciences','336',15,1241),
(2026,'Michael','Physical education','337',16,1241),
(2027,'David','Computer basics','338',17,1241),
(2028,'William','electronics','339',12,1241),
(2029,'Joseph','c++','340',13,1241),
(2030,'Richard','python','341',14,1241),
(2031,'Joseph','tom','342',13,1241),
(2032,'Thomas','som','343',13,1241),
(2033,'Charles','engg drawing','344',14,1241)


--------------------inserting data into class table------------------------

insert into class values
(50,'B-50',12),
(51,'B-51',12),
(52,'B-52',12),
(53,'B-53',12),
(54,'B-54',12),
(55,'B-55',12),
(56,'B-56',12),
(57,'B-57',12),
(58,'B-58',12),
(59,'B-59',12)

--------------------inserting data into timetable table------------------------

INSERT INTO timetable VALUES
(343,50,12),
(342,51,12),
(341,52,13),
(340,53,14),
(339,54,15),
(338,55,15),
(337,55,16),
(336,54,17),
(335,53,14),
(334,52,14),
(344,51,13)








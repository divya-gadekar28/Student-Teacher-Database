create table student1(sno integer primary key,sname varchar(20),sclass varchar(20),saddr varchar(20));
create table teacher(tno integer primary key,tname varchar(20),quali varchar(20),exper integer);
create table stu_tea1(sno integer references student1(sno),
					tno integer references teacher(tno),
					subject varchar(20));
select * from student1;
select * from teacher;
select * from stu_tea1;

insert into student1(sno,sname,sclass,saddr)
values(1,'divya','sybca','pune'),
	  (2,'nikhil','sybtech','pcmc'),
	  (3,'shreya','fybba','nigdi'),
	  (4,'prerna','tybcom','buldhana'),
	  (5,'jyoti','tybba-ca','panvel');

insert into teacher(tno,tname,quali,exper)      
values(101,'Mr.desai','B.ed',4),
      (102,'Mrs.kulkarni','Mcom',6),
	  (103,'Mr.rajguru','Mtech',10),
	  (104,'Mrs.kadam','Mba',11),
	  (105,'Mr.pathak','Mca',8);
	  
insert into stu_tea1(sno,tno,subject)
values(1,101,'mathematics'),
      (2,102,'biology'),
	  (3,103,'networking'),
	  (4,104,'data structures'),
	  (5,105,'rdbms');

/*SQL function to count number of teachers teaching to a respective student name given by the user */	  
1)
create or replace function f5(s_name varchar(20)) returns void as'
DECLARE
	count integer:=0;
BEGIN
	select count(teacher.tno) into count
	from student1,teacher,stu_tea1
	where student1.sno=stu_tea1.sno and
	teacher.tno=stu_tea1.tno and s_name=sname;
	if
	count=0
	then
	raise exception ''invalid student name'';
	else
	raise notice ''count of teacher teaching % is %'',s_name,count;
	end if;
end;
'language'plpgsql';
select f5('priya');

/*SQL function to count number of students studying respective subject name given by the user*/
2)
create or replace function f6(sub_name varchar(20)) returns void as'
DECLARE
	count integer:=0;
BEGIN
	select count(student1.sno) into count
	from student1,teacher,stu_tea1
	where student1.sno=stu_tea1.sno and
	teacher.tno=stu_tea1.tno and sub_name=subject;
	if
	count=0
	then
	raise exception ''invalid subject name'';
	else
	raise notice ''count of student learning % is %'',sub_name,count;
	end if;
end;
'language'plpgsql';
select f6('dbms');

/*SQL function to display details of teacher of a respective qualification given by the user*/
3)
create or replace function f7(t_qua varchar(20)) returns void as'
DECLARE
	r1 record;
BEGIN
	select teacher.tno,tname,quali,exper
	from student1,teacher,stu_tea1
	where student1.sno=stu_tea1.sno and
	teacher.tno=stu_tea1.tno and t_qua=quali;
	if
	t_qua<>quali
	then
	raise exception ''invalid qualification name'';
	else
	raise notice ''teacher name:%
	qualification:%
	experience:%'',r1.tname,r1.quali,r1.exper;
	end if;
end;
'language'plpgsql';
select f7('mcom');

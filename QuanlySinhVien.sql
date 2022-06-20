create database Test2;
use Test2;

create table Students(
	StudentID int,
    StudentName varchar(255),
    Age int,
    Email varchar(255),
    primary key (StudentID)
);

create table Classes(
	ClassID int,
    ClassName varchar(255),
    primary key (ClassID)
);

create table ClassStudent(
	StudentID int,
    ClassID int,
    foreign key(StudentID) references Students(StudentID),
    foreign key(ClassID) references Classes(ClassID)
);

create table Subjects(
	SubjectID int,
    SubjectName varchar(255),
    primary key(SubjectID)
);

create table Marks(
	Mark int,
    SubjectID int,
    StudentID int,
    foreign key(SubjectID) references Subjects(SubjectID),
    foreign key(StudentID) references Students(StudentID)
);
    
insert into Students values(1,'Nguyen Quang Anh', 18,'qqq');
insert into students values(2,'Nguyen Cong Vinh',20,'Vinh@gmail.com');
insert into Students values(3,'Nguyen Van Quyen', 19,'eeee');
insert into Students values(4,'Pham Thanh Binh', 25,'Taiem@sport.vn');
insert into Students values(5,'Nguyen Van Tai Em', 30,'dddd');

insert into Classes values(1,'C0706L');
insert into Classes values(2,'C0708G');

insert into ClassStudent values(1,1);
insert into ClassStudent values(2,1);
insert into ClassStudent values(3,2);
insert into ClassStudent values(4,2);
insert into ClassStudent values(5,2);

insert into Subjects values(1,'SQL');
insert into Subjects values(2,'JAVA');
insert into Subjects values(3,'C');
insert into Subjects values(4,'Visual Basic');

insert into Marks values(8,1,1);
insert into Marks values(4,2,1);
insert into Marks values(9,1,1);
insert into Marks values(7,1,3);
insert into Marks values(3,1,4);
insert into Marks values(5,2,5);
insert into Marks values(8,3,3);
insert into Marks values(1,3,5);
insert into Marks values(3,2,4);

    
select * from Test2.Students;

select * from Test2.Subjects;

select	Students.StudentID, Students.StudentName, Subjects.SubjectName ,avg(Marks.Mark)
from	Test2.Students , Test2.Subjects , Test2.Marks 
where 	Students.StudentID=Marks.StudentID and Marks.SubjectID=Subjects.SubjectID
group by StudentID ,SubjectName
;

select 	Subjects.SubjectName as 'Mon hoc co hoc sinh thi duoc diem cao nhat'
from Test2.Subjects , Test2.Marks 
where Subjects.SubjectID=Marks.SubjectID and Marks.Mark=(select max(Mark) from Test2.Marks)
;

select * from Test2.Marks
order by Marks.Mark desc;

alter table Test2.Subjects 
	modify column SubjectName nvarchar(10000) not null;
    
alter table Test2.Students 
add constraint check(Age>15 and Age <50);

alter table Test2.Marks
drop constraint SubjectID,
drop constraint	StudentID;
    
alter table Test2.ClassStudent
drop constraint StudentID,
drop constraint ClassID;

delete from Test2.Students 
where StudentID=1;

alter table Test2.Students 
add column Status bit default 1;

update Test2.Students
set Status=0
where StudentID>0;
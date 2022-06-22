CREATE DATABASE QL_DIEM_HV;
USE QL_DIEM_HV;

CREATE TABLE Test (
    TestID INT PRIMARY KEY,
    NameTest VARCHAR(255)
);
CREATE TABLE Student (
    RN INT PRIMARY KEY,
    Name VARCHAR(60),
    age INT,
    status VARCHAR(255)
);

CREATE TABLE StudentTest (
    RN INT,
    TestID INT,
    date DATE,
    Mark DOUBLE,
    FOREIGN KEY (RN)
        REFERENCES Student (RN),
    FOREIGN KEY (TestID)
        REFERENCES Test (TestID)
);

insert into Student values 
(1,'Nguyen Hong Ha',20, null),
(2,'Truong Ngoc Anh',30,null),
(3, 'Tuan Minh',25,null),
(4,'Dan Truong',22,null);

insert into Test values 
(1,'EPC'),
(2,'DWMX'),
(3,'SQL1'),
(4,'SQL2');

insert into StudentTest values
(1,1,'2006/7/17',8),
(1,2,'2006/7/18',5),
(1,3,'2006/7/19',7),
(2,1,'2006/7/17',7),
(2,2,'2006/7/18',4),
(2,3,'2006/7/19',2),
(3,1,'2006/7/17',10),
(3,3,'2006/7/18',1);

-- câu 2
SELECT 
    student.Name AS 'Student name',
    Test.nameTest AS 'Test Name',
    sdt.Mark,
    sdt.date
FROM
    student
        JOIN
    studenttest AS `sdt` ON sdt.RN = student.RN
        JOIN
    Test ON Test.TestID = sdt.TestID;

-- câu 3
SELECT 
    student.RN AS 'Student RN',
    student.name AS 'Student Name',
    student.age
FROM
    student
WHERE
    RN NOT IN (SELECT 
            RN
        FROM
            studenttest);

-- câu 4
SELECT 
    student.Name AS 'Student name',
    Test.nameTest AS 'Test Name',
    sdt.Mark,
    sdt.date
FROM
    student
        JOIN
    studenttest AS `sdt` ON sdt.RN = student.RN
        JOIN
    Test ON Test.TestID = sdt.TestID
WHERE
    sdt.mark < 5;

-- câu 5
select name,avg(mark) from student
join studenttest as `sdt` on sdt.RN=student.RN
group by student.name
order by avg(mark) desc;

-- câu 6
create view diemtb as select name,avg(mark) as avgmark from student
join studenttest as `sdt` on sdt.RN=student.RN
group by student.name
order by avg(mark) desc;
select name,max(avgmark) from diemtb;


-- câu 7: 
select nameTest,max(mark) from 
studenttest as `stdt` 
join test on stdt.testID=test.testid
group by nameTest
order by nameTest;

-- câu 8
select name as `Student name`,nameTest as `Test Name` 
from student 
join StudentTest as `stdt` on Student.RN=stdt.RN
join Test on stdt.TestID=Test.TestID;

-- câu 9
update student set age = age + 1
where RN > 0;

-- câu 10
alter table student add column status varchar(255);

-- câu 11
create index ageIndex on student(age);
update student 
set status= 'Young'
where age < 30;

update student
set status='old'
where age >= 30;

-- câu 12
create view vwStudentTestList as (
select name,nameTest,mark,date from student 
join studenttest as `stdt` on stdt.RN=student.RN
join test on test.TestID= stdt.TestID
);
select * from vwStudentTestList;

-- câu 13
DELIMITER //  
CREATE TRIGGER	tgSetStatus
AFTER UPDATE
ON Student FOR EACH ROW
BEGIN
IF Student.age < 30 THEN SET Student.status = 'Young';
END IF;
IF Student.age >= 30 THEN SET Student.status = 'Old';
END IF;
END//

UPDATE Student set age = 21 WHERE id = '1';

select * from Student;

-- câu 14
DELIMITER //
create procedure spViewStatus(IN vl1 VARCHAR(60), vl2 VARCHAR(255), OUT vl1Out VARCHAR(60), vl2Out VARCHAR(255))
   begin
   IF (SELECT Name FROM Student WHERE vl1 [NOT] EXISTS(select Name from Student)) or (SELECT NameTest FROM Test WHERE vl2 [not] EXISTS(select NameTest from Test)) then set vl1Out = 'Khong tim thay';
   end if;
   if (SELECT Mark FROM Test WHERE vl1 = null ) then set vl1Out = 'Chua thi';
   end if;
   if (SELECT Mark FROM Test WHERE vl1 >= 5 ) then set vl1Out = 'Do';
   end if;
   if (SELECT Mark FROM Test WHERE vl1 < 5 ) then set vl1Out = 'Truot';
   end if;
   end;
//delimiter ;



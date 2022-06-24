create database TicketFilm;
USE TicketFilm;

create table Phong(
	PhongID int primary key ,
    Ten_phong varchar(20) ,
    Trang_thai varchar(50)
);

create table Phim(
	PhimID int PRIMARY key,
    Ten_phim varchar(50),
    Loai_phim varchar(50),
    Thoi_gian int
);

create table Ghe(
	GheID int PRIMARY key,
    So_ghe varchar(50),
    PhongID int,
    FOREIGN KEY(PhongID) REFERENCES Phong(PhongID)
);

create table Ve(
	Ngay_chieu DATETIME,
    Trang_thai_ve varchar(50),
    PhimID int,
    GheID int,
    FOREIGN KEY(PhimID) REFERENCES Phim(PhimID),
    FOREIGN KEY(GheID) REFERENCES Ghe(GheID)
);

INSERT INTO `TicketFilm`.`Phong` (`PhongID`, `Ten_phong`, `Trang_thai`) VALUES ('1', 'Phòng chiếu 1', '1');
INSERT INTO `TicketFilm`.`Phong` (`PhongID`, `Ten_phong`, `Trang_thai`) VALUES ('2', 'Phòng chiếu 2', '1');
INSERT INTO `TicketFilm`.`Phong` (`PhongID`, `Ten_phong`, `Trang_thai`) VALUES ('3', 'Phòng chiếu 3', '0');

INSERT INTO `TicketFilm`.`Phim` (`PhimID`, `Ten_phim`, `Loai_phim`, `Thoi_gian`) VALUES ('1', 'Em bé Hà Nôi', 'Tâm lý', '90');
INSERT INTO `TicketFilm`.`Phim` (`PhimID`, `Ten_phim`, `Loai_phim`, `Thoi_gian`) VALUES ('2', 'Nhiệm vụ bất khả thi', 'Hành động', '100');
INSERT INTO `TicketFilm`.`Phim` (`PhimID`, `Ten_phim`, `Loai_phim`, `Thoi_gian`) VALUES ('3', 'Dị nhân', 'Viễn tưởng', '90');
INSERT INTO `TicketFilm`.`Phim` (`PhimID`, `Ten_phim`, `Loai_phim`, `Thoi_gian`) VALUES ('4', 'Cuốn theo chiều gió', 'Tình cảm', '120');

INSERT INTO `TicketFilm`.`Ghe` (`GheID`, `So_ghe`, `PhongID`) VALUES ('1', 'A3', '1');
INSERT INTO `TicketFilm`.`Ghe` (`GheID`, `So_ghe`, `PhongID`) VALUES ('2', 'B5', '1');
INSERT INTO `TicketFilm`.`Ghe` (`GheID`, `So_ghe`, `PhongID`) VALUES ('3', 'A7', '2');
INSERT INTO `TicketFilm`.`Ghe` (`GheID`, `So_ghe`, `PhongID`) VALUES ('4', 'D1', '2');
INSERT INTO `TicketFilm`.`Ghe` (`GheID`, `So_ghe`, `PhongID`) VALUES ('5', 'T2', '3');

INSERT INTO Ve
VALUES ('2008-10-20', 'Đã bán', 1 , 1),
		('2008-11-20', 'Đã bán', 1 , 3),
        ( '2008-12-23', 'Đã bán',1 , 4),
        ( '2008-02-14', 'Đã bán', 2 , 1),
        ( '2008-02-14', 'Đã bán',3 , 1),
        ( '2008-03-08', 'Chưa bán',2 , 5),
        ( '2008-03-08', 'Chưa bán', 2 , 3);

-- câu2 
SELECT *
FROM Phim
order by Thoi_gian DESC;

-- câu 3
select Phim.Ten_Phim, Phim.Thoi_gian
FROM Phim
WHERE Phim.Thoi_gian =  (select max(Thoi_gian) from Phim);

-- câu 4
select Phim.Ten_Phim, Phim.Thoi_gian
FROM Phim
WHERE Phim.Thoi_gian =  (select min(Thoi_gian) from Phim);

-- câu 5
select GheID, So_ghe 
from Ghe
where So_ghe like 'A%';

-- câu6
alter table Phong 
MODIFY Trang_thai nvarchar(25);

-- câu 7
update Phong set Trang_thai = if(Trang_thai=0, 'Đang sửa', if(Trang_thai=1, 'Đang sử dụng', 'Unknow')) WHERE PhongID > 0;
SELECT *
FROM Phong;

-- câu 8
SELECT *
FROM Phim
WHERE length(Ten_phim) > 15 AND length(Ten_phim) <25;

-- câu 9
SELECT concat(Ten_Phong, '  ', Trang_Thai) as 'Trạng thái phòng chiếu'
from Phong;

-- câu 10
create table tblRank(
	STT int AUTO_INCREMENT PRIMARY key,
    TenPhim varchar(50),
    Thoi_gian int	
);

INSERT INTO tblRank(TenPhim, Thoi_gian)
SELECT Ten_phim, Thoi_gian
FROM Phim
ORDER BY Ten_phim;

-- câu 11
ALTER TABLE Phim 
ADD COLUMN Mo_ta varchar(100);

UPDATE Phim
set Mo_ta=concat('Đây là bộ phim thể loại', ' ' ,  Loai_phim)
where PhimID >0;

UPDATE Phim
set Mo_ta = replace(Mo_ta, 'bộ phim', 'film')
where PhimID >0;

-- câu 12
ALTER TABLE Ghe
DROP FOREIGN KEY Ghe_ibfk_1;

ALTER TABLE Ve
DROP FOREIGN KEY Ve_ibfk_1;

ALTER TABLE Ve
DROP FOREIGN KEY Ve_ibfk_2;

-- câu 13
DELETE FROM Ghe
WHERE GheID>0;

-- câu 14
SELECT now(), subtime(now(), "-0:5:0");


    


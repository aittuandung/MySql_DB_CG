CREATE DATABASE QLSV;
USE QLSV;

CREATE TABLE sinhvien(
id_sv INT PRIMARY KEY,
hoten VARCHAR(255),
ngaysinh DATE,
hocbong DOUBLE,
gioitinh VARCHAR(255),
id_lop INT,
id_sv_diemmh INT,
FOREIGN KEY(id_lop) REFERENCES lop(id_lop),
FOREIGN KEY(id_sv_diemmh) REFERENCES ketqua(id_sv_diemmh)
);

CREATE TABLE lop(
id_lop INT PRIMARY KEY,
tenlop VARCHAR(255),
id_khoa INT,
FOREIGN KEY(id_khoa) REFERENCES khoa(id_khoa)
);

CREATE TABLE khoa(
id_khoa INT PRIMARY KEY,
tenkhoa VARCHAR(255)
);	

CREATE TABLE monhoc(
id_mh INT PRIMARY KEY,
tenmh VARCHAR(255),
sotiet INT,
id_sv_diemmh INT,
FOREIGN KEY(id_sv_diemmh) REFERENCES ketqua(id_sv_diemmh)
);

CREATE TABLE ketqua(
id_sv_diemmh INT PRIMARY KEY,
diemthi DOUBLE
);
-- id_sv, hoten, ngaysinh, hocbong, gioitinh, id_lop, id_sv_diemmh
INSERT INTO sinhvien 
VALUES  (1, 'Trần Duy Hưng', '1994-04-12', 8000000, 'nam', 1, 1),
		(2, 'Lê Huy Hoàng', '1996-12-23', 400000, 'nữ', 1, 1),
		(3, 'Trần Bình', '2001-08-30', 7000000, 'nam', 1, 1);
        
INSERT INTO lop
VALUES  (1, 'c0322g1', 1),
        (2, 'c0623g1', 2);
        
INSERT INTO khoa
VALUES  (1, 'phan mem'),
		(2, 'ung dung');
        
INSERT INTO monhoc
VALUES 	(1, 'OOP' , 24, 1),
		(2, 'PHP' , 16, 2);
        
INSERT INTO ketqua
VALUES  (1, 8.5),
		(2, 6.5),
        (3, 7.0);
-- câu 5
SELECT hoten 
FROM sinhvien 
WHERE hoten LIKE 'Trần';

-- câu 6
SELECT gioitinh 
FROM sinhvien 
WHERE gioitinh LIKE 'nữ';

-- câu 7
SELECT gioitinh, hocbong
FROM sinhvien
WHERE gioitinh LIKE 'nữ' AND hocbong NOT LIKE 0;

-- câu 8
SELECT ngaysinh
FROM sinhvien
WHERE ngaysinh BETWEEN '1978' AND '1985';

-- câu 9
SELECT id_sv
FROM sinhvien
ORDER BY id_sv ASC;

-- câu 10
SELECT hocbong
FROM sinhvien
ORDER BY hocbong DESC;

-- câu 14
SELECT COUNT(id_sv) as 'số hoc sinh mỗi lớp'
FROM sinhvien;

-- câu 15
SELECT COUNT(id_khoa) as 'số hoc sinh mỗi khoa'
FROM khoa;

-- câu 16
SELECT COUNT(id_sv) as 'số lượng sinh viên nữ'
FROM sinhvien
WHERE gioitinh LIKE 'nữ';

-- câu 17
SELECT SUM(hocbong) as sumhocbong
FROM sinhvien;

-- câu 18
SELECT SUM(hocbong) 
FROM hocsinh
JOIN (
		SELECT id_khoa
        FROM khoa
	) as summoikhoa;

-- câu 19
SELECT id_khoa , tenkhoa , COUNT(id_khoa)
FROM khoa
WHERE count(id_khoa) > 100;

-- câu 20
SELECT id_khoa , tenkhoa , COUNT(id_khoa)
FROM khoa
WHERE count(id_khoa) > 100 AND gioitinh LIKE 'nữ'; 

-- câu 22
SELECT * 
FROM sinhvien
JOIN (
	SELECT MAX(hocbong)	
	FROM sinhvien
) as listmaxhocbong;

-- câu 23
SELECT * 
FROM sinhvien
JOIN (
	SELECT diemthi	
	FROM ketqua
    join (
		SELECT MAX(diemthi)
        FROM ketqua
        )
) as listmaxtoan
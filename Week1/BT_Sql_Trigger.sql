create database BT_Sql_Trigger;
use BT_Sql_Trigger;

CREATE TABLE KHACHHANG (
    MAKH INT PRIMARY KEY AUTO_INCREMENT,
    HOTEN VARCHAR(50),
    DCHI VARCHAR(50),
    SODT VARCHAR(15),
    NGSINH DATETIME,
    DOANHSO FLOAT,
    NGDK DATETIME
);

CREATE TABLE SANPHAM (
    MANV INT PRIMARY KEY AUTO_INCREMENT,
    HOTEN VARCHAR(50),
    NGVL DATETIME,
    SODT VARCHAR(15)
);

CREATE TABLE SANPHAM (
    MASP INT PRIMARY KEY AUTO_INCREMENT,
    TENSP VARCHAR(50),
    DVT VARCHAR(15),
    NUOCSX VARCHAR(30),
    GIA FLOAT
);

CREATE TABLE HOADON (
    SOHD INT PRIMARY KEY AUTO_INCREMENT,
    NGHD DATETIME,
    MAKH INT,
    MANV INT,
    TRIGIA FLOAT,
    FOREIGN KEY (MAKH)
        REFERENCES KHACHHANG (MAKH),
    FOREIGN KEY (MANV)
        REFERENCES SANPHAM (MANV)
);

CREATE TABLE CTHD (
    SOHD INT,
    MASP INT,
    SL INT,
    FOREIGN KEY (SOHD)
        REFERENCES HOADON (SOHD),
    FOREIGN KEY (MASP)
        REFERENCES SANPHAM (MASP),
    PRIMARY KEY (SOHD , MASP)
);
                        
-- câu 1:
seleCT count(distinCT CT.MASP) 
from HOADON HD join CTHD CT on HD.SOHD = CT.SOHD 
where year(HD.nghd) = 2006  ;

-- câu 2:
seleCT max(HOADON.TRIGIA), min(HOADON.TRIGIA) 
from HOADON; 

-- câu 3:
seleCT avg(HOADON.TRIGIA) 
from HOADON
where year(HOADON.NGHD) = 2006 ;

-- câu 4:
seleCT sum(HOADON.TRIGIA) 
from HOADON
where year(HOADON.NGHD) = 2006 ;

-- câu 5:
seleCT max(HOADON.TRIGIA) 
from HOADON
where year(NGHD) = 2006; 

-- câu 6:
seleCT KH.hoten, max(HD.TRIGIA)
from KHACHHANG KH join HOADON HD on KH.MAKH = hd.MAKH
where year(NGHD) = 2006;

-- câu 7:
seleCT KH.MAKH,KH.hoten
from KHACHHANG kh
order by kh.doanhso desc
limit 3;

-- câu 8:
seleCT MASP, TENSP, GIA
from SANPHAM
where GIA >= (
seleCT distinCT GIA from SANPHAM
order by GIA desc
limit 2,1
);

-- câu 9:
SELECT 
    MASP, TENSP, GIA
FROM
    SANPHAM
WHERE
    NUOCSX LIKE 'Thai Lan'
        AND GIA >= (SELECT DISTINCT
            GIA
        FROM
            SANPHAM
        ORDER BY GIA DESC
        LIMIT 2 , 1);
        
-- câu 10: 
seleCT MASP, TENSP, GIA
from SANPHAM
where NUOCSX like 'Trung Quoc' and GIA >= (
seleCT distinCT GIA from SANPHAM
order by GIA desc
limit 2,1
);

-- câu 11:
SeleCT *, rank() over(order by doanhso DESC) as ranking from KHACHHANG;

-- câu 12:
seleCT count(MASP) 'Trung Quoc' 
from SANPHAM
where NUOCSX like 'Trung Quoc';

-- câu 13:
seleCT NUOCSX, count(MASP) 
from SANPHAM
group by NUOCSX;

-- câu 14:
seleCT NUOCSX , min(GIA) , max(GIA) , avg(GIA)  
from SANPHAM
group by NUOCSX;

-- câu 15:
seleCT NGHD , sum(TRIGIA)
from HOADON
group by NGHD
order by NGHD;

-- câu 16:
seleCT count(CTHD.sl) 
from CTHD join HOADON on HOADON.SOHD = CTHD.SOHD
where month(NGHD) = 10 and year(NGHD) = 2006;

-- câu 17:
seleCT month(NGHD) , sum(TRIGIA) 
from HOADON
where year(NGHD) = 2006
group by month(NGHD)
order by month(NGHD);

-- câu 18:
seleCT HOADON.SOHD , count(CTHD.MASP) 
from HOADON join CTHD on CTHD.SOHD = HOADON.SOHD
group by HOADON.SOHD
having count(CTHD.MASP) = 3 ;

-- câu 19:
seleCT HOADON.SOHD , count(CTHD.MASP) 
from HOADON join CTHD on CTHD.SOHD = HOADON.SOHD join SANPHAM on SANPHAM.MASP = CTHD.MASP
where SANPHAM.NUOCSX = 'việt nam'
group by HOADON.SOHD
having count(CTHD.MASP) = 3 ;

-- câu 20:
seleCT KHACHHANG.MAKH, KHACHHANG.hoten,count(HOADON.SOHD)
from KHACHHANG join HOADON on HOADON.MAKH = KHACHHANG.MAKH
group by KHACHHANG.MAKH
having count(HOADON.SOHD) = (
seleCT count(SOHD)
from HOADON
group by MAKH
order by count(SOHD) desc
limit 1
);
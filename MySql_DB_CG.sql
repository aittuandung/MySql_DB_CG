CREATE DATABASE newclass;
use newclass;
CREATE TABLE class(
	id int primary key,
    name varchar(255)
);

CREATE TABLE student(
	id int PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(255),
    birthday DATE,
    id_class INT,
    FOREIGN KEY(id_class) REFERENCES class(id)
);

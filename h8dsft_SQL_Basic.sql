CREATE TABLE teachers (
	id int not null primary key auto_increment,
    first_name varchar(25) not null,
    last_name varchar(50),
    school varchar(50) not null,
    hire_date date,
    salary numeric
    );
    
INSERT INTO teachers (id, first_name, last_name, school, hire_date, salary)
	values (1,'Janet', 'Smith', 'MIT', '2011-10-30', 36200),
           (2,'Lee', 'Reynolds', 'MIT', '1993-05-22', 65000),
           (3,'Samuel', 'Cole', 'Cambridge University', '2005-08-01', 43500),
           (4,'Samantha', 'Bush', 'Cambridge University', '2011-10-30', 36200),
           (5,'Betty', 'Diaz', 'Cambridge University', '2005-08-30', 43500),
           (6,'Kathleen', 'Roush', 'MIT', '2010-10-22', 38500),
           (7,'James', 'Diaz', 'Harvard University', '2003-07-18', 61000),
           (8,'Zack', 'Smith', 'Harvard University', '2000-12-29', 55500),
           (9,'Luis', 'Gonzales', 'Standford University', '2002-12-01', 50000),
           (10,'Frank', 'Abbers', 'Standford University', '1999-01-30', 66000);
           
describe teachers;

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
    VALUES ('Samuel', 'Abbers', 'Standford University', '2006-01-30', 32000),
           ('Jessica', 'Abbers', 'Standford University', '2005-01-30', 33000),
           ('Tom', 'Massi', 'Harvard University', '1999-09-09', 39500),
           ('Esteban', 'Brown', 'MIT', '2007-01-30', 36000),
           ('Carlos', 'Alonso', 'Standford University', '2001-01-30', 44000);

CREATE TABLE courses (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(20),
    teachers_id INT,
    total_students INT
    );
    
INSERT INTO courses (name, teachers_id, total_students)
    VALUES  ('Calculus', 2, 20),
            ('Physics', 2, 10),
            ('Calculus', 1, 30),
            ('Computer Science', 1, 20),
            ('Politic', 13, 15),
            ('Algebra', 2, 10),
            ('Algebra', 13, 30),
            ('Computer Science', 10, 35),
            ('Life Science', 11, 20),
            ('Chemistry', 9, 22),
            ('Chemistry', 8, 16),
            ('Calculus', 5, 19),
            ('Politic', 4, 17),
            ('Biology', 6, 22),
            ('Physics', 3, 29),
            ('Biology', 8, 28),
            ('Calculus', 12, 34),
            ('Physics', 13, 34),
            ('Biology', 14, 25),
            ('Calculus', 15, 20);

describe courses;

# soal
# Carilah dosen yang memiliki gaji tertinggi per masing-masing mata kuliah. 
# Tampilkan semua atribut dosen dan semua atribut mata kuliahnya. 
# Urutkan hasilnya berdasarkan nama mata kuliahnya secara ascending

# cara 1 (urutan semua courses name)
select * from teachers
join courses on teachers.id = courses.teachers_id
where teachers.salary = (select distinct max(salary) from teachers a where a.id = courses.teachers_id
						group by name
                        having max(salary))
order by name asc, salary desc, teachers_id;

# cara 2 (per courses name & max)
select x.* from
(select a.*,
	ROW_NUMBER() OVER(PARTITION BY name order by a.name asc, a.salary desc) AS row_num
	from
	(
	select t.id, first_name, last_name, t.school, t.hire_date, t.salary, c.name, 
    c.teachers_id, c.total_students from teachers t
	join courses c on c.teachers_id = t.id
	-- order by c.name asc, t.salary desc
	) a
)	x
where x.row_num = 1
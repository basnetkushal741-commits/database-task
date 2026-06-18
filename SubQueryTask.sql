create database lms_db;
use lms_db;
create table students(
student_id int auto_increment primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(10),
registration_date Date,
country varchar(50)
);
create table instructors(
instructor_id int primary key auto_increment,
instructor_name varchar(100),
specializatrion varchar(100),
joining_date Date
);

create table courses(
course_id int primary key auto_increment,
course_name varchar(100),
catergory varchar (50),
course_fee decimal (10,2),
instructor_id int,
foreign key (instructor_id) references instructors (instructor_id)

);


create table enrollments(
enrollment_id int primary key auto_increment,
student_id int,
course_id int,
enrollment_date date,
completion_status varchar(20),
foreign key (student_id) references students (student_id),
foreign key (course_id) references courses (course_id)
);

create table assignments (
    assignment_id int primary key,
    course_id int,
    assignment_title varchar(100),
    max_marks int,
    due_date date,
    foreign key (course_id)
        references courses(course_id)
);


create table assignment_submissions(
submissions_id int primary key auto_increment,
assignment_id int,
student_id int,
marks_obtained int,
submission_date date,
foreign key (assignment_id) references assignments (assignment_id),
foreign key (student_id) references students (student_id)

);


create table payments (
    payment_id int primary key,
    student_id int,
    amount_paid decimal(10,2),
    payment_date date,
    payment_method varchar(20),
    foreign key (student_id)
        references students(student_id)
);
insert into students (first_name, last_name, email, registration_date, country) values
('liam', 'smith', 'l.smith', '2026-01-10', 'united states'),
('olivia', 'jones', 'o.jones', '2026-01-12', 'canada'),
('noah', 'brown', 'n.brown', '2026-01-15', 'united kingdom'),
('emma', 'miller', 'e.miller', '2026-01-18', 'australia'),
('oliver', 'davis', 'o.davis', '2026-01-20', 'germany'),
('ava', 'garcia', 'a.garcia', '2026-01-22', 'spain'),
('elijah', 'rodriguez', 'e.rod', '2026-01-25', 'mexico'),
('charlotte', 'wilson', 'c.wilson', '2026-01-28', 'new zealand'),
('william', 'martinez', 'w.mart', '2026-02-01', 'colombia'),
('sophia', 'anderson', 's.and', '2026-02-03', 'sweden');

-- 4. Insert 10 records into instructors
insert into instructors (instructor_name, specializatrion, joining_date) values
('dr. alan turing', 'computer science', '2025-05-10'),
('prof. ada lovelace', 'programming logic', '2025-06-15'),
('grace hopper', 'compiler design', '2025-08-20'),
('edger dijkstra', 'algorithms', '2025-09-01'),
('tim berners-lee', 'web development', '2025-10-11'),
('katherine johnson', 'data science', '2025-11-05'),
('linus torvalds', 'operating systems', '2025-12-01'),
('guido van rossum', 'python scripting', '2026-01-05'),
('james gosling', 'java architectures', '2026-01-15'),
('donald knuth', 'software engineering', '2026-02-01');

-- 5. Insert 10 records into courses
insert into courses (course_name, catergory, course_fee, instructor_id) values
('introduction to sql', 'databases', 99.99, 1),
('advanced python', 'programming', 149.99, 8),
('web development basics', 'web design', 89.99, 5),
('data structures & algorithms', 'computer science', 199.99, 4),
('machine learning foundations', 'data science', 249.99, 6),
('operating systems 101', 'it & software', 129.99, 7),
('java programming', 'programming', 139.99, 9),
('compiler construction', 'computer science', 299.99, 3),
('discrete mathematics', 'mathematics', 119.99, 10),
('database optimization', 'databases', 179.99, 1);

-- 6. Insert 10 records into enrollments
insert into enrollments (student_id, course_id, enrollment_date, completion_status) values
(1, 1, '2026-02-10', 'completed'),
(2, 1, '2026-02-11', 'in progress'),
(3, 2, '2026-02-12', 'completed'),
(4, 3, '2026-02-15', 'in progress'),
(5, 4, '2026-02-18', 'completed'),
(6, 5, '2026-02-20', 'dropped'),
(7, 6, '2026-02-22', 'in progress'),
(8, 7, '2026-02-25', 'completed'),
(9, 8, '2026-03-01', 'in progress'),
(10, 9, '2026-03-03', 'completed');

-- 7. Insert 10 records into assignments
insert into assignments (assignment_id, course_id, assignment_title, max_marks, due_date) values
(101, 1, 'basic select queries', 100, '2026-02-20'),
(102, 1, 'joins and subqueries', 100, '2026-02-28'),
(103, 2, 'python loops and lists', 50, '2026-02-25'),
(104, 3, 'html and css basic page', 100, '2026-03-05'),
(105, 4, 'binary tree implementation', 150, '2026-03-10'),
(106, 5, 'linear regression analysis', 100, '2026-03-15'),
(107, 6, 'process scheduling lab', 100, '2026-03-20'),
(108, 7, 'oop inheritance challenge', 50, '2026-03-02'),
(109, 8, 'lexical analyzer draft', 200, '2026-03-25'),
(110, 9, 'set theory problem set', 100, '2026-03-12');

-- 8. Insert 10 records into assignment_submissions
insert into assignment_submissions (assignment_id, student_id, marks_obtained, submission_date) values
(101, 1, 95, '2026-02-18'),
(102, 1, 88, '2026-02-27'),
(103, 3, 48, '2026-02-24'),
(104, 4, 90, '2026-03-04'),
(105, 5, 142, '2026-03-09'),
(106, 6, 75, '2026-03-14'),
(107, 7, 85, '2026-03-19'),
(108, 8, 47, '2026-03-01'),
(109, 9, 180, '2026-03-24'),
(110, 10, 99, '2026-03-11');

-- 9. Insert 10 records into payments
insert into payments (payment_id, student_id, amount_paid, payment_date, payment_method) values
(501, 1, 99.99, '2026-02-10', 'credit card'),
(502, 2, 99.99, '2026-02-11', 'paypal'),
(503, 3, 149.99, '2026-02-12', 'credit card'),
(504, 4, 89.99, '2026-02-15', 'bank transfer'),
(505, 5, 199.99, '2026-02-18', 'credit card'),
(506, 6, 249.99, '2026-02-20', 'paypal'),
(507, 7, 129.99, '2026-02-22', 'credit card'),
(508, 8, 139.99, '2026-02-25', 'debit card'),
(509, 9, 299.99, '2026-03-01', 'bank transfer'),
(510, 10, 119.99, '2026-03-03', 'paypal');

-- q.1 find students who paid more than the average payment amount.
select * from students 
where student_id in (
    select student_id 
    from payments 
    where amount_paid > (select avg(amount_paid) from payments)
);

-- q.2 find courses whose fee is greater than the average course fee.
select * from courses 
where course_fee > (
    select avg(course_fee) from courses
);

-- q.3 find instructors teaching the most expensive course.
select * from instructors 
where instructor_id in (
    select instructor_id 
    from courses 
    where course_fee = (select max(course_fee) from courses)
);

-- q.4 find students who enrolled in the course with the highest fee.
select * from students 
where student_id in (
    select student_id 
    from enrollments 
    where course_id in (
        select course_id 
        from courses 
        where course_fee = (select max(course_fee) from courses)
    )
);

-- q.5 find assignments whose maximum marks are greater than the average maximum marks.
select * from assignments 
where max_marks > (
    select avg(max_marks) from assignments
);

-- q.6 find students who have submitted at least one assignment.
select * from students 
where student_id in (
    select student_id 
    from assignment_submissions
);

-- q.7 find students who have never submitted any assignment.
select * from students 
where student_id not in (
    select student_id 
    from assignment_submissions 
    where student_id is not null
);

-- q.8 find courses that have enrollments.
select * from courses 
where course_id in (
    select course_id 
    from enrollments
);

-- q.9 find courses that have no enrollments.
select * from courses 
where course_id not in (
    select course_id 
    from enrollments 
    where course_id is not null
);

-- q.10 find instructors who are not assigned to any course.
select * from instructors 
where instructor_id not in (
    select instructor_id 
    from courses 
    where instructor_id is not null
);

-- q.11 find students whose total payment is higher than the average payment of all students.
select * from students s
where (
    select sum(amount_paid) 
    from payments p 
    where p.student_id = s.student_id
) > (
    select avg(total_paid) 
    from (
        select sum(amount_paid) as total_paid 
        from payments 
        group by student_id
    ) as sub
);



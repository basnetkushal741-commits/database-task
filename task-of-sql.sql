-- ============================================================
--  HOSPITAL DATABASE - TABLE CREATION + ALL 20 SOLUTIONS
-- ============================================================

-- ------------------------------------------------------------
-- TABLE CREATION (based on ER Diagram)
-- ------------------------------------------------------------

create table doctor (
    doctorid    int primary key,
    firstname   varchar(50),
    lastname    varchar(50),
    specialty   varchar(100),
    phone       varchar(15),
    email       varchar(100)
);

create table patient (
    patientid     int primary key,
    firstname     varchar(50),
    lastname      varchar(50),
    dateofbirth   date,
    gender        varchar(10),
    contactinfo   varchar(150)
);

create table medicalrecord (
    recordid     int primary key,
    patientid    int,
    diagnosis    varchar(200),
    treatment    varchar(200),
    recorddate   date,
    notes        text,
    foreign key (patientid) references patient(patientid)
);

create table billing (
    billingid    int primary key,
    patientid    int,
    amount       decimal(10, 2),
    billingdate  date,
    status       varchar(50),
    foreign key (patientid) references patient(patientid)
);

create table appointment (
    appointmentid    int primary key,
    patientid        int,
    doctorid         int,
    appointmentdate  date,
    reason           varchar(200),
    status           varchar(50),
    foreign key (patientid) references patient(patientid),
    foreign key (doctorid)  references doctor(doctorid)
);

create table prescription (
    prescriptionid  int primary key,
    patientid       int,
    doctorid        int,
    medication      varchar(100),
    dosage          varchar(100),
    startdate       date,
    enddate         date,
    foreign key (patientid) references patient(patientid),
    foreign key (doctorid)  references doctor(doctorid)
);


-- ------------------------------------------------------------
-- SAMPLE DATA
-- ------------------------------------------------------------

insert into doctor values
(1, 'Alice',   'Smith',   'Cardiology',    '9800000001', 'alice@hospital.com'),
(2, 'Bob',     'Jones',   'Neurology',     '9800000002', 'bob@hospital.com'),
(3, 'Carol',   'White',   'Orthopedics',   '9800000003', 'carol@hospital.com'),
(4, 'David',   'Brown',   'General',       '9800000004', 'david@hospital.com');

insert into patient values
(1, 'Aarav',   'Sharma',  '1990-05-10', 'Male',   '9811111111'),
(2, 'Bipasha', 'Rai',     '1985-08-22', 'Female', '9822222222'),
(3, 'Chetan',  'Thapa',   '2000-01-15', 'Male',   '9833333333'),
(4, 'Deepa',   'Karki',   '1978-11-30', 'Female', '9844444444'),
(5, 'Anish',   'Gurung',  '1995-07-04', 'Male',   '9855555555');

insert into medicalrecord values
(1, 1, 'Hypertension',  'Medication',        '2025-01-10', 'Monitor BP'),
(2, 2, 'Migraine',      'Pain Relief',       '2025-02-14', null),
(3, 3, 'Fracture',      'Surgery required',  '2025-03-05', 'Post-op care needed'),
(4, 4, 'Diabetes',      'Insulin Therapy',   '2025-04-20', 'Diet control'),
(5, 1, 'Hypertension',  'Surgery follow-up', '2025-05-01', null),
(6, 5, 'Asthma',        'Inhaler',           '2025-06-10', 'Avoid dust');

insert into billing values
(1, 1, 1500.00, '2025-01-11', 'Paid'),
(2, 2,  800.00, '2025-02-15', 'Paid'),
(3, 3, 3000.00, '2025-03-06', 'Unpaid'),
(4, 4,  500.00, '2025-04-21', 'Paid'),
(5, 1,  700.00, '2025-05-02', 'Paid'),
(6, 3, 1200.00, '2025-06-01', 'Unpaid');

insert into appointment values
(1, 1, 1, '2026-01-15', 'Chest Pain',     'Scheduled'),
(2, 2, 2, '2026-02-20', 'Headache',       'Scheduled'),
(3, 3, 3, '2025-11-10', 'Knee Pain',      'Completed'),
(4, 4, 1, '2026-03-05', 'Sugar levels',   'Scheduled'),
(5, 5, 2, '2026-04-18', 'Breathing',      'Scheduled'),
(6, 1, 4, '2025-12-01', 'Routine Check',  'Completed');

insert into prescription values
(1, 1, 1, 'Amlodipine',   '5mg once daily',   '2025-01-10', '2025-04-10'),
(2, 2, 2, 'Paracetamol',  '500mg twice daily', '2025-02-14', '2025-02-21'),
(3, 3, 3, 'Ibuprofen',    '400mg thrice daily','2025-03-05', '2025-03-15'),
(4, 4, 1, 'Metformin',    '500mg twice daily', '2025-04-20', '2025-10-20'),
(5, 5, 2, 'Amoxicillin',  '250mg thrice daily','2025-06-10', '2025-06-17'),
(6, 1, 1, 'Atenolol',     '25mg once daily',   '2025-05-01', '2025-08-01'),
(7, 2, 2, 'Ibuprofen',    '200mg once daily',  '2025-07-01', '2025-07-07');


-- ============================================================
-- SOLUTIONS
-- ============================================================

-- Q1. total billing amount paid by each patient (patientid + total amount)
select patientid,
       sum(amount) as total_amount
from billing
group by patientid;


-- Q2. total number of appointments booked for each doctor (doctorname + count)
select concat(d.firstname, ' ', d.lastname) as doctorname,
       count(a.appointmentid) as appointment_count
from doctor d
join appointment a on d.doctorid = a.doctorid
group by d.doctorid, d.firstname, d.lastname;


-- Q3. average billing amount from the billing table
select avg(amount) as average_billing_amount
from billing;


-- Q4. maximum and minimum billing amount from the billing table
select max(amount) as maximum_amount,
       min(amount) as minimum_amount
from billing;


-- Q5. doctors who have issued more than 2 prescriptions (doctorname + prescription count)
select concat(d.firstname, ' ', d.lastname) as doctorname,
       count(p.prescriptionid) as prescription_count
from doctor d
join prescription p on d.doctorid = p.doctorid
group by d.doctorid, d.firstname, d.lastname
having count(p.prescriptionid) > 2;


-- Q6. total number of medical records grouped by diagnosis
select diagnosis,
       count(recordid) as record_count
from medicalrecord
group by diagnosis;


-- Q7. full name of each patient along with their diagnosis from medicalrecord
select concat(p.firstname, ' ', p.lastname) as full_name,
       m.diagnosis
from patient p
join medicalrecord m on p.patientid = m.patientid;


-- Q8. all appointments with patient's first name, last name, doctor's first name, last name
select a.appointmentid,
       a.appointmentdate,
       p.firstname  as patient_firstname,
       p.lastname   as patient_lastname,
       d.firstname  as doctor_firstname,
       d.lastname   as doctor_lastname
from appointment a
join patient p on a.patientid = p.patientid
join doctor  d on a.doctorid  = d.doctorid;


-- Q9. all prescriptions with medication name, patient name, and prescribing doctor's name
select pr.medication,
       concat(p.firstname, ' ', p.lastname) as patient_name,
       concat(d.firstname, ' ', d.lastname) as doctor_name
from prescription pr
join patient p on pr.patientid = p.patientid
join doctor  d on pr.doctorid  = d.doctorid;


-- Q10. all patients and their billing details (include patients with no billing records)
select p.patientid,
       concat(p.firstname, ' ', p.lastname) as patient_name,
       b.billingid,
       b.amount,
       b.billingdate,
       b.status
from patient p
left join billing b on p.patientid = b.patientid;


-- Q11. all doctors and any appointments they have (include doctors with no appointments)
select d.doctorid,
       concat(d.firstname, ' ', d.lastname) as doctor_name,
       a.appointmentid,
       a.appointmentdate,
       a.reason,
       a.status
from doctor d
left join appointment a on d.doctorid = a.doctorid;


-- Q12. each patient's full name and total amount billed (join patient and billing)
select concat(p.firstname, ' ', p.lastname) as full_name,
       sum(b.amount) as total_billed
from patient p
join billing b on p.patientid = b.patientid
group by p.patientid, p.firstname, p.lastname;


-- Q13. appointment details (date, reason, status) with patient's gender and contact info
select a.appointmentdate,
       a.reason,
       a.status,
       p.gender,
       p.contactinfo
from appointment a
join patient p on a.patientid = p.patientid;


-- Q14. appointments where status is 'scheduled' and date is after jan 1 2026
select *
from appointment
where status = 'Scheduled'
  and appointmentdate > '2026-01-01';


-- Q15. patients whose first name starts with the letter 'a'
select *
from patient
where firstname like 'A%';


-- Q16. billing records where the amount is between 500 and 2000
select *
from billing
where amount between 500 and 2000;


-- Q17. prescriptions where medication is 'paracetamol', 'ibuprofen', or 'amoxicillin'
select *
from prescription
where medication in ('Paracetamol', 'Ibuprofen', 'Amoxicillin');


-- Q18. medical records where treatment contains 'surgery' or notes are not null
select *
from medicalrecord
where treatment like '%Surgery%'
   or notes is not null;


-- Q19. add a new column bloodgroup of type varchar(5) to the patient table
alter table patient
add column bloodgroup varchar(5);


-- Q20. modify the phone column in doctor table from varchar(15) to varchar(20)
alter table doctor
modify column phone varchar(20);
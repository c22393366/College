-- Dropping tables if they already exist
drop table if exists OLD_PATIENT_DATA, patients;

-- Creating the patients table
create table patients (
    PatientID serial primary key,        
    Date date,                            
    PatientName varchar(50),             
    PatientLastName varchar(50),          
    Age int check (Age > 0),             
    Weight float check (Weight > 0),      
    Height float check (Height > 0),       
    BMI float                              
);

-- Create the old_patient_data table to store previous data before updates
create table OLD_PATIENT_DATA (
    PatientID int references patients(PatientID),                          -- Reference to the patient
    Record_ID serial,                       -- Unique ID for each historical record
    Date date,                              -- Date of the record
    Age int,                                -- Previous age
    Weight float,                           -- Previous weight
    Height float,                           -- Previous height
    BMI float,                              -- Previous BMI
    primary key (PatientID, Record_ID)     -- Composite primary key
);


create or replace function calculate_bmi() returns trigger as $$
begin
    -- Calculate BMI: weight in kg / (height in meters)^2
    new.BMI := new.Weight / (new.Height / 100)^2;
    return new;
end;
$$ language plpgsql;

-- Create trigger to automatically calculate BMI during insert and update
create trigger before_bmi_calculation
before insert or update on patients
for each row
execute function calculate_bmi();

-- Create a trigger function to store previous data before updates
create or replace function store_old_patient_data() returns trigger as $$
begin
    -- Insert old data into the OLD_PATIENT_DATA table
    insert into OLD_PATIENT_DATA (PatientID, Date, Age, Weight, Height, BMI)
    values (old.PatientID, old.Date, old.Age, old.Weight, old.Height, old.BMI);
    
    return new;
end;
$$ language plpgsql;

-- Create trigger to store old data before updating a patient record
create trigger before_patient_update
before update on patients
for each row
execute function store_old_patient_data();

-- Insert new patients
insert into patients (Date, PatientName, PatientLastName, Age, Weight, Height) 
values ('2024-01-01', 'John', 'Doe', 45, 75, 175), 
       ('2024-03-03', 'Mary', 'Smith', 24, 56, 172);

-- Check patients table to verify data and BMI calculation
select * from patients;

-- Update patient data (this will trigger the storage of old data)
update patients 
set Age = 46, Weight = 78 
where PatientID = 1;

-- Check the old_patient_data table to see the stored old data
select * from OLD_PATIENT_DATA;

-- Check updated data in the patients table
select * from patients;



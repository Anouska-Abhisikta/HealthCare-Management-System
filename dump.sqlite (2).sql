-- TABLE
CREATE TABLE 'Appointment' ('AppointmentID' INTEGER,'Date' TEXT,'Time' TEXT,'PatientID' INTEGER,'DoctorID' INTEGER);
CREATE TABLE 'Billing' ('InvoiceID' TEXT,'PatientID' INTEGER,'Items' TEXT,'Amount' INTEGER);
CREATE TABLE CombinedDataset(
  AppointmentID INT,
  Date TEXT,
  Time TEXT,
  PatientID INT,
  PatientFirstName TEXT,
  PatientLastName TEXT,
  PatientEmail TEXT,
  DoctorID INT,
  DoctorName TEXT,
  Specialization TEXT,
  DoctorContact TEXT,
  ProcedureID INT,
  ProcedureName TEXT,
  MedicalProcedureAppointmentID INT,
  InvoiceID TEXT,
  Items TEXT,
  Amount INT
);
CREATE TABLE demo (ID integer primary key, Name varchar(20), Hint text );
CREATE TABLE 'Doctor' ('DoctorID' INTEGER,'DoctorName' TEXT,'Specialization' TEXT,'DoctorContact' TEXT);
CREATE TABLE 'MedicalProcedure' ('ProcedureID' INTEGER,'ProcedureName' TEXT,'AppointmentID' INTEGER);
CREATE TABLE 'Patient' ('PatientID' INTEGER,'firstname' TEXT,'lastname' TEXT,'email' TEXT);
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 

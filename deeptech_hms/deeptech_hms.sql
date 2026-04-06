-- Identifying the database to query
USE deeptech_hms_db;

-- Identifying Patients in FCT and Plateau
SELECT * FROM patient_table
WHERE State IN ('Fct Abuja', 'Plateau');

-- Retrieving the total number of male and female patients
SELECT Gender, COUNT(*) AS Total
FROM patient_table
GROUP BY Gender;

-- List of doctors and their specialities in state where confirmed appointment exist
SELECT a.AppointmentID, a.PatientID, a.Date, a.Status, d.DoctorID, d.Name, d.Speciality, d.State
FROM appointment_table a 
JOIN doctor_table d 
ON a.DoctorID = d.DoctorID
WHERE a.Status = 'Confirmed'
GROUP BY a.AppointmentID, a.PatientID, d.DoctorID;

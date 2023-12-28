CREATE TABLE CombinedDataset AS
SELECT
    A.AppointmentID,
    A.Date,
    A.Time,
    P.PatientID AS PatientID,
    P.firstname AS PatientFirstName,
    P.lastname AS PatientLastName,
    P.email AS PatientEmail,
    D.DoctorID AS DoctorID,
    D.DoctorName,
    D.Specialization,
    D.DoctorContact,
    MP.ProcedureID,
    MP.ProcedureName,
    MP.AppointmentID AS MedicalProcedureAppointmentID,
    B.InvoiceID,
    B.Items,
    B.Amount
FROM Appointment A
JOIN Patient P ON A.PatientID = P.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
LEFT JOIN MedicalProcedure MP ON A.AppointmentID = MP.AppointmentID
LEFT JOIN Billing B ON A.PatientID = B.PatientID;

SELECT * FROM CombinedDataset LIMIT 10; 

** Exploratory Data Analysis**

-- View basic statistics for numerical columns
SELECT
    COUNT(*) AS TotalRows,
    AVG(Amount) AS AvgAmount,
    MIN(Amount) AS MinAmount,
    MAX(Amount) AS MaxAmount
FROM CombinedDataset;

-- Check for null values in the dataset
SELECT
    'AppointmentID' AS ColumnName,
    COUNT(*) - COUNT(AppointmentID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'Date' AS ColumnName,
    COUNT(*) - COUNT(Date) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'Time' AS ColumnName,
    COUNT(*) - COUNT(Time) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'PatientID' AS ColumnName,
    COUNT(*) - COUNT(PatientID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'DoctorID' AS ColumnName,
    COUNT(*) - COUNT(DoctorID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'DoctorName' AS ColumnName,
    COUNT(*) - COUNT(DoctorName) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'Specialization' AS ColumnName,
    COUNT(*) - COUNT(Specialization) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'DoctorContact' AS ColumnName,
    COUNT(*) - COUNT(DoctorContact) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'ProcedureID' AS ColumnName,
    COUNT(*) - COUNT(ProcedureID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'ProcedureName' AS ColumnName,
    COUNT(*) - COUNT(ProcedureName) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'MedicalProcedureAppointmentID' AS ColumnName,
    COUNT(*) - COUNT(MedicalProcedureAppointmentID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'InvoiceID' AS ColumnName,
    COUNT(*) - COUNT(InvoiceID) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'Items' AS ColumnName,
    COUNT(*) - COUNT(Items) AS NullCount
FROM CombinedDataset
UNION ALL
SELECT
    'Amount' AS ColumnName,
    COUNT(*) - COUNT(Amount) AS NullCount
FROM CombinedDataset;

-- Update the CombinedDataset table to handle null values

-- Treat null values in Date column by setting it to a default value
UPDATE CombinedDataset
SET Date = '1970-01-01'
WHERE Date IS NULL;

-- Treat null values in Time column by setting it to a default value
UPDATE CombinedDataset
SET Time = '00:00:00'
WHERE Time IS NULL;

-- Treat null values in Specialization column by setting it to 'Unknown'
UPDATE CombinedDataset
SET Specialization = 'Unknown'
WHERE Specialization IS NULL;

-- Treat null values in Amount column by setting it to 0
UPDATE CombinedDataset
SET Amount = 0
WHERE Amount IS NULL;

-- Time series analysis: Number of appointments over time
SELECT
    Date,
    COUNT(*) AS AppointmentsCount
FROM CombinedDataset
GROUP BY Date
ORDER BY Date;

-- Doctor specialization analysis: Count of doctors by specialization
SELECT
    Specialization,
    COUNT(DISTINCT DoctorID) AS DoctorCount
FROM CombinedDataset
GROUP BY Specialization
ORDER BY DoctorCount DESC;

-- Procedure analysis: Count of procedures by type
SELECT
    ProcedureName,
    COUNT(*) AS ProcedureCount
FROM CombinedDataset
GROUP BY ProcedureName
ORDER BY ProcedureCount DESC;

-- Procedure analysis: Count of procedures by type (excluding nulls)
SELECT
    ProcedureName,
    COUNT(*) AS ProcedureCount
FROM CombinedDataset
WHERE ProcedureName IS NOT NULL
GROUP BY ProcedureName
ORDER BY ProcedureCount DESC;

-- Correlation analysis for numerical columns using standard SQL
SELECT
    (COUNT(*) * SUM(AppointmentID * Amount) - SUM(AppointmentID) * SUM(Amount)) /
    SQRT((COUNT(*) * SUM(AppointmentID * AppointmentID) - SUM(AppointmentID) * SUM(AppointmentID)) *
         (COUNT(*) * SUM(Amount * Amount) - SUM(Amount) * SUM(Amount))) AS Correlation_AppointmentID_Amount,
    
    (COUNT(*) * SUM(PatientID * DoctorID) - SUM(PatientID) * SUM(DoctorID)) /
    SQRT((COUNT(*) * SUM(PatientID * PatientID) - SUM(PatientID) * SUM(PatientID)) *
         (COUNT(*) * SUM(DoctorID * DoctorID) - SUM(DoctorID) * SUM(DoctorID))) AS Correlation_PatientID_DoctorID
FROM CombinedDataset;

-- Cross-tabulation: Count of appointments by doctor and procedure
SELECT
    DoctorName,
    ProcedureName,
    COUNT(*) AS AppointmentCount
FROM CombinedDataset
GROUP BY DoctorName, ProcedureName
ORDER BY DoctorName, ProcedureName;

** Data Analysis**

-- Count of appointments by doctor and procedure
SELECT
    DoctorName,
    ProcedureName,
    COUNT(*) AS AppointmentCount
FROM CombinedDataset
GROUP BY DoctorName, ProcedureName
ORDER BY AppointmentCount DESC;

-- Monthly count of appointments in SQLite
SELECT
    strftime('%Y', Date) AS Year,
    strftime('%m', Date) AS Month,
    COUNT(*) AS AppointmentsCount
FROM CombinedDataset
GROUP BY Year, Month
ORDER BY Year, Month;

-- Average amount by doctor specialization
SELECT
    Specialization,
    AVG(Amount) AS AvgAmount
FROM CombinedDataset
GROUP BY Specialization
ORDER BY AvgAmount DESC;

-- Identify high-value patients based on total amount spent
SELECT
    PatientID,
    SUM(Amount) AS TotalAmountSpent
FROM CombinedDataset
GROUP BY PatientID
ORDER BY TotalAmountSpent DESC
LIMIT 10; -- Adjust the limit as needed

-- Rank doctors by the total amount of appointments
WITH DoctorRank AS (
    SELECT
        DoctorID,
        SUM(Amount) AS TotalAmount,
        RANK() OVER (ORDER BY SUM(Amount) DESC) AS Rank
    FROM CombinedDataset
    GROUP BY DoctorID
)
SELECT
    d.DoctorName,
    r.TotalAmount,
    r.Rank
FROM Doctor d
JOIN DoctorRank r ON d.DoctorID = r.DoctorID
ORDER BY r.Rank;

-- Monthly revenue growth in SQLite
WITH MonthlyRevenue AS (
    SELECT
        strftime('%Y', Date) AS Year,
        strftime('%m', Date) AS Month,
        SUM(Amount) AS MonthlyRevenue
    FROM CombinedDataset
    GROUP BY Year, Month
),
LaggedRevenue AS (
    SELECT
        Year,
        Month,
        MonthlyRevenue,
        LAG(MonthlyRevenue) OVER (ORDER BY Year, Month) AS PreviousMonthRevenue
    FROM MonthlyRevenue
)
SELECT
    Year,
    Month,
    MonthlyRevenue,
    COALESCE(MonthlyRevenue - PreviousMonthRevenue, MonthlyRevenue) AS MonthlyRevenueGrowth
FROM LaggedRevenue
ORDER BY Year, Month;

-- Identify patients with high spending trends
WITH PatientSpendingTrend AS (
    SELECT
        PatientID,
        Amount,
        LAG(Amount) OVER (PARTITION BY PatientID ORDER BY Date) AS PreviousAmount
    FROM CombinedDataset
)
SELECT
    PatientID,
    MAX(Amount) AS MaxAmount,
    AVG(Amount) AS AvgAmount,
    MAX(Amount - PreviousAmount) AS MaxIncrease
FROM PatientSpendingTrend
GROUP BY PatientID;

-- Calculate running total for billing
SELECT
    InvoiceID,
    PatientID,
    Items,
    Amount,
    SUM(Amount) OVER (PARTITION BY PatientID ORDER BY InvoiceID) AS RunningTotal
FROM Billing;

-- Find doctors with the most diverse procedures
WITH DoctorProcedureCount AS (
    SELECT
        DoctorID,
        COUNT(DISTINCT ProcedureName) AS ProcedureCount
    FROM CombinedDataset
    GROUP BY DoctorID
)
SELECT
    d.DoctorName,
    p.ProcedureCount
FROM Doctor d
JOIN DoctorProcedureCount p ON d.DoctorID = p.DoctorID
ORDER BY p.ProcedureCount DESC;


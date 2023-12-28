# HealthCare-Management-System
The HealthCare Management System is a comprehensive solution utilizing SQLite and SQL for efficient patient records, appointment scheduling, billing, and medical procedure coordination within healthcare facilities.

**Key Components:**

1. **Patient Records Management:**
   - The system facilitates the organized and secure storage of patient information, including personal details, contact information, and other relevant data. This feature ensures a centralized and easily accessible repository of patient records.

2. **Appointment Scheduling:**
   - Efficient scheduling of appointments between patients and healthcare providers is a crucial aspect of the system. It allows for the systematic arrangement of consultations, examinations, and other medical interactions, optimizing the use of healthcare resources.

3. **Billing Processes:**
   - The system incorporates a billing module to handle financial transactions related to healthcare services. It manages invoicing, tracks payment details, and provides a comprehensive view of financial transactions, contributing to effective financial management within the healthcare facility.

4. **Medical Procedures Coordination:**
   - Coordinating and tracking medical procedures is a vital function of the system. It ensures that information related to medical tests, treatments, and other procedures is properly documented and associated with the corresponding patient records.

**Technological Foundation:**

1. **SQLite Database Management:**
   - SQLite, a lightweight and self-contained relational database management system, is employed as the foundation for data storage and retrieval. Its simplicity and efficiency make it well-suited for applications that require seamless data management.

2. **SQL for Query Processing:**
   - SQL (Structured Query Language) is utilized for querying and processing data within the database. SQL provides a standardized and powerful language for interacting with the database, enabling the retrieval, insertion, updating, and deletion of data.

**Benefits:**

1. **Efficiency:**
   - The system enhances operational efficiency by automating routine tasks, reducing manual errors, and providing quick access to critical information.

2. **Accuracy in Billing:**
   - Accurate billing processes contribute to transparent financial transactions, reducing discrepancies and enhancing the financial management of the healthcare facility.

3. **Improved Patient Care:**
   - With organized patient records and efficient appointment scheduling, healthcare providers can deliver better and more timely care to patients.

4. **Data-Driven Decision-Making:**
   - SQL queries enable the extraction of valuable insights from the database, supporting data-driven decision-making for administrators and healthcare professionals.

### Dataset Description

### 1. Appointment Table:
   - **Attributes:**
     - `AppointmentID` (INTEGER): Unique identifier for each appointment.
     - `Date` (TEXT): Date of the scheduled appointment.
     - `Time` (TEXT): Time of the scheduled appointment.
     - `PatientID` (INTEGER): Foreign key linking to the `Patient` table, representing the patient associated with the appointment.
     - `DoctorID` (INTEGER): Foreign key linking to the `Doctor` table, representing the doctor conducting the appointment.
   - **Relationships:**
     - Many-to-One with the `Patient` table through the `PatientID` foreign key.
     - Many-to-One with the `Doctor` table through the `DoctorID` foreign key.

### 2. Billing Table:
   - **Attributes:**
     - `InvoiceID` (TEXT): Unique identifier for each billing transaction.
     - `PatientID` (INTEGER): Foreign key linking to the `Patient` table, representing the patient associated with the billing.
     - `Items` (TEXT): Description of billed items.
     - `Amount` (INTEGER): Amount associated with the billing transaction.
   - **Relationships:**
     - Many-to-One with the `Patient` table through the `PatientID` foreign key.

### 3. CombinedDataset Table:
   - **Attributes:**
     - `AppointmentID` (INTEGER): Unique identifier for each appointment.
     - `Date` (TEXT): Date of the scheduled appointment.
     - `Time` (TEXT): Time of the scheduled appointment.
     - `PatientID` (INTEGER): Foreign key linking to the `Patient` table, representing the patient associated with the appointment.
     - `PatientFirstName` (TEXT): First name of the patient.
     - `PatientLastName` (TEXT): Last name of the patient.
     - `PatientEmail` (TEXT): Email address of the patient.
     - `DoctorID` (INTEGER): Foreign key linking to the `Doctor` table, representing the doctor conducting the appointment.
     - `DoctorName` (TEXT): Name of the doctor.
     - `Specialization` (TEXT): Specialization area of the doctor.
     - `DoctorContact` (TEXT): Contact details of the doctor.
     - `ProcedureID` (INTEGER): Unique identifier for each medical procedure.
     - `ProcedureName` (TEXT): Name or type of medical procedure.
     - `MedicalProcedureAppointmentID` (INTEGER): Foreign key linking to the `Appointment` table, associating medical procedures with specific appointments.
     - `InvoiceID` (TEXT): Unique identifier for each billing transaction.
     - `Items` (TEXT): Description of billed items.
     - `Amount` (INTEGER): Amount associated with the billing transaction.
   - **Relationships:**
     - Many-to-One with the `Patient` table through the `PatientID` foreign key.
     - Many-to-One with the `Doctor` table through the `DoctorID` foreign key.
     - Many-to-One with the `Appointment` table through the `MedicalProcedureAppointmentID` foreign key.
     - Many-to-One with the `Billing` table through the `InvoiceID` foreign key.

### 4. Doctor Table:
   - **Attributes:**
     - `DoctorID` (INTEGER): Unique identifier for each doctor.
     - `DoctorName` (TEXT): Name of the doctor.
     - `Specialization` (TEXT): Specialization area of the doctor.
     - `DoctorContact` (TEXT): Contact details of the doctor.
   - **Relationships:**
     - One-to-Many with the `Appointment` table through the `DoctorID` foreign key.

### 5. MedicalProcedure Table:
   - **Attributes:**
     - `ProcedureID` (INTEGER): Unique identifier for each medical procedure.
     - `ProcedureName` (TEXT): Name or type of medical procedure.
     - `AppointmentID` (INTEGER): Foreign key linking to the `Appointment` table, associating medical procedures with specific appointments.
   - **Relationships:**
     - Many-to-One with the `Appointment` table through the `AppointmentID` foreign key.

### 6. Patient Table:
   - **Attributes:**
     - `PatientID` (INTEGER): Unique identifier for each patient.
     - `firstname` (TEXT): First name of the patient.
     - `lastname` (TEXT): Last name of the patient.
     - `email` (TEXT): Email address of the patient.
   - **Relationships:**
     - One-to-Many with the `Appointment` table through the `PatientID` foreign key.
     - One-to-Many with the `Billing` table through the `PatientID` foreign key.
  
### Exploratory Data Analysis

The Exploratory Data Analysis (EDA) process conducted on the HealthCare Management System dataset aims to gain insights into the characteristics and patterns within the healthcare data. The analysis involves statistical summaries, handling null values, and exploring relationships among various attributes. Here is an overview of the EDA steps performed:

1. **Basic Statistics:**
   - Calculated basic statistics for numerical columns in the dataset.
   - Provided insights into the total number of records, average amount, minimum amount, and maximum amount.

2. **Null Value Handling:**
   - Checked for null values in key columns.
   - Addressed null values in critical columns by applying appropriate treatments:
     - Set null values in the 'Date' column to a default value ('1970-01-01').
     - Set null values in the 'Time' column to a default value ('00:00:00').
     - Set null values in the 'Specialization' column to 'Unknown'.
     - Set null values in the 'Amount' column to 0.

3. **Time Series Analysis:**
   - Conducted time series analysis to understand the trend in the number of appointments over time.
   - Grouped data by date and counted the appointments for each date.

4. **Doctor Specialization Analysis:**
   - Investigated the distribution of doctors based on their specialization.
   - Counted the number of distinct doctors for each specialization, providing insights into the distribution of medical expertise.

5. **Procedure Analysis:**
   - Analyzed medical procedures, including overall counts and counts by type.
   - Investigated the count of procedures by type, emphasizing the distribution of medical activities.

6. **Correlation Analysis:**
   - Explored correlations between numerical columns using standard SQL calculations.
   - Calculated correlations between 'AppointmentID' and 'Amount,' and between 'PatientID' and 'DoctorID.'

7. **Cross-Tabulation:**
   - Investigated the count of appointments based on the combination of doctor and procedure.
   - Provided a detailed breakdown of appointment counts for each doctor and procedure pair.

The EDA process ensures a comprehensive understanding of the dataset's characteristics and establishes a foundation for further analysis and decision-making within the healthcare management system. These insights are crucial for optimizing operations, enhancing patient care, and improving overall efficiency in a healthcare setting.

### Data Analysis 

The Data Analysis phase of the HealthCare Management System project delves deeper into the combined dataset, extracting actionable insights and providing a foundation for informed decision-making within healthcare operations. The following analyses explore various aspects, ranging from appointment patterns and doctor performance to financial trends and patient spending behavior.

1. **Count of Appointments by Doctor and Procedure:**
   - Identified the most frequently performed procedures by each doctor, offering insights into the distribution of medical services.
   - Facilitated the understanding of the workload and expertise of healthcare professionals.

2. **Monthly Count of Appointments:**
   - Conducted a monthly breakdown of appointment counts, enabling the identification of peak periods and potential resource allocation adjustments.
   - Provides a macro-level overview of appointment trends over time.

3. **Average Amount by Doctor Specialization:**
   - Explored the average billing amount associated with each doctor's specialization.
   - Aids in understanding the financial performance of different medical specializations.

4. **High-Value Patients:**
   - Identified patients with the highest total amount spent on healthcare services.
   - Useful for recognizing and acknowledging patients contributing significantly to the healthcare facility's revenue.

5. **Ranking Doctors by Total Amount of Appointments:**
   - Ranked doctors based on the total amount generated from appointments, showcasing their financial impact on the healthcare facility.
   - Supports strategic decision-making regarding resource allocation and recognition of high-performing doctors.

6. **Monthly Revenue Growth:**
   - Analyzed the growth in monthly revenue over time.
   - Offers insights into financial trends and identifies periods of revenue increase or decline.

7. **Patients with High Spending Trends:**
   - Explored patients with notable spending trends over time.
   - Useful for identifying patients with consistent high spending and tailoring services to their needs.

8. **Running Total for Billing:**
   - Calculated the running total of billing amounts for each patient.
   - Provides a dynamic view of a patient's cumulative spending, aiding in financial management.

9. **Doctors with Diverse Procedures:**
   - Identified doctors with a diverse range of performed medical procedures.
   - Useful for recognizing doctors with versatile skills and adapting healthcare services accordingly.

The data analyses provide valuable insights that can inform operational decisions, enhance patient care strategies, and optimize resource allocation within the healthcare management system. These findings contribute to a data-driven approach, ensuring the effective and efficient functioning of the healthcare facility.

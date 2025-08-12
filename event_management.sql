-- College Event Management System (With Analytics)
-- Author: Your Name
-- Date: 2025-08-12

-- DROP TABLES (if rerunning script)
DROP TABLE IF EXISTS Registrations;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Participants;
DROP TABLE IF EXISTS Venues;
DROP TABLE IF EXISTS Organizers;

-- ======================
-- TABLE CREATION
-- ======================

CREATE TABLE Venues (
    Venue_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Capacity INT NOT NULL CHECK (Capacity >= 0)
);

CREATE TABLE Organizers (
    Organizer_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);

CREATE TABLE Events (
    Event_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Date DATE,
    Time TIME,
    Venue_ID INT,
    Organizer_ID INT,
    Capacity INT NOT NULL CHECK (Capacity >= 0),
    CONSTRAINT fk_events_venue FOREIGN KEY (Venue_ID) REFERENCES Venues(Venue_ID),
    CONSTRAINT fk_events_organizer FOREIGN KEY (Organizer_ID) REFERENCES Organizers(Organizer_ID)
);

CREATE TABLE Participants (
    Participant_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);

CREATE TABLE Registrations (
    Registration_ID INT PRIMARY KEY,
    Event_ID INT NOT NULL,
    Participant_ID INT NOT NULL,
    Registration_Date DATE,
    CONSTRAINT fk_reg_event FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
    CONSTRAINT fk_reg_participant FOREIGN KEY (Participant_ID) REFERENCES Participants(Participant_ID),
    CONSTRAINT uq_unique_registration UNIQUE (Event_ID, Participant_ID)
);

-- ======================
-- SAMPLE DATA
-- ======================

INSERT INTO Venues VALUES
(1, 'Auditorium', 'Main Block', 300),
(2, 'Seminar Hall', 'Block A', 100),
(3, 'Open Ground', 'Sports Complex', 500);

INSERT INTO Organizers VALUES
(1, 'Dr. Anita Sharma', 'CSE', 'anita@college.edu', '9876543210'),
(2, 'Prof. Raj Kumar', 'ECE', 'raj@college.edu', '9876501234');

INSERT INTO Events VALUES
(1, 'Tech Fest', '2025-09-10', '10:00', 1, 1, 300),
(2, 'Robotics Workshop', '2025-09-12', '14:00', 2, 2, 100),
(3, 'Cultural Night', '2025-09-15', '18:00', 3, 1, 500);

INSERT INTO Participants VALUES
(1, 'Amit Verma', 'CSE', 'amit@college.edu', '9988776655'),
(2, 'Priya Singh', 'ECE', 'priya@college.edu', '8877665544'),
(3, 'Rahul Mehta', 'ME', 'rahul@college.edu', '7766554433');

INSERT INTO Registrations VALUES
(1, 1, 1, '2025-08-10'),
(2, 2, 2, '2025-08-11'),
(3, 1, 3, '2025-08-11'),
(4, 3, 1, '2025-08-12');

-- ======================
-- ANALYTICS QUERIES
-- ======================

-- 1. Check seat availability
SELECT e.Name AS Event_Name, (e.Capacity - COUNT(r.Participant_ID)) AS Seats_Left
FROM Events e
LEFT JOIN Registrations r ON e.Event_ID = r.Event_ID
GROUP BY e.Event_ID, e.Name, e.Capacity
ORDER BY e.Name;

-- 2. Most popular event
SELECT e.Name AS Event_Name, COUNT(r.Participant_ID) AS Total_Registrations
FROM Events e
JOIN Registrations r ON e.Event_ID = r.Event_ID
GROUP BY e.Event_ID, e.Name
ORDER BY Total_Registrations DESC
LIMIT 1;

-- 3. Busiest venue
SELECT v.Name AS Venue_Name, COUNT(e.Event_ID) AS Total_Events
FROM Venues v
JOIN Events e ON v.Venue_ID = e.Venue_ID
GROUP BY v.Venue_ID, v.Name
ORDER BY Total_Events DESC
LIMIT 1;

-- 4. Participation trends by department
SELECT p.Department, COUNT(r.Participant_ID) AS Total_Participations
FROM Participants p
JOIN Registrations r ON p.Participant_ID = r.Participant_ID
GROUP BY p.Department
ORDER BY Total_Participations DESC;



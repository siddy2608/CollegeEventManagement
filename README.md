## College Event Management System (With Analytics)

### Project Overview
This project manages and analyzes college events, participants, organizers, and venues.
In addition to CRUD-ready schema, it includes analytics queries for:
- Most popular events
- Busiest venues
- Participation trends by department
- Seat availability checks

This repository focuses on the SQL database design and queries. It can be plugged into any web/app backend.

### Tech Stack
- Database: MySQL (works with PostgreSQL/SQLite with small tweaks)
- SQL features: joins, grouping/aggregates, constraints, foreign keys
- Optional tools: [dbdiagram.io](https://dbdiagram.io), MySQL Workbench

### Project Structure
```
CollegeEventManagement/
├─ README.md                 # Project documentation
├─ event_management.sql      # SQL schema, sample data, analytics queries
└─ ERD.dbdiagram.txt         # ER model in dbdiagram DSL (import into dbdiagram.io)
```

### ER Diagram (Concept)
Entities:
- Venues(Venue_ID, Name, Location, Capacity)
- Organizers(Organizer_ID, Name, Department, Email, Phone)
- Events(Event_ID, Name, Date, Time, Venue_ID, Organizer_ID, Capacity)
- Participants(Participant_ID, Name, Department, Email, Phone)
- Registrations(Registration_ID, Event_ID, Participant_ID, Registration_Date)

Relationships:
- One venue → many events
- One organizer → many events
- Many participants ↔ many events (via Registrations)

See `ERD.dbdiagram.txt` for an importable diagram definition.

### How to Run
1. Open `event_management.sql` in MySQL Workbench or your SQL client.
2. Execute the script. It creates tables, inserts sample data, and includes analytics queries at the end.
3. Tweak, extend, or integrate into your application.

### Example Analytics Output
Most Popular Event

| Event Name | Total Registrations |
|------------|---------------------|
| Tech Fest  | 150                 |

Seats Left

| Event Name        | Seats_Left |
|-------------------|------------|
| Robotics Workshop | 25         |

### Author
Your Name — Final Year B.Tech Student



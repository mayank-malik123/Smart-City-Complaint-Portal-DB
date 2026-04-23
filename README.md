# 🏙️ Smart City Complaint Portal (Database Project)

##  Overview
The Smart City Complaint Portal is a database-driven system designed to manage and resolve citizen complaints efficiently in a smart city environment.

This project focuses on building a **normalized relational database** with real-world features such as complaint tracking, escalation, notifications, and feedback.

---

##  Objectives
- Centralized complaint management system  
- Efficient department-based issue handling  
- Track complaint lifecycle (Pending → Resolved)  
- Improve transparency and accountability  
- Enable citizen feedback  

---

##  Features

###  Core Features
- Complaint registration  
- User (citizen) management  
- Admin/staff management  
- Department-based routing  

###  Intermediate Features
- Complaint status tracking (history)  
- Priority handling system  
- Area/location-based complaints  
- Media upload (images/videos)  

###  Advanced Features 
- SLA (Service Level Agreement) tracking  
- Escalation system  
- Notification system  
- Feedback and rating  
- OTP verification  
- Audit logs  
- Announcements  
- Geo-location (latitude/longitude)  

---

###  Main Tables
- user  
- admin  
- department  
- area  
- category  
- complaint  

###  Supporting Tables
- complaint_history  
- feedback  
- notification  
- complaint_media  
- escalation  
- sla  
- audit_log  
- otp_verification  
- announcement  

---

##  Relationships
- One user → many complaints  
- One complaint → one department, category, area  
- One complaint → many history records  
- One complaint → assigned to one admin  
- One complaint → can have feedback, media, escalation  

---

##  Technologies Used
- MySQL / MariaDB  
- SQL  
- MySQL Workbench / phpMyAdmin  

---

##  How to Run

###  Option 1: MySQL Workbench (Recommended)
1. Install MySQL and MySQL Workbench  
2. Open MySQL Workbench  
3. Connect to local server  
4. Open SQL file:
   - File → Open SQL Script  
5. Click Execute (⚡)  

---

###  Option 2: Command Line
```bash
mysql -u root -p < smart_city.sql

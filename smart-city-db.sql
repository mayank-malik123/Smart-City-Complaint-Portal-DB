-- =========================================
-- SMART CITY COMPLAINT PORTAL DATABASE
-- =========================================

DROP DATABASE IF EXISTS smart_city_db;
CREATE DATABASE smart_city_db;
USE smart_city_db;

-- =========================================
-- 1. DEPARTMENT TABLE
-- =========================================
CREATE TABLE department (
  dept_id INT AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(100),
  description TEXT,
  contact_email VARCHAR(100),
  contact_phone VARCHAR(15)
);

-- =========================================
-- 2. AREA TABLE
-- =========================================
CREATE TABLE area (
  area_id INT AUTO_INCREMENT PRIMARY KEY,
  area_name VARCHAR(100),
  city VARCHAR(100),
  pincode VARCHAR(10)
);

-- =========================================
-- 3. USER TABLE (CITIZENS)
-- =========================================
CREATE TABLE user (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100),
  phone_number VARCHAR(15),
  email VARCHAR(100) UNIQUE,
  address TEXT,
  password VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- 4. ADMIN TABLE
-- =========================================
CREATE TABLE admin (
  admin_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(100) NOT NULL,
  role ENUM('SuperAdmin','DepartmentAdmin','Staff') DEFAULT 'Staff',
  dept_id INT,
  email VARCHAR(100),
  last_login DATETIME,

  CONSTRAINT fk_admin_dept
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

-- =========================================
-- 5. COMPLAINT TABLE
-- =========================================
CREATE TABLE complaint (
  complaint_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  dept_id INT,
  area_id INT,

  title VARCHAR(200),
  description TEXT,
  image_url VARCHAR(255),

  status ENUM('Pending','In Progress','Resolved','Rejected') DEFAULT 'Pending',
  priority ENUM('Low','Medium','High') DEFAULT 'Medium',

  assigned_to INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME,

  CONSTRAINT fk_complaint_user
  FOREIGN KEY (user_id) REFERENCES user(user_id),

  CONSTRAINT fk_complaint_dept
  FOREIGN KEY (dept_id) REFERENCES department(dept_id),

  CONSTRAINT fk_complaint_area
  FOREIGN KEY (area_id) REFERENCES area(area_id),

  CONSTRAINT fk_complaint_admin
  FOREIGN KEY (assigned_to) REFERENCES admin(admin_id)
);

-- =========================================
-- 6. COMPLAINT HISTORY (STATUS TRACKING)
-- =========================================
CREATE TABLE complaint_history (
  history_id INT AUTO_INCREMENT PRIMARY KEY,
  complaint_id INT,
  status VARCHAR(20),
  updated_by INT,
  remarks TEXT,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_history_complaint
  FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id),

  CONSTRAINT fk_history_admin
  FOREIGN KEY (updated_by) REFERENCES admin(admin_id)
);

-- =========================================
-- 7. FEEDBACK TABLE
-- =========================================
CREATE TABLE feedback (
  feedback_id INT AUTO_INCREMENT PRIMARY KEY,
  complaint_id INT,
  user_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comments TEXT,
  feedback_date DATE,

  CONSTRAINT fk_feedback_complaint
  FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id),

  CONSTRAINT fk_feedback_user
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- =========================================
-- 8. NOTIFICATION TABLE
-- =========================================
CREATE TABLE notification (
  notification_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_notification_user
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- =========================================
-- 9. COMPLAINT MEDIA TABLE
-- =========================================
CREATE TABLE complaint_media (
  media_id INT AUTO_INCREMENT PRIMARY KEY,
  complaint_id INT,
  file_url VARCHAR(255),
  file_type VARCHAR(50),

  CONSTRAINT fk_media_complaint
  FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id)
);

-- =========================================
-- 10. ESCALATION TABLE
-- =========================================
CREATE TABLE escalation (
  escalation_id INT AUTO_INCREMENT PRIMARY KEY,
  complaint_id INT,
  escalated_to INT,
  reason TEXT,
  escalated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_escalation_complaint
  FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id),

  CONSTRAINT fk_escalation_admin
  FOREIGN KEY (escalated_to) REFERENCES admin(admin_id)
);

-- =========================================
-- SAMPLE DATA (FOR DEMO/VIVA)
-- =========================================

-- Departments
INSERT INTO department (dept_name, description) VALUES
('Water Supply','Water related issues'),
('Electricity','Power related issues'),
('Road Maintenance','Road and potholes'),
('Garbage Collection','Waste management');

-- Areas
INSERT INTO area (area_name, city, pincode) VALUES
('Sector 10','Delhi','110001'),
('Sector 15','Delhi','110002');

-- Users
INSERT INTO user (full_name, phone_number, email, address, password) VALUES
('Mayank Malik','9999999999','mayank@gmail.com','Delhi','1234');

-- Admins
INSERT INTO admin (username, password, role, dept_id, email) VALUES
('admin1','pass123','SuperAdmin',1,'admin@gmail.com'),
('staff1','pass123','Staff',3,'staff@gmail.com');

-- Complaint
INSERT INTO complaint (user_id, dept_id, area_id, title, description, location, priority)
VALUES (1, 3, 1, 'Potholes on Road', 'Large potholes causing traffic issues', 'Sector 10', 'High');

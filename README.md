# ⚡ Electricity Billing System

An end-to-end web-based electricity billing management system built using **JSP**, **Servlets**, **JDBC**, and **MySQL**. This project automates the processes of user registration, meter info management, bill calculation, and payment tracking in a utility company.

---

## 🔧 Tech Stack

- **Frontend**: HTML, CSS, JSP (Java Server Pages), Swing (for Admin UI)
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL
- **Server**: Apache Tomcat 11
- **IDE**: NetBeans 25

---

## ✨ Features

- 👥 **User Authentication** (Admin & Customer login)
- 📥 **Customer Registration**
- ⚙️ **Meter Information Management**
- 📄 **Bill Calculation & Generation**
- 💸 **Bill Payment Tracking**
- 📝 **Update Profile Information**
- 📊 **Admin Panel** for managing all records

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

git clone https://github.com/CK-InLoop/Electricity_Billing_System.git

### 2. Configure MySQL
Create a database named ebs

Run the SQL script provided (ebs.sql) to create required tables

### 3. Update Database Credentials
In Conn.java, update:

c = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebs", "root", "your_password");

### 4. Deploy on Tomcat
Build the project in NetBeans

Deploy the generated .war file from /dist to your tomcat/webapps/ folder

Start the Tomcat server

### 5. Access the Application
http://localhost:8080/Electricity_Billing_System/

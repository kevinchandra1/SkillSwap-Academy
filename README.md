# 🎓 SkillSwap Academy – Web-Based Learning Platform

![ASP.NET](https://img.shields.io/badge/ASP.NET-WebForms-blue)
![C#](https://img.shields.io/badge/C%23-.NET-purple)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Database-red)
![HTML5](https://img.shields.io/badge/HTML5-Frontend-orange)
![CSS3](https://img.shields.io/badge/CSS3-Styling-blue)
![JavaScript](https://img.shields.io/badge/JavaScript-ES6-yellow)
![License](https://img.shields.io/badge/License-MIT-green)

A modern educational web application developed using **ASP.NET Web Forms**, **C#**, and **Microsoft SQL Server**. SkillSwap Academy provides an interactive platform where users can discover, upload, and manage educational resources, while administrators oversee platform content through a secure management dashboard.

---

# 📌 Project Overview

SkillSwap Academy is a full-stack educational web application developed as a university software engineering project. The platform is designed to encourage knowledge sharing by allowing users to browse learning materials, upload educational resources, interact with other users, and organize content efficiently.

The project demonstrates the implementation of modern web application development using ASP.NET Web Forms, relational database management with Microsoft SQL Server, and software engineering best practices.

---

# ✨ Key Features

## 👨‍🎓 User Features

- User registration and secure login
- User profile management
- Browse learning resources
- Search educational resources
- Explore resource categories
- Upload learning resources
- Save favorite resources (Bookmarks)
- View detailed resource information
- Submit comments and reviews
- Responsive and user-friendly interface

---

## 👨‍💼 Administrator Features

- Administrator dashboard
- Category management
- Learning resource management
- Create, update, and delete educational resources
- Manage platform content
- Database-driven CRUD operations

---

# 🏗 System Architecture

The application follows a layered architecture.

```
Presentation Layer
│
├── ASP.NET Web Forms
│
Business Logic Layer
│
├── C#
│
Data Access Layer
│
├── ADO.NET
│
Database Layer
│
└── Microsoft SQL Server
```

---

# 💻 Technology Stack

## Backend

- ASP.NET Web Forms
- C#
- ADO.NET

## Frontend

- HTML5
- CSS3
- JavaScript

## Database

- Microsoft SQL Server
- SQL Server Express

## Development Tools

- Visual Studio 2022
- SQL Server Management Studio (SSMS)
- IIS Express

---

# 📂 Project Structure

```
SkillSwap-Academy
│
├── Assignment/
│
├── Assignment.sln
│
├── README.md
│
├── LICENSE
│
└── .gitignore
```

---

# 🗄 Database

Microsoft SQL Server is used as the backend database to manage application data.

The database stores:

- User Accounts
- User Profiles
- Learning Resources
- Resource Categories
- Comments
- Bookmarks
- Course Information

Database connectivity is implemented using **ADO.NET** through the application's configuration file.

---

# 📋 Functionalities

The current implementation includes:

- User authentication
- User registration
- Session management
- User profile management
- Learning resource management
- Category management
- Search functionality
- Upload learning resources
- Favorite (Bookmark) system
- Comment and review system
- Administrator dashboard
- CRUD operations
- SQL Server integration
- Responsive web interface

---

# 🚀 Getting Started

## Prerequisites

Before running the project, ensure the following software is installed:

- Visual Studio 2022
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- .NET Framework
- IIS Express

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/kevinchandra1/SkillSwap-Academy.git
```

---

### 2. Open the solution

Open:

```
Assignment.sln
```

using Visual Studio.

---

### 3. Configure the database

- Create the SQL Server database.
- Import the provided SQL script.
- Verify the database tables are created successfully.

---

### 4. Configure the connection string

Update the database connection string inside:

```
Web.config
```

Example:

```xml
<connectionStrings>
    <add name="LearnHubConn"
         connectionString="Data Source=.\SQLEXPRESS;
         Initial Catalog=LearnHubDB;
         Integrated Security=True"
         providerName="System.Data.SqlClient"/>
</connectionStrings>
```

---

### 5. Run the application

Press

```
F5
```

or start the project using **IIS Express**.

---

# 🎯 Learning Outcomes

This project demonstrates practical experience in:

- Full-Stack Web Development
- ASP.NET Web Forms
- C# Programming
- Microsoft SQL Server
- Database Design
- CRUD Operations
- User Authentication
- Session Management
- ADO.NET
- Object-Oriented Programming
- Software Engineering
- Responsive Web Design

---

# 📈 Future Improvements

Potential enhancements include:

- Email verification
- Password recovery
- Role-based authorization
- Notification system
- Dashboard analytics
- REST API integration
- Cloud deployment (Azure)
- Mobile application
- Multi-language support
- AI-powered learning resource recommendations

---

# 📚 Skills Demonstrated

This project highlights experience in:

- Full-Stack Web Development
- ASP.NET Web Forms
- C#
- ADO.NET
- SQL Server
- Relational Database Design
- CRUD Development
- Frontend Development
- Backend Development
- User Authentication
- Session Management
- Software Engineering
- Responsive UI Design

---

# 📄 License

This project is licensed under the **MIT License**.

See the LICENSE file for more information.

---

# 👨‍💻 Author

## Kevin Chandra

Computer Science Undergraduate

Specialising in Data Analytics

Asia Pacific University of Technology & Innovation (APU)

GitHub:

https://github.com/kevinchandra1

---

⭐ If you find this project useful, consider giving it a **Star** on GitHub!

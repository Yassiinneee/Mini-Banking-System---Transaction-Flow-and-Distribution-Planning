<div align="center">

# 💳 Mini Banking System
### Transaction Flow, Concurrency Control & Distributed Database Planning

A professional Node.js and MySQL project that demonstrates secure banking transactions using **ACID transactions**, **pessimistic locking**, and **distributed database design concepts**.

![Node.js](https://img.shields.io/badge/Node.js-20+-339933?style=for-the-badge&logo=node.js&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Database-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

</div>

---

# 📖 Overview

This project simulates a **banking management system** where customers can transfer money between accounts while preserving data consistency through **database transactions**.

The project also includes a theoretical study of:

- Database concurrency problems
- Locking mechanisms
- Pessimistic locking
- Serializable transaction schedules
- Distributed database planning using fragmentation and replication

The implementation combines practical SQL transaction management with database design principles commonly used in real banking systems.

---

# ✨ Features

- Display all customers
- Display all bank accounts
- Secure money transfers
- Transaction management using MySQL
- Pessimistic row locking (`FOR UPDATE`)
- Automatic rollback on failure
- Transaction history storage
- Distributed database planning documentation
- Clean modular Node.js architecture

---

# 🏗️ Project Structure

```
Mini-Banking-System/
│
├── config/
│   └── db.js                     # MySQL connection pool
│
├── services/
│   └── bankingService.js         # Banking business logic
│
├── Screenshots/
│   ├── appbanking-execution.png
│   ├── banking-sys-diagram.png
│   ├── DB-concepteur.png
│   ├── DB-structure.png
│   └── SQL-execution.png
│
├── BankingDB.sql                 # Complete database schema
├── BankingDB.txt                 # Concurrency & distributed database answers
├── app.js                        # Application entry point
├── package.json
├── package-lock.json
└── README.md
```

---

# 🛠 Technologies Used

| Technology | Purpose |
|------------|---------|
| Node.js | Application runtime |
| MySQL | Relational Database |
| mysql2 | MySQL driver |
| dotenv | Environment configuration |
| SQL Transactions | Atomic banking operations |
| Pessimistic Locking | Prevent concurrent update conflicts |

---

# ⚙️ Installation

## 1. Clone the repository

```bash
git clone https://github.com/yourusername/mini-banking-system.git

cd mini-banking-system
```

---

## 2. Install dependencies

```bash
npm install
```

---

## 3. Configure MySQL

Create a MySQL database.

Example:

```sql
CREATE DATABASE BankingDB;
```

Import the SQL script:

```bash
BankingDB.sql
```

or using MySQL command line:

```bash
mysql -u root -p BankingDB < BankingDB.sql
```

---

## 4. Configure database connection

Update:

```
config/db.js
```

with your MySQL credentials.

Example:

```javascript
host: "localhost",
user: "root",
password: "",
database: "BankingDB"
```

---

# ▶️ Running the Application

Start the application:

```bash
npm start
```

or

```bash
node app.js
```

---

# 💰 Banking Workflow

The application performs the following steps:

1. Connects to MySQL
2. Retrieves all customers
3. Displays account balances
4. Starts a database transaction
5. Locks sender account
6. Locks receiver account
7. Withdraws money
8. Deposits money
9. Saves transaction history
10. Commits the transaction
11. Displays updated balances

If any error occurs:

- Transaction is rolled back
- No partial updates are saved
- Database consistency is preserved

---

# 🔒 Concurrency Control

The banking system prevents simultaneous updates by using:

```sql
SELECT ...
FOR UPDATE
```

This applies an **exclusive lock** to the selected rows until the transaction completes.

Benefits include:

- Prevents lost updates
- Prevents dirty writes
- Ensures consistency
- Maintains ACID properties
- Guarantees safe money transfers

---

# 🔄 Transaction Flow

```
Begin Transaction
        │
        ▼
Lock Sender Account
        │
        ▼
Lock Receiver Account
        │
        ▼
Validate Balance
        │
        ▼
Withdraw Funds
        │
        ▼
Deposit Funds
        │
        ▼
Insert Transaction Record
        │
        ▼
Commit
```

If an error occurs:

```
Rollback
```

---

# 🌍 Distributed Database Planning

The project documentation also discusses distributed database concepts including:

### Horizontal Fragmentation

Customer records are distributed based on bank branch locations.

Example:

- Tunis
- Sousse
- Sfax

Each branch stores only its local customers.

---

### Replication

The **Accounts** table is replicated across branches to improve:

- Availability
- Fault tolerance
- Disaster recovery
- Read performance

---

# 📂 Important Files

## BankingDB.sql

Contains the complete database including:

- Customers
- Accounts
- Transactions
- Sample data
- Constraints
- Relationships

---

## BankingDB.txt

Contains the theoretical checkpoint answers covering:

- Lost Update problem
- Shared and Exclusive Locks
- Pessimistic Locking
- Serializable schedules
- Horizontal Fragmentation
- Replication strategy

---

# 📸 Screenshots

The project includes screenshots demonstrating:

- Database schema
- ER diagram
- SQL execution
- Application execution
- System architecture

Located inside:

```
Screenshots/
```

---

# 📚 Learning Objectives

This project demonstrates practical understanding of:

- SQL Transactions
- ACID Properties
- MySQL Locking
- Database Concurrency Control
- Distributed Databases
- Node.js Database Integration
- Service Layer Architecture
- Transaction Management

---

# 🚀 Future Improvements

Possible enhancements include:

- User authentication
- REST API using Express.js
- Account creation and management
- Deposit and withdrawal operations
- Transaction history endpoint
- Balance inquiry API
- Logging system
- Unit and integration testing
- Docker support
- Web-based frontend

---

# 👨‍💻 Author

**Yassine Kalthoum**

Database & Backend Development Project

---

# 📄 License

This project is intended for educational purposes.

Feel free to modify and extend it for learning or academic use.

---

<div align="center">

**⭐ If you found this project helpful, consider giving it a star! ⭐**

</div>

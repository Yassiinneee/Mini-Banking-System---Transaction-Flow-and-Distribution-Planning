/*
=========================================================
              BANKING MANAGEMENT SYSTEM
=========================================================

Author      : Yassine Kalthoum
Database    : BankingDB
DBMS        : MySQL 8.x

Description:
This script creates a simple banking database for
demonstrating:

1. Customers
2. Customer Login (Vertical Fragmentation)
3. Accounts
4. Transactions
5. Horizontal Fragmentation (Views)
6. Sample Data
7. Indexes
8. Example Queries

=========================================================
*/

-- =====================================================
-- Create Database
-- =====================================================

DROP DATABASE IF EXISTS BankingDB;

CREATE DATABASE BankingDB;

USE BankingDB;

-- =====================================================
-- Customers
-- =====================================================

CREATE TABLE Customers (

    customer_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    phone VARCHAR(20),

    address VARCHAR(100),

    branch ENUM('Tunis','Sousse','Sfax') NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- =====================================================
-- Customer Login
-- (Vertical Fragmentation)
-- =====================================================

CREATE TABLE Customer_Login (

    login_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id INT NOT NULL,

    email VARCHAR(100) NOT NULL UNIQUE,

    username VARCHAR(50) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
        ON DELETE CASCADE

);

-- =====================================================
-- Accounts
-- =====================================================

CREATE TABLE Accounts (

    account_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id INT NOT NULL,

    account_number VARCHAR(20) UNIQUE NOT NULL,

    account_type ENUM('Savings','Checking') NOT NULL,

    balance DECIMAL(12,2) NOT NULL DEFAULT 0,

    status ENUM('Active','Closed')
        DEFAULT 'Active',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)

);

-- =====================================================
-- Transactions
-- =====================================================

CREATE TABLE Transactions (

    transaction_id INT AUTO_INCREMENT PRIMARY KEY,

    sender_account INT,

    receiver_account INT,

    amount DECIMAL(12,2) NOT NULL,

    transaction_type ENUM
    (
        'Deposit',
        'Withdrawal',
        'Transfer'
    ) NOT NULL,

    transaction_date TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (sender_account)
        REFERENCES Accounts(account_id),

    FOREIGN KEY (receiver_account)
        REFERENCES Accounts(account_id)

);

-- =====================================================
-- Sample Customers
-- =====================================================

INSERT INTO Customers
(first_name,last_name,phone,address,branch)

VALUES

('Ahmed','Ben Ali','22110011','Tunis','Tunis'),

('Sara','Trabelsi','22334455','Sousse','Sousse'),

('Mohamed','Gharbi','22998877','Sfax','Sfax');

-- =====================================================
-- Customer Login Data
-- =====================================================

INSERT INTO Customer_Login
(customer_id,email,username,password_hash)

VALUES

(1,'ahmed@bank.com','ahmed01','password123'),

(2,'sara@bank.com','sara01','password123'),

(3,'mohamed@bank.com','mohamed01','password123');

-- =====================================================
-- Accounts
-- =====================================================

INSERT INTO Accounts
(customer_id,account_number,account_type,balance)

VALUES

(1,'ACC1001','Savings',5000.00),

(2,'ACC1002','Checking',3500.00),

(3,'ACC1003','Savings',6200.00);

-- =====================================================
-- Transactions
-- =====================================================

INSERT INTO Transactions
(sender_account,receiver_account,amount,transaction_type)

VALUES

(1,2,500,'Transfer'),

(NULL,3,1000,'Deposit'),

(2,NULL,300,'Withdrawal');

-- =====================================================
-- Horizontal Fragmentation
-- Views
-- =====================================================

CREATE VIEW Customers_Tunis AS

SELECT *
FROM Customers
WHERE branch = 'Tunis';

CREATE VIEW Customers_Sousse AS

SELECT *
FROM Customers
WHERE branch = 'Sousse';

CREATE VIEW Customers_Sfax AS

SELECT *
FROM Customers
WHERE branch = 'Sfax';

-- =====================================================
-- Indexes
-- =====================================================

CREATE INDEX idx_customer_branch
ON Customers(branch);

CREATE INDEX idx_account_number
ON Accounts(account_number);

CREATE INDEX idx_transaction_date
ON Transactions(transaction_date);

-- =====================================================
-- Example Queries
-- =====================================================

-- View all customers
SELECT * FROM Customers;

-- View login information
SELECT * FROM Customer_Login;

-- View all accounts
SELECT * FROM Accounts;

-- View all transactions
SELECT * FROM Transactions;

-- Customers by branch
SELECT * FROM Customers_Tunis;

SELECT * FROM Customers_Sousse;

SELECT * FROM Customers_Sfax;

-- Customer account summary
SELECT

    c.customer_id,

    CONCAT(c.first_name,' ',c.last_name) AS customer_name,

    c.branch,

    a.account_number,

    a.account_type,

    a.balance

FROM Customers c

JOIN Accounts a
ON c.customer_id = a.customer_id;

-- Total balance by branch
SELECT

    c.branch,

    SUM(a.balance) AS total_balance

FROM Customers c

JOIN Accounts a
ON c.customer_id = a.customer_id

GROUP BY c.branch;

-- Transaction history with account numbers
SELECT

    t.transaction_id,

    sender.account_number AS sender,

    receiver.account_number AS receiver,

    t.amount,

    t.transaction_type,

    t.transaction_date

FROM Transactions t

LEFT JOIN Accounts sender
ON t.sender_account = sender.account_id

LEFT JOIN Accounts receiver
ON t.receiver_account = receiver.account_id;

-- =====================================================
-- End of Script
-- =====================================================
-- BANKING MANAGEMENT SYSTEM - BEGINNER MYSQL MINI PROJECT
-- Compatible with MySQL 8.0+
-- Run this script in MySQL Workbench or another MySQL client.

CREATE DATABASE IF NOT EXISTS BankingSystem;
USE BankingSystem;

-- 1. Create tables
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50),
    date_of_birth DATE
);

CREATE TABLE IF NOT EXISTS Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(60),
    salary DECIMAL(10,2),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE IF NOT EXISTS Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(30) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    branch_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_amount DECIMAL(12,2) NOT NULL,
    transaction_type VARCHAR(10) NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE IF NOT EXISTS Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 2. Insert sample data
-- Delete these sample rows first if you need to re-run the INSERT statements:
-- DELETE FROM Transactions; DELETE FROM Loans; DELETE FROM Accounts;
-- DELETE FROM Employees; DELETE FROM Branches; DELETE FROM Customers;

INSERT IGNORE INTO Customers
(customer_id, customer_name, phone, email, city, date_of_birth) VALUES
(1, 'Ananya Rao', '9876501001', 'ananya@example.com', 'Hyderabad', '2000-05-14'),
(2, 'Rahul Kumar', '9876501002', 'rahul@example.com', 'Vijayawada', '1997-11-20'),
(3, 'Sana Ali', '9876501003', 'sana@example.com', 'Hyderabad', '2001-02-08'),
(4, 'Kiran Reddy', '9876501004', 'kiran@example.com', 'Visakhapatnam', '1995-08-30'),
(5, 'Meera Das', '9876501005', 'meera@example.com', 'Chennai', '1999-12-03');

INSERT IGNORE INTO Branches (branch_id, branch_name, location) VALUES
(1, 'Central Branch', 'Hyderabad'),
(2, 'Coastal Branch', 'Visakhapatnam'),
(3, 'City Branch', 'Vijayawada');

INSERT IGNORE INTO Employees
(employee_id, employee_name, designation, salary, branch_id) VALUES
(1, 'Priya Sharma', 'Branch Manager', 65000, 1),
(2, 'Arjun Varma', 'Cashier', 35000, 1),
(3, 'Nisha Patel', 'Loan Officer', 48000, 2),
(4, 'Vikram Singh', 'Accountant', 42000, 3);

INSERT IGNORE INTO Accounts
(account_id, customer_id, account_type, balance, branch_id) VALUES
(1001, 1, 'Savings', 75000, 1),
(1002, 2, 'Current', 120000, 3),
(1003, 3, 'Savings', 45000, 1),
(1004, 4, 'Fixed Deposit', 200000, 2),
(1005, 5, 'Savings', 90000, 2),
(1006, 1, 'Current', 25000, 1);

INSERT IGNORE INTO Transactions
(transaction_id, account_id, transaction_amount, transaction_type, transaction_date) VALUES
(5001, 1001, 10000, 'credit', '2026-01-10'),
(5002, 1001, 2500, 'debit',  '2026-01-12'),
(5003, 1002, 20000, 'credit', '2026-02-02'),
(5004, 1003, 1500, 'debit',  '2026-02-05'),
(5005, 1004, 50000, 'credit', '2026-02-10'),
(5006, 1005, 8000, 'credit', '2026-03-01'),
(5007, 1006, 3000, 'debit',  '2026-03-03'),
(5008, 1002, 4000, 'debit',  '2026-03-08');

INSERT IGNORE INTO Loans
(loan_id, customer_id, loan_type, loan_amount, interest_rate) VALUES
(7001, 1, 'Home Loan', 800000, 8.25),
(7002, 2, 'Vehicle Loan', 300000, 9.10),
(7003, 3, 'Education Loan', 250000, 7.50),
(7004, 5, 'Personal Loan', 150000, 11.00);

-- 3. REQUIRED QUERIES FROM YOUR DOCUMENT (20)

-- Q1. Display all records from Customers.
SELECT * FROM Customers;

-- Q2. Display customer name, phone and email.
SELECT customer_name, phone, email FROM Customers;

-- Q3. Display customers from Hyderabad.
SELECT * FROM Customers WHERE city = 'Hyderabad';

-- Q4. Display Savings accounts.
SELECT * FROM Accounts WHERE account_type = 'Savings';

-- Q5. Accounts with balance greater than ₹50,000.
SELECT * FROM Accounts WHERE balance > 50000;

-- Q6. All credit transactions.
SELECT * FROM Transactions WHERE transaction_type = 'credit';

-- Q7. Employees earning more than ₹40,000.
SELECT * FROM Employees WHERE salary > 40000;

-- Q8. Customers born after 1998-01-01.
SELECT * FROM Customers WHERE date_of_birth > '1998-01-01';

-- Q9. Accounts sorted by balance from highest to lowest.
SELECT * FROM Accounts ORDER BY balance DESC;

-- Q10. Total number of customers.
SELECT COUNT(*) AS total_customers FROM Customers;

-- Q11. Total balance across all accounts.
SELECT SUM(balance) AS total_account_balance FROM Accounts;

-- Q12. Average account balance.
SELECT AVG(balance) AS average_account_balance FROM Accounts;

-- Q13. Highest and lowest account balance.
SELECT MAX(balance) AS highest_balance, MIN(balance) AS lowest_balance
FROM Accounts;

-- Q14. Number of accounts for each account type.
SELECT account_type, COUNT(*) AS number_of_accounts
FROM Accounts
GROUP BY account_type;

-- Q15. Account types whose combined balance is greater than ₹80,000.
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type
HAVING SUM(balance) > 80000;

-- Q16. Customer name, account ID, account type and balance.
SELECT c.customer_name, a.account_id, a.account_type, a.balance
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id;

-- Q17. Customer name and transaction details.
SELECT c.customer_name, t.transaction_id, t.transaction_amount, t.transaction_type
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
INNER JOIN Transactions t ON a.account_id = t.account_id;

-- Q18. Customer name and loan details.
SELECT c.customer_name, l.loan_type, l.loan_amount, l.interest_rate
FROM Customers c
INNER JOIN Loans l ON c.customer_id = l.customer_id;

-- Q19. Employee name, designation, branch name and location.
SELECT e.employee_name, e.designation, b.branch_name, b.location
FROM Employees e
INNER JOIN Branches b ON e.branch_id = b.branch_id;

-- Q20. Customers whose account balance is greater than the average balance.
SELECT c.customer_name, a.account_id, a.balance
FROM Customers c
INNER JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (SELECT AVG(balance) FROM Accounts);

-- END OF BANKING MANAGEMENT SYSTEM PROJECT

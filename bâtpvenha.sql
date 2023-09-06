
CREATE DATABASE btvn1;
GO

USE btvn1;


CREATE TABLE booksold (
      booksoldid INT IDENTITY(1,1) PRIMARY KEY,
    customerid INT,
    bookcode INT,
    sale_date DATETIME,
    price INT,
    amount INT
);
INSERT INTO booksold (customerid, bookcode, sale_date, price, amount)
VALUES
    (1, 101, '2023-09-06 10:00:00', 20, 2),
    (2, 102, '2023-09-06 10:15:00', 25, 1),
    (3, 103, '2023-09-06 10:30:00', 30, 3),
    (4, 104, '2023-09-06 10:45:00', 15, 5),
    (5, 105, '2023-09-06 11:00:00', 18, 2),
    (6, 106, '2023-09-06 11:15:00', 22, 1),
    (7, 107, '2023-09-06 11:30:00', 28, 4),
    (8, 108, '2023-09-06 11:45:00', 32, 2),
    (9, 109, '2023-09-06 12:00:00', 10, 6),
    (10, 110, '2023-09-06 12:15:00', 24, 3);

CREATE TABLE BOOK (
    BookCode INT PRIMARY KEY,
    Category VARCHAR(50),
    Author VARCHAR(50),
    Publisher VARCHAR(50),
    Title VARCHAR(100),
    Price INT,
    InStore INT
);

INSERT INTO BOOK (BookCode, Category, Author, Publisher, Title, Price, InStore)
VALUES
    (101, 'Fiction', 'Author A', 'Publisher X', 'Book 1', 20, 10),
    (102, 'Non-Fiction', 'Author B', 'Publisher Y', 'Book 2', 25, 15),
    (103, 'Science', 'Author C', 'Publisher Z', 'Book 3', 30, 20),
    (104, 'Mystery', 'Author D', 'Publisher W', 'Book 4', 15, 5),
    (105, 'Romance', 'Author E', 'Publisher V', 'Book 5', 18, 12);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(12)
);


INSERT INTO Customers (CustomerID, CustomerName, Address, Phone)
VALUES
    (1, 'Customer A', '123 Main Street', '123-456-7890'),
    (2, 'Customer B', '456 Elm Street', '987-654-3210'),
    (3, 'Customer C', '789 Oak Street', '555-555-5555'),
    (4, 'Customer D', '321 Pine Street', '111-222-3333'),
    (5, 'Customer E', '654 Cedar Street', '444-777-8888');

	Select*from booksold
		Select*from BOOK
		Select*from Customers


CREATE VIEW BookSalesInfo AS
SELECT b.BookCode, b.Title, b.Price, SUM(bs.amount) AS SoldQuantity
FROM BOOK b
LEFT JOIN booksold bs ON b.BookCode = bs.bookcode
GROUP BY b.BookCode, b.Title, b.Price;


CREATE VIEW CustomerPurchaseInfo AS
SELECT c.CustomerID, c.CustomerName, c.Address, COUNT(bs.booksoldid) AS PurchasedBooks
FROM Customers c
LEFT JOIN booksold bs ON c.CustomerID = bs.customerid
GROUP BY c.CustomerID, c.CustomerName, c.Address;

CREATE VIEW CustomerPurchasesLastMonth AS
SELECT c.CustomerID, c.CustomerName, c.Address, b.Title AS PurchasedBook
FROM Customers c
JOIN booksold bs ON c.CustomerID = bs.customerid
JOIN BOOK b ON bs.bookcode = b.BookCode
WHERE DATEPART(MONTH, bs.sale_date) = DATEPART(MONTH, GETDATE()) - 1;

CREATE VIEW CustomerTotalSpent AS
SELECT c.CustomerID, c.CustomerName, c.Address, SUM(bs.price * bs.amount) AS TotalSpent
FROM Customers c
JOIN booksold bs ON c.CustomerID = bs.customerid
GROUP BY c.CustomerID, c.CustomerName, c.Address;

SELECT * FROM BookSalesInfo;
SELECT * FROM CustomerPurchaseInfo;
SELECT * FROM CustomerPurchasesLastMonth;
SELECT * FROM CustomerTotalSpent;

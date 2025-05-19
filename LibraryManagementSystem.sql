-- 1. Create the database
CREATE DATABASE LibraryDB;

-- 2. Use the database
USE LibraryDB;

-- 3. Create tables

-- Library
CREATE TABLE Library (
    L_ID INT PRIMARY KEY IDENTITY(1,1),
    Library_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Established_Year INT CHECK (Established_Year >= 1500));

-- LibraryPhones
CREATE TABLE LibraryPhones (
    L_ID INT,
    Contact_Number VARCHAR(15),
    PRIMARY KEY (L_ID, Contact_Number),
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID));

-- Member
CREATE TABLE Member (
    M_ID INT PRIMARY KEY IDENTITY(201,1),
    FName VARCHAR(50) NOT NULL,
    MName VARCHAR(50),
    LName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Membership_Start_Date DATE NOT NULL,
    L_ID INT,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID));

-- MemberPhone
CREATE TABLE MemberPhone (
    M_ID INT,
    Phone_Number VARCHAR(15),
    PRIMARY KEY (M_ID, Phone_Number),
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID));

-- Staff
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    MName VARCHAR(50),
    LName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Contact_Number VARCHAR(15) NOT NULL,
    L_ID INT,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID));

-- Book
CREATE TABLE Book (
    B_ID INT PRIMARY KEY IDENTITY(101,1),
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Price DECIMAL(6,2) CHECK (Price > 0),
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(30) NOT NULL CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Availability_Status VARCHAR(50) DEFAULT 'TRUE',
    Shelf_Location VARCHAR(20),
    L_ID INT,
    M_ID INT NULL,
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID),
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID));

-- Loan
CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY IDENTITY(1,1),
    Loan_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    M_ID INT,
    B_ID INT,
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID),
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID));

-- Payment
CREATE TABLE Payment (
    P_ID INT PRIMARY KEY IDENTITY(501,1),
    Payment_Date DATE NOT NULL,
    Amount DECIMAL(6,2) CHECK (Amount > 0),
    Payment_Method VARCHAR(20) NOT NULL,
    Loan_ID INT,
    FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID));

-- Review
CREATE TABLE Review (
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(200) DEFAULT 'No Comments',
    Review_Date DATE NOT NULL,
    M_ID INT,
    B_ID INT,
    FOREIGN KEY (M_ID) REFERENCES Member(M_ID),
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID));

-- Ownership (LibraryBook)
CREATE TABLE Ownership (
    L_ID INT,
    B_ID INT,
    PRIMARY KEY (L_ID, B_ID),
    FOREIGN KEY (L_ID) REFERENCES Library(L_ID),
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID));

-- BookGenre (assumed separate genre expansion)
CREATE TABLE BookGenre (
    B_ID INT,
    Genre VARCHAR(50),
    PRIMARY KEY (B_ID, Genre),
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID));

--Insert data

-- Library
INSERT INTO Library (Library_Name, Location, Established_Year) VALUES
('Sohar City Library', 'Sohar', 2010),
('Muscat Public Library', 'Muscat', 1998),
('Salalah Knowledge Hub', 'Salalah', 2005);

-- LibraryPhones
INSERT INTO LibraryPhones (L_ID, Contact_Number) VALUES
(1, '+96826780000'),
(2, '+96824120000'),
(2, '+96824120001'),
(3, '+96823230000');

-- Member
INSERT INTO Member (Email, FName, MName, LName, Membership_Start_Date, L_ID) VALUES
('fatma@library.om', 'Fatma', 'Mohammed', 'Al Mamari', '2025-01-15', 1),
('farid@library.om', 'Farid', 'Sameer', 'Al Alawi', '2023-03-10', 2),
('fahad@library.om', 'Fahad', 'Khalid', 'Al Shekaili', '2024-07-05', 3),
('dana@library.om', 'Dana', 'Salim', 'Al Ghailani', '2023-06-22', 1),
('somou@library.om', 'Somou', 'Hosni', 'Al Salti', '2024-12-12', 3),
('tariq@library.om', 'Tariq', 'Farid', 'Al Alawi', '2024-09-22', 2);

-- MemberPhone
INSERT INTO MemberPhone (M_ID, Phone_Number) VALUES
(201, '+96891879354'),
(202, '+96895959229'),
(203, '+96896689687');

-- Staff
INSERT INTO Staff (Staff_ID, FName, MName, LName, Position, Contact_Number, L_ID) VALUES
(301, 'Salim', 'Nasser', 'Al Maskari', 'Librarian', '+96899887766', 1),
(302, 'Mariam', 'Talib', 'Al Hinai', 'Assistant', '+96899775544', 2),
(303, 'Yousuf', 'Said', 'Al Amri', 'Technician', '+96899443322', 3),
(304, 'Sami', 'Khalid', 'Al Shekaili', 'Manager', '+96898580428', 2);

-- Book
INSERT INTO Book (ISBN, Price, Title, Genre, Availability_Status, Shelf_Location, L_ID, M_ID) VALUES
('97803458100', 5.5, 'Al Noor', 'Fiction', 'Available', 'A1', 1, NULL),
('97812501022', 6.0, 'Whispers of the Wadi', 'Fiction', 'Borrowed', 'A2', 1, 201),
('97811019793', 7.5, 'Desert Stories', 'Reference', 'Available', 'B1', 2, NULL),
('97804515249', 8.0, 'Oman’s Hidden Treasures', 'Children', 'Borrowed', 'C3', 3, 202),
('97806797833', 4.5, 'Waves of Quriyat', 'Children', 'Available', 'C5', 2, NULL),
('97814000347', 5.0, 'Frankincense Trails', 'Reference', 'Available', 'A4', 2, NULL),
('97803074764', 6.5, 'Wadis and Wonders', 'Fiction', 'Borrowed', 'B2', 3, 203),
('97803745345', 9.0, 'Echoes from Dhofar', 'Non-fiction', 'Available', 'D2', 1, NULL),
('97801404493', 3.0, 'Souq Tales', 'Reference', 'Available', 'A5', 2, NULL),
('97800623150', 4.8, 'My Life in Muscat', 'Children', 'Borrowed', 'E1', 1, 204);

-- BookGenre
INSERT INTO BookGenre (B_ID, Genre) VALUES
(101, 'Poetry'),
(102, 'Fiction'),
(103, 'History'),
(104, 'Culture'),
(105, 'Memoir');

-- Loan
INSERT INTO Loan (Loan_Date, Due_Date, Return_Date, Status, M_ID, B_ID) VALUES
('2025-05-01', '2025-05-15', NULL, 'Issued', 201, 102),
('2025-05-02', '2025-05-16', NULL, 'Issued', 202, 104),
('2025-04-15', '2025-04-29', '2025-04-28', 'Returned', 203, 107),
('2025-05-10', '2025-05-24', NULL, 'Issued', 204, 110),
('2025-03-20', '2025-04-03', '2025-04-01', 'Returned', 205, 105),
('2025-05-12', '2025-05-26', NULL, 'Issued', 206, 103),
('2025-03-10', '2025-03-24', '2025-03-22', 'Returned', 201, 106),
('2025-04-01', '2025-04-15', '2025-04-12', 'Returned', 202, 109);

-- Payment
INSERT INTO Payment (Payment_Date, Amount, Payment_Method, Loan_ID) VALUES
('2025-05-16', 1.50, 'Credit Card', 1),
('2025-04-05', 2.00, 'Cash', 5),
('2025-05-10', 2.50, 'Debit Card', 3),
('2025-05-17', 1.00, 'Credit Card', 4),
('2025-05-15', 3.00, 'Mobile Payment', 7);

-- Review
INSERT INTO Review (M_ID, B_ID, Rating, Comments, Review_Date) VALUES
(201, 101, 5, 'Beautiful and inspiring', '2025-05-12'),
(202, 104, 4, 'Interesting cultural insight', '2025-04-20'),
(203, 105, 3, 'Could have more depth in storytelling', '2025-05-14'),
(201, 102, 4, 'Great characters and vivid imagery', '2025-05-01'),
(202, 103, 5, 'Fascinating historical content', '2025-05-10'),
(203, 101, 2, 'Not my style, but well-written', '2025-05-17');

-- Ownership
INSERT INTO Ownership (L_ID, B_ID) VALUES
(1, 101),
(1, 102),
(2, 103),
(3, 104),
(3, 105);
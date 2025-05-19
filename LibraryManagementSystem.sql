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


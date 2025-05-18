--create database
create database LibraryDB;

--usedatabase
use LibraryDB;

--create Library table
create table Library(
 L_ID int Not Null PRIMARY KEY identity(1,1),
    Library_Name VARCHAR(100) Not Null,
    Location VARCHAR(100) Not Null,
    Established_Year INT CHECK (Established_Year >= 1500));

-- create Library Contact Numbers table
create table LibraryPhones (
L_ID int, foreign key (L_ID) references Library(L_ID),
Contact_Number VARCHAR(15),
Primary key (L_ID, Contact_Number));

-- create Member table
create table Member (
M_ID int Not Null PRIMARY KEY identity(1,1),
FName VARCHAR(50) Not Null,
MName VARCHAR(50),
LName VARCHAR(50) Not Null,
Email Varchar(100) Unique Not Null,
Membership_Staet_Date Date Not Null,
L_ID int, foreign key (L_ID) references Library(L_ID));

--create Member Phone Number table 
create table MemberPhone(
M_ID int, foreign key (M_ID) references Member(M_ID),
Phone_Number VARCHAR(15),
Primary key (M_ID, Phone_Number));

--create Staff table
create table Staff(
Staff_ID int Not Null PRIMARY KEY identity(1,1),
FName VARCHAR(50) Not Null,
MName VARCHAR(50),
LName VARCHAR(50) Not Null,
Position VARCHAR(50) Not Null,
Contact_Number VARCHAR(15)Not Null,
L_ID int, foreign key (L_ID) references Library(L_ID));

--create Book table
create table Book(
B_ID int Not Null PRIMARY KEY identity(1,1),
ISBN VARCHAR(20) Unique Not Null,
Price Decimal(6,2) CHECK (Price > 0), 
Title VARCHAR(100) Not Null,
Genre VarChar(30) Not Null CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
Availability_Status BIT Default 1, -- 1 means Available and 0 means Not Available
Shelf_Location Varchar(20),
L_ID int, foreign key (L_ID) references Library(L_ID));

--create Loan table 
create table Loan(
Loan_ID int Not Null PRIMARY KEY identity(1,1),
Loan_Date DATE Not Null,
Due_Date DATE Not Null,
Return_Date DATE,
Status Varchar(20) Not Null CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
M_ID int, foreign key (M_ID) references Member(M_ID),
B_ID int, foreign key (B_ID) references Book(B_ID));


--create Payment table
create table Payment (
P_ID  int Not Null PRIMARY KEY identity(1,1),
Payment_Date DATE Not Null,
Amount Decimal(6,2) Not Null CHECK (Amount > 0),
Payment_Method VARCHAR(20) Not Null,
Loan_ID int, foreign key (Loan_ID) references Loan(Loan_ID));

--create Review table
create table Review (
Rating int CHECK (Rating Between 1 and 5),
Comments VARCHAR(200) Default 'No Comments',
Review_Date Date Not Null,
M_ID int, foreign key (M_ID) references Member(M_ID),
B_ID int, foreign key (B_ID) references Book(B_ID));

--create Ownership table
create table Ownership (
L_ID int, foreign key (L_ID) references Library(L_ID),
B_ID int, foreign key (B_ID) references Book(B_ID),
Primary key (L_ID, B_ID));
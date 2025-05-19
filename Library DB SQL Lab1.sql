-- 1. Display all book records.
SELECT * FROM Book;

-- 2. Show each book’s title, genre, and availability.
SELECT Title, Genre, Availability_Status FROM Book;

-- 3. Display all members' names, email, and membership start date.
SELECT FName, Email, Membership_Start_Date FROM Member;

-- 4. Display each book’s title and price with alias “BookPrice”.
SELECT Title, Price AS BookPrice FROM Book;

-- 5. List books priced above 250 LE.
SELECT * FROM Book WHERE Price > 250;

-- 6. List members who joined before 2023.
SELECT * FROM Member
WHERE Membership_Start_Date < '2023-01-01';

-- 7. Display names and roles of staff working in 'Zamalek Branch'. 
-- SELECT CONCAT (FName,' ', LName) AS FullName FROM Staff WHERE ;
-- 8. Display branch name managed by staff ID = 3008. 
-- SELECT L_Name from Library where Staff_ID =3008;

-- 9. List titles and authors of books available in branch ID = 2.
 SELECT L_ID,B_ID from Ownership ;
-- 10. Insert yourself as a member with ID = 405 and register to borrow book ID = 1011.
INSERT INTO Member  (FName, Email, Membership_Start_Date)
VALUES ( 'Amani Alshekaili', 'amani@example.com', '2024');

SET IDENTITY_INSERT Members ON 

SET IDENTITY_INSERT Members OFF 

select * from Member;
-- 11. Insert a member with NULL email and phone.
INSERT INTO Member ( FName,LName, Email, Membership_Start_Date)
VALUES ('Farid','AlAlawi', NULL, 2023);
select * from Member;
insert into MemberPhone(M_ID,Phone_Number)
values 
(8,'NULL');
select * from MemberPhone;
-- 12. Update the return date of your loan to today.
UPDATE Loan
SET Return_Date = GETDATE()
WHERE M_ID = 405 AND B_ID = 1011;

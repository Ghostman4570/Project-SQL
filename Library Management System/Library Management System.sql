-- First, create the database for the Library Management System --
CREATE DATABASE library_management;
USE library_management;

-- Next, create the necessary tables: books, members, and borrows --
	-- Create Books Table --
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    published_year INT,
    copies_available INT DEFAULT 0
);

	-- Create Members Table --
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(15)
);

	-- Create Borrows Table --
CREATE TABLE borrows (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert Data into Books Table --
INSERT INTO books (title, author, genre, published_year, copies_available)
VALUES 
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 5),
('1984', 'George Orwell', 'Dystopian', 1949, 8),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 3);

-- Insert Data into Members Table --
INSERT INTO members (name, email, phone)
VALUES 
('John Doe', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210');

-- Insert Data into Borrows Table --
INSERT INTO borrows (book_id, member_id, borrow_date, due_date, return_date)
VALUES 
(1, 1, '2024-06-01', '2024-06-15', NULL),
(2, 2, '2024-06-10', '2024-06-24', NULL);

-- Queries--
-- Select All Books --
SELECT * FROM books;

-- Find Books by a Specific Author --
SELECT * FROM books
WHERE author = 'George Orwell';

-- Add a New Book --
INSERT INTO books (title, author, genre, published_year, copies_available)
VALUES ('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 4);

-- Update the Number of Copies of a Book -- 
UPDATE books
SET copies_available = 6
WHERE book_id = 3;

-- Delete a Book --
DELETE FROM books
WHERE book_id = 3;

-- List All Members Who Have Borrowed Books --
SELECT DISTINCT members.member_id, members.name
FROM members
JOIN borrows ON members.member_id = borrows.member_id;

-- List All Books Borrowed by a Specific Member --
SELECT books.title, borrows.borrow_date, borrows.due_date
FROM books
JOIN borrows ON books.book_id = borrows.book_id
WHERE borrows.member_id = 1;

-- Count the Number of Books in Each Genre --
SELECT genre, COUNT(*) as number_of_books
FROM books
GROUP BY genre;

-- Find Overdue Books --
SELECT books.title, members.name, borrows.due_date
FROM books
JOIN borrows ON books.book_id = borrows.book_id
JOIN members ON borrows.member_id = members.member_id
WHERE borrows.due_date < CURDATE() AND borrows.return_date IS NULL;


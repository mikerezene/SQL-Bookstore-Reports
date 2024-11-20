
-- Create Tables for Bookstore Database
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

CREATE TABLE Genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert Sample Data
INSERT INTO Authors (name, country) VALUES 
('J.K. Rowling', 'UK'),
('George R.R. Martin', 'USA'),
('Haruki Murakami', 'Japan');

INSERT INTO Genres (name) VALUES 
('Fantasy'),
('Science Fiction'),
('Literary Fiction');

INSERT INTO Books (title, author_id, genre_id, price) VALUES 
('Harry Potter', 1, 1, 29.99),
('A Song of Ice and Fire', 2, 1, 49.99),
('Norwegian Wood', 3, 3, 19.99);

INSERT INTO Sales (book_id, quantity, sale_date) VALUES 
(1, 100, '2024-01-01'),
(2, 50, '2024-02-15'),
(3, 75, '2024-03-10');

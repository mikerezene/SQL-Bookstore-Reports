
-- Example Queries for Using GetBookstoreReport Procedure

-- Get total sales, top 3 books, and books by authors from the USA
CALL GetBookstoreReport('Fantasy', 'USA');

-- Get total sales, top 3 books, and books by authors from the UK
CALL GetBookstoreReport('Fantasy', 'UK');

-- Get total sales, top 3 books, and books by authors from Japan
CALL GetBookstoreReport('Literary Fiction', 'Japan');

-- Complex Query 1: Total Revenue by Author and Genre
SELECT 
    a.name AS author_name,
    g.name AS genre_name,
    SUM(b.price * s.quantity) AS total_revenue
FROM 
    Books b
JOIN 
    Authors a ON b.author_id = a.author_id
JOIN 
    Genres g ON b.genre_id = g.genre_id
JOIN 
    Sales s ON b.book_id = s.book_id
GROUP BY 
    a.name, g.name
ORDER BY 
    total_revenue DESC;

-- Complex Query 2: Monthly Sales Trend by Genre
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sale_month,
    g.name AS genre_name,
    SUM(s.quantity) AS total_sold
FROM 
    Sales s
JOIN 
    Books b ON s.book_id = b.book_id
JOIN 
    Genres g ON b.genre_id = g.genre_id
GROUP BY 
    sale_month, g.name
ORDER BY 
    sale_month ASC, total_sold DESC;

-- Complex Query 3: Books Not Sold
SELECT 
    b.title AS unsold_books
FROM 
    Books b
LEFT JOIN 
    Sales s ON b.book_id = s.book_id
WHERE 
    s.book_id IS NULL;

-- Complex Query 4: Top Authors by Revenue (with 3-level Subquery)
SELECT 
    a.name AS author_name,
    SUM(b.price * s.quantity) AS total_revenue
FROM 
    Books b
JOIN 
    Authors a ON b.author_id = a.author_id
JOIN 
    Sales s ON b.book_id = s.book_id
WHERE 
    b.genre_id IN (
        SELECT genre_id
        FROM Genres
        WHERE name = 'Fantasy'
    )
GROUP BY 
    a.name
HAVING 
    total_revenue > (
        SELECT AVG(total_revenue)
        FROM (
            SELECT 
                a.name,
                SUM(b.price * s.quantity) AS total_revenue
            FROM 
                Books b
            JOIN 
                Authors a ON b.author_id = a.author_id
            JOIN 
                Sales s ON b.book_id = s.book_id
            GROUP BY 
                a.name
        ) AS author_revenue
    )
ORDER BY 
    total_revenue DESC;


DELIMITER $$

CREATE PROCEDURE GetBookstoreReport(
    IN genreFilter VARCHAR(100), 
    IN authorCountry VARCHAR(100)
)
BEGIN
    CREATE TEMPORARY TABLE TempGenreSales (
        genre_name VARCHAR(100),
        total_revenue DECIMAL(10, 2)
    );

    INSERT INTO TempGenreSales (genre_name, total_revenue)
    SELECT 
        g.name AS genre_name,
        SUM(b.price * s.quantity) AS total_revenue
    FROM 
        Books b
    JOIN 
        Genres g ON b.genre_id = g.genre_id
    JOIN 
        Sales s ON b.book_id = s.book_id
    GROUP BY 
        g.name;

    SELECT * FROM TempGenreSales;

    SELECT 
        b.title,
        SUM(s.quantity) AS total_sold
    FROM 
        Books b
    JOIN 
        Sales s ON b.book_id = s.book_id
    JOIN 
        Genres g ON b.genre_id = g.genre_id
    WHERE 
        g.name = genreFilter
    GROUP BY 
        b.book_id, b.title
    ORDER BY 
        total_sold DESC
    LIMIT 3;

    SELECT 
        b.title,
        a.name AS author_name,
        g.name AS genre_name,
        SUM(s.quantity * b.price) AS revenue
    FROM 
        Books b
    JOIN 
        Authors a ON b.author_id = a.author_id
    JOIN 
        Genres g ON b.genre_id = g.genre_id
    LEFT JOIN 
        Sales s ON b.book_id = s.book_id
    WHERE 
        a.country = authorCountry
    GROUP BY 
        b.title, a.name, g.name
    ORDER BY 
        revenue DESC;

    DROP TEMPORARY TABLE TempGenreSales;
END$$

DELIMITER ;

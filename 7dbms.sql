CREATE TABLE Library (
    book_id INT UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
    book_name VARCHAR(100) DEFAULT '',
    author VARCHAR(100),
    price INT
);
    
CREATE TABLE Library_Audit (
    update_id INT UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
    old_book_id INT,
    old_book_name VARCHAR(100) DEFAULT '',
    old_author VARCHAR(100),
    old_price INT
);

INSERT INTO Library VALUES 
    (1,'MATHS' , 500, 'PERSON A'),
    (2,'SCIENCE' , 200, 'PERSON B'),
    (3,'ENGLISH' , 300, 'PERSON C'),
    (4,'HINDI' , 100, 'PERSON D'),
    (5,'SOCIAL SCIENCE' , 900, 'PERSON E'),
    (6,'SANSKRIT' , 1200, 'PERSON F');
;

DELIMITER $$
CREATE TRIGGER update_trig
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (old_book_id, old_book_name, old_author, old_price) VALUES 
    (OLD.book_id, OLD.book_name, OLD.author, OLD.price);
END $$
DELIMITER ;


UPDATE Library
SET book_name = 'ANOTHER MATHS' WHERE book_id = 1;

DELIMITER $$
CREATE TRIGGER error_trig
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    IF NEW.book_name = OLD.book_name AND NEW.auhor = OLD.author THEN
    SIGNAL SQLSTATE '45000'
    SET message_text = 'Same value of updated book';
    END IF;
END $$
DELIMITER ; 

UPDATE Library
SET book_name = 'quae' WHERE book_id = 3;

DELIMITER $$
CREATE TRIGGER del_trig
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (old_book_id, old_book_name, old_author, old_price) VALUES 
    (OLD.book_id, OLD.book_name, OLD.author, OLD.price);
END $$
DELIMITER ;

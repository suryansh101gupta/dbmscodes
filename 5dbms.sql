CREATE TABLE stud_marks(
	name VARCHAR(50),
	total_marks INT
);

CREATE TABLE result (
	class VARCHAR(25) DEFAULT NULL,
	name VARCHAR(50)
);

INSERT INTO stud_marks VALUES 
	('ali',756),
	('santosh',1253),
	('abdul',755),
	('anish',1285),
	('sumit',877),
;

DELIMITER $$

-- Function to classify marks
CREATE FUNCTION IF NOT EXISTS classify (marks INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	IF marks BETWEEN 990 AND 1500 THEN
		RETURN 'Distinction';
	ELSEIF marks BETWEEN 900 AND 989 THEN
		RETURN 'First Class';
	ELSEIF marks BETWEEN 825 AND 899 THEN
		RETURN 'Higher Second Class';
	ELSE
		RETURN 'Pass';
	END IF;
END $$

-- Procedure to insert into result table
CREATE PROCEDURE proc_grade (IN stud_name VARCHAR(50))
BEGIN
	DECLARE clss VARCHAR(25);
	DECLARE studmarks INT;
	SELECT total_marks INTO studmarks FROM stud_marks WHERE name = stud_name;
	SET clss := classify(studmarks);
	INSERT INTO result VALUES (clss, stud_name);
END $$
DELIMITER ;

CALL proc_grade('Shantanu');
CALL proc_grade('Riya');
CALL proc_grade('Atharva');
CALL proc_grade('Durvesh');
CALL proc_grade('Rhea');
CALL proc_grade('Ridhima');
CALL proc_grade('Piyush');
CALL proc_grade('Riddhi');

SELECT * FROM result;

DROP FUNCTION IF EXISTS max_of;

DROP FUNCTION IF EXISTS min_of;

DELIMITER $$

CREATE FUNCTION max_of(left INT, right INT)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result INT DEFAULT 0;

    IF right < left THEN SET result = left;
    ELSE SET result = right;
    END IF;

    RETURN result;
END $$


CREATE FUNCTION min_of(left INT, right INT)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result INT DEFAULT 0;

    IF left < right THEN SET result = left;
    ELSE SET result = right;
    END IF;

    RETURN result;
END $$

DELIMITER ;

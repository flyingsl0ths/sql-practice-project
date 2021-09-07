USE sports_booking;

DROP TRIGGER IF EXISTS payment_check;

DELIMITER $$

CREATE TRIGGER payment_check BEFORE
DELETE ON members FOR EACH ROW
BEGIN
    IF OLD.payment_due > 0 THEN
        INSERT INTO pending_terminations
        (id, email, request_date, payment_due)
        VALUES
        (OLD.id, OLD.email, NOW(), OLD.payment_due);
    END IF;

END $$

DELIMITER ;

USE sports_booking;

DROP FUNCTION IF EXISTS has_to_pay_cancellation_fee;

DELIMITER $$

CREATE FUNCTION has_to_pay_cancellation_fee(p_member_id VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE CANCELLATION_LIMIT INT UNSIGNED DEFAULT 3;

    DECLARE has_to_pay_fee BOOLEAN DEFAULT TRUE;
    DECLARE total_cancellations INT UNSIGNED DEFAULT 0;

    SELECT COUNT(payment_status) INTO total_cancellations
    FROM bookings WHERE payment_status = 'Cancelled' AND member_id = p_member_id;

    IF total_cancellations < CANCELLATION_LIMIT THEN
        SET has_to_pay_fee = FALSE;
    END IF;

    RETURN has_to_pay_fee;
END $$

DELIMITER ;

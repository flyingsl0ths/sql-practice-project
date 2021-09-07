USE sports_booking;

DROP PROCEDURE IF EXISTS update_payment;

DELIMITER $$

CREATE PROCEDURE update_payment(IN p_id INT UNSIGNED)
BEGIN
    DECLARE v_member_id VARCHAR(255);
    DECLARE v_price DOUBLE(6, 2) DEFAULT 0;
    DECLARE v_payment_due DECIMAL DEFAULT 0;

    DECLARE v_payment_status VARCHAR(255);

    SELECT payment_status INTO v_payment_status FROM bookings WHERE id = p_id;

    IF v_payment_status = 'Unpaid' THEN
        -- Stores the member id for a given booking
        SELECT member_id INTO v_member_id FROM member_bookings WHERE id = p_id;

        -- Stores the price of a room with corresponding p_id 
        SELECT price INTO v_price FROM member_bookings WHERE id = p_id;

        -- Stores the payment due amount of the member
        SELECT payment_due INTO v_payment_due FROM members WHERE id = v_member_id;

        UPDATE bookings
        SET payment_status = 'Paid'
        WHERE id = p_id;

        UPDATE members
        SET payment_due = v_payment_due - v_price
        WHERE id = v_member_id;
    END IF;

END $$

DELIMITER ;


USE sports_booking;

DROP PROCEDURE IF EXISTS increment_member_due_amount;

DROP PROCEDURE IF EXISTS make_booking;

DROP PROCEDURE IF EXISTS view_bookings;

DROP PROCEDURE IF EXISTS cancel_booking;

DELIMITER $$

CREATE PROCEDURE increment_member_due_amount(
    IN p_member_id VARCHAR(255),
    IN p_room_id VARCHAR(255)
)
BEGIN
    DECLARE room_price DOUBLE(6, 2) DEFAULT 0;

    DECLARE v_payment_due DECIMAL DEFAULT 0;

    SELECT price INTO room_price FROM rooms WHERE id = p_room_id;

    SELECT payment_due INTO v_payment_due FROM members WHERE id = p_member_id;

    UPDATE members
    SET payment_due = v_payment_due + room_price
    WHERE id = p_member_id;
END $$

CREATE PROCEDURE make_booking(
    IN p_room_id VARCHAR(255),
    IN p_booked_date DATE,
    IN p_booked_time TIME,
    IN p_member_id VARCHAR(255)
)
BEGIN
    INSERT INTO bookings (
        room_id,
        booked_date,
        booked_time,
        member_id,
        datetime_of_booking,
        payment_status
    ) VALUES (
        p_room_id,
        p_booked_date,
        p_booked_time,
        p_member_id,
        DEFAULT,
        DEFAULT
    );

    CALL increment_member_due_amount(p_member_id, p_room_id);
END $$

CREATE PROCEDURE view_bookings(IN p_member_id VARCHAR(255))
BEGIN
    SELECT * FROM member_bookings WHERE member_id = p_member_id ORDER BY booked_date;
END $$

CREATE PROCEDURE cancel_booking(
    IN p_booking_id INT UNSIGNED,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE CANCELLATION_FEE DECIMAL DEFAULT 10.00;
    DECLARE v_member_id VARCHAR(255);
    DECLARE v_payment_status VARCHAR(20);
    DECLARE v_booked_date DATE;
    DECLARE v_price DOUBLE(6, 2);
    DECLARE v_payment_due DECIMAL;

    SELECT member_id INTO v_member_id FROM member_bookings WHERE id = p_booking_id;

    SELECT booked_date INTO v_booked_date FROM member_bookings WHERE id = p_booking_id;

    SELECT price INTO v_price FROM member_bookings WHERE id = p_booking_id; 

    SELECT payment_status INTO v_payment_status FROM member_bookings WHERE id = p_booking_id;

    SELECT payment_due INTO v_payment_due FROM members WHERE id = v_member_id;

    IF CURDATE() >= v_booked_date THEN
        SELECT "Cancellation cannot be done on/after the booked date"
        INTO p_message;

    ELSEIF v_payment_status = 'Cancelled' OR v_payment_status = 'Paid'
        THEN SELECT 'Booking has already been cancelled or paid' INTO p_message;

    ELSE
        SET v_payment_due = v_payment_due - v_price;

        UPDATE members
        SET payment_due = v_payment_due
        WHERE id = v_member_id;

        IF has_to_pay_cancellation_fee(v_member_id) THEN
            UPDATE members
            SET payment_due = v_payment_due + CANCELLATION_FEE
            WHERE id = v_member_id;

            SET p_message = 'Must pay $10 cancellation fee';

        ELSE 
            UPDATE bookings
            SET payment_status = 'Cancelled'
            WHERE member_id = v_member_id;

            SET p_message = 'Booking Cancelled';
        END IF;

    END IF;

END $$

DELIMITER ;

USE sports_booking;

DROP PROCEDURE IF EXISTS search_for_available_rooms;

DELIMITER $$

CREATE PROCEDURE search_for_available_rooms(
    IN p_room_type VARCHAR(255),
    IN p_booked_date DATE,
    IN p_booked_time TIME
)
BEGIN

    SELECT id, room_type, price
    FROM rooms WHERE rooms.id NOT IN
    (
        SELECT room_id FROM bookings WHERE
        booked_date = p_booked_date AND
        booked_time = p_booked_time AND
        payment_status != "Cancelled"
    ) AND p_room_type = rooms.room_type;

END $$

DELIMITER ;

USE sports_booking;

DROP VIEW IF EXISTS member_bookings;

CREATE VIEW member_bookings AS
    SELECT
        bookings.id,
        bookings.room_id,
        rooms.room_type,
        bookings.booked_date,
        bookings.booked_time,
        bookings.member_id,
        bookings.datetime_of_booking,
        rooms.price,
        bookings.payment_status
    FROM bookings
    JOIN
        rooms
    ON bookings.room_id = rooms.id
    ORDER BY bookings.id;


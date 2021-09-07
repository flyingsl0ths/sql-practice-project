DROP DATABASE IF EXISTS sports_booking;

CREATE DATABASE sports_booking;

USE sports_booking;

CREATE TABLE members (
    id VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    member_since TIMESTAMP NOT NULL DEFAULT NOW(),
    payment_due DECIMAL NOT NULL DEFAULT 0
);

CREATE TABLE pending_terminations (
    id VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    request_date TIMESTAMP NOT NULL DEFAULT NOW(),
    payment_due DECIMAL NOT NULL DEFAULT 0,

    CONSTRAINT no_duplicate_terminations UNIQUE (id, email)
);

CREATE TABLE rooms (
    id VARCHAR(255) PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    price DOUBLE(6, 2) NOT NULL
);

CREATE TABLE bookings (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    room_id VARCHAR(255) NOT NULL,
    booked_date DATE NOT NULL,
    booked_time TIME NOT NULL,
    member_id VARCHAR(255) NOT NULL,
    datetime_of_booking TIMESTAMP NOT NULL DEFAULT NOW(),
    payment_status VARCHAR(20) NOT NULL DEFAULT "Unpaid",

    CONSTRAINT only_one_booking_for_room
    UNIQUE (room_id, booked_date, booked_time),

    CONSTRAINT booking_for_member
    FOREIGN KEY (member_id) REFERENCES members (id)
    ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT booking_for_room
    FOREIGN KEY (room_id) REFERENCES rooms (id)
    ON UPDATE CASCADE ON DELETE CASCADE
);


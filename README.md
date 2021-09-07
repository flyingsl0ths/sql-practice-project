# Sports Complex Booking Database

## Problem Description

Create a simple database to manage the booking process of a sports complex

**Relevant information** 

The sports complex has

- 2 tennis courts
- 2 badminton courts
- 2 multi-purpose fields
- an archery range

## Requirements

- Each of it's facilities can be booked for a duration of an hour
- Only registered users are allowed to make a booking
- The complex allows users to cancel their bookings latests by the day prior to the booked date
- Three or more cancellations by a single user results in a fee of $10 otherwise it is free

#### Tables

- members
- pending_terminations
- rooms
- bookings

#### View(s)

- member_bookings

#### Stored Procedures

- insert_new_member
- delete_member
- update_member_password
- update_member_email
- make_booking
- view_bookings
- cancel_booking
- update_payment
- search_room

#### Trigger(s)

- payment_check

#### Stored Function(s)

- check_cancellation

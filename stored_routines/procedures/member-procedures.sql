USE sports_booking;

DROP PROCEDURE IF EXISTS insert_new_member;

DROP PROCEDURE IF EXISTS delete_member;

DROP PROCEDURE IF EXISTS update_member_password;

DROP PROCEDURE IF EXISTS update_member_email;

DELIMITER $$

CREATE PROCEDURE insert_new_member(
    IN p_member_id VARCHAR(255),
    IN p_member_password VARCHAR(255),
    IN p_member_email VARCHAR(255)
)
BEGIN
    INSERT INTO members (
       id,
       password,
       email,
       member_since,
       payment_due
    ) VALUES
    (p_member_id, p_member_password, p_member_email, DEFAULT, DEFAULT);
END $$

CREATE PROCEDURE delete_member(IN p_member_id VARCHAR(255))
BEGIN
    DELETE FROM members WHERE id = p_member_id;
END $$

CREATE PROCEDURE update_member_password(
    IN p_member_id VARCHAR(255),
    IN new_password VARCHAR(255)
)
BEGIN
    UPDATE members
    SET password = new_password
    WHERE id = p_member_id;
END $$

CREATE PROCEDURE update_member_email(
    IN p_member_id VARCHAR(255),
    IN new_email VARCHAR(255)
)
BEGIN
    UPDATE members
    SET email = new_email
    WHERE id = p_member_id;
END $$

DELIMITER ;


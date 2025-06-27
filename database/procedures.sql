DELIMITER //

CREATE PROCEDURE BookSeat(
    IN p_customer_id INT,
    IN p_showtime_id INT,
    IN p_seat_id INT,
    IN p_payment_method VARCHAR(50)
)
BEGIN
    DECLARE v_price DECIMAL(8,2);
    DECLARE v_reservation_id INT;

    IF EXISTS (
        SELECT 1 FROM Reservations
        WHERE showtime_id = p_showtime_id
        AND seat_id = p_seat_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Seat already booked!';
    ELSE
        SELECT price INTO v_price FROM Showtimes WHERE showtime_id = p_showtime_id;

        INSERT INTO Reservations (customer_id, showtime_id, seat_id)
        VALUES (p_customer_id, p_showtime_id, p_seat_id);

        SET v_reservation_id = LAST_INSERT_ID();

        INSERT INTO Payments (reservation_id, amount, payment_method)
        VALUES (v_reservation_id, v_price, p_payment_method);
    END IF;
END //

DELIMITER ;
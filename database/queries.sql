-- Available Seats
SELECT s.seat_number
FROM Seats s
LEFT JOIN Reservations r ON s.seat_id = r.seat_id AND r.showtime_id = 1
WHERE s.cinema_id = 1 AND r.reservation_id IS NULL;

-- Customer Booking History
SELECT c.full_name, m.title, st.show_date, st.show_time, s.seat_number
FROM Customers c
JOIN Reservations r ON c.customer_id = r.customer_id
JOIN Showtimes st ON r.showtime_id = st.showtime_id
JOIN Movies m ON st.movie_id = m.movie_id
JOIN Seats s ON r.seat_id = s.seat_id
WHERE c.customer_id = 1;

-- Most-Watched Movies
SELECT m.title, COUNT(r.reservation_id) AS total_bookings
FROM Movies m
JOIN Showtimes st ON m.movie_id = st.movie_id
JOIN Reservations r ON st.showtime_id = r.showtime_id
GROUP BY m.title
ORDER BY total_bookings DESC;
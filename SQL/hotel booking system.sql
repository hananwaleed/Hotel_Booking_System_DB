CREATE DATABASE booking_hotel_system;
use [booking hotel system];
CREATE TABLE hotell (
    hotel_id INT PRIMARY KEY IDENTITY(1,1),
    hotel_name NVARCHAR(50) NOT NULL,
    location NVARCHAR(100),
    phone NVARCHAR(20)
);

INSERT INTO hotell (hotel_name, location, phone) VALUES
('City Stars Hotel', 'Cairo - Nasr City', '01123456789'),
('Red Sea Hotel', 'Hurghada - Corniche', '01234567891'),
('El Gouna Resort', 'El Gouna - Red Sea', '01099887766'),
('Alexandria Plaza Hotel', 'Alexandria - Raml Station', '01555551111'),
('Swiss Inn', 'Suez - Army Street', '01222223333');

CREATE TABLE room (
    room_id INT PRIMARY KEY IDENTITY(1,1),
    hotel_id INT NOT NULL,
    room_number NVARCHAR(10) NOT NULL,
    room_type NVARCHAR(50),
    price DECIMAL(10,2),
    is_available BIT DEFAULT 1,
    FOREIGN KEY (hotel_id) REFERENCES hotell(hotel_id)
);

INSERT INTO room (hotel_id, room_number, room_type, price) VALUES
(1, '101', 'Single', 800.00),
(1, '102', 'Double', 1200.00),
(1, '103', 'Suite', 2000.00),
(2, '201', 'Single', 700.00),
(2, '202', 'Double', 1100.00),
(3, '301', 'Suite', 2500.00),
(3, '302', 'Double', 1300.00),
(4, '401', 'Single', 600.00),
(4, '402', 'Suite', 1900.00),
(5, '501', 'Double', 1000.00),
(5, '502', 'Single', 750.00);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20)
);

INSERT INTO customer (full_name, email, phone) VALUES
('Ahmed Mostafa', 'ahmed.mostafa@example.com', '01012345678'),
('Fatma Zahra', 'fatma.zahra@example.com', '01122334455'),
('Youssef Tarek', 'youssef.tarek@example.com', '01234567890'),
('Hanin Mahmoud', 'hanin.mahmoud@example.com', '01099887766'),
('Sarah Ibrahim', 'sarah.ibrahim@example.com', '01555556666');

 CREATE TABLE booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    booking_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

INSERT INTO booking (customer_id, room_id, check_in_date, check_out_date) VALUES
(1, 1, '2025-06-01', '2025-06-05'),
(2, 3, '2025-07-10', '2025-07-15'),
(3, 6, '2025-08-01', '2025-08-10'),
(4, 9, '2025-09-05', '2025-09-12'),
(5, 10, '2025-10-20', '2025-10-25');

CREATE TABLE payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

INSERT INTO payment (booking_id, amount, payment_method) VALUES
(1, 3200.00, 'Credit Card'),
(2, 2000.00, 'Cash'),
(3, 8000.00, 'PayPal'),
(4, 11400.00, 'Credit Card'),
(5, 3750.00, 'Bank Transfer');

SELECT * FROM hotell;
SELECT * FROM room;
SELECT * FROM customer;
SELECT * FROM booking;
SELECT * FROM payment;

SELECT * FROM room WHERE is_available = 1;

SELECT full_name, email FROM customer WHERE email LIKE '%example.com%';

SELECT * FROM booking WHERE check_in_date > '2025-07-01';

SELECT room_number, price FROM room WHERE price BETWEEN 700 AND 1500;

SELECT * FROM customer ORDER BY full_name DESC;

SELECT room_type, COUNT(*) AS available_rooms FROM room WHERE is_available = 1 GROUP BY room_type;

SELECT * FROM hotell WHERE location LIKE '%Cairo%';

SELECT * FROM booking WHERE DATEDIFF(day, check_in_date, check_out_date) >= 5;

SELECT r.room_number, r.room_type, h.hotel_name
FROM room r
JOIN hotell h ON r.hotel_id = h.hotel_id;

SELECT c.customer_id, c.full_name
FROM customer c
LEFT JOIN booking b ON c.customer_id = b.customer_id
WHERE b.booking_id IS NULL;



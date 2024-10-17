-- Drop tables if they exist to avoid errors during creation
DROP TABLE IF EXISTS Ticket, Ticket_Type, Booking, Customer, Showtime, Movie, Screen, Cinema;

-- Create Cinema table
CREATE TABLE Cinema(
    ID INT PRIMARY KEY,
    cin_name VARCHAR(30),
    the_location VARCHAR(30),
    contact VARCHAR(30) UNIQUE,
    num_screens INT
);

-- Create Screen table with a foreign key to Cinema
CREATE TABLE Screen(
    ID INT PRIMARY KEY,
    cinema INT REFERENCES Cinema(ID),
    num_seats INT
);

-- Create Movie table
CREATE TABLE Movie(
    ID INT PRIMARY KEY,
    title VARCHAR(30),
    duration INTERVAL,  -- Consider using INTERVAL or INT for total minutes
    rating FLOAT
);

-- Create Showtime table with foreign keys to Movie and Screen, and using TIMESTAMP
CREATE TABLE Showtime(
    ID INT PRIMARY KEY,
    movie INT REFERENCES Movie(ID),
    screen INT REFERENCES Screen(ID),
    show_date TIMESTAMP DEFAULT NOW()
);

-- Create Customer table with the correct column syntax
CREATE TABLE Customer(
    ID INT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    user_password VARCHAR(30) NOT NULL,
    age INT NOT NULL
);

-- Create Booking table with foreign keys to Customer and Showtime
CREATE TABLE Booking(
    ID INT PRIMARY KEY,
    customer INT REFERENCES Customer(ID),
    showtime INT REFERENCES Showtime(ID)
);

-- Create Ticket_Type table
CREATE TABLE Ticket_Type(
    ID INT PRIMARY KEY,
    ticket_name VARCHAR(30),
    price DECIMAL(10,2),
    age_cap INT
);

-- Create Ticket table with foreign keys to Ticket_Type and Booking
CREATE TABLE Ticket(
    ID INT PRIMARY KEY,
    ticket_type INT REFERENCES Ticket_Type(ID),
    booking_num INT REFERENCES Booking(ID),
    seat INT
);

-- Insert data into Cinema table
INSERT INTO Cinema (ID, cin_name, the_location, contact, num_screens) VALUES
    (1, 'CinA', 'Adamstown', '0850000001', 3),
    (2, 'CinB', 'Booterstown', '0850000002', 3),
    (3, 'CinC', 'Cabra', '0850000003', 1);

-- Insert data into Screen table
INSERT INTO Screen (ID, cinema, num_seats) VALUES
    (1, 1, 20),
    (2, 1, 20),
    (3, 1, 20),
    (4, 2, 20),
    (5, 2, 20),
    (6, 2, 25),
    (7, 3, 50);

-- Insert data into Movie table
INSERT INTO Movie (ID, title, duration, rating) VALUES
    (1, 'Pixels', '2 hours 10 minutes', 3.00),
    (2, 'Joker', '2 hours 20 minutes', 4.60);

-- Insert data into Showtime table using TIMESTAMP
INSERT INTO Showtime (ID, movie, screen, show_date) VALUES
    (1, 1, 1, '2024-09-24 12:00:00'),
    (2, 2, 2, '2024-09-24 16:00:00');

-- Insert data into Customer table
INSERT INTO Customer (ID, username, user_password, age) VALUES
    (1, 'Ruben', 'Pass', 20),
    (2, 'Felix', 'Pass', 18);

-- Insert data into Booking table (make sure price_total is provided)
INSERT INTO Booking (ID, customer, showtime) VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 1);

-- Insert data into Ticket_Type table
INSERT INTO Ticket_Type (ID, ticket_name, price, age_cap) VALUES
    (1, 'Adult', 15.00, 99);

-- Insert data into Ticket table
INSERT INTO Ticket (ID, ticket_type, booking_num, seat) VALUES
    (1, 1, 1, 1),
    (2, 1, 1, 2),
    (3, 1, 2, 1),
    (4, 1, 3, 2);

-- Query to count tickets sold per movie
SELECT m.title, COUNT(t.ID) AS ticket_count
FROM Movie m
JOIN Showtime s ON m.ID = s.movie
JOIN Booking b ON s.ID = b.showtime
JOIN Ticket t ON b.ID = t.booking_num
GROUP BY m.title;

-- Query to count the amount of tickets a user holds
select c.username, count(t.booking_num)
from Customer c
join Booking b on b.customer = c.ID
join Ticket t on t.booking_num = b.ID
group by c.username;

--Query to rank the cinemas by the amount of total seats they hold
SELECT c.cin_name, 
       SUM(s.num_seats) AS total_seats, 
       RANK() OVER (ORDER BY SUM(s.num_seats) DESC) AS rank
FROM Cinema c
JOIN Screen s ON s.cinema = c.ID
GROUP BY c.cin_name;



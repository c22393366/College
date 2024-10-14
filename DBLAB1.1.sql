-- Drop tables if they exist
DROP TABLE IF EXISTS Teddys, Cars, Fuel_types, Toy;

-- Create Toy table
CREATE TABLE Toy (
    ID INT PRIMARY KEY,
    name VARCHAR(30),
    price DECIMAL(10, 2)
);

-- Create Fuel_types table
CREATE TABLE Fuel_types (
    ID INT PRIMARY KEY,
    name VARCHAR(30)
);

-- Create Teddys table (with a foreign key referencing Toy)
CREATE TABLE Teddys (
    ID INT REFERENCES Toy(ID),
    material VARCHAR(30),
    age INT
);

-- Create Cars table (with a foreign key referencing Toy and Fuel_types)
CREATE TABLE Cars (
    ID INT REFERENCES Toy(ID),
    engine_size FLOAT,
    fuel_type INT REFERENCES Fuel_types(ID)
);

-- Insert values into Toy table
INSERT INTO Toy (ID, name, price) VALUES
(1, 'Lil Ted', 6.50),
(2, 'Rory the Racecar', 10.00),
(3, 'Lightning McQueen', 20.00);

-- Insert values into Teddys table
INSERT INTO Teddys (ID, material, age) VALUES
(1, 'Wool', 4);

-- Insert values into Fuel_types table
INSERT INTO Fuel_types (ID, name) VALUES
(0, 'Unleaded'),
(1, 'Diesel');

-- Insert values into Cars table
INSERT INTO Cars (ID, engine_size, fuel_type) VALUES
(2, 2.1, 0),
(3, 2.6, 0);

SELECT t.name, t.price, c.engine_size, f.name AS fuel_type
FROM Cars c
JOIN Toy t USING (ID)
JOIN Fuel_types f ON f.ID = c.fuel_type;



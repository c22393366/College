<?php
// Process_Reservation.php

session_start();

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: Signin_Form.php');
    exit();
}

// Establish a connection to your database (replace with your actual database connection code)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "library";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve user input from the form
$isbn = isset($_POST['isbn']) ? $_POST['isbn'] : "";
$username = $_SESSION['username'];

// Check if the ISBN is provided
if (!empty($isbn)) {
    // Insert a reservation record
    $sql = "INSERT INTO reserved (ISBN, Username, ReservedDate) VALUES (?, ?, CURRENT_DATE)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ss", $isbn, $username);

    if ($stmt->execute()) {
        // Update the reserved status in the books table
        $updateSql = "UPDATE books SET reserved = 'Yes' WHERE ISBN = ?";
        $updateStmt = $conn->prepare($updateSql);
        $updateStmt->bind_param("s", $isbn);
        $updateStmt->execute();

        // Close the update statement
        $updateStmt->close();
        
        // Redirect back to Display_Books.php with the search criteria
        echo"Success";
        header("Location: Search_Page.php");
        exit();
    } else {
        echo "Error: " . $stmt->error;
    }

    // Close the reservation statement
    $stmt->close();
} else {
    // Redirect or display an error if ISBN is not provided
    echo "Invalid request.";
}

// Close the connection
$conn->close();
?>

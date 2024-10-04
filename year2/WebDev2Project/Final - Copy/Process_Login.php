<?php
// Process_Login.php

session_start();

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "library";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted through POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve user input from the form
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validate username and password ... Change to function later?
    $sql = "SELECT * FROM users WHERE username = ? AND passw = ?";
    $stmt = $conn->prepare($sql);
    
    // Bind parameters
    $stmt->bind_param("ss", $username, $password);
    
    // Execute the query
    $stmt->execute();
    
    // Store the result
    $result = $stmt->get_result();

    // Check if any rows are returned
    if ($result->num_rows > 0) {
        // Authentication successful
        $_SESSION['username'] = $username;
        header('Location: Search_Page.php');  // Redirect To Website Content
        exit();
    } 
    else {
        echo "Invalid username or password.";
    }

    // Close the statement ERROR PREVENTION
    $stmt->close();
} else {
    // POST method was not used
    echo "Invalid request.";
}

// Close the connection
$conn->close();
?>

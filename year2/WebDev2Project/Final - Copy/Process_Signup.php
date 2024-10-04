<?php

// Process_Signup.php

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
    $passw = $_POST['passw'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $addressline1 = $_POST['addressline1'];
    $addressline2 = $_POST['addressline2'];
    $city = $_POST['city'];
    $mobile = $_POST['mobile'];

    $checkSql = "SELECT count(username) as count FROM users WHERE username = ?";
    $checkStmt = $conn->prepare($checkSql);
    $checkStmt->bind_param("s", $username);
    $checkStmt->execute();

    $result = $checkStmt->get_result();
    $row = $result->fetch_assoc();

    if ($row['count'] > 0) {
        echo "Username already exists. Please choose a different username.";
    }
    else {
        // Stops errors by making input into strings only. Also stops injection this way
        $insertSql = "INSERT INTO users (Username, Passw, FirstName, LastName, AddressLine1, AddressLine2, City, Mobile) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $insertStmt = $conn->prepare($insertSql);

        $insertStmt->bind_param("ssssssss", $username, $passw, $firstname, $lastname, $addressline1, $addressline2, $city, $mobile);

        if ($insertStmt->execute()) {
            echo "Signup successful!";
            header('Location: Signin_Form.php');
        } else {
            echo "An error occurred. Signup did not work.";
        }

        // Close the insert statement
        $insertStmt->close();
    }

    // Close the check statement
    $checkStmt->close();
} else {
    // Redirect or display an error if accessed directly without a POST request
    echo "Invalid request.";
}

// Close the connection
$conn->close();
?>

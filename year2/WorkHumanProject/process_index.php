<?php

//process_index.php

session_start();

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "countriesDB";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$countryname = isset($_POST['country']) ? $_POST['country'] : "";

if (!empty($countryname)){
    $sql = "SELECT name FROM countries
    WHERE name LIKE ?";
    $stmt = $conn->prepare($sql);
    
    $likeCountryName = "%$countryname%";
    $stmt->bind_param("s", $likeCountryName); // Bind the parameter

    // Execute the query
    $stmt->execute();

    // Get the result set
    $result = $stmt->get_result();

    $rows = [];
    while ($row = $result->fetch_assoc()) {
        array_push($rows, $row);
    }

    // Close the statement
    $stmt->close();

    // Close the connection
    $conn->close();

    // Check if there are matching rows
    if (!empty($rows)) {
        header("Location: display_countries.php?rows=" . urlencode(serialize($rows)));
        exit();
    } else {
        $_SESSION['error_message'] = "No countries found matching your search.";
        header("Location: index.php");
        exit();
    }
}

else{
    $_SESSION['error_message'] = "Please enter a country name.";
    header("Location: index.php");
    exit();
}
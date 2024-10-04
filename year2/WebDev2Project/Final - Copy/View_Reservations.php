<?php
// View_Reservations.php

session_start();

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: Signin_Form.php');
    exit();
}

// Retrieve the username from the session
$userSession = $_SESSION['username'];

// Establish a connection to your database (replace with your actual database connection code)
$servername = "localhost";
$dbUsername = "root"; // Use a different variable name to avoid conflict
$password = "";
$dbname = "library";

$conn = new mysqli($servername, $dbUsername, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve reserved books for the user
$sql = "SELECT books.ISBN, books.BookTitle, books.author, books.edition, books.year, books.categoryid, reserved.ReservedDate 
        FROM books
        INNER JOIN reserved ON books.ISBN = reserved.ISBN
        WHERE reserved.username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $userSession);
$stmt->execute();
$result = $stmt->get_result();



echo "<html><body>";
    // Display reserved books in a table
    echo "<html><html lang=\"en\">
    <head>
        <meta charset=\"UTF-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        <link rel=\"stylesheet\" href=\"style.css\">
        <title>Book Display</title>
    </head>";

    echo "
    <nav>
        <ul class=\"menu\">
            <li><a href=\"Search_Page.php\">Home</a></li>
            <li><a href=\"View_Reservations.php\">View Reservations</a></li>
            <li><a href=\"Signin_Form.php\">Log Out</a></li>
        </ul>
    </nav>
    <h2>Your Reserved Books:</h2>";
    if($result->num_rows > 0){

    echo "
    <table border='1'>
    <tr>
    <th>ISBN</th>
    <th>Book Title</th>
    <th>Author</th>
    <th>Edition</th>
    <th>Year</th>
    <th>Category ID</th>
    <th>Reserved</th>
    <th>Action</th>
    </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . $row['ISBN'] . "</td>";
        echo "<td>" . $row['BookTitle'] . "</td>";
        echo "<td>" . $row['author'] . "</td>";
        echo "<td>" . $row['edition'] . "</td>";
        echo "<td>" . $row['year'] . "</td>";
        echo "<td>" . $row['categoryid'] . "</td>";
        echo "<td>" . $row['ReservedDate'] . "</td>";
        echo "<td><form action='Process_unreservation.php' method='post'>";
            echo "<input type='hidden' name='isbn' value='" . (isset($row['ISBN']) ? $row['ISBN'] : '') . "'>";
            echo "<input type='submit' value='Unreserve'>";
        echo "</form></td>";
        echo "</tr>";
    }

    echo "</table></body></html>";
}
else{
    echo "
        <div class=\"container\">
            <h1>NO RESERVATIONS FOUND</h1>
        </div>
    ";
}



// Close the statement and database connection
$stmt->close();
$conn->close();
?>

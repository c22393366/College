<?php
// Display_Books.php

session_start();

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header('Location: Signin_Form.php');
    exit();
}

// Retrieve the search results from the URL or fetch from the database
$rows = unserialize(urldecode($_GET['rows']));
    
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "library";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$conn->close();


// Display the results
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

<table border='1' background-color: white>
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


foreach ($rows as $row) {
    echo "<tr>";
    echo "<td>" . (isset($row['ISBN']) ? $row['ISBN'] : '') . "</td>";
    echo "<td>" . (isset($row['BookTitle']) ? $row['BookTitle'] : '') . "</td>";
    echo "<td>" . (isset($row['author']) ? $row['author'] : '') . "</td>";
    echo "<td>" . (isset($row['edition']) ? $row['edition'] : '') . "</td>";
    echo "<td>" . (isset($row['year']) ? $row['year'] : '') . "</td>";
    echo "<td>" . (isset($row['categoryid']) ? $row['categoryid'] : '') . "</td>";
    echo "<td>" . (isset($row['reserved']) ? $row['reserved'] : '') . "</td>";

    // Check if the book is not reserved, then display the Reserve button
    if (isset($row['reserved']) && $row['reserved'] == 'No') {
        echo "<td><form action='Process_Reservation.php' method='post'>";
        echo "<input type='hidden' name='isbn' value='" . (isset($row['ISBN']) ? $row['ISBN'] : '') . "'>";
        echo "<input type='submit' value='Reserve'>";
        echo "</form></td>";
    } else {
        echo "<td>Already Reserved</td>";
    }

    echo "</tr>";
}

echo "</table></body></html>";
?>
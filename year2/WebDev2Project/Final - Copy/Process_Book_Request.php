<?php
// Process_Book_Request.php
session_start();

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

// Retrieve user input from the form, set as empty if not entered
$bookTitle = isset($_POST['booktitle']) ? $_POST['booktitle'] : "";
//$_SESSION['booktitle'] = $bookTitle;
$author = isset($_POST['author']) ? $_POST['author'] : "";
//$_SESSION['author'] = $author;
$category = isset($_POST['category']) ? $_POST['category'] : "";
//$_SESSION['category'] = $category;

$conditions = [];  // Allows for the following SQL queries to be stored
if (!empty($bookTitle)) {
    array_push($conditions, "BookTitle LIKE '%$bookTitle%'");
}
if (!empty($author)) {
    array_push($conditions, "author LIKE '%$author%'");
}

if (!empty($category)) {
    array_push($conditions, "books.categoryid IN (SELECT categoryid FROM Category WHERE CategoryName = '$category')");
}

// Check if at least one search field is filled
if (!empty($conditions)) {
    // Prepare the query to retrieve matching rows from the database
    $sql = "SELECT ISBN, BookTitle, author, edition, year, books.categoryid, reserved FROM books 
            JOIN Category ON books.categoryid = Category.categoryid 
            WHERE " . implode(" OR ", $conditions);  // Implode allows OR check between each stored query, necessitating only one of them to be true

    $stmt = $conn->prepare($sql);

    // Execute the query
    $stmt->execute();

    // Get the result set
    $result = $stmt->get_result();

    // Fetch the rows from the result set and store them in an array. The loop automatically increments
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
        // Pass the array of rows to the second page
        header("Location: Display_Books.php?rows=" . urlencode(serialize($rows)));
        exit();
    } 
    
    else {
        //header("Location: Search_Page.php");  // needs fix. Should just show none, or maybe error message w CSS included
        echo"None found";
        //exit();
    }
} else {
    // No search criteria provided
    echo "No search criteria provided.";
}
?>

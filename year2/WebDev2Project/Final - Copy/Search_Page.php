<?php session_start();
// Check if the username is not set in the session
if (!isset($_SESSION['username'])) {
    // Redirect to Signin_Form.php if the username is not set
    header('Location: Signin_Form.php');
    exit(); // Ensure that no other code is executed after the redirect
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Search Books</title>
</head>
<body>
    <nav>
        <ul class="menu">
            <li><a href="Search_Page.php">Home</a></li>
            <li><a href="View_Reservations.php">View Reservations</a></li>
            <li><a href="Signin_Form.php">Log Out</a></li>
        </ul>
    </nav>
    <header>
        <div class="user">
            <h1><?php echo "Signed in as: " . $_SESSION['username'] . "<br><br>Fill out book fields"; ?></h1>
        </div>
    </header>
    <div class="container">
        <form action="Process_Book_Request.php" method="post">
            <label for="booktitle">Book Name</label>
            <input type="text" id="booktitle" name="booktitle"><br>
            <label for="author">Author Name</label>
            <input type="text" id="author" name="author"><br>
            <label for="category">Choose a category:</label>
            <select name="category" id="category">
                <option value="none">---</option>
                <option value="Health">Health</option>
                <option value="Business">Business</option>
                <option value="Biology">Biology</option>
                <option value="Technology">Technology</option>
                <option value="Travel">Travel</option>
                <option value="Self-Help">Self-Help</option>
                <option value="Cookery">Cookery</option>
                <option value="Fiction">Fiction</option>
            </select>
            <input type="submit" value="Submit">
        </form>
        <form action="View_Reservations.php" method="post">
            <input type="submit" value="See Reservations">
        </form>
    </div>
</body>
</html>

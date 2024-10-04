<?php
// Signin_Form.php

// Start the session and destroy the previous
session_start();
session_unset();
session_destroy();
session_start();

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
    <div class="container">
        <form action="Process_Login.php" method="Post">
            <label for="username">UserName</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required><br>

            <input type="submit" value="submit"><br><br>
        </form>
    <a href="Signup_Form.php">Signup</a>
    </div>
</body>
</html>


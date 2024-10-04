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
        <form action="Process_Signup.php" method="post">
            <label for="username">UserName</label>
            <input type="text" id="username" name="username" required><br>
            <label for="passw">Password</label>
            <input type="password" id="passw" name="passw" required><br>
            <label for="firstname">Firstname</label>
            <input type="text" id="firstname" name="firstname" required><br>
            <label for="lastname">Lastname</label>
            <input type="text" id="lastname" name="lastname" required><br>
            <label for="addressline1">Address Line 1</label>
            <input type="text" id="addressline1" name="addressline1" required><br>
            <label for="addressline2">Address Line 2</label>
            <input type="text" id="addressline2" name="addressline2" required><br>
            <label for="city">City</label>
            <input type="text" id="city" name="city" required><br>
            <label for="mobile">Mobile</label>
            <input type="text" id="mobile" name="mobile" required><br>
            <input type="submit" value="submit">
        </form>
    </div>
</body>
</html>
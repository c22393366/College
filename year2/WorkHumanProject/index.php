<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Index</title>
</head>
<body>
    <div class="container">
        <?php
        if (isset($_SESSION['error_message'])) {
            echo "<p style='color:red;'>" . $_SESSION['error_message'] . "</p>";
            unset($_SESSION['error_message']);
        }
        ?>
        <form action="process_index.php" method="post">
            <label for="country">Country</label>
            <input type="text" id="country" name="country" required><br>
            <input type="submit" value="Submit"><br><br>
        </form>
    </div>
</body>
</html>

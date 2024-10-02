<?php
session_start();

$valid_pass = 'Ju57_4_R4nd0m_1337_57r1n9';

$uname = isset($_POST['uname']) ? $_POST['uname'] : '';
$psw = isset($_POST['password']) ? $_POST['password'] : '';
$error = 0;

// check hardcoded credentials
if ($uname == 'guest' && $psw == $valid_pass) {
  $_SESSION['loggedin'] = true;
  header('Location: upload.php');
  exit;
} else if ($uname != '') {
  $error = 'Invalid credentials or insufficient permissions';
}
header('definitely_not_a_pw:' . $valid_pass);
?>



<!DOCTYPE html>
<html>

<head>
  <title>Guardians Gallery - Login</title>
  <!-- Include Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
</head>

<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <h2 class="text-center mt-5">Login</h2>
        <?php if ($error): ?>
          <div id="errorMessage" class="alert alert-danger" style="display: block;"><?php echo $error; ?></div>
        <?php endif; ?>

        <form action="login.php" method="post">
          <div class="form-group">
            <label for="uname">Username</label>
            <input type="text" class="form-control" id="uname" name="uname" required>
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
          <button type="submit" class="btn btn-primary">Login</button>
        </form>
      </div>
    </div>
  </div>

  <!-- Include jQuery and Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>

</html>

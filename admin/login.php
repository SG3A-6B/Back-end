<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

try {
  $db = openDb();
  $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

  $input = json_decode(file_get_contents('php://input'));
  $email = filter_var($input->email, FILTER_SANITIZE_STRING);
  $password = filter_var($input->password, FILTER_SANITIZE_STRING);

  $sql = "SELECT * FROM admin WHERE email = :email AND password = :password";

  $stmt = $db->prepare($sql);
  $stmt->bindParam(':email', $email, PDO::PARAM_STR);
  $stmt->bindParam(':password', $password, PDO::PARAM_STR);
  $stmt->execute();

  //Katsotaan löytyykö riviä, joka sisältää syötetyt arvot 
  if ($stmt->rowCount() == 1) {

    //Login successful
    $response = array('status' => '200', 'message' => 'Login successful!');

  } else {

    //Login failed
    $response = array('status' => '401', 'message' => 'Incorrect email or password');

  }

  echo json_encode($response);
  
} catch (PDOException $pdoex) {
  returnError($pdoex);
}

<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'));
$firstname = filter_var($input->firstname, FILTER_SANITIZE_STRING);
$lastname = filter_var($input->lastname, FILTER_SANITIZE_STRING);
$email = filter_var($input->email, FILTER_SANITIZE_STRING);
$password = filter_var($input->password, FILTER_SANITIZE_STRING);

try {
  $db = openDb();
  $sql = "insert into admin (firstname, lastname, email, password) values ('$firstname', '$lastname', '$email', '$password')";
  executeInsert($db,$sql);
  $response = array('firstname' => $firstname, 'lastname' => $lastname, 'email' => $email, 'password' => $password);
  print json_encode($response);
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}
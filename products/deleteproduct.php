<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'));
$id = filter_var($input->id, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

try {
  $db = openDb();

  $query = $db->prepare("delete from product where id=(:id)");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();

  header("http/1.1 200 ok");
  $data = array("id" => $id);
  print json_encode($data);
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}
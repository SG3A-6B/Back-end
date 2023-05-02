<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'));
$id = filter_var($input->id, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

try {
  $db = openDb();

  $query = $db->prepare("SELECT image FROM product WHERE id=:id");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();
  $result = $query->fetch(PDO::FETCH_ASSOC);
  $imageFilename = $result['image'];

  // Poistetaan tuote tietokannasta
  $query = $db->prepare("DELETE FROM product WHERE id=:id");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();

  // Poistetaan kuva "images" kansiosta
  if ($imageFilename !== 'placeholder.png') {
    unlink("../images/products/$imageFilename");
  }

  header("HTTP/1.1 200 OK");
  $data = array("id" => $id);
  print json_encode($data);
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}

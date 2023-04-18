<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'));
$brand = filter_var($input->brand, FILTER_SANITIZE_STRING);
$name = filter_var($input->name, FILTER_SANITIZE_STRING);
$description = filter_var($input->description, FILTER_SANITIZE_STRING);
$price = filter_var($input->price, FILTER_SANITIZE_STRING);
$category_id = filter_var($input->category_id, FILTER_SANITIZE_STRING);

try {
  $db = openDb();

  $sql = "insert into product (brand, name, description, price, category_id, image) values ('$brand', '$name', '$description', '$price', '$category_id', 'placeholder.png')";
  executeInsert($db,$sql);
  $data = array('id' => $db->lastInsertId(), 'brand' => $brand, 'name' => $name, 'description' => $description, 'price' => $price, 'image' => 'placeholder.png');
  print json_encode($data);
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}
<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

try {
  $db = openDb();

  $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);

  $image_name = isset($_FILES['image']['name']) ? $_FILES['image']['name'] : 'placeholder.png';
  $image_tmp_name = isset($_FILES['image']['tmp_name']) ? $_FILES['image']['tmp_name'] : '';
  $image_type = isset($_FILES['image']['type']) ? $_FILES['image']['type'] : '';
  $image_path = dirname(__DIR__) . DIRECTORY_SEPARATOR . 'images' . DIRECTORY_SEPARATOR . 'categories' . DIRECTORY_SEPARATOR . $image_name;

  $sql = "INSERT INTO category (name, image) VALUES (:name, :image_name)";
  $stmt = $db->prepare($sql);
  $stmt->bindValue(':name', $name);
  $stmt->bindValue(':image_name', $image_name);
  $stmt->execute();

  if (!empty($image_tmp_name)) {
    move_uploaded_file($image_tmp_name, $image_path);
  }

  $data = array('id' => $db->lastInsertId(), 'name' => $name, 'image' => $image_name);
  print json_encode($data);
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}
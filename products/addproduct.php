<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

try {
  $db = openDb();

  $brand = filter_input(INPUT_POST, 'brand', FILTER_SANITIZE_STRING);
  $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
  $description = filter_input(INPUT_POST, 'description', FILTER_SANITIZE_STRING);
  $price = filter_input(INPUT_POST, 'price', FILTER_SANITIZE_STRING);
  $category_id = filter_input(INPUT_POST, 'category_id', FILTER_SANITIZE_STRING);
  
  $image_name = isset($_FILES['image']['name']) ? $_FILES['image']['name'] : 'placeholder.png';
  $image_tmp_name = isset($_FILES['image']['tmp_name']) ? $_FILES['image']['tmp_name'] : '';
  $image_type = isset($_FILES['image']['type']) ? $_FILES['image']['type'] : '';
  $image_path = dirname(__DIR__) . DIRECTORY_SEPARATOR . 'images' . DIRECTORY_SEPARATOR . 'products' . DIRECTORY_SEPARATOR . $image_name;

  $sql = "INSERT INTO product (brand, name, description, price, category_id, image) VALUES (:brand, :name, :description, :price, :category_id, :image_name)";
  $stmt = $db->prepare($sql);
  $stmt->bindValue(':brand', $brand);
  $stmt->bindValue(':name', $name);
  $stmt->bindValue(':description', $description);
  $stmt->bindValue(':price', $price);
  $stmt->bindValue(':category_id', $category_id);
  $stmt->bindValue(':image_name', $image_name);
  $stmt->execute();

  if (!empty($image_tmp_name)) {
    move_uploaded_file($image_tmp_name, $image_path);
  }

  $data = array('id' => $db->lastInsertId(), 'brand' => $brand, 'name' => $name, 'description' => $description, 'price' => $price, 'image' => $image_name);
  print json_encode($data);
} catch (PDOException $pdoex) {
  returnError($pdoex);
}

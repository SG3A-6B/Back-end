<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'));
$id = filter_var($input->id, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

try {
  $db = openDb();

  $query = $db->prepare("SELECT image FROM product WHERE category_id=:id");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();
  $results = $query->fetchAll(PDO::FETCH_ASSOC);
  $imageFilename = $result['image'];

  // Poistetaan kategorian tuotteiden kuvat "images" kansiosta
  $image_path = '../images/products/';
  foreach ($results as $result) {
    $imageFilename = $result['image'];
    if ($imageFilename !== 'placeholder.png') {
      unlink($image_path . $imageFilename);
    }
  }

  $query = $db->prepare("SELECT image FROM category WHERE id=:id");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();
  $results = $query->fetchAll(PDO::FETCH_ASSOC);
  $categoryImageFilename = $results[0]['image'];

  //Poistetaan kategoria kuva "images" kansiosta
  $category_image_path = '../images/categories/';
  if ($categoryImageFilename !== 'placeholder.png') {
    unlink($category_image_path . $categoryImageFilename);
  }

  // Poistetaan kategoria tietokannasta
  $query = $db->prepare("DELETE FROM category WHERE id=(:id)");
  $query->bindValue(":id", $id, PDO::PARAM_INT);
  $query->execute();

  header("http/1.1 200 ok");
  $data = array("id" => $id);
  print json_encode($data);
} catch (PDOException $pdoex) {
  returnError($pdoex);
}

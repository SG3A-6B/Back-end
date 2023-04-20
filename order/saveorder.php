<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

$input = json_decode(file_get_contents('php://input'), true);
$firstname = filter_var($input['firstname'], FILTER_SANITIZE_STRING);
$lastname = filter_var($input['lastname'], FILTER_SANITIZE_STRING);
$email = filter_var($input['email'], FILTER_SANITIZE_STRING);
$phone = filter_var($input['phone'], FILTER_SANITIZE_STRING);
$address = filter_var($input['address'], FILTER_SANITIZE_STRING);
$zip = filter_var($input['zip'], FILTER_SANITIZE_STRING);
$city = filter_var($input['city'], FILTER_SANITIZE_STRING);

try {
    // Connect to database
    $db = openDb();
    $db->beginTransaction();

    // Insert customer
    $sql = "INSERT INTO customer (firstname, lastname, email, phone, address, zip, city) VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $db->prepare($sql);
    $stmt->execute([$firstname, $lastname, $email, $phone, $address, $zip, $city]);

    $customer_id = $db->lastInsertId();

    // Insert order
    $sql = "INSERT INTO `order` (customer_id) VALUES (?)";
    $stmt = $db->prepare($sql);
    $stmt->execute([$customer_id]);

    $order_id = $db->lastInsertId();

    // Insert order row
    $cart = $input['cart'];
    foreach ($cart as $product) {
        $sql = "INSERT INTO order_row (order_id, product_id, kpl) VALUES (?, ?, ?)";
        $stmt = $db->prepare($sql);
        $stmt->execute([$order_id, $product['id'], $product['amount']]);
    }

    $db->commit();

    header('HTTP/1.1 200 OK');
    $data = array('id' => $customer_id);
    echo json_encode($data);
} catch (PDOException $pdoex) {
    $db->rollback();
    returnError($pdoex);
}

// Close database connection
$db = null;
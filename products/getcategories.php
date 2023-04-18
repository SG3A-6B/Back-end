<?php
require_once '../inc/functions.php';
require_once '../inc/headers.php';

try {
  $db = openDb();
  selectAsJson($db,'select * from category order by name');
}
catch (PDOException $pdoex) {
  returnError($pdoex);
}
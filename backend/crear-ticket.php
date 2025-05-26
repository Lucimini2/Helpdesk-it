<?php
$conexion = new mysqli("db", "root", "root", "helpdesk");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$asunto = $_POST['asunto'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$origen = $_POST['origen'] ?? 'cliente';

$stmt = $conexion->prepare("INSERT INTO tickets (asunto, descripcion, estado) VALUES (?, ?, 'Abierto')");
$stmt->bind_param("ss", $asunto, $descripcion);
$stmt->execute();

header("Location: /$origen/");
exit;
?>
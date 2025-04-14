<?php
header('Content-Type: application/json');

// Conexión a la base de datos
$conexion = new mysqli("db", "root", "root", "helpdesk");

if ($conexion->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión: " . $conexion->connect_error]);
    exit;
}

// Consulta de tickets
$sql = "SELECT * FROM tickets";
$resultado = $conexion->query($sql);

$tickets = [];

if ($resultado->num_rows > 0) {
    while ($fila = $resultado->fetch_assoc()) {
        $tickets[] = $fila;
    }
}

echo json_encode($tickets);
$conexion->close();
?>

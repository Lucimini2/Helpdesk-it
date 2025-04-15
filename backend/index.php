<?php
header('Content-Type: application/json');

// Conexión a la base de datos
$conexion = new mysqli("db", "root", "root", "helpdesk");

if ($conexion->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión: " . $conexion->connect_error]);
    exit;
}

// Determinar el tipo de usuario (simulado - en producción usarías autenticación)
$esAdmin = strpos($_SERVER['HTTP_REFERER'] ?? '', '/admin/') !== false;

// Consulta de tickets diferente según el rol
if ($esAdmin) {
    $sql = "SELECT * FROM tickets";
} else {
    // Para clientes, solo mostrar tickets abiertos/en progreso
    $sql = "SELECT * FROM tickets WHERE estado IN ('Abierto', 'En progreso')";
}

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
<?php
$conexion = new mysqli("db", "root", "root", "helpdesk");

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Procesar actualizaciones de estado
if (isset($_POST['estados'])) {
    foreach ($_POST['estados'] as $id => $estado) {
        $stmt = $conexion->prepare("UPDATE tickets SET estado = ?, fecha_actualizacion = NOW() WHERE id = ?");
        $stmt->bind_param("si", $estado, $id);
        $stmt->execute();
    }
}

// Procesar eliminaciones
if (isset($_POST['eliminar'])) {
    foreach ($_POST['eliminar'] as $id => $valor) {
        if ($valor == '1') {
            $stmt = $conexion->prepare("DELETE FROM tickets WHERE id = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
        }
    }
}

header("Location: " . ($_SERVER['HTTP_REFERER'] ?? '/admin/'));
exit;
?>
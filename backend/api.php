<?php
header('Content-Type: application/json');

// Conexión a la base de datos
$conexion = new mysqli("db", "root", "root", "helpdesk");

if ($conexion->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Error de conexión: " . $conexion->connect_error]);
    exit;
}

// Obtener el método HTTP
$method = $_SERVER['REQUEST_METHOD'];

// Manejar diferentes rutas y métodos
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$parts = explode('/', $path);
$endpoint = $parts[count($parts) - 1];

if ($endpoint === 'tickets') {
    // Obtener ID si existe
    $id = isset($parts[3]) ? intval($parts[3]) : null;
    
    switch ($method) {
        case 'GET':
            // Determinar si es admin (simulado)
            $esAdmin = strpos($_SERVER['HTTP_REFERER'] ?? '', '/admin/') !== false;
            
            if ($id) {
                // Obtener un ticket específico
                $stmt = $conexion->prepare("SELECT * FROM tickets WHERE id = ?");
                $stmt->bind_param("i", $id);
                $stmt->execute();
                $result = $stmt->get_result();
                $ticket = $result->fetch_assoc();
                echo json_encode($ticket);
            } else {
                // Obtener todos los tickets
                if ($esAdmin) {
                    $sql = "SELECT * FROM tickets";
                } else {
                    $sql = "SELECT * FROM tickets WHERE estado IN ('Abierto', 'En progreso')";
                }
                $resultado = $conexion->query($sql);
                $tickets = [];
                while ($fila = $resultado->fetch_assoc()) {
                    $tickets[] = $fila;
                }
                echo json_encode($tickets);
            }
            break;
            
        case 'POST':
            // Crear nuevo ticket
            $data = json_decode(file_get_contents('php://input'), true);
            $asunto = $data['asunto'];
            $descripcion = $data['descripcion'];
            
            $stmt = $conexion->prepare("INSERT INTO tickets (asunto, descripcion) VALUES (?, ?)");
            $stmt->bind_param("ss", $asunto, $descripcion);
            
            if ($stmt->execute()) {
                echo json_encode(["success" => true, "id" => $conexion->insert_id]);
            } else {
                echo json_encode(["error" => $conexion->error]);
            }
            break;
            
        case 'PUT':
            // Actualizar ticket (admin)
            $data = json_decode(file_get_contents('php://input'), true);
            $estado = $data['estado'];
            
            $stmt = $conexion->prepare("UPDATE tickets SET estado = ? WHERE id = ?");
            $stmt->bind_param("si", $estado, $id);
            
            if ($stmt->execute()) {
                echo json_encode(["success" => true]);
            } else {
                echo json_encode(["error" => $conexion->error]);
            }
            break;
            
        case 'DELETE':
            // Eliminar ticket (admin)
            $stmt = $conexion->prepare("DELETE FROM tickets WHERE id = ?");
            $stmt->bind_param("i", $id);
            
            if ($stmt->execute()) {
                echo json_encode(["success" => true]);
            } else {
                echo json_encode(["error" => $conexion->error]);
            }
            break;
            
        default:
            http_response_code(405);
            echo json_encode(["error" => "Método no permitido"]);
    }
} else {
    http_response_code(404);
    echo json_encode(["error" => "Endpoint no encontrado"]);
}

$conexion->close();
?>
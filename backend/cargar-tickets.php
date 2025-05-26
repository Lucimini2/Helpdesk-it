<?php
function conectarDB() {
    $conexion = new mysqli('db', 'root', 'root', 'helpdesk');
    if ($conexion->connect_error) {
        die("<div class='error'>Error de conexión: " . $conexion->connect_error . "</div>");
    }
    return $conexion;
}

function mostrarTickets($esAdmin = false) {
    $conexion = conectarDB();
    
    $sql = $esAdmin 
        ? "SELECT * FROM tickets ORDER BY fecha_creacion DESC" 
        : "SELECT * FROM tickets WHERE estado IN ('Abierto', 'En progreso') ORDER BY fecha_creacion DESC";
    
    $resultado = $conexion->query($sql);
    $html = '';
    
    if ($resultado && $resultado->num_rows > 0) {
        if ($esAdmin) {
            $html .= '<form action="/backend/actualizar-tickets.php" method="post">';
        }

        while ($ticket = $resultado->fetch_assoc()) {
            $html .= '<div class="ticket" data-estado="'.htmlspecialchars($ticket['estado']).'">';
            $html .= '<h3>'.htmlspecialchars($ticket['asunto']).'</h3>';
            $html .= '<p><strong>Descripción:</strong> '.nl2br(htmlspecialchars($ticket['descripcion'])).'</p>';
            $html .= '<p><strong>Estado:</strong> ';
            
            if ($esAdmin) {
                $html .= '<select name="estados['.$ticket['id'].']">';
                $html .= '<option value="Abierto"'.($ticket['estado']=='Abierto'?' selected':'').'>Abierto</option>';
                $html .= '<option value="En progreso"'.($ticket['estado']=='En progreso'?' selected':'').'>En progreso</option>';
                $html .= '<option value="Cerrado"'.($ticket['estado']=='Cerrado'?' selected':'').'>Cerrado</option>';
                $html .= '</select>';
            } else {
                $html .= htmlspecialchars($ticket['estado']);
            }
            
            $html .= '</p>';
            $html .= '<p><strong>Fecha creación:</strong> '.$ticket['fecha_creacion'].'</p>';
            
            if ($esAdmin) {
                $html .= '<label class="eliminar-ticket"><input type="checkbox" name="eliminar['.$ticket['id'].']" value="1"> Eliminar</label>';
            }
            
            $html .= '</div>';
        }

        if ($esAdmin) {
            $html .= '<div class="form-actions"><button type="submit" class="button">Guardar Cambios</button></div>';
            $html .= '</form>';
        }
    } else {
        $html = '<div class="no-tickets">No hay tickets disponibles</div>';
    }

    $conexion->close();
    return $html;
}
?>
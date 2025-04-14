-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS helpdesk;
USE helpdesk;

-- Crear tabla de tickets
CREATE TABLE IF NOT EXISTS tickets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  asunto VARCHAR(100) NOT NULL,
  descripcion TEXT NOT NULL,
  estado ENUM('Abierto', 'En progreso', 'Cerrado') DEFAULT 'Abierto',
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar algunos tickets de prueba
INSERT INTO tickets (asunto, descripcion, estado) VALUES
('Error de red', 'El equipo no puede conectarse a la red WiFi.', 'Abierto'),
('Fallo en impresora', 'La impresora de la oficina 2 muestra error de papel atascado.', 'En progreso'),
('Actualización de software', 'Solicito actualización del antivirus.', 'Cerrado');

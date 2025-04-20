<?php
require_once '/var/www/html/backend/cargar-tickets.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Soporte Cliente - HelpDesk</title>
    <link rel="stylesheet" href="/cliente/css/styles.css">
</head>
<body>
    <header>
        <h1>Soporte Técnico</h1>
        <p>Sistema de gestión de tickets</p>
    </header>

    <div class="cliente-controls">
        <a href="/cliente/nuevo-ticket.php" class="button">Nuevo Ticket</a>
    </div>

    <div class="tickets-container">
        <?php echo mostrarTickets(false); ?>
    </div>
</body>
</html>
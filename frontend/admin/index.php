<?php
require_once '/var/www/html/backend/cargar-tickets.php';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Admin - HelpDesk</title>
    <link rel="stylesheet" href="/admin/css/styles.css">
</head>
<body>
    <header>
        <h1>Panel de Administración</h1>
        <p>Gestión completa de tickets</p>
    </header>

    <div class="admin-controls">
        <a href="/admin/nuevo-ticket.php" class="button">Nuevo Ticket</a>
    </div>

    <div class="tickets-container">
        <?php echo mostrarTickets(true); ?>
    </div>
</body>
</html>
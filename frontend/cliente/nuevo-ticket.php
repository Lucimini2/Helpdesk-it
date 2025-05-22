<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuevo Ticket - Soporte Cliente</title>
    <link rel="stylesheet" href="/cliente/css/styles.css">
</head>
<body>
    <header>
        <h1>Nuevo Ticket de Soporte</h1>
    </header>

    <form action="/backend/crear-ticket.php" method="post">
        <input type="hidden" name="origen" value="cliente">
        <div class="form-group">
            <label for="asunto">Asunto:</label>
            <input type="text" id="asunto" name="asunto" required>
        </div>
        <div class="form-group">
            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" required></textarea>
        </div>
        <div class="form-actions">
            <button type="submit" class="button">Enviar Ticket</button>
            <a href="/cliente/" class="button">Cancelar</a>
        </div>
    </form>
</body>
</html>
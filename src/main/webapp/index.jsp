<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String baseURL = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio</title>
    <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
</head>
<body>
    <div class="form-container">
       <h1>Bienvenido</h1>
       <a class="btn" href="persona?action=agregar">Agregar Persona</a>
       <a class="btn" href="persona?action=listar">Listar Personas</a>
    </div>
</body>
</html>

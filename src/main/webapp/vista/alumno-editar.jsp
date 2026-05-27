<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.vo.AlumnoVO" %>
<%
  String baseURL = request.getContextPath();
  AlumnoVO alumno = (AlumnoVO) request.getAttribute("alumno");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Alumno</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
</head>
<body>
<div class="form-container">
  <h1>Editar Alumno</h1>
  <% if (alumno == null) { %>
    <p style="color:#ef4444;">No se encontró el alumno.</p>
    <a class="btn btn-secondary" href="<%= baseURL %>/alumno">Volver</a>
  <% } else { %>
  <form action="<%= baseURL %>/alumno" method="post">
    <input type="hidden" name="action" value="actualizar">
    <label>Código</label>
    <input type="number" name="codigo" value="<%= alumno.getCodigo() %>" readonly>
    <label>Nombre</label>
    <input type="text" name="nombre" value="<%= alumno.getNombre() %>" required>
    <label>Teléfono</label>
    <input type="text" name="telefono" value="<%= alumno.getTelefono() %>" required>
    <button class="btn" type="submit">Actualizar</button>
    <a class="btn btn-secondary" href="<%= baseURL %>/alumno">Volver</a>
  </form>
  <% } %>
</div>
</body>
</html>

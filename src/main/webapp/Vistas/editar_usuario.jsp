<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Rol"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    Usuario uEditar = (Usuario) request.getAttribute("usuarioEditar");
    List<Rol> listaRoles = (List<Rol>) request.getAttribute("listaRoles");
    List<String> listaEstados = (List<String>) request.getAttribute("listaEstados");
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Usuario - SICULTIVO</title>
  <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
  <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container py-4">
  <div class="bg-white p-4 rounded shadow-sm">

    <h4 class="mb-3">Editar Usuario</h4>

    <form action="<%=ctx%>/LoginServlet" method="post">
      <input type="hidden" name="action" value="actualizarUsuario">
      <input type="hidden" name="idUsuario" value="<%=uEditar.getIdUsuario()%>">

      <div class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Nombre completo:</label>
          <input type="text" class="form-control" name="nombre"
                 value="<%=uEditar.getNombre()%>" required>
        </div>

        <div class="col-md-4">
          <label class="form-label">Correo:</label>
          <input type="email" class="form-control" name="correo"
                 value="<%=uEditar.getCorreo()%>" required>
        </div>

        <div class="col-md-2">
          <label class="form-label">Rol:</label>
          <select class="form-select" name="idRol" required>
            <option value="">Seleccione...</option>
            <%
              if (listaRoles != null) {
                for (Rol r : listaRoles) {
                  String sel = (r.getIdRol() == uEditar.getIdRol()) ? "selected" : "";
            %>
              <option value="<%=r.getIdRol()%>" <%=sel%>><%=r.getNombre()%></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div class="col-md-2">
          <label class="form-label">Estado:</label>
          <select class="form-select" name="estado">
            <%
              if (listaEstados != null) {
                for (String e : listaEstados) {
                  String sel = e.equalsIgnoreCase(uEditar.getEstado()) ? "selected" : "";
            %>
              <option value="<%=e%>" <%=sel%>><%=e%></option>
            <%
                }
              }
            %>
          </select>
        </div>
          
          <div class="col-md-6">
    <label class="form-label">Fecha de Creación</label>
    <input type="date" name="fechaCreado"
           value="${usuarioEditar.fechaCreado}"
           class="form-control" required />
</div>


        <div class="col-md-4">
          <label class="form-label">Contraseña:</label>
          <input type="text" class="form-control" name="clave"
                 value="<%= (uEditar.getClaveHash() != null ? uEditar.getClaveHash() : "") %>"
                 required>
        </div>
      </div>

      <div class="d-flex justify-content-end mt-4 gap-2">
        <a href="<%=ctx%>/LoginServlet?action=usuarios" class="btn btn-outline-secondary btn-sm">
          Cancelar
        </a>
        <button type="submit" class="btn btn-primary btn-sm">
          Actualizar
        </button>
      </div>

    </form>
  </div>
</div>

</body>
</html>

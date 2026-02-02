<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.HistorialAccion"%>

<%
  String ctx = request.getContextPath();
  HistorialAccion h = (HistorialAccion) request.getAttribute("historialEditar");
  List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
  List<String> listaTablas = (List<String>) request.getAttribute("listaTablas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>SICULTIVO - Editar Historial</title>
  <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
  <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
</head>

<body class="bg-light">

  <div class="container py-4">
    <div class="bg-white p-4 rounded shadow-sm">

      <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Editar Historial</h3>
       
      </div>

      <% if (h == null) { %>
        <div class="alert alert-danger fw-bold">
          No se encontró el registro del historial para editar.
        </div>
      <% } else { %>

      <form action="<%=ctx%>/LoginServlet" method="post" class="row g-3">
        <input type="hidden" name="action" value="actualizarHistorial"/>
        <input type="hidden" name="idHistorial" value="<%=h.getIdHistorial()%>"/>

        <div class="col-md-4">
          <label class="form-label">Usuario</label>
          <select name="idUsuario" class="form-select" required>
            <%
              if (listaUsuarios != null) {
                for (Usuario u : listaUsuarios) {
                  String sel = (u.getIdUsuario()==h.getIdUsuario()) ? "selected" : "";
            %>
              <option value="<%=u.getIdUsuario()%>" <%=sel%>><%=u.getNombre()%></option>
            <%  }
              }
            %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Tabla afectada</label>
          <select name="tablaAfectada" class="form-select" required>
            <%
              if (listaTablas != null) {
                for (String t : listaTablas) {
                  String sel = (t != null && t.equalsIgnoreCase(h.getTablaAfectada())) ? "selected" : "";
            %>
              <option value="<%=t%>" <%=sel%>><%=t%></option>
            <%  }
              }
            %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Acción</label>
          <input type="text" name="accion" class="form-control"
                 value="<%=h.getAccion()%>" required/>
        </div>

        <div class="col-md-8">
          <label class="form-label">Descripción</label>
          <input type="text" name="descripcion" class="form-control"
                 value="<%=h.getDescripcion()%>" required/>
        </div>

        <div class="col-md-4">
          <label class="form-label">Fecha y hora</label>
          <input type="text" name="fechaHora" class="form-control"
                 value="<%=h.getFechaHora()%>"
                 placeholder="yyyy-MM-dd HH:mm:ss" required/>
        </div>

        <div class="col-12 d-flex justify-content-end gap-2 mt-2">
          <a class="btn btn-outline-secondary btn-sm"
             href="<%=ctx%>/LoginServlet?action=historial">
            Cancelar
          </a>
          <button class="btn btn-primary btn-sm" type="submit">
            Guardar cambios
          </button>
        </div>
      </form>

      <% } %>

    </div>
  </div>

</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>

<%
  String ctx = request.getContextPath();
  List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
  List<String> listaTablas = (List<String>) request.getAttribute("listaTablas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>SICULTIVO - Nuevo Historial</title>

  <!-- Bootstrap -->
  <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- CSS propio -->
  <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
</head>

<body class="bg-light">

  <div class="container py-4">
    <div class="bg-white p-4 rounded shadow-sm">

      <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">Nuevo Historial</h3>
      </div>

      <form action="<%=ctx%>/LoginServlet" method="post" class="row g-3">
        <input type="hidden" name="action" value="guardarHistorial"/>

        <div class="col-md-4">
          <label class="form-label">Usuario</label>
          <select name="idUsuario" class="form-select" required>
            <option value="">Seleccione...</option>
            <%
              if (listaUsuarios != null) {
                for (Usuario u : listaUsuarios) {
            %>
              <option value="<%=u.getIdUsuario()%>"><%=u.getNombre()%></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Tabla afectada</label>
          <select name="tablaAfectada" class="form-select" required>
            <option value="">Seleccione...</option>
            <%
              if (listaTablas != null) {
                for (String t : listaTablas) {
            %>
              <option value="<%=t%>"><%=t%></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div class="col-md-4">
          <label class="form-label">Acción</label>
          <input type="text" name="accion" class="form-control"
                 placeholder="INSERT / UPDATE / DELETE" required/>
        </div>

        <div class="col-md-8">
          <label class="form-label">Descripción</label>
          <input type="text" name="descripcion" class="form-control" required/>
        </div>

        <!-- Solo si el profe exige ingresar fecha/hora -->
        <div class="col-md-4">
          <label class="form-label">Fecha y hora</label>
          <input type="text" name="fechaHora" class="form-control"
                 placeholder="yyyy-MM-dd HH:mm:ss (opcional)"/>
        </div>

        <div class="col-12 d-flex justify-content-end gap-2 mt-3">
          <a class="btn btn-outline-secondary btn-sm"
             href="<%=ctx%>/LoginServlet?action=historial">
            Cancelar
          </a>
          <button class="btn btn-primary btn-sm" type="submit">
            Guardar
          </button>
        </div>
      </form>

    </div>
  </div>

</body>
</html>

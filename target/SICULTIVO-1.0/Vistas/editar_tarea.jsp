<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Tarea"%>
<%@page import="SICULTIVO.Modelo.Cultivo"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%
    String ctx = request.getContextPath();
    Tarea t = (Tarea) request.getAttribute("tareaEditar");
    List<Cultivo> listaCultivos = (List<Cultivo>) request.getAttribute("listaCultivos");
    List<String> listaTipoTarea = (List<String>) request.getAttribute("listaTipoTarea");
    List<String> listaEstados = (List<String>) request.getAttribute("listaEstadosTarea");
    List<Usuario> listaOperarios = (List<Usuario>) request.getAttribute("listaOperarios");

%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Editar Tarea</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
        <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
    </head>

    <body class="bg-light">

        <div class="container py-4">
            <div class="bg-white p-4 rounded shadow-sm">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Editar Tarea</h3>
                </div>

                <% if (t == null) { %>
                <div class="alert alert-danger fw-bold">
                    No se encontró la tarea para editar.
                </div>
                <% } else {%>

                <form action="<%=ctx%>/LoginServlet" method="post" class="row g-3">
                    <input type="hidden" name="action" value="actualizarTarea">
                    <input type="hidden" name="idTarea" value="<%=t.getIdTarea()%>">

                    <div class="col-md-6">
                        <label class="form-label">Cultivo <span class="text-danger">*</span></label>
                        <select class="form-select" name="idCultivo" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaCultivos != null) {
                                    for (Cultivo c : listaCultivos) {
                                        String sel = (c.getIdCultivo() == t.getIdCultivo()) ? "selected" : "";
                            %>
                            <option value="<%=c.getIdCultivo()%>" <%=sel%>><%=c.getNombre()%></option>
                            <% }
              } %>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Tipo <span class="text-danger">*</span></label>
                        <select name="tipo" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaTipoTarea != null) {
                                    for (String tipo : listaTipoTarea) {
                                        String sel = (tipo != null && tipo.equalsIgnoreCase(t.getTipo())) ? "selected" : "";
                            %>
                            <option value="<%=tipo%>" <%=sel%>><%=tipo%></option>
                            <% }
              }%>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Fecha programada <span class="text-danger">*</span></label>
                        <input type="date" name="fechaProgramada" class="form-control"
                               value="<%=t.getFechaProgramada()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Responsable <span class="text-danger">*</span></label>

                        <select name="responsable" class="form-select" required>
                            <option value="">Seleccione un operario...</option>

                            <%
                                if (listaOperarios != null) {
                                    for (Usuario op : listaOperarios) {
                                        String sel = (op.getNombre() != null && op.getNombre().equalsIgnoreCase(t.getResponsable()))
                                                ? "selected" : "";
                            %>
                            <option value="<%= op.getNombre()%>" <%= sel%>><%= op.getNombre()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>


                    <div class="col-md-4">
                        <label class="form-label">Estado <span class="text-danger">*</span></label>
                        <select name="estado" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaEstados != null) {
                                    for (String est : listaEstados) {
                                        String sel = (est != null && est.equalsIgnoreCase(t.getEstado())) ? "selected" : "";
                            %>
                            <option value="<%=est%>" <%=sel%>><%=est%></option>
                            <% }
              }%>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Fecha ejecución</label>
                        <input type="date" name="fechaEjecucion" class="form-control"
                               value="<%= (t.getFechaEjecucion() != null ? t.getFechaEjecucion() : "")%>">
                    </div>

                    <div class="col-12">
                        <label class="form-label">Observaciones</label>
                        <textarea name="observaciones" rows="2" class="form-control"><%= (t.getObservaciones() != null ? t.getObservaciones() : "")%></textarea>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2 mt-2">
                        <a class="btn btn-outline-secondary btn-sm"
                           href="<%=ctx%>/LoginServlet?action=tareas">Cancelar</a>
                        <button class="btn btn-primary btn-sm" type="submit">Guardar cambios</button>
                    </div>
                </form>

                <% }%>

            </div>
        </div>

    </body>
</html>

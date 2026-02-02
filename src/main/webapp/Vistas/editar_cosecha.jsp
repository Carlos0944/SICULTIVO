<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Cosecha"%>
<%@page import="SICULTIVO.Modelo.Cultivo"%>

<%
    String ctx = request.getContextPath();
    Cosecha c = (Cosecha) request.getAttribute("cosechaEditar");
    List<Cultivo> listaCultivos = (List<Cultivo>) request.getAttribute("listaCultivos");
    List<String> listaCalidad = (List<String>) request.getAttribute("listaCalidad");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Editar Cosecha</title>
        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
        <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
    </head>

    <body class="bg-light">

        <div class="container py-4">
            <div class="bg-white p-4 rounded shadow-sm">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Editar Cosecha</h3>
                </div>

                <% if (c == null) { %>
                <div class="alert alert-danger fw-bold">
                    No se encontró la cosecha a editar.
                </div>
                <% } else {%>

                <form action="<%=ctx%>/LoginServlet" method="post" class="row g-3">

                    <input type="hidden" name="action" value="actualizarCosecha">
                    <input type="hidden" name="idCosecha" value="<%=c.getIdCosecha()%>">

                    <!-- Cultivo -->
                    <div class="col-md-6">
                        <label class="form-label">Cultivo <span class="text-danger">*</span></label>
                        <select class="form-select" name="idCultivo" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaCultivos != null) {
                                    for (Cultivo cu : listaCultivos) {
                                        String sel = (cu.getIdCultivo() == c.getIdCultivo()) ? "selected" : "";
                            %>
                            <option value="<%=cu.getIdCultivo()%>" <%=sel%>>
                                <%=cu.getNombre()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <!-- Fecha -->
                    <div class="col-md-3">
                        <label class="form-label">Fecha de cosecha <span class="text-danger">*</span></label>
                        <input type="date" name="fechaCosecha"
                               class="form-control"
                               value="<%=c.getFechaCosecha()%>" required>
                    </div>

                    <!-- Cantidad -->
                    <div class="col-md-3">
                        <label class="form-label">Cantidad (kg) <span class="text-danger">*</span></label>
                        <input type="number" name="cantidad"
                               class="form-control"
                               step="0.01" min="0"
                               value="<%=c.getCantidad()%>" required>
                    </div>

                    <!-- Calidad -->
                    <div class="col-md-4">
                        <label class="form-label">Calidad <span class="text-danger">*</span></label>
                        <select name="calidad" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaCalidad != null) {
                                    for (String cal : listaCalidad) {
                                        String sel = cal.equalsIgnoreCase(c.getCalidad()) ? "selected" : "";
                            %>
                            <option value="<%=cal%>" <%=sel%>><%=cal%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <!-- Observaciones -->
                    <div class="col-12">
                        <label class="form-label">Observaciones</label>
                        <textarea class="form-control" name="observaciones" rows="3"
                                  placeholder="Notas adicionales..."><%=c.getObservaciones()%></textarea>
                    </div>

                    <!-- Botones -->
                    <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                        <a class="btn btn-outline-secondary btn-sm"
                           href="<%=ctx%>/LoginServlet?action=cosechas">
                            Cancelar
                        </a>

                        <button type="submit" class="btn btn-success btn-sm d-flex align-items-center">
                            <img src="<%=ctx%>/img/icon_guardar.png" class="crud-icon me-2">
                            Guardar cambios
                        </button>
                    </div>

                </form>

                <% }%>

            </div>
        </div>

    </body>
</html>

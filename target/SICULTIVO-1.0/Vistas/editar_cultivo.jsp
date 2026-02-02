<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Cultivo"%>
<%@page import="SICULTIVO.Modelo.Parcela"%>

<%
    String ctx = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

    Cultivo c = (Cultivo) request.getAttribute("cultivoEditar");
    List<Parcela> listaParcelas = (List<Parcela>) request.getAttribute("listaParcelas");
    List<String> listaEstados = (List<String>) request.getAttribute("listaEstadosCultivo");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Editar Cultivo</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
        <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
    </head>

    <body class="bg-light">

        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
            <div class="container-fluid">

                <form action="<%=ctx%>/LoginServlet" method="post">
                    <button type="submit" name="action" value="inicio"
                            class="navbar-brand btn btn-link text-white text-decoration-none p-0">
                        SICULTIVO
                    </button>
                </form>

                <ul class="navbar-nav ms-auto">
                    <li class="nav-item me-4">
                        <span class="nav-link text-white">
                            <img src="<%=ctx%>/img/icon_user.png" class="nav-user-icon me-1">
                            <strong><%= u.getNombre()%></strong> (<%= u.getRolNombre()%>)
                        </span>
                    </li>

                    <li class="nav-item">
                        <form action="<%=ctx%>/LoginServlet" method="post">
                            <button type="submit" name="action" value="logout"
                                    class="btn btn-link nav-link text-white ms-2">
                                <img src="<%=ctx%>/img/icon_logout.png" class="nav-user-icon me-1">
                                Cerrar sesión
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container py-4">
            <div class="bg-white p-4 rounded shadow-sm">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Editar Cultivo</h3>
                </div>

                <% if (c == null) { %>
                <div class="alert alert-danger fw-bold">
                    No se encontró el cultivo para editar.
                </div>
                <% } else {%>

                <form class="row g-3" action="<%=ctx%>/LoginServlet" method="post">
                    <input type="hidden" name="action" value="actualizarCultivo">
                    <input type="hidden" name="idCultivo" value="<%=c.getIdCultivo()%>">

                    <div class="col-md-6">
                        <label class="form-label">Parcela <span class="text-danger">*</span></label>
                        <select class="form-select" name="idParcela" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaParcelas != null) {
                                    for (Parcela p : listaParcelas) {
                                        String sel = (p.getIdParcela() == c.getIdParcela()) ? "selected" : "";
                            %>
                            <option value="<%=p.getIdParcela()%>" <%=sel%>><%=p.getNombre()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Nombre del cultivo <span class="text-danger">*</span></label>
                        <input type="text" name="nombre" class="form-control"
                               value="<%=c.getNombre()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Variedad <span class="text-danger">*</span></label>
                        <input type="text" name="variedad" class="form-control"
                               value="<%=c.getVariedad()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Fecha de siembra <span class="text-danger">*</span></label>
                        <input type="date" name="fechaSiembra" class="form-control"
                               value="<%=c.getFechaSiembra()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Cantidad sembrada <span class="text-danger">*</span></label>
                        <input type="number" name="cantidad" min="0" step="1"
                               class="form-control"
                               value="<%=c.getCantidadSembrada()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Estado <span class="text-danger">*</span></label>
                        <select name="estado" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaEstados != null) {
                                    for (String est : listaEstados) {
                                        String sel = (est != null && est.equalsIgnoreCase(c.getEstado())) ? "selected" : "";
                            %>
                            <option value="<%=est%>" <%=sel%>><%=est%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label">Observaciones</label>
                        <textarea class="form-control" name="observaciones" rows="2"><%= (c.getObservaciones() != null ? c.getObservaciones() : "")%></textarea>
                    </div>

                    <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                        <a class="btn btn-outline-secondary btn-sm"
                           href="<%=ctx%>/LoginServlet?action=cultivos">
                            Cancelar
                        </a>
                        <button type="submit" class="btn btn-success btn-sm d-flex align-items-center">
                            <img src="<%=ctx%>/img/icon_guardar.png" class="crud-icon me-2" alt="Guardar">
                            Guardar cambios
                        </button>
                    </div>

                </form>
                <% }%>

            </div>
        </div>

    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Parcela"%>

<%
    String ctx = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

    Parcela p = (Parcela) request.getAttribute("parcelaEditar");
    List<String> listaTiposSuelo = (List<String>) request.getAttribute("listaTiposSuelo");
    List<String> listaEstados = (List<String>) request.getAttribute("listaEstadosParcela");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Editar Parcela</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
        <link href="<%=ctx%>/CSS/style.css" rel="stylesheet"/>
    </head>

    <body class="bg-light">

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
                    <h3 class="mb-0">Editar Parcela</h3>
                </div>

                <% if (p == null) { %>
                <div class="alert alert-danger fw-bold">
                    No se encontró la parcela para editar.
                </div>
                <% } else {%>

                <form class="row g-3" action="<%=ctx%>/LoginServlet" method="post">
                    <input type="hidden" name="action" value="actualizarParcela">
                    <input type="hidden" name="idParcela" value="<%=p.getIdParcela()%>">

                    <input type="hidden" name="idUsuario" value="<%=p.getIdUsuario()%>">

                    <div class="col-md-6">
                        <label class="form-label">Nombre de la parcela <span class="text-danger">*</span></label>
                        <input type="text" name="nombre" class="form-control"
                               value="<%=p.getNombre()%>" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ubicación / referencia <span class="text-danger">*</span></label>
                        <input type="text" name="ubicacion" class="form-control"
                               value="<%=p.getUbicacion()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Área total (ha) <span class="text-danger">*</span></label>
                        <input type="number" name="area" step="0.01" min="0"
                               class="form-control"
                               value="<%=p.getArea()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Tipo de suelo <span class="text-danger">*</span></label>
                        <select name="tipoSuelo" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaTiposSuelo != null) {
                                    for (String ts : listaTiposSuelo) {
                                        String sel = (ts != null && ts.equalsIgnoreCase(p.getTipoSuelo())) ? "selected" : "";
                            %>
                            <option value="<%=ts%>" <%=sel%>><%=ts%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Estado operativo <span class="text-danger">*</span></label>
                        <select name="estado" class="form-select" required>
                            <option value="">Seleccione...</option>
                            <%
                                if (listaEstados != null) {
                                    for (String est : listaEstados) {
                                        String sel = (est != null && est.equalsIgnoreCase(p.getEstado())) ? "selected" : "";
                            %>
                            <option value="<%=est%>" <%=sel%>><%=est%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Fecha de creación <span class="text-danger">*</span></label>
                        <input type="datetime-local" name="fechaCreado" class="form-control"
                               value="<%= (p.getFechaCreado() != null ? p.getFechaCreado().replace(" ", "T").substring(0, 16) : "")%>"
                               required>
                    </div>


                    <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                        <a class="btn btn-outline-secondary btn-sm"
                           href="<%=ctx%>/LoginServlet?action=parcelas">
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

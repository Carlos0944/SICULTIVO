<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Parcela"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    List<Parcela> listaParcelas = (List<Parcela>) request.getAttribute("listaParcelas");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Registrar Parcela</title>

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

        <div class="container-fluid">
            <div class="row">

                <nav class="col-md-3 col-lg-2 bg-white sidebar shadow-sm pt-3">
                    <h6 class="sidebar-heading px-3 text-muted text-uppercase">Módulos</h6>

                    <form action="<%=ctx%>/LoginServlet" method="post">

                        <button type="submit" name="action" value="inicio"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_inicio.png" class="sidebar-icon"> Inicio
                        </button>

                        <button type="submit" name="action" value="parcelas"
                                class="btn btn-link nav-link text-start sidebar-item active">
                            <img src="<%=ctx%>/img/icon_parcela.png" class="sidebar-icon"> Parcelas
                        </button>

                        <% if ("ADMINISTRADOR".equalsIgnoreCase(u.getRolNombre())) {%>

                        <button type="submit" name="action" value="cultivos"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cultivo.png" class="sidebar-icon"> Cultivos
                        </button>

                        <button type="submit" name="action" value="tareas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_tareas.png" class="sidebar-icon"> Tareas agrícolas
                        </button>

                        <button type="submit" name="action" value="cosechas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cosecha.png" class="sidebar-icon"> Cosechas
                        </button>

                        <button type="submit" name="action" value="historial"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_historia.png" class="sidebar-icon"> Historial
                        </button>

                        <button type="submit" name="action" value="usuarios"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_usuarios.png" class="sidebar-icon"> Gestión de Usuarios
                        </button>

                        <% } else {%>

                        <button type="submit" name="action" value="cultivos"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cultivo.png" class="sidebar-icon"> Cultivos
                        </button>

                        <button type="submit" name="action" value="tareas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_tareas.png" class="sidebar-icon"> Tareas agrícolas
                        </button>

                        <button type="submit" name="action" value="cosechas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cosecha.png" class="sidebar-icon"> Cosechas
                        </button>

                        <% }%>
                    </form>
                </nav>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-md-9 ms-sm-auto col-lg-10 p-4 main-content-bg main-scroll-area">

                    <div class="bg-white bg-opacity-75 p-4 rounded shadow-sm mb-4">
                        <h3 class="mb-3">Registrar Parcela</h3>
                        <p class="text-muted">
                            Complete el formulario para registrar una nueva parcela.
                            Los campos con <span class="text-danger">*</span> son obligatorios.
                        </p>
                          <%
                                String msgOk = (String) session.getAttribute("msgOk");
                                String msgError = (String) session.getAttribute("msgError");
                            %>

                            <% if (msgOk != null) {%>
                            <div class="alert alert-success alert-dismissible fade show fw-bold" role="alert">
                                <%= msgOk%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                session.removeAttribute("msgOk");
                            %>
                            <% } %>

                            <% if (msgError != null) {%>
                            <div class="alert alert-danger alert-dismissible fade show fw-bold" role="alert">
                                <%= msgError%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                session.removeAttribute("msgError");
                            %>
                            <% }%>

                        <form class="row g-3" action="<%=ctx%>/LoginServlet" method="post">
                            <input type="hidden" name="action" value="guardarParcela">

                            <div class="col-md-6">
                                <label class="form-label">Nombre de la parcela <span class="text-danger">*</span></label>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej. Parcela Norte" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Ubicación / referencia <span class="text-danger">*</span></label>
                                <input type="text" name="ubicacion" class="form-control" placeholder="Ej. Sector La Esperanza, Cayambe" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Área total (ha) <span class="text-danger">*</span></label>
                                <input type="number" name="area" step="0.01" min="0" class="form-control" required>
                                <div class="form-text">
                                    El área debe ser un valor numérico mayor a cero.
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">
                                    Tipo de suelo <span class="text-danger">*</span>
                                </label>

                                <select name="tipoSuelo" class="form-select" required>
                                    <option value="">Seleccione...</option>

                                    <%
                                        List<String> listaTipoSuelo
                                                = (List<String>) request.getAttribute("listaTiposSuelo");

                                        if (listaTipoSuelo != null) {
                                            for (String est : listaTipoSuelo) {
                                    %>
                                    <option value="<%= est%>"><%= est%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>


                            <div class="col-md-4">
                                <label class="form-label">
                                    Estado operativo <span class="text-danger">*</span>
                                </label>

                                <select name="estado" class="form-select" required>
                                    <option value="">Seleccione...</option>

                                    <%
                                        List<String> listaEstados
                                                = (List<String>) request.getAttribute("listaEstadosParcela");

                                        if (listaEstados != null) {
                                            for (String est : listaEstados) {
                                    %>
                                    <option value="<%= est%>"><%= est%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                          

                            <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                                <button type="reset" class="btn btn-outline-secondary btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_limpiar.png" class="crud-icon me-2" alt="Limpiar">
                                    Limpiar
                                </button>

                                <button type="submit" class="btn btn-success btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_guardar.png" class="crud-icon me-2" alt="Guardar parcela">
                                    Guardar
                                </button>
                            </div>

                        </form>
                    </div>

                    <div class="bg-white bg-opacity-75 p-4 rounded shadow-sm">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Listado general de parcelas</h5>
                        </div>
                        <form action="<%=ctx%>/LoginServlet" method="post" class="mb-3">
                            <input type="hidden" name="action" value="parcelas">

                            <div class="d-flex justify-content-end align-items-center gap-2">

                                <input type="text"
                                       name="buscar"
                                       class="form-control form-control-sm w-25"
                                       placeholder="Buscar parcela">

                                <button type="submit"
                                        class="btn btn-outline-success btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_buscar.png"
                                         class="crud-icon me-1" alt="Buscar">
                                    Buscar
                                </button>

                            </div>
                        </form>


                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-sm align-middle">
                                <thead class="table-success">
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Ubicación</th>
                                        <th>Área (ha)</th>
                                        <th>Tipo de suelo</th>
                                        <th>Estado</th>
                                        <th>Fecha de creación</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <%
                                        List<Parcela> lista = (List<Parcela>) request.getAttribute("listaParcelas");
                                        if (lista != null && !lista.isEmpty()) {
                                            for (Parcela p : lista) {
                                    %>
                                    <tr>
                                        <td><%=p.getNombre()%></td>
                                        <td><%=p.getUbicacion()%></td>
                                        <td><%=p.getArea()%></td>
                                        <td><%=p.getTipoSuelo()%></td>
                                        <td><%=p.getEstado()%></td>
                                        <td><%=p.getFechaCreado()%></td>
                                        <td class="text-center">
                                            <a class="btn btn-warning btn-sm d-inline-flex align-items-center"
                                               href="<%=ctx%>/LoginServlet?action=editarParcela&id=<%=p.getIdParcela()%>">
                                                <img src="<%=ctx%>/img/icon_editar.png" class="crud-icon me-1" alt="Editar">
                                                Editar
                                            </a>
                                            <button type="button"
                                                    class="btn btn-danger btn-sm d-inline-flex align-items-center"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#modalEliminarParcela"
                                                    data-id="<%= p.getIdParcela()%>">
                                                <img src="<%=ctx%>/img/icon_eliminar.png" class="crud-icon me-1" alt="Eliminar">
                                                Eliminar
                                            </button>

                                        </td>

                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted">
                                            No hay parcelas registradas.
                                        </td>
                                    </tr>
                                    <% }%>

                                </tbody>

                            </table>
                        </div>

                    </div>
                    <div class="modal fade" id="modalEliminarParcela" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">Confirmar eliminación</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                     No se puede eliminar una parcela si tiene cultivos asociados.<br>
                                    ¿Desea continuar?
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <a id="btnConfirmEliminarParcela" class="btn btn-danger">Sí, eliminar</a>
                                </div>

                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>
        <script>
            const modalParcela = document.getElementById('modalEliminarParcela');
            modalParcela.addEventListener('show.bs.modal', function (event) {
                const btn = event.relatedTarget;
                const id = btn.getAttribute('data-id');

                document.getElementById('btnConfirmEliminarParcela').href =
                        '<%=ctx%>/LoginServlet?action=eliminarParcela&id=' + id;
            });
        </script>

    </body>
</html>

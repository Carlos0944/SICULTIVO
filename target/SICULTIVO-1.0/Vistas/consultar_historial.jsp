<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.HistorialAccion"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    List<HistorialAccion> lista
            = (List<HistorialAccion>) request.getAttribute("listaHistorial");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Historial de acciones</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>

        <link href="<%= ctx%>/CSS/style.css" rel="stylesheet" />
    </head>

    <body class="bg-light">

        <!-- NAVBAR SUPERIOR -->
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

        <!-- CONTENIDO GENERAL -->
        <div class="container-fluid">
            <div class="row">
                <!-- SIDEBAR -->
                <nav class="col-md-3 col-lg-2 bg-white sidebar shadow-sm">
                    <div class="pt-3">
                        <h6 class="sidebar-heading px-3 mb-3 text-muted text-uppercase">Módulos</h6>
                        <form action="<%=ctx%>/LoginServlet" method="post">
                            <button type="submit" name="action" value="inicio"
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_inicio.png" class="sidebar-icon"> Inicio
                            </button>

                            <% if ("ADMINISTRADOR".equalsIgnoreCase(u.getRolNombre())) {%>
                            <button type="submit" name="action" value="parcelas"
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_parcela.png" class="sidebar-icon"> Parcelas
                            </button>
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

                            <button type="submit" name="action" value="historial"
                                    class="btn btn-link nav-link text-start sidebar-item active">
                                <img src="<%=ctx%>/img/icon_historia.png" class="sidebar-icon"> Historial
                            </button>
                            <button type="submit" name="action" value="usuarios"
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_usuarios.png" class="sidebar-icon"> Gestión de Usuarios
                            </button>
                        </form>
                    </div>
                </nav>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-md-9 ms-sm-auto col-lg-10 p-4 main-content-bg main-scroll-area">

                    <div class="bg-white p-4 rounded shadow-sm">

                        <h3 class="mb-3">Historial de acciones</h3>

                        <p class="text-muted">
                            Consulta de actividades de usuarios según filtros seleccionados.
                        </p>
                        <%
                            String msgOk = (String) session.getAttribute("msgOk");
                            if (msgOk != null) {%>
                        <div class="alert alert-success alert-dismissible fade show fw-bold">
                            <%=msgOk%><button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <%  session.removeAttribute("msgOk");
                            } %>

                        <%
                            String msgError = (String) session.getAttribute("msgError");
                            if (msgError != null) {%>
                        <div class="alert alert-danger alert-dismissible fade show fw-bold">
                            <%=msgError%><button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <%  session.removeAttribute("msgError");
                            }%>


                        <!-- FILTROS  -->
                        <form action="<%=ctx%>/LoginServlet" method="post" class="card p-3 mb-4">
                            <input type="hidden" name="action" value="historial"/>

                            <h6 class="mb-3">Filtros de búsqueda</h6>

                            <!-- ✅ CORREGIDO: solo un row g-3 -->
                            <div class="row g-3">

                                <div class="col-md-4">
                                    <label class="form-label">Usuario:</label>
                                    <select class="form-select" name="idUsuario">
                                        <option value="">-- Todos --</option>
                                        <%
                                            List<Usuario> listaUsuarios
                                                    = (List<Usuario>) request.getAttribute("listaUsuarios");
                                            if (listaUsuarios != null) {
                                                for (Usuario usr : listaUsuarios) {
                                        %>
                                        <option value="<%=usr.getIdUsuario()%>">
                                            <%=usr.getNombre()%>
                                        </option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label">Tabla afectada:</label>
                                    <select class="form-select" name="tabla">
                                        <option value="">-- Todas --</option>
                                        <%
                                            List<String> listaTablas
                                                    = (List<String>) request.getAttribute("listaTablas");

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
                                    <label class="form-label">Rango de fechas:</label>
                                    <input type="date" class="form-control mb-2" name="desde">
                                    <input type="date" class="form-control" name="hasta">
                                </div>

                                <div class="col-12">
                                    <button type="submit" class="btn btn-success d-flex align-items-center">
                                        <img src="<%=ctx%>/img/icon_buscar.png"
                                             class="crud-icon me-2" alt="Buscar">
                                        Buscar
                                    </button>
                                </div>

                            </div>
                        </form>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="mb-0">Historiales  registrados</h6>

                            <form action="<%=ctx%>/LoginServlet" method="post" class="m-0">
                                <button type="submit" name="action" value="nuevoHistorial"
                                        class="btn btn-success btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_nuevo.png"
                                         class="crud-icon me-2" alt="Nuevo">
                                    Nuevo
                                </button>
                            </form>
                        </div>

                        <!-- TABLA DEL HISTORIAL -->
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-sm align-middle">
                                <thead class="table-success">
                                    <tr>
                                        <th>Usuario</th>
                                        <th>Tabla</th>
                                        <th>Acción</th>
                                        <th>Descripción</th>
                                        <th>Fecha y hora</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <%
                                        if (lista != null && !lista.isEmpty()) {
                                            for (HistorialAccion h : lista) {
                                    %>
                                    <tr>
                                        <td><%=h.getNombreUsuario()%></td>
                                        <td><%=h.getTablaAfectada()%></td>
                                        <td><%=h.getAccion()%></td>
                                        <td><%=h.getDescripcion()%></td>
                                        <td><%=h.getFechaHora()%></td>
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-2">

                                                <a class="btn btn-warning btn-sm d-inline-flex align-items-center"
                                                   href="<%=ctx%>/LoginServlet?action=editarHistorial&id=<%=h.getIdHistorial()%>">
                                                    <img src="<%=ctx%>/img/icon_editar.png" class="crud-icon me-1" alt="Editar">
                                                    Editar
                                                </a>

                                                <button type="button"
                                                        class="btn btn-danger btn-sm d-inline-flex align-items-center"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#modalEliminarHistorial"
                                                        data-id="<%= h.getIdHistorial()%>">
                                                    <img src="<%=ctx%>/img/icon_eliminar.png" class="crud-icon me-1" alt="Eliminar">
                                                    Eliminar
                                                </button>

                                            </div>
                                        </td>


                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            No existen registros para los filtros seleccionados.
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal fade" id="modalEliminarHistorial" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">Confirmar eliminación</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                    ¿Desea eliminar este registro del historial?
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <a id="btnConfirmEliminarHistorial" class="btn btn-danger">Sí, eliminar</a>
                                </div>

                            </div>
                        </div>
                    </div>


                </main>
            </div>
        </div>
        <script>
            const modalHist = document.getElementById('modalEliminarHistorial');
            modalHist.addEventListener('show.bs.modal', function (event) {
                const btn = event.relatedTarget;
                const id = btn.getAttribute('data-id');

                document.getElementById('btnConfirmEliminarHistorial').href =
                        '<%=ctx%>/LoginServlet?action=eliminarHistorial&id=' + id;
            });
        </script>

    </body>
</html>

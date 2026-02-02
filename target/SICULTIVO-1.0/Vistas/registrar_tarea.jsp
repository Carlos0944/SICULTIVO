<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Tarea"%>
<%@page import="SICULTIVO.Modelo.Cultivo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    // Verificar sesión
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    // Listas enviadas desde el Servlet (action=tareas)
    List<Tarea> listaTareas = (List<Tarea>) request.getAttribute("listaTareas");
    List<Cultivo> listaCultivos = (List<Cultivo>) request.getAttribute("listaCultivos");
    String msgTarea = (String) session.getAttribute("msgOk");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Registrar Tarea Agrícola</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"></script>
        <link href="<%=ctx%>/CSS/style.css" rel="stylesheet" />
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

        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <nav class="col-md-3 col-lg-2 bg-white sidebar shadow-sm pt-3">
                    <h6 class="sidebar-heading px-3 text-muted text-uppercase">Módulos</h6>

                    <form action="<%=ctx%>/LoginServlet" method="post">

                        <button type="submit" name="action" value="inicio"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_inicio.png" class="sidebar-icon"> Inicio
                        </button>

                        <button type="submit" name="action" value="parcelas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_parcela.png" class="sidebar-icon"> Parcelas
                        </button>

                        <button type="submit" name="action" value="cultivos"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cultivo.png" class="sidebar-icon"> Cultivos
                        </button>

                        <button type="submit" name="action" value="tareas"
                                class="btn btn-link nav-link text-start sidebar-item active">
                            <img src="<%=ctx%>/img/icon_tareas.png" class="sidebar-icon"> Tareas agrícolas
                        </button>

                        <% if ("ADMINISTRADOR".equalsIgnoreCase(u.getRolNombre())) {%>
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
                        <h3 class="mb-3">Registrar Tarea Agrícola</h3>
                        <p class="text-muted">
                            Registre tareas agrícolas (riego, fertilización, deshierbe, fumigación, etc.)
                            asociadas a un cultivo existente. Los campos marcados con
                            <span class="text-danger">*</span> son obligatorios.
                        </p>

                        <form class="row g-3" action="<%=ctx%>/LoginServlet" method="post">
                            <input type="hidden" name="action" value="guardarTarea">

                            <div class="col-md-6">
                                <label class="form-label">Cultivo <span class="text-danger">*</span></label>

                                <select class="form-select" name="idCultivo" required>
                                    <option value="">Seleccione un cultivo...</option>
                                    <%
                                        if (listaCultivos != null && !listaCultivos.isEmpty()) {
                                            for (Cultivo c : listaCultivos) {
                                    %>
                                    <option value="<%=c.getIdCultivo()%>"> <%=c.getNombre()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>

                                <div class="form-text">
                                    Si no hay cultivos registrados:
                                    “Es necesario registrar un cultivo primero”.
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">
                                    Tipo de tarea <span class="text-danger">*</span>
                                </label>

                                <select name="tipo" class="form-select" required>
                                    <option value="">Seleccione...</option>

                                    <%
                                        List<String> listaTipoTarea
                                                = (List<String>) request.getAttribute("listaTipoTarea");

                                        if (listaTipoTarea != null) {
                                            for (String est : listaTipoTarea) {
                                    %>
                                    <option value="<%= est%>"><%= est%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Fecha programada <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="fechaProgramada" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Responsable <span class="text-danger">*</span></label>

                                <select class="form-select" name="responsable" required>
                                    <option value="">Seleccione un operario...</option>

                                    <%
                                        List<Usuario> listaOperarios
                                                = (List<Usuario>) request.getAttribute("listaOperarios");

                                        if (listaOperarios != null) {
                                            for (Usuario op : listaOperarios) {
                                    %>
                                    <option value="<%= op.getNombre()%>">
                                        <%= op.getNombre()%>
                                    </option>
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
                                                = (List<String>) request.getAttribute("listaEstadosTarea");

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


                            <div class="col-md-4">
                                <label class="form-label">Fecha de ejecución</label>
                                <input type="date" class="form-control" name="fechaEjecucion">
                            </div>

                            <div class="col-md-8">
                                <label class="form-label">Observaciones</label>
                                <textarea class="form-control" rows="2" name="observaciones"
                                          placeholder="Notas sobre la tarea, insumos utilizados, condiciones del clima, etc."></textarea>
                            </div>

                            <% if (msgTarea != null) {%>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <%= msgTarea%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                session.removeAttribute("msgOk");
                            %>
                            <% }%>

                            <%
                                String msgError = (String) session.getAttribute("msgError");
                                if (msgError != null) {
                            %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <%= msgError%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <%
                                    session.removeAttribute("msgError");
                                }
                            %>


                            <div class="col-12 d-flex justify-content-end gap-2 mt-3">
                                <button type="reset" class="btn btn-outline-secondary btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_limpiar.png"
                                         class="crud-icon me-2" alt="Limpiar">
                                    Limpiar
                                </button>

                                <button type="submit" class="btn btn-success btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_guardar.png"
                                         class="crud-icon me-2" alt="Guardar tarea">
                                    Guardar
                                </button>
                            </div>

                        </form>
                    </div>

                    <div class="bg-white bg-opacity-75 p-4 rounded shadow-sm">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Listado general de tareas agrícolas</h5>
                        </div>

                        <form action="<%=ctx%>/LoginServlet" method="post" class="mb-3">
                            <input type="hidden" name="action" value="tareas">

                            <div class="d-flex justify-content-end align-items-center gap-2">
                                <input type="text"
                                       name="buscar"
                                       class="form-control form-control-sm w-25"
                                       placeholder="Buscar tarea">

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
                                        <th>Nombre Cultivo</th>
                                        <th>Tipo de tarea</th>
                                        <th>Fecha programada</th>
                                        <th>Responsable</th>
                                        <th>Estado</th>
                                        <th>Fecha ejecución</th>
                                        <th>Observaciones</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (listaTareas != null && !listaTareas.isEmpty()) {
                                            for (Tarea t : listaTareas) {
                                    %>
                                    <tr>
                                        <td><%=t.getNombreCultivo()%></td>
                                        <td><%=t.getTipo()%></td>
                                        <td><%=t.getFechaProgramada()%></td>
                                        <td><%=t.getResponsable()%></td>
                                        <td><%=t.getEstado()%></td>
                                        <td><%=t.getFechaEjecucion()%></td>
                                        <td><%=t.getObservaciones()%></td>
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-2">
                                                <a class="btn btn-warning btn-sm d-inline-flex align-items-center"
                                                   href="<%=ctx%>/LoginServlet?action=editarTarea&id=<%=t.getIdTarea()%>">
                                                    <img src="<%=ctx%>/img/icon_editar.png" class="crud-icon me-1" alt="Editar">
                                                    Editar
                                                </a>

                                                <button type="button"
                                                        class="btn btn-danger btn-sm d-inline-flex align-items-center"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#modalEliminarTarea"
                                                        data-id="<%= t.getIdTarea()%>">
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
                                        <td colspan="9" class="text-center text-muted">
                                            No hay tareas registradas.
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal fade" id="modalEliminarTarea" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">Confirmar eliminación</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                    ¿Desea eliminar esta tarea?
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <a id="btnConfirmEliminarTarea" class="btn btn-danger">Sí, eliminar</a>
                                </div>

                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>
        <script>
            const modalTarea = document.getElementById('modalEliminarTarea');
            modalTarea.addEventListener('show.bs.modal', function (event) {
                const btn = event.relatedTarget;
                const id = btn.getAttribute('data-id');

                document.getElementById('btnConfirmEliminarTarea').href =
                        '<%=ctx%>/LoginServlet?action=eliminarTarea&id=' + id;
            });
        </script>

    </body>
</html>

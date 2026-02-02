<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Cultivo"%>
<%@page import="SICULTIVO.Modelo.Parcela"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    // Verificar sesión
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    //  Listas enviadas desde el Servlet
    List<Cultivo> listaCultivos = (List<Cultivo>) request.getAttribute("listaCultivos");
    List<Parcela> listaParcelas = (List<Parcela>) request.getAttribute("listaParcelas");
    String msgCultivo = (String) session.getAttribute("msgOk");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Registrar Cultivo</title>

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
                            <img src="<%=ctx%>/img/icon_inicio.png" class="sidebar-icon" alt="Inicio"> Inicio
                        </button>

                        <button type="submit" name="action" value="parcelas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_parcela.png" class="sidebar-icon" alt="Parcelas"> Parcelas
                        </button>

                        <!-- Módulo actual: Cultivos -->
                        <button type="submit" name="action" value="cultivos"
                                class="btn btn-link nav-link text-start sidebar-item active">
                            <img src="<%=ctx%>/img/icon_cultivo.png" class="sidebar-icon" alt="Cultivos"> Cultivos
                        </button>

                        <% if ("ADMINISTRADOR".equalsIgnoreCase(u.getRolNombre())) {%>
                        <button type="submit" name="action" value="tareas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_tareas.png" class="sidebar-icon" alt="Tareas"> Tareas agrícolas
                        </button>

                        <button type="submit" name="action" value="cosechas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cosecha.png" class="sidebar-icon" alt="Cosechas"> Cosechas
                        </button>

                        <button type="submit" name="action" value="historial"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_historia.png" class="sidebar-icon" alt="Historial"> Historial
                        </button>

                        <button type="submit" name="action" value="usuarios"
                                class="btn btn-link nav-link text-start">
                            <img src="<%=ctx%>/img/icon_usuarios.png" class="sidebar-icon" alt="Usuarios"> Gestión de Usuarios
                        </button>
                        <% } else {%>
                        <button type="submit" name="action" value="tareas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_tareas.png" class="sidebar-icon" alt="Tareas"> Tareas agrícolas
                        </button>

                        <button type="submit" name="action" value="cosechas"
                                class="btn btn-link nav-link text-start sidebar-item">
                            <img src="<%=ctx%>/img/icon_cosecha.png" class="sidebar-icon" alt="Cosechas"> Cosechas
                        </button>
                        <% }%>
                    </form>
                </nav>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-md-9 ms-sm-auto col-lg-10 p-4 main-content-bg main-scroll-area">

                    <div class="bg-white bg-opacity-75 p-4 rounded shadow-sm mb-4">
                        <h3 class="mb-3">Registrar Cultivo</h3>
                        <p class="text-muted">
                            Registre un nuevo cultivo asociado a una parcela existente.
                            Los campos marcados con <span class="text-danger">*</span> son obligatorios.
                        </p>

                        <form class="row g-3" action="<%=ctx%>/LoginServlet" method="post">
                            <input type="hidden" name="action" value="guardarCultivo">

                            <div class="col-md-6">
                                <label class="form-label">Parcela <span class="text-danger">*</span></label>

                                <select class="form-select" name="idParcela" required>
                                    <option value="">Seleccione una parcela...</option>
                                    <%
                                        if (listaParcelas != null && !listaParcelas.isEmpty()) {
                                            for (Parcela p : listaParcelas) {
                                    %>
                                    <option value="<%=p.getIdParcela()%>"><%=p.getNombre()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Nombre del cultivo <span class="text-danger">*</span></label>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej. Lechuga crespa" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Variedad <span class="text-danger">*</span></label>
                                <input type="text" name="variedad" class="form-control" placeholder="Ej. Romana, Iceberg, etc." required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Fecha de siembra <span class="text-danger">*</span></label>
                                <input type="date" name="fechaSiembra" class="form-control" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Cantidad sembrada <span class="text-danger">*</span></label>
                                <input type="number" name="cantidad" min="0" step="1" class="form-control"
                                       placeholder="Ej. 500 plantas" required>
                                <div class="form-text">
                                    Ingrese un valor numérico mayor o igual a cero.
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">
                                    Estado <span class="text-danger">*</span>
                                </label>

                                <select name="estado" class="form-select" required>
                                    <option value="">Seleccione...</option>

                                    <%
                                        List<String> listaEstados
                                                = (List<String>) request.getAttribute("listaEstadosCultivo");

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

                            <div class="col-md-8">
                                <label class="form-label">Observaciones</label>
                                <textarea class="form-control" name="observaciones" rows="2"
                                          placeholder="Notas adicionales sobre el cultivo, plagas, fertilización, etc."></textarea>
                            </div>

                            <% if (msgCultivo != null) {%>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <%= msgCultivo%>
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
                                    <img src="<%=ctx%>/img/icon_limpiar.png" class="crud-icon me-2" alt="Limpiar">
                                    Limpiar
                                </button>
                                <button type="submit" class="btn btn-success btn-sm d-flex align-items-center">
                                    <img src="<%=ctx%>/img/icon_guardar.png" class="crud-icon me-2" alt="Guardar cultivo">
                                    Guardar
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="bg-white bg-opacity-75 p-4 rounded shadow-sm">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Listado general de cultivos</h5>                         
                        </div>
                        <form action="<%=ctx%>/LoginServlet" method="post" class="mb-3">
                            <input type="hidden" name="action" value="cultivos">

                            <div class="d-flex justify-content-end align-items-center gap-2">

                                <input type="text"
                                       name="buscar"
                                       class="form-control form-control-sm w-25"
                                       placeholder="Buscar cultivo">

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
                                        <th>Parcela</th>
                                        <th>Cultivo</th>
                                        <th>Variedad</th>
                                        <th>Fecha siembra</th>
                                        <th>Cantidad sembrada</th>
                                        <th>Estado</th>
                                        <th>Observaciones</th>
                                        <th class="text-center">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (listaCultivos != null && !listaCultivos.isEmpty()) {
                                            for (Cultivo c : listaCultivos) {
                                    %>
                                    <tr>
                                        <td><%=c.getNombreParcela()%></td>
                                        <td><%=c.getNombre()%></td>
                                        <td><%=c.getVariedad()%></td>
                                        <td><%=c.getFechaSiembra()%></td>
                                        <td><%=c.getCantidadSembrada()%></td>
                                        <td><%=c.getEstado()%></td>
                                        <td><%=c.getObservaciones()%></td>
                                        <td class="text-center">
                                            <div class="d-inline-flex gap-2 flex-nowrap" style="white-space:nowrap;">

                                                <a class="btn btn-warning btn-sm d-inline-flex align-items-center"
                                                   href="<%=ctx%>/LoginServlet?action=editarCultivo&id=<%=c.getIdCultivo()%>">
                                                    <img src="<%=ctx%>/img/icon_editar.png" class="crud-icon me-1" alt="Editar">
                                                    Editar
                                                </a>

                                                <button type="button"
                                                        class="btn btn-danger btn-sm d-inline-flex align-items-center"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#modalEliminarCultivo"
                                                        data-id="<%= c.getIdCultivo()%>">
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
                                            No hay cultivos registrados.
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal fade" id="modalEliminarCultivo" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">Confirmar eliminación</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                    No se puede eliminar un cultivo si tiene tareas o cosechas asociadas.<br>
                                    ¿Desea continuar?
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    <a id="btnConfirmEliminarCultivo" class="btn btn-danger">Sí, eliminar</a>
                                </div>

                            </div>
                        </div>
                    </div>

                </main>
            </div>
        </div>
        <script>
            const modalCultivo = document.getElementById('modalEliminarCultivo');
            modalCultivo.addEventListener('show.bs.modal', function (event) {
                const btn = event.relatedTarget;
                const id = btn.getAttribute('data-id');

                document.getElementById('btnConfirmEliminarCultivo').href =
                        '<%=ctx%>/LoginServlet?action=eliminarCultivo&id=' + id;
            });
        </script>

    </body>
</html>

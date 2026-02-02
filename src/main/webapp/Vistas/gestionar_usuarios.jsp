<%@page import="java.util.List"%>
<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page import="SICULTIVO.Modelo.Rol"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%
    String ctx = request.getContextPath();
    // Verificar sesión
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");
    // Listas enviadas desde el servlet (action=usuarios)
    List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
    List<Rol> listaRoles = (List<Rol>) request.getAttribute("listaRoles");
    String msgUsuarios = (String) session.getAttribute("msgOk");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Gestión de Usuarios</title>

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
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_historia.png" class="sidebar-icon"> Historial
                            </button>

                            <!-- Gestión de usuarios (activa) -->
                            <button type="submit" name="action" value="usuarios"
                                    class="btn btn-link nav-link text-start active">
                                <img src="<%=ctx%>/img/icon_usuarios.png" class="sidebar-icon"> Gestión de Usuarios
                            </button>

                        </form>
                    </div>
                </nav>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-md-9 ms-sm-auto col-lg-10 p-4 main-content-bg main-scroll-area">
                    <div class="bg-white p-4 rounded shadow-sm">

                        <h3 class="mb-3">Gestión de Usuarios</h3>
                        <p class="text-muted">
                            Módulo para registrar, actualizar y administrar los usuarios del sistema
                            (administradores y operadores agrícolas).
                        </p>

                        <% if (msgUsuarios != null) {%>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <%= msgUsuarios%>
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
                        <div class="alert alert-danger alert-dismissible fade show fw-bold" role="alert">
                            <%= msgError%>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <%
                                session.removeAttribute("msgError");
                            }
                        %>


                        <div class="card mb-4">
                            <div class="card-body">
                                <h6 class="card-title mb-3">Datos del usuario</h6>

                                <form action="<%=ctx%>/LoginServlet" method="post">
                                    <input type="hidden" name="action" value="guardarUsuario">

                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label">Nombre completo:</label>
                                            <input type="text" class="form-control" name="nombre" placeholder="Nombre y apellido" required>
                                        </div>

                                        <div class="col-md-4">
                                            <label class="form-label">Correo electrónico:</label>
                                            <input type="email" class="form-control" name="correo" placeholder="correo@ejemplo.com" required>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label">Rol:</label>
                                            <select class="form-select" name="idRol" required>
                                                <option value="">Seleccione...</option>
                                                <%
                                                    if (listaRoles != null && !listaRoles.isEmpty()) {
                                                        for (Rol r : listaRoles) {
                                                %>
                                                <option value="<%= r.getIdRol()%>"><%= r.getNombre()%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>

                                        <div class="col-md-2">
                                            <label class="form-label">Estado:</label>
                                            <select class="form-select" name="estado">
                                                <%
                                                    List<String> estados = (List<String>) request.getAttribute("listaEstados");
                                                    if (estados != null) {
                                                        for (String e : estados) {
                                                %>
                                                <option value="<%=e%>"><%=e%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>

                                        </div>

                                        <div class="col-md-4">
                                            <label class="form-label">Contraseña:</label>
                                            <input type="text" class="form-control" name="clave" placeholder="Clave " required>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-end mt-4 gap-2">

                                        <button type="reset" class="btn btn-outline-secondary btn-sm d-flex align-items-center">
                                            <img src="<%=ctx%>/img/icon_limpiar.png" class="crud-icon me-2" alt="Limpiar">
                                            Limpiar
                                        </button>

                                        <button type="submit" class="btn btn-primary btn-sm d-flex align-items-center">
                                            <img src="<%=ctx%>/img/icon_guardar.png" class="crud-icon me-2" alt="Guardar">
                                            Guardar
                                        </button>

                                    </div>
                                </form>

                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="mb-0">Usuarios registrados</h6>

                            <form action="<%=ctx%>/LoginServlet" method="post" class="m-0">
                                <input type="hidden" name="action" value="usuarios">

                                <div class="d-flex justify-content-end align-items-center gap-2">
                                    <input type="text" name="buscar"
                                           class="form-control form-control-sm w-25"
                                           placeholder="Buscar usuario">

                                    <button type="submit"
                                            class="btn btn-outline-success btn-sm d-flex align-items-center">
                                        <img src="<%=ctx%>/img/icon_buscar.png"
                                             class="crud-icon me-1" alt="Buscar">
                                        Buscar
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- TABLA -->
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-sm align-middle">
                                <thead class="table-success">
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Correo</th>
                                        <th>Rol</th>
                                        <th>Estado</th>
                                        <th>Fecha creación</th>
                                        <th>Acciones</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                            for (Usuario usr : listaUsuarios) {
                                    %>
                                    <tr>
                                        <td><%= usr.getNombre()%></td>
                                        <td><%= usr.getCorreo()%></td>
                                        <td><%= usr.getRolNombre()%></td>
                                        <td><%= usr.getEstado()%></td>
                                        <td><%String fc = usr.getFechaCreado();
                                            if (fc != null && fc.length() >= 10) {
                                                out.print(fc.substring(0, 10));
                                            } else {
                                                out.print("--");
                                            }
                                            %>
                                        </td>

                                        <td class="text-center">
                                            <a class="btn btn-warning btn-sm d-inline-flex align-items-center"
                                               href="<%=ctx%>/LoginServlet?action=editarUsuario&id=<%= usr.getIdUsuario()%>">
                                                <img src="<%=ctx%>/img/icon_editar.png" class="crud-icon me-1" alt="Editar">
                                                Editar
                                            </a>
                                            <button type="button"
                                                    class="btn btn-danger btn-sm d-inline-flex align-items-center"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#modalEliminarUsuario"
                                                    data-id="<%= usr.getIdUsuario()%>">
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
                                        <td colspan="6" class="text-center text-muted">
                                            No hay usuarios registrados aún.
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal fade" id="modalEliminarUsuario" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">

                                <div class="modal-header bg-danger text-white">
                                    <h5 class="modal-title">Confirmar eliminación</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                </div>

                                <div class="modal-body">
                                    No se puede eliminar el usuario si tiene datos relacionados.<br>
                                    ¿Desea continuar?
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Cancelar
                                    </button>

                                    <a id="btnConfirmEliminarUsuario" class="btn btn-danger">
                                        Sí, eliminar
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>

                </main>

            </div>
        </div>
        <script>
            const modalEliminar = document.getElementById('modalEliminarUsuario');
            modalEliminar.addEventListener('show.bs.modal', function (event) {

                const boton = event.relatedTarget;
                const id = boton.getAttribute('data-id');

                const link = document.getElementById('btnConfirmEliminarUsuario');
                link.href = '<%=ctx%>/LoginServlet?action=eliminarUsuario&id=' + id;
            });
        </script>

    </body>
</html>

<%@page import="SICULTIVO.Modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

    // ====== KPIs (vienen del Servlet) ======
    Integer kpiParcelasActivas = (Integer) request.getAttribute("kpiParcelasActivas");
    Integer kpiCultivosActivos = (Integer) request.getAttribute("kpiCultivosActivos");
    Integer kpiTareasPendientes = (Integer) request.getAttribute("kpiTareasPendientes");
    Integer kpiCosechasMes = (Integer) request.getAttribute("kpiCosechasMes");
    Double kpiKgMes = (Double) request.getAttribute("kpiKgMes");

    if (kpiParcelasActivas == null) {
        kpiParcelasActivas = 0;
    }
    if (kpiCultivosActivos == null) {
        kpiCultivosActivos = 0;
    }
    if (kpiTareasPendientes == null) {
        kpiTareasPendientes = 0;
    }
    if (kpiCosechasMes == null) {
        kpiCosechasMes = 0;
    }
    if (kpiKgMes == null)
        kpiKgMes = 0.0;
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>SICULTIVO - Inicio</title>

        <link href="<%=ctx%>/bootstrap/css/bootstrap.min.css"
              rel="stylesheet" type="text/css"/>
        <script src="<%=ctx%>/bootstrap/js/bootstrap.bundle.min.js"
        type="text/javascript"></script>

        <link href="<%=ctx%>/CSS/style.css"
              rel="stylesheet" type="text/css"/>
    </head>

    <body class="bg-light">

        <!-- NAVBAR SUPERIOR -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
            <div class="container-fluid">

                <form action="<%=ctx%>/LoginServlet" method="post">
                    <button type="submit" name="action" value="inicio"
                            class="navbar-brand btn btn-link text-white text-decoration-none p-0 m-0">
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

        <!-- CONTENIDO -->
        <div class="container-fluid">
            <div class="row">

                <!-- SIDEBAR -->
                <nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar shadow-sm">
                    <div class="position-sticky pt-3">
                        <h6 class="sidebar-heading px-3 mb-3 text-muted text-uppercase">
                            Módulos
                        </h6>

                        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">

                            <button type="submit" name="action" value="inicio"
                                    class="btn btn-link nav-link text-start sidebar-item active">
                                <img src="<%=ctx%>/img/icon_inicio.png" class="sidebar-icon"> Inicio
                            </button>

                            <%
                                String rol = u.getRolNombre();
                                if ("ADMINISTRADOR".equalsIgnoreCase(rol)) {
                            %>

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

                            <button type="submit" name="action" value="historial"
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_historia.png" class="sidebar-icon"> Historial
                            </button>

                            <button type="submit" name="action" value="usuarios"
                                    class="btn btn-link nav-link text-start sidebar-item">
                                <img src="<%=ctx%>/img/icon_usuarios.png" class="sidebar-icon"> Gestión de Usuarios
                            </button>

                            <%
                            } else {
                            %>

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

                            <%
                                }
                            %>

                        </form>
                    </div>
                </nav>

                <!-- MAIN -->
                <main class="col-md-9 ms-sm-auto col-lg-10 p-4 main-content-bg main-scroll-area">

                    <!-- CABECERA -->
                    <div class="p-4 bg-white bg-opacity-75 rounded shadow-sm mb-4">
                        <h3 class="mb-1">Bienvenido a SICULTIVO</h3>
                        <p class="text-muted mb-0">
                            Resumen general del sistema (indicadores en tiempo real).
                        </p>
                    </div>

                    <!-- DASHBOARD -->
                    <div class="row g-3">

                        <div class="col-md-6 col-lg-3">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <div class="text-muted">Parcelas activas</div>
                                    <div class="display-6 fw-bold"><%= kpiParcelasActivas%></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <div class="text-muted">Cultivos activos</div>
                                    <div class="display-6 fw-bold"><%= kpiCultivosActivos%></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <div class="text-muted">Tareas pendientes</div>
                                    <div class="display-6 fw-bold"><%= kpiTareasPendientes%></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="card shadow-sm h-100">
                                <div class="card-body">
                                    <div class="text-muted">Cosechas (mes)</div>
                                    <div class="display-6 fw-bold"><%= kpiCosechasMes%></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="card shadow-sm">
                                <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-2">
                                    <div>
                                        <div class="text-muted">Producción cosechada este mes</div>
                                        <div class="h3 fw-bold mb-0"><%= String.format("%.2f", kpiKgMes)%> Kg</div>
                                    </div>
                                    <div class="text-muted">
                                        Indicador automático para control productivo
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </main>

            </div>
        </div>

    </body>
</html>

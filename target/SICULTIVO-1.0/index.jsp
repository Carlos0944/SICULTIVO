<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String error = (String) request.getAttribute("errorLogin");
    String correoIntento = (String) request.getAttribute("correoIntento");
    Integer intentosRestantes = (Integer) request.getAttribute("intentosRestantes");
    Boolean bloqueado = (Boolean) request.getAttribute("bloqueado");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Login - SICULTIVO</title>

        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- CSS propio -->
        <link href="CSS/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body class="login-bg">

        <div class="login-wrapper">
            <div class="card login-card shadow-lg">

                <!-- ENCABEZADO CON LOGO -->
                <div class="login-header text-center">
                    <img src="img/logo_sc.png" alt="Logo SICULTIVO" class="logo-sc mb-2">
                    <h5 class="mb-0">SICULTIVO</h5>
                    <small>Sistema de Gestión Integral de Cultivos</small>
                </div>

                <!-- CUERPO -->
                <div class="login-body">
                    <h4 class="login-title">Iniciar Sesión</h4>

                    <!-- IMPORTANTE: action debe coincidir con el url-pattern del servlet -->
                    <form class="row g-3 needs-validation"
                          action="LoginServlet" method="POST" novalidate>
                        <input type="hidden" name="action" value="login">

                        <div class="mb-3">
                            <label class="form-label">Usuario (correo):</label>
                            <input class="form-control" type="email" name="correo" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Contraseña:</label>
                            <input class="form-control" type="password" name="clave" required>
                        </div>

                        <div class="d-grid mt-2">
                            <button class="btn btn-success btn-login" type="submit">
                                Ingresar
                            </button>
                        </div>
                    </form>


                   <% if (error != null) { %>
    <div class="alert alert-danger mt-3 mb-0">
        <% if (correoIntento != null && !correoIntento.isEmpty()) { %>
            <p class="mb-1">
                <strong>Usuario:</strong> <%= correoIntento %>
            </p>
        <% } %>

        <p class="mb-1"><%= error %></p>

        <% if (bloqueado != null && bloqueado) { %>
            <p class="mb-0">
                Su cuenta ha sido <strong>bloqueada</strong> por superar el número máximo de intentos.
            </p>
        <% } else if (intentosRestantes != null) { %>
            <p class="mb-0">
                Intentos restantes: <strong><%= intentosRestantes %></strong>.
            </p>
        <% } %>
    </div>
<% } %>
                </div>

                <!-- FOOTER -->
                <div class="login-footer">
                    © 2026 · Finca Agroecológica San Carlos
                </div>
            </div>
        </div>

    </body>
</html>

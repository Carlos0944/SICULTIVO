package SICULTIVO.Controlador;

import SICULTIVO.Modelo.Cosecha;
import SICULTIVO.Modelo.CosechaDAO;
import SICULTIVO.Modelo.Cultivo;
import SICULTIVO.Modelo.CultivoDAO;
import SICULTIVO.Modelo.DashboardDAO;
import SICULTIVO.Modelo.HistorialAccion;
import SICULTIVO.Modelo.HistorialAccionesDAO;
import SICULTIVO.Modelo.Parcela;
import SICULTIVO.Modelo.ParcelaDAO;
import SICULTIVO.Modelo.RolDAO;
import SICULTIVO.Modelo.Tarea;
import SICULTIVO.Modelo.TareaDAO;
import SICULTIVO.Modelo.Usuario;
import SICULTIVO.Modelo.UsuarioDAO;
import SICULTIVO.Modelo.ValidaUsuario;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.io.OutputStream;

// OpenPDF
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;


public class LoginServlet extends HttpServlet {

    String logueo = "/index.jsp";
    String inicio = "/Vistas/inicio.jsp";
    String parcelas = "/Vistas/registrar_parcela.jsp";
    String cultivos = "/Vistas/registrar_cultivo.jsp";
    String tareas = "/Vistas/registrar_tarea.jsp";
    String cosechas = "/Vistas/registrar_cosecha.jsp";
    String historial = "/Vistas/consultar_historial.jsp";
    String usuarios = "/Vistas/gestionar_usuarios.jsp";
    String editar = "/Vistas/editar_usuario.jsp";
    String editarh = "/Vistas/editar_historial.jsp";
    String nuevo = "/Vistas/nuevo_historial.jsp";
    String editarT = "/Vistas/editar_tarea.jsp";
    String editarC = "/Vistas/editar_cosecha.jsp";
    String editarCU = "/Vistas/editar_cultivo.jsp";
    String editarP = "/Vistas/editar_parcela.jsp";

    UsuarioDAO objdao;
    String mensajesbd = "error";

    private String jdbcURL;
    private String jdbcUSERName;
    private String jdbcPassword;

    @Override
    public void init() throws ServletException {

        jdbcURL = getServletContext().getInitParameter("jdbcURL");
        jdbcUSERName = getServletContext().getInitParameter("jdbcUSERName");
        jdbcPassword = getServletContext().getInitParameter("jdbcPassword");

        try {
            objdao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            mensajesbd = "Conexion establecida";
            System.out.println(mensajesbd);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            mensajesbd = "Error conexion BD";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {

            case "login":
                login(request, response);
                break;

            case "logout":
                logout(request, response);
                break;

            case "inicio":
                irInicio(request, response);
                break;

            case "parcelas":
                mostrarParcelas(request, response);
                break;

            case "cultivos":
                mostrarCultivos(request, response);
                break;

            case "tareas":
                mostrarTareas(request, response);
                break;

            case "cosechas":
                mostrarCosechas(request, response);
                break;

            case "historial":
                mostrarHistorial(request, response);
                break;

            case "usuarios":
                mostrarUsuarios(request, response);
                break;

            case "guardarParcela":
                guardarParcela(request, response);
                break;

            case "guardarCultivo":
                guardarCultivo(request, response);
                break;

            case "guardarTarea":
                guardarTarea(request, response);
                break;

            case "guardarCosecha":
                guardarCosecha(request, response);
                break;

            case "guardarUsuario":
                guardarUsuario(request, response);
                break;

            case "editarUsuario":
                editarUsuario(request, response);
                break;

            case "actualizarUsuario":
                actualizarUsuario(request, response);
                break;
            case "editarHistorial":
                editarHistorial(request, response);
                break;

            case "actualizarHistorial":
                actualizarHistorial(request, response);
                break;
            case "nuevoHistorial":
                nuevoHistorial(request, response);
                break;

            case "guardarHistorial":
                guardarHistorial(request, response);
                break;

            case "editarTarea":
                editarTarea(request, response);
                break;

            case "actualizarTarea":
                actualizarTarea(request, response);
                break;

            case "editarCosecha":
                editarCosecha(request, response);
                break;

            case "actualizarCosecha":
                actualizarCosecha(request, response);
                break;

            case "editarCultivo":
                editarCultivo(request, response);
                break;

            case "actualizarCultivo":
                actualizarCultivo(request, response);
                break;

            case "editarParcela":
                editarParcela(request, response);
                break;

            case "actualizarParcela":
                actualizarParcela(request, response);
                break;
            case "eliminarUsuario":
                eliminarUsuario(request, response);
                break;
            case "eliminarParcela":
                eliminarParcela(request, response);
                break;
            case "eliminarCultivo":
                eliminarCultivo(request, response);
                break;
            case "eliminarTarea":
                eliminarTarea(request, response);
                break;
            case "eliminarCosecha":
                eliminarCosecha(request, response);
                break;
            case "eliminarHistorial":
                eliminarHistorial(request, response);
                break;
                case "exportarCosechasPdf":
    exportarCosechasPdf(request, response);
    break;
            default:
                request.getRequestDispatcher(logueo).forward(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        ValidaUsuario valida = new ValidaUsuario(correo, clave);

        if (!valida.camposValidos()) {
            request.setAttribute("errorLogin", "Debe ingresar correo y contraseña.");
            request.setAttribute("correoIntento", correo);
            request.getRequestDispatcher(logueo).forward(request, response);
            return;
        }

        if (valida.estaBloqueado()) {
            request.setAttribute("errorLogin", "Ingreso bloqueado por superar el número máximo de intentos.");
            request.setAttribute("correoIntento", correo);
            request.setAttribute("bloqueado", true);
            request.getRequestDispatcher(logueo).forward(request, response);
            return;
        }

        Usuario u = valida.validar(objdao);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", u);
            session.setAttribute("idRol", u.getIdRol());

            try {
                HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(u.getIdUsuario());
                h.setTablaAfectada("USUARIOS");
                h.setAccion("LOGIN");
                h.setDescripcion("Inicio de sesión exitoso");

                hdao.insertar(h);

            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=inicio");
            return;

        } else {
            int restantes = valida.registrarFalloYDevolverRestantes();

            request.setAttribute("errorLogin", "Credenciales inválidas.");
            request.setAttribute("correoIntento", correo);
            request.setAttribute("intentosRestantes", restantes);
            request.setAttribute("bloqueado", restantes <= 0);

            request.getRequestDispatcher(logueo).forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + logueo);
    }

    private void mostrarvista(HttpServletRequest request, HttpServletResponse response, String vista)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        request.getRequestDispatcher(vista).forward(request, response);
    }

    private void irInicio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            DashboardDAO ddao = new DashboardDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            request.setAttribute("kpiParcelasActivas", ddao.contarParcelasActivas());
            request.setAttribute("kpiCultivosActivos", ddao.contarCultivosActivos());
            request.setAttribute("kpiTareasPendientes", ddao.contarTareasPendientes());
            request.setAttribute("kpiCosechasMes", ddao.contarCosechasMes());
            request.setAttribute("kpiKgMes", ddao.sumarKgCosechadosMes());

            request.getRequestDispatcher(inicio).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "No se pudo cargar el dashboard.");
            response.sendRedirect(request.getContextPath() + logueo);
        }
    }

    private void mostrarParcelas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String buscar = request.getParameter("buscar");

        try {
            ParcelaDAO dao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            if (buscar != null && !buscar.trim().isEmpty()) {
                request.setAttribute("listaParcelas", dao.buscarPorNombre(buscar));
            } else {
                request.setAttribute("listaParcelas", dao.listar());
            }

            request.setAttribute("listaEstadosParcela", dao.listarEstados());
            request.setAttribute("listaTiposSuelo", dao.listarTiposSuelo());

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(parcelas).forward(request, response);
    }

    private void guardarParcela(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        Parcela p = new Parcela();
        p.setIdUsuario(u.getIdUsuario());
        p.setNombre(request.getParameter("nombre"));
        p.setUbicacion(request.getParameter("ubicacion"));
        p.setArea(Double.parseDouble(request.getParameter("area")));
        p.setTipoSuelo(request.getParameter("tipoSuelo"));
        p.setEstado(request.getParameter("estado"));

        try {
            ParcelaDAO dao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            if (dao.existeParcelaPorNombre(p.getNombre())) {
                session.setAttribute("msgError", "Ya existe una parcela con ese nombre.");
                response.sendRedirect(request.getContextPath() + "/LoginServlet?action=parcelas");
                return;
            }

            dao.insertar(p);
            session.setAttribute("msgOk", "Parcela registrada correctamente.");

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(u.getIdUsuario());
            h.setTablaAfectada("PARCELAS");
            h.setAccion("INSERT");
            h.setDescripcion("Se registró una nueva parcela: " + p.getNombre());

            hdao.insertar(h);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al registrar  una nueva Parcela.");

        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=parcelas");
    }

    private void editarParcela(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            ParcelaDAO pdao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            UsuarioDAO udao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword); // si tienes listar usuarios simple
            // Si no tienes udao listar, usa el de historial: HistorialAccionesDAO.listarUsuarios()

            request.setAttribute("parcelaEditar", pdao.seleccionarPorId(id));
            request.setAttribute("listaEstadosParcela", pdao.listarEstados());
            request.setAttribute("listaTiposSuelo", pdao.listarTiposSuelo());

            // si quieres cambiar el dueño (ADMIN): lista de usuarios
            // request.setAttribute("listaUsuarios", udao.listarUsuariosSimple());
            request.getRequestDispatcher(editarP).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=parcelas");
        }
    }

    private void actualizarParcela(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Parcela p = new Parcela();
            p.setIdParcela(Integer.parseInt(request.getParameter("idParcela")));
            p.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            p.setNombre(request.getParameter("nombre"));
            p.setUbicacion(request.getParameter("ubicacion"));
            p.setArea(Double.parseDouble(request.getParameter("area")));
            p.setTipoSuelo(request.getParameter("tipoSuelo"));
            p.setEstado(request.getParameter("estado"));
            p.setFechaCreado(request.getParameter("fechaCreado"));

            ParcelaDAO pdao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = pdao.actualizar(p);

            if (ok) {
                session.setAttribute("msgOk", "Parcela actualizada correctamente.");
                session.removeAttribute("msgError");

                // ===== HISTORIAL =====
                HistorialAccionesDAO hdao
                        = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(uSesion.getIdUsuario());
                h.setTablaAfectada("PARCELAS");
                h.setAccion("UPDATE");
                h.setDescripcion(
                        "Se actualizó la parcela ID " + p.getNombre());

                hdao.insertar(h);

            } else {
                session.setAttribute("msgError", "Error al actualizar parcela.");
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al actualizar parcela.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=parcelas");
    }

    private void eliminarParcela(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            int idParcela = Integer.parseInt(request.getParameter("id"));

            ParcelaDAO pdao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            String r = pdao.eliminarParcela(idParcela);

            if ("OK".equals(r)) {
                session.setAttribute("msgOk", "Parcela eliminada correctamente.");
                session.removeAttribute("msgError");
            } else {
                session.setAttribute("msgError", r);
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar la parcela.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=parcelas");
    }

    private void mostrarCultivos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String buscar = request.getParameter("buscar");

        try {
            CultivoDAO cudao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            ParcelaDAO dao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            if (buscar != null && !buscar.trim().isEmpty()) {
                request.setAttribute("listaCultivos", cudao.buscarPorNombre(buscar));
            } else {
                request.setAttribute("listaCultivos", cudao.listar());
            }
            request.setAttribute("listaEstadosCultivo", cudao.listarEstadosCultivo());

            request.setAttribute("listaParcelas", dao.listar());

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(cultivos).forward(request, response);
    }

    private void guardarCultivo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Cultivo c = new Cultivo();
            c.setIdParcela(Integer.parseInt(request.getParameter("idParcela")));
            c.setNombre(request.getParameter("nombre"));
            c.setVariedad(request.getParameter("variedad"));
            c.setFechaSiembra(request.getParameter("fechaSiembra"));
            c.setCantidadSembrada(Integer.parseInt(request.getParameter("cantidad")));
            c.setEstado(request.getParameter("estado"));
            c.setObservaciones(request.getParameter("observaciones"));

            CultivoDAO cudao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            cudao.insertar(c);
            session.setAttribute("msgOk", "Cultivo registrado correctamente.");

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(u.getIdUsuario());
            h.setTablaAfectada("CULTIVOS");
            h.setAccion("INSERT");
            h.setDescripcion("Se registró un nuevo cultivo: " + c.getNombre());

            hdao.insertar(h);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al registrar  un nuevo cultivo.");

        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cultivos");
    }

    private void editarCultivo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            CultivoDAO cdao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            ParcelaDAO pdao = new ParcelaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            Cultivo c = cdao.seleccionarPorId(id);

            request.setAttribute("cultivoEditar", c);
            request.setAttribute("listaParcelas", pdao.listar()); // necesitas listar parcelas
            request.setAttribute("listaEstadosCultivo", cdao.listarEstadosCultivo());

            request.getRequestDispatcher(editarCU).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cultivos");
        }
    }

    private void actualizarCultivo(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Cultivo c = new Cultivo();
            c.setIdCultivo(Integer.parseInt(request.getParameter("idCultivo")));
            c.setIdParcela(Integer.parseInt(request.getParameter("idParcela")));
            c.setNombre(request.getParameter("nombre"));
            c.setVariedad(request.getParameter("variedad"));
            c.setFechaSiembra(request.getParameter("fechaSiembra"));
            c.setCantidadSembrada(Integer.parseInt(request.getParameter("cantidad")));
            c.setEstado(request.getParameter("estado"));
            c.setObservaciones(request.getParameter("observaciones"));

            CultivoDAO cdao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = cdao.actualizar(c);

            if (ok) {
                session.setAttribute("msgOk", "Cultivo actualizado correctamente.");
                session.removeAttribute("msgError");

                // ===== HISTORIAL =====
                HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(uSesion.getIdUsuario());
                h.setTablaAfectada("CULTIVOS");
                h.setAccion("UPDATE");
                h.setDescripcion(
                        "Se actualizó el cultivo  " + c.getNombre());

                hdao.insertar(h);

            } else {
                session.setAttribute("msgError", "Error al actualizar cultivo.");
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al actualizar cultivo.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cultivos");
    }

    private void eliminarCultivo(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();//Obtiene la sesion actual del usuario

        try {
            int idCultivo = Integer.parseInt(request.getParameter("id"));// Obtiene el parametro id enviado desde el JSP

            CultivoDAO cdao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);// Crea el DAO cultivo y establece la conexion
            String r = cdao.eliminarCultivo(idCultivo);// llama al metodo eliminar

            if ("OK".equals(r)) {
                session.setAttribute("msgOk", "Cultivo eliminado correctamente.");// Si la sesion esta activa manda un mensaje de exito en session.
                session.removeAttribute("msgError");
            } else {
                session.setAttribute("msgError", r);// mensaje de error devuelto por el DAO
                session.removeAttribute("msgOk");// Elimina mensaje de exito previos
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar el cultivo.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cultivos");
    }

    private void mostrarTareas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String buscar = request.getParameter("buscar");
        String rol = u.getRolNombre(); // ADMINISTRADOR / OPERARIO

        try {
            TareaDAO tdao = new TareaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            CultivoDAO cudao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            // ✅ LISTA TAREAS SEGÚN ROL
            if ("OPERARIO".equalsIgnoreCase(rol)) {

                // Operario: solo ve sus tareas
                if (buscar != null && !buscar.trim().isEmpty()) {
                    request.setAttribute("listaTareas", tdao.buscarPorResponsable(u.getNombre(), buscar));
                } else {
                    request.setAttribute("listaTareas", tdao.listarPorResponsable(u.getNombre()));
                }

            } else {

                // Admin: ve todas
                if (buscar != null && !buscar.trim().isEmpty()) {
                    request.setAttribute("listaTareas", tdao.buscar(buscar));
                } else {
                    request.setAttribute("listaTareas", tdao.listar());
                }
            }

            // Listas para combos (registrar/editar)
            request.setAttribute("listaEstadosTarea", tdao.listarEstadoTarea());
            request.setAttribute("listaTipoTarea", tdao.listarTipoTarea());
            request.setAttribute("listaOperarios", usudao.listarOperarios());
            request.setAttribute("listaCultivos", cudao.listar());

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(tareas).forward(request, response);
    }

    private void guardarTarea(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String idCultivoStr = request.getParameter("idCultivo");
        String tipo = request.getParameter("tipo");
        String fechaProgramada = request.getParameter("fechaProgramada");
        String responsable = request.getParameter("responsable");
        String estado = request.getParameter("estado");
        String fechaEjecucion = request.getParameter("fechaEjecucion");
        String observaciones = request.getParameter("observaciones");

        try {
            Tarea t = new Tarea();
            t.setIdCultivo(Integer.parseInt(idCultivoStr));
            t.setTipo(tipo);
            t.setFechaProgramada(fechaProgramada);
            t.setResponsable(responsable);
            t.setEstado(estado);
            t.setFechaEjecucion(fechaEjecucion);
            t.setObservaciones(observaciones);

            TareaDAO tdao = new TareaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            tdao.insertar(t);
            session.setAttribute("msgOk", "Tarea registrada correctamente.");

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(u.getIdUsuario());
            h.setTablaAfectada("Tareas");
            h.setAccion("INSERT");
            h.setDescripcion("Nueva tarea: " + t.getTipo());

            hdao.insertar(h);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al registrar la tarea.");

        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=tareas");
    }

    private void editarTarea(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            TareaDAO tdao = new TareaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            CultivoDAO cdao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            Tarea tarea = tdao.seleccionarPorId(id);

            request.setAttribute("tareaEditar", tarea);
            request.setAttribute("listaCultivos", cdao.listar());
            request.setAttribute("listaTipoTarea", tdao.listarTipoTarea());
            request.setAttribute("listaEstadosTarea", tdao.listarEstadoTarea());
            request.setAttribute("listaOperarios", usudao.listarOperarios());
            request.getRequestDispatcher(editarT).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=tareas");
        }
    }

    private void actualizarTarea(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Tarea t = new Tarea();
            t.setIdTarea(Integer.parseInt(request.getParameter("idTarea")));
            t.setIdCultivo(Integer.parseInt(request.getParameter("idCultivo")));
            t.setTipo(request.getParameter("tipo"));
            t.setFechaProgramada(request.getParameter("fechaProgramada"));
            t.setResponsable(request.getParameter("responsable"));
            t.setEstado(request.getParameter("estado"));
            t.setFechaEjecucion(request.getParameter("fechaEjecucion"));
            t.setObservaciones(request.getParameter("observaciones"));

            TareaDAO tdao = new TareaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = tdao.actualizar(t);

            if (ok) {
                session.setAttribute("msgOk", "Tarea actualizada correctamente.");
                session.removeAttribute("msgError");

                // ===== HISTORIAL =====
                HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(uSesion.getIdUsuario());
                h.setTablaAfectada("TAREAS");
                h.setAccion("UPDATE");
                h.setDescripcion(
                        "Se actualizó una tarea ");

                hdao.insertar(h);

            } else {
                session.setAttribute("msgError", "Error al actualizar tarea.");
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al actualizar tarea.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=tareas");
    }

    private void eliminarTarea(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            TareaDAO dao = new TareaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            if (dao.eliminar(id)) {
                session.setAttribute("msgOk", "Tarea eliminada correctamente.");
            } else {
                session.setAttribute("msgError", "No se pudo eliminar la tarea.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar la tarea.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=tareas");
    }

    private void mostrarCosechas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String buscar = request.getParameter("buscar");

        try {
            CosechaDAO cosdao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            CultivoDAO cudao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            if (buscar != null && !buscar.trim().isEmpty()) {
                request.setAttribute("listaCosechas", cosdao.buscarPorCalidad(buscar));
            } else {
                request.setAttribute("listaCosechas", cosdao.listar());
            }
            request.setAttribute("listaCalidad", cosdao.listarCalidad());
            request.setAttribute("listaCultivos", cudao.listar());

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(cosechas).forward(request, response);
    }

    private void guardarCosecha(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Cosecha c = new Cosecha();
            c.setIdCultivo(Integer.parseInt(request.getParameter("idCultivo")));
            c.setFechaCosecha(request.getParameter("fechaCosecha"));
            c.setCantidad(Double.parseDouble(request.getParameter("cantidad")));
            c.setCalidad(request.getParameter("calidad"));
            c.setObservaciones(request.getParameter("observaciones"));

            CosechaDAO cosdao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            cosdao.insertar(c);

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(u.getIdUsuario());
            h.setTablaAfectada("COSECHAS");
            h.setAccion("INSERT");
            h.setDescripcion("Nueva cosecha registrada ");

            hdao.insertar(h);
            session.setAttribute("msgOk", "Cosecha registrada correctamente.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al registrar la cosecha.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
    }

    private void editarCosecha(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            CosechaDAO cdao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            CultivoDAO culdao = new CultivoDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            request.setAttribute("cosechaEditar", cdao.seleccionarPorId(id));
            request.setAttribute("listaCultivos", culdao.listar());
            request.setAttribute("listaCalidad", cdao.listarCalidad());

            request.getRequestDispatcher(editarC).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
        }
    }

    private void actualizarCosecha(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Cosecha c = new Cosecha();
            c.setIdCosecha(Integer.parseInt(request.getParameter("idCosecha")));
            c.setIdCultivo(Integer.parseInt(request.getParameter("idCultivo")));
            c.setFechaCosecha(request.getParameter("fechaCosecha"));
            c.setCantidad(Double.parseDouble(request.getParameter("cantidad")));
            c.setCalidad(request.getParameter("calidad"));
            c.setObservaciones(request.getParameter("observaciones"));

            CosechaDAO dao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = dao.actualizar(c);

            if (ok) {
                session.setAttribute("msgOk", "Cosecha actualizada correctamente.");
                session.removeAttribute("msgError");

                // Insertar Historial
                HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(uSesion.getIdUsuario());
                h.setTablaAfectada("COSECHAS");
                h.setAccion("UPDATE");
                h.setDescripcion("Se actualizó una cosecha  ");

                hdao.insertar(h);

            } else {
                session.setAttribute("msgError", "Error al actualizar cosecha.");
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al actualizar cosecha.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
    }

    private void eliminarCosecha(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            CosechaDAO dao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = dao.eliminar(id);

            if (ok) {
                session.setAttribute("msgOk", "Cosecha eliminada correctamente.");
            } else {
                session.setAttribute("msgError", "No se pudo eliminar la cosecha.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar la cosecha.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
    }
    
    private void exportarCosechasPdf(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    HttpSession session = request.getSession(false);
    Usuario uSesion = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

    if (uSesion == null) {
        response.sendRedirect(request.getContextPath() + logueo);
        return;
    }

    String desde = request.getParameter("desde"); // yyyy-mm-dd
    String hasta = request.getParameter("hasta"); // yyyy-mm-dd

    if (desde == null || hasta == null || desde.trim().isEmpty() || hasta.trim().isEmpty()) {
        session.setAttribute("msgError", "Debe seleccionar el rango de fechas para exportar.");
        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
        return;
    }

    // Validación: desde <= hasta (como String yyyy-mm-dd se compara bien)
    if (desde.compareTo(hasta) > 0) {
        session.setAttribute("msgError", "La fecha 'Desde' no puede ser mayor que 'Hasta'.");
        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
        return;
    }

    try {
        CosechaDAO cosdao = new CosechaDAO(jdbcURL, jdbcUSERName, jdbcPassword);

        // ✅ este método es el que ya implementaste en el DAO
        java.util.List<Cosecha> lista = cosdao.listarPorRangoFechas(desde, hasta);

        // Respuesta PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=cosechas_" + desde + "_a_" + hasta + ".pdf");

        OutputStream out = response.getOutputStream();

        Document doc = new Document(PageSize.A4.rotate(), 30, 30, 30, 30);
        PdfWriter.getInstance(doc, out);

        doc.open();

        Font titulo = new Font(Font.HELVETICA, 16, Font.BOLD);
        Font normal = new Font(Font.HELVETICA, 10, Font.NORMAL);
        Font head = new Font(Font.HELVETICA, 10, Font.BOLD);

        Paragraph t = new Paragraph("SICULTIVO - Reporte de Cosechas", titulo);
        t.setAlignment(Element.ALIGN_CENTER);
        doc.add(t);

        doc.add(new Paragraph("Rango: " + desde + " a " + hasta, normal));
        doc.add(new Paragraph("Generado por: " + uSesion.getNombre() + " (" + uSesion.getRolNombre() + ")", normal));
        doc.add(new Paragraph(" ", normal));

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{3f, 2f, 2f, 2f, 5f});

        addHeaderCell(table, "Cultivo", head);
        addHeaderCell(table, "Fecha", head);
        addHeaderCell(table, "Cantidad (kg)", head);
        addHeaderCell(table, "Calidad", head);
        addHeaderCell(table, "Observaciones", head);

        if (lista == null || lista.isEmpty()) {
            PdfPCell cell = new PdfPCell(new Phrase("No hay cosechas registradas en ese rango.", normal));
            cell.setColspan(5);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(10);
            table.addCell(cell);
        } else {
            for (Cosecha co : lista) {
                table.addCell(new PdfPCell(new Phrase(valor(co.getNombreCultivo()), normal)));
                table.addCell(new PdfPCell(new Phrase(valor(co.getFechaCosecha()), normal)));
                table.addCell(new PdfPCell(new Phrase(String.valueOf(co.getCantidad()), normal)));
                table.addCell(new PdfPCell(new Phrase(valor(co.getCalidad()), normal)));
                table.addCell(new PdfPCell(new Phrase(valor(co.getObservaciones()), normal)));
            }
        }

        doc.add(table);
        doc.close();
        out.flush();

    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("msgError", "Error al generar el PDF.");
        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=cosechas");
    }
}

private void addHeaderCell(PdfPTable table, String text, Font font) {
    PdfPCell cell = new PdfPCell(new Phrase(text, font));
    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
    cell.setPadding(6);
    table.addCell(cell);
}

private String valor(String s) {
    return (s == null) ? "" : s;
}


    private void mostrarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String idUsuario = request.getParameter("idUsuario");
        String tabla = request.getParameter("tabla");
        String desde = request.getParameter("desde");
        String hasta = request.getParameter("hasta");

        try {
            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            request.setAttribute("listaHistorial", hdao.filtrar(idUsuario, tabla, desde, hasta));// Ejecuta el select, SQL dentro del DAO
            request.setAttribute("listaUsuarios", hdao.listarUsuarios());
            request.setAttribute("listaTablas", hdao.listarTablas());
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(historial).forward(request, response);// Enviar a la vista JSP
    }

    private void editarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            HistorialAccion h = hdao.seleccionarPorId(id);

            request.setAttribute("listaUsuarios", hdao.listarUsuarios());
            request.setAttribute("listaTablas", hdao.listarTablas());

            request.setAttribute("historialEditar", h);
            request.getRequestDispatcher(editarh).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=historial");
        }
    }

    private void nuevoHistorial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            request.setAttribute("listaUsuarios", hdao.listarUsuarios());
            request.setAttribute("listaTablas", hdao.listarTablas());

            request.getRequestDispatcher(nuevo).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=historial");
        }
    }

    private void guardarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));//Leer los datos del formulario (request.getParameter)
            h.setTablaAfectada(request.getParameter("tablaAfectada"));
            h.setAccion(request.getParameter("accion"));
            h.setDescripcion(request.getParameter("descripcion"));

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            boolean ok = hdao.insertar(h);// Insertar, SQL en el DAO insertar

            if (ok) {
                session.setAttribute("msgOk", "Historial registrado correctamente.");
            } else {
                session.setAttribute("msgError", "No se pudo registrar el historial.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al registrar historial.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=historial");
    }

    private void actualizarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            HistorialAccion h = new HistorialAccion();
            h.setIdHistorial(Integer.parseInt(request.getParameter("idHistorial")));
            h.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            h.setTablaAfectada(request.getParameter("tablaAfectada"));
            h.setAccion(request.getParameter("accion"));
            h.setDescripcion(request.getParameter("descripcion"));
            h.setFechaHora(request.getParameter("fechaHora"));

            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = hdao.actualizar(h);// Ejecucion de actualizar ( sql en DAO actualizar

            HttpSession session = request.getSession();
            if (ok) {
                session.setAttribute("msgOk", "Historial actualizado correctamente.");
            } else {
                session.setAttribute("msgError", "Error al actualizar historial.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msgError", "Error al actualizar historial.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=historial");
    }

    private void eliminarHistorial(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            HistorialAccionesDAO dao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = dao.eliminar(id);

            if (ok) {
                session.setAttribute("msgOk", "Registro del historial eliminado correctamente.");
            } else {
                session.setAttribute("msgError", "No se pudo eliminar el registro del historial.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar el registro del historial.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=historial");
    }

    private void mostrarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuarioLogueado");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        String buscar = request.getParameter("buscar");

        try {
            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            RolDAO rdao = new RolDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            if (buscar != null && !buscar.trim().isEmpty()) {
                request.setAttribute("listaUsuarios", usudao.buscarUsuariosConRol(buscar));
            } else {
                request.setAttribute("listaUsuarios", usudao.listarUsuariosConRol());
            }

            request.setAttribute("listaEstados", rdao.listarEstadosUsuario());
            request.setAttribute("listaRoles", rdao.listar());

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(usuarios).forward(request, response);
    }

    private void guardarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");

        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Usuario nu = new Usuario();
            nu.setIdRol(Integer.parseInt(request.getParameter("idRol")));
            nu.setNombre(request.getParameter("nombre"));
            nu.setCorreo(request.getParameter("correo"));
            nu.setEstado(request.getParameter("estado"));
            nu.setClaveHash(request.getParameter("clave"));

            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            if (usudao.existeUsuarioPorCorreo(nu.getCorreo())) {
                session.setAttribute("msgError", "El correo ya se encuentra registrado.");
                response.sendRedirect(request.getContextPath() + "/LoginServlet?action=usuarios");
                return;
            }
            usudao.insertarUsuario(nu);
            session.setAttribute("msgOk", "Usuario registrado correctamente.");
            HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            HistorialAccion h = new HistorialAccion();
            h.setIdUsuario(uSesion.getIdUsuario());
            h.setTablaAfectada("USUARIOS");
            h.setAccion("INSERT");
            h.setDescripcion("Se registró un nuevo usuario: " + nu.getCorreo());

            hdao.insertar(h);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al registrar  un nuevo Usuario.");

        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=usuarios");
    }

    private void editarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");
        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);
            RolDAO rdao = new RolDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            Usuario uEditar = usudao.seleccionarPorId(id);

            request.setAttribute("listaRoles", rdao.listar());
            request.setAttribute("listaEstados", rdao.listarEstadosUsuario());
            request.setAttribute("usuarioEditar", uEditar);
            request.getRequestDispatcher(editar).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/LoginServlet?action=usuarios");
        }
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario uSesion = (Usuario) session.getAttribute("usuarioLogueado");
        if (uSesion == null) {
            response.sendRedirect(request.getContextPath() + logueo);
            return;
        }

        try {
            Usuario u = new Usuario();
            u.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
            u.setNombre(request.getParameter("nombre"));
            u.setCorreo(request.getParameter("correo"));
            u.setIdRol(Integer.parseInt(request.getParameter("idRol")));
            u.setEstado(request.getParameter("estado"));
            u.setFechaCreado(request.getParameter("fechaCreado"));
            u.setClaveHash(request.getParameter("clave"));

            UsuarioDAO usudao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            boolean ok = usudao.actualizarUsuario(u);

            // guardar en Historial si actualiza//
            if (ok) {
                HistorialAccionesDAO hdao = new HistorialAccionesDAO(jdbcURL, jdbcUSERName, jdbcPassword);

                HistorialAccion h = new HistorialAccion();
                h.setIdUsuario(uSesion.getIdUsuario());
                h.setTablaAfectada("USUARIOS");
                h.setAccion("UPDATE");
                h.setDescripcion("Se actualizó el usuario  " + u.getNombre());

                hdao.insertar(h);
            }

            session.setAttribute("msgOk", ok ? "Usuario actualizado correctamente." : "Error al actualizar usuario.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgOk", "Error al actualizar usuario.");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=usuarios");
    }

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            UsuarioDAO udao = new UsuarioDAO(jdbcURL, jdbcUSERName, jdbcPassword);

            String r = udao.eliminarUsuario(id);

            if ("OK".equals(r)) {
                session.setAttribute("msgOk", "Usuario eliminado correctamente.");
                session.removeAttribute("msgError");
            } else {
                session.setAttribute("msgError", r);
                session.removeAttribute("msgOk");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msgError", "Error al eliminar usuario.");
            session.removeAttribute("msgOk");
        }

        response.sendRedirect(request.getContextPath() + "/LoginServlet?action=usuarios");
    }

    @Override
    public String getServletInfo() {
        return "";
    }
}

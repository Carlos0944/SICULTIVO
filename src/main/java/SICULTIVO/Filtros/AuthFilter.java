package SICULTIVO.Filtros;

import SICULTIVO.Modelo.Usuario;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession sesion = request.getSession(false);

        String action = request.getParameter("action");

        boolean logueado = (sesion != null && sesion.getAttribute("usuarioLogueado") != null);

        boolean esPublica = (action != null) && "login".equals(action);


        String path = request.getServletPath();
        boolean esRecurso = path.startsWith("/bootstrap")
                || path.startsWith("/CSS")
                || path.startsWith("/img");

        boolean esLoginJsp = path.equals("/index.jsp");

        if (logueado || esPublica || esRecurso || esLoginJsp) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}

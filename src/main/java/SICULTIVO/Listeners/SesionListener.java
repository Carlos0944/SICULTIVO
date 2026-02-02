package SICULTIVO.Listeners;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SesionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("[SICULTIVO] Sesión creada: " + se.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("[SICULTIVO] Sesión destruida: " + se.getSession().getId());
        
        // Aquí después agregarás:
        // HistorialAccionDAO.registrar("FIN_SESION", idUsuario, fechaHora);
    }
}

package SICULTIVO.Modelo;

import java.util.HashMap;
import java.util.Map;


public class ValidaUsuario {

    private String correo;
    private String clave;

    private static final Map<String, Integer> intentos = new HashMap<>();
    private static final int MAX_INTENTOS = 3;

    public ValidaUsuario(String correo, String clave) {
        this.correo = correo;
        this.clave = clave;
    }

    public boolean camposValidos() {
        return correo != null && !correo.isEmpty()
            && clave != null && !clave.isEmpty();
    }
    public boolean estaBloqueado() {
    int usados = intentos.getOrDefault(correo, 0);
    return usados >= MAX_INTENTOS;
}


    public int intentosRestantes() {
        int usados = intentos.getOrDefault(correo, 0);
        return MAX_INTENTOS - usados;
    }
    public int registrarFalloYDevolverRestantes() {
    int usados = intentos.getOrDefault(correo, 0) + 1;
    intentos.put(correo, usados);
    return MAX_INTENTOS - usados;
}
  

   public Usuario validar(UsuarioDAO dao) {

    if (!camposValidos()) return null;

    Usuario u = dao.autenticar(correo, clave);

    // si no existe o clave incorrecta
    if (u == null) return null;

    // si existe pero está INACTIVO → no deja entrar
    if ("INACTIVO".equalsIgnoreCase(u.getEstado())) {
        return null;
    }

    return u;
}

    
   

    
}



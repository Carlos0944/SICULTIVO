package SICULTIVO.Modelo;

public class Usuario {

    private int idUsuario;
    private int idRol;
    private String nombre;
    private String correo;
    private String estado;
    private String fechaCreado;
    private String rolNombre;
    private String claveHash;

    public Usuario() {//Constructor Vacio
    }

    public Usuario(int idUsuario, int idRol, String nombre, String correo,// Constructor
            String estado, String fechaCreado, String rolNombre) {
        this.idUsuario = idUsuario;
        this.idRol = idRol;
        this.nombre = nombre;
        this.correo = correo;
        this.estado = estado;
        this.fechaCreado = fechaCreado;
        this.rolNombre = rolNombre;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdRol() {
        return idRol;
    }

    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFechaCreado() {
        return fechaCreado;
    }

    public void setFechaCreado(String fechaCreado) {
        this.fechaCreado = fechaCreado;
    }

    public String getRolNombre() {
        return rolNombre;
    }

    public void setRolNombre(String rolNombre) {
        this.rolNombre = rolNombre;
    }
    public String getClaveHash() {
        return claveHash;
    }
    public void setClaveHash(String claveHash) {
        this.claveHash = claveHash;
    }

    @Override
    public String toString() {
        return "Usuario{"
                + "idUsuario=" + idUsuario
                + ", idRol=" + idRol
                + ", nombre='" + nombre + '\''
                + ", correo='" + correo + '\''
                + ", estado='" + estado + '\''
                + ", fechaCreado='" + fechaCreado + '\''
                + ", rolNombre='" + rolNombre + '\''
                + '}';
    }
}

package SICULTIVO.Modelo;

public class HistorialAccion {

    private int idHistorial;
    private int idUsuario;
    private String tablaAfectada;
    private String accion;
    private String descripcion;
    private String fechaHora;
    private String NombreUsuario;


    public HistorialAccion() {
    }

    public HistorialAccion(int idHistorial, int idUsuario, String tablaAfectada, String accion, String descripcion, String fechaHora, String NombreUsuario) {
        this.idHistorial = idHistorial;
        this.idUsuario = idUsuario;
        this.tablaAfectada = tablaAfectada;
        this.accion = accion;
        this.descripcion = descripcion;
        this.fechaHora = fechaHora;
        this.NombreUsuario = NombreUsuario;
    }

    public int getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(int idHistorial) {
        this.idHistorial = idHistorial;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getTablaAfectada() {
        return tablaAfectada;
    }

    public void setTablaAfectada(String tablaAfectada) {
        this.tablaAfectada = tablaAfectada;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.accion = accion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(String fechaHora) {
        this.fechaHora = fechaHora;
    }

    public String getNombreUsuario() {
        return NombreUsuario;
    }

    public void setNombreUsuario(String NombreUsuario) {
        this.NombreUsuario = NombreUsuario;
    }

    @Override
    public String toString() {
        return "HistorialAccion{" + "idHistorial=" + idHistorial + ", idUsuario=" + idUsuario + ", tablaAfectada=" + tablaAfectada + ", accion=" + accion + ", descripcion=" + descripcion + ", fechaHora=" + fechaHora + ", NombreUsuario=" + NombreUsuario + '}';
    }
}

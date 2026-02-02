package SICULTIVO.Modelo;

public class Tarea {

    private int idTarea;
    private int idCultivo;

    private String tipo;               
    private String fechaProgramada;   
    private String responsable;        
    private String estado;         
    private String fechaEjecucion;     
    private String observaciones;   
    private String nombreCultivo;     


    public Tarea() {
    }

    public Tarea(int idTarea, int idCultivo, String tipo, String fechaProgramada, String responsable, String estado, String fechaEjecucion, String observaciones, String nombreCultivo) {
        this.idTarea = idTarea;
        this.idCultivo = idCultivo;
        this.tipo = tipo;
        this.fechaProgramada = fechaProgramada;
        this.responsable = responsable;
        this.estado = estado;
        this.fechaEjecucion = fechaEjecucion;
        this.observaciones = observaciones;
        this.nombreCultivo = nombreCultivo;
    }

    
    public int getIdTarea() {
        return idTarea;
    }

    public void setIdTarea(int idTarea) {
        this.idTarea = idTarea;
    }

    public int getIdCultivo() {
        return idCultivo;
    }

    public void setIdCultivo(int idCultivo) {
        this.idCultivo = idCultivo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getFechaProgramada() {
        return fechaProgramada;
    }

    public void setFechaProgramada(String fechaProgramada) {
        this.fechaProgramada = fechaProgramada;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFechaEjecucion() {
        return fechaEjecucion;
    }

    public void setFechaEjecucion(String fechaEjecucion) {
        this.fechaEjecucion = fechaEjecucion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getNombreCultivo() {
        return nombreCultivo;
    }

    public void setNombreCultivo(String nombreCultivo) {
        this.nombreCultivo = nombreCultivo;
    }

    @Override
    public String toString() {
        return "Tarea{" + "idTarea=" + idTarea + ", idCultivo=" + idCultivo + ", tipo=" + tipo + ", fechaProgramada=" + fechaProgramada + ", responsable=" + responsable + ", estado=" + estado + ", fechaEjecucion=" + fechaEjecucion + ", observaciones=" + observaciones + ", nombreCultivo=" + nombreCultivo + '}';
    }
    
    
}

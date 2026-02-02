package SICULTIVO.Modelo;

public class Cultivo {

    private int idCultivo;
    private int idParcela;
    private String nombre;
    private String variedad;
    private String fechaSiembra; 
    private int cantidadSembrada;
    private String estado;
    private String observaciones;
    private String nombreParcela;
    
    public Cultivo() {
    }
    
    public Cultivo(int idCultivo, int idParcela, String nombre, String variedad, String fechaSiembra, int cantidadSembrada, String estado, String observaciones, String nombreParcela) {
        this.idCultivo = idCultivo;
        this.idParcela = idParcela;
        this.nombre = nombre;
        this.variedad = variedad;
        this.fechaSiembra = fechaSiembra;
        this.cantidadSembrada = cantidadSembrada;
        this.estado = estado;
        this.observaciones = observaciones;
        this.nombreParcela = nombreParcela;
    }
    public int getIdCultivo() {
        return idCultivo;
    }
    public void setIdCultivo(int idCultivo) {
        this.idCultivo = idCultivo;
    }
    public int getIdParcela() {
        return idParcela;
    }
    public void setIdParcela(int idParcela) {
        this.idParcela = idParcela;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getVariedad() {
        return variedad;
    }
    public void setVariedad(String variedad) {
        this.variedad = variedad;
    }
    public String getFechaSiembra() {
        return fechaSiembra;
    }
    public void setFechaSiembra(String fechaSiembra) {
        this.fechaSiembra = fechaSiembra;
    }
    public int getCantidadSembrada() {
        return cantidadSembrada;
    }
    public void setCantidadSembrada(int cantidadSembrada) {
        this.cantidadSembrada = cantidadSembrada;
    }
    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }
    public String getObservaciones() {
        return observaciones;
    }
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    public String getNombreParcela() {
    return nombreParcela;
}
    public void setNombreParcela(String nombreParcela) {
    this.nombreParcela = nombreParcela;
}
    @Override
    public String toString() {
        return "Cultivo{" + "idCultivo=" + idCultivo + ", idParcela=" + idParcela + ", nombre=" + nombre + ", variedad=" + variedad + ", fechaSiembra=" + fechaSiembra + ", cantidadSembrada=" + cantidadSembrada + ", estado=" + estado + ", observaciones=" + observaciones + ", nombreParcela=" + nombreParcela + '}';
    }
}

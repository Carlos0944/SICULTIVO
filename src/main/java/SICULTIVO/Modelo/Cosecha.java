package SICULTIVO.Modelo;

public class Cosecha {

    private int idCosecha;
    private int idCultivo;
    private String fechaCosecha;
    private double cantidad;
    private String calidad;
    private String observaciones;
    private String nombreCultivo;


    public Cosecha() {
    }

    public Cosecha(int idCosecha, int idCultivo, String fechaCosecha, double cantidad, String calidad, String observaciones, String nombreCultivo) {
        this.idCosecha = idCosecha;
        this.idCultivo = idCultivo;
        this.fechaCosecha = fechaCosecha;
        this.cantidad = cantidad;
        this.calidad = calidad;
        this.observaciones = observaciones;
        this.nombreCultivo = nombreCultivo;
    }

    public int getIdCosecha() {
        return idCosecha;
    }

    public void setIdCosecha(int idCosecha) {
        this.idCosecha = idCosecha;
    }

    public int getIdCultivo() {
        return idCultivo;
    }

    public void setIdCultivo(int idCultivo) {
        this.idCultivo = idCultivo;
    }

    public String getFechaCosecha() {
        return fechaCosecha;
    }

    public void setFechaCosecha(String fechaCosecha) {
        this.fechaCosecha = fechaCosecha;
    }

    public double getCantidad() {
        return cantidad;
    }

    public void setCantidad(double cantidad) {
        this.cantidad = cantidad;
    }

    public String getCalidad() {
        return calidad;
    }

    public void setCalidad(String calidad) {
        this.calidad = calidad;
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
        return "Cosecha{" + "idCosecha=" + idCosecha + ", idCultivo=" + idCultivo + ", fechaCosecha=" + fechaCosecha + ", cantidad=" + cantidad + ", calidad=" + calidad + ", observaciones=" + observaciones + ", nombreCultivo=" + nombreCultivo + '}';
    }
    

    
}

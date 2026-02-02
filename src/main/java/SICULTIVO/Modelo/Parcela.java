package SICULTIVO.Modelo;

/**
 *
 * @author HP
 */
public class Parcela {

    private int idParcela;
    private int idUsuario;
    private String nombre;
    private String ubicacion;
    private double area;
    private String tipoSuelo;
    private String estado;
    private String fechaCreado;

    public Parcela() {
    }

    public Parcela(int idUsuario, String nombre, String ubicacion, double area, String tipoSuelo, String estado) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.ubicacion = ubicacion;
        this.area = area;
        this.tipoSuelo = tipoSuelo;
        this.estado = estado;
    }

    public int getIdParcela() {
        return idParcela;
    }

    public void setIdParcela(int idParcela) {
        this.idParcela = idParcela;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public String getTipoSuelo() {
        return tipoSuelo;
    }

    public void setTipoSuelo(String tipoSuelo) {
        this.tipoSuelo = tipoSuelo;
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

    @Override
    public String toString() {
        return "Parcela{" + "idParcela=" + idParcela + ", idUsuario=" + idUsuario + ", nombre=" + nombre + ", ubicacion=" + ubicacion + ", area=" + area + ", tipoSuelo=" + tipoSuelo + ", estado=" + estado + ", fechaCreado=" + fechaCreado + '}';
    }

}

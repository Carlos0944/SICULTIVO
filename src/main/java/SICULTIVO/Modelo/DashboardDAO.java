package SICULTIVO.Modelo;

import java.sql.*;

public class DashboardDAO {

    private conexionBD conecta;

    public DashboardDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    private int obtenerEntero(String sql) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
            }
            if (ps != null) try {
                ps.close();
            } catch (SQLException ex) {
            }
            try {
                conecta.disconnect();
            } catch (Exception ex) {
            }
        }
    }

    private double obtenerDouble(String sql) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            return rs.next() ? rs.getDouble(1) : 0.0;
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
            }
            if (ps != null) try {
                ps.close();
            } catch (SQLException ex) {
            }
            try {
                conecta.disconnect();
            } catch (Exception ex) {
            }
        }
    }

    public int contarParcelasActivas() throws SQLException {
        return obtenerEntero("SELECT COUNT(*) FROM parcelas WHERE PARESTADO = 'ACTIVO'");
    }

    public int contarCultivosActivos() throws SQLException {
        return obtenerEntero(
                "SELECT COUNT(*) FROM cultivos "
                + "WHERE UPPER(CULESTADO) IN ('GERMINANDO','EN CRECIMIENTO','LISTO COSECHA')"
        );
    }

    public int contarTareasPendientes() throws SQLException {
        return obtenerEntero("SELECT COUNT(*) FROM tareas WHERE TAREESTADO = 'PENDIENTE'");
    }

    public int contarCosechasMes() throws SQLException {
        return obtenerEntero(
                "SELECT COUNT(*) FROM cosechas "
                + "WHERE YEAR(COSFECHACOSECHA)=YEAR(CURDATE()) "
                + "AND MONTH(COSFECHACOSECHA)=MONTH(CURDATE())"
        );
    }

    public double sumarKgCosechadosMes() throws SQLException {
        return obtenerDouble(
                "SELECT IFNULL(SUM(COSCANTIDAD),0) FROM cosechas "
                + "WHERE YEAR(COSFECHACOSECHA)=YEAR(CURDATE()) "
                + "AND MONTH(COSFECHACOSECHA)=MONTH(CURDATE())"
        );
    }
}

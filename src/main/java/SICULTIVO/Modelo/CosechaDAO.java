package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CosechaDAO {

    private conexionBD conecta;

    public CosechaDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword)
            throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    // 🔹 INSERT
    public boolean insertar(Cosecha c) {

        String sql = "INSERT INTO cosechas "
                + "(ID_CULTIVO, COSFECHACOSECHA, COSCANTIDAD, COSCALIDAD, COSOBSERVACIONES) "
                + "VALUES (?, ?, ?, ?, ?)";

        boolean estado = false;

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, c.getIdCultivo());
            ps.setString(2, c.getFechaCosecha());
            ps.setDouble(3, c.getCantidad());
            ps.setString(4, c.getCalidad());
            ps.setString(5, c.getObservaciones());

            ps.executeUpdate();
            estado = true;

            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estado;
    }

    public List<String> listarCalidad() {

        List<String> calidad = new ArrayList<>();

        String sql = "SELECT DISTINCT COSCALIDAD FROM cosechas WHERE COSCALIDAD IS NOT NULL";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                calidad.add(rs.getString("COSCALIDAD"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return calidad;
    }

    // 🔹 SELECT (listar)
    public List<Cosecha> listar() {

        List<Cosecha> lista = new ArrayList<>();

        String sql = "SELECT co.ID_COSECHA, co.ID_CULTIVO, c.CULNOMBRE, "
                + "co.COSFECHACOSECHA, co.COSCANTIDAD, co.COSCALIDAD, co.COSOBSERVACIONES "
                + "FROM cosechas co, cultivos c "
                + "WHERE co.ID_CULTIVO = c.ID_CULTIVO "
                + "ORDER BY co.ID_COSECHA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cosecha c = new Cosecha();
                c.setIdCosecha(rs.getInt("ID_COSECHA"));
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setNombreCultivo(rs.getString("CULNOMBRE"));
                c.setFechaCosecha(rs.getString("COSFECHACOSECHA"));
                c.setCantidad(rs.getDouble("COSCANTIDAD"));
                c.setCalidad(rs.getString("COSCALIDAD"));
                c.setObservaciones(rs.getString("COSOBSERVACIONES"));

                lista.add(c);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // 🔹 BUSCAR (por calidad)
    public List<Cosecha> buscarPorCalidad(String calidad) {

        List<Cosecha> lista = new ArrayList<>();

        String sql
                = "SELECT co.ID_COSECHA, co.ID_CULTIVO, cu.CULNOMBRE, "
                + "       co.COSFECHACOSECHA, co.COSCANTIDAD, co.COSCALIDAD, co.COSOBSERVACIONES "
                + "FROM cosechas co "
                + "JOIN cultivos cu ON cu.ID_CULTIVO = co.ID_CULTIVO "
                + "WHERE co.COSCALIDAD LIKE ?";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, "%" + calidad + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cosecha c = new Cosecha();
                c.setIdCosecha(rs.getInt("ID_COSECHA"));
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setFechaCosecha(rs.getString("COSFECHACOSECHA"));
                c.setCantidad(rs.getDouble("COSCANTIDAD"));
                c.setCalidad(rs.getString("COSCALIDAD"));
                c.setObservaciones(rs.getString("COSOBSERVACIONES"));
                c.setNombreCultivo(rs.getString("CULNOMBRE"));

                lista.add(c);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Cosecha seleccionarPorId(int idCosecha) {

        String sql = "SELECT co.ID_COSECHA, co.ID_CULTIVO, c.CULNOMBRE, "
                + "co.COSFECHACOSECHA, co.COSCANTIDAD, co.COSCALIDAD, co.COSOBSERVACIONES "
                + "FROM cosechas co "
                + "JOIN cultivos c ON co.ID_CULTIVO = c.ID_CULTIVO "
                + "WHERE co.ID_COSECHA = ?";

        Cosecha c = null;

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idCosecha);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cosecha();
                c.setIdCosecha(rs.getInt("ID_COSECHA"));
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setNombreCultivo(rs.getString("CULNOMBRE"));
                c.setFechaCosecha(rs.getString("COSFECHACOSECHA"));
                c.setCantidad(rs.getDouble("COSCANTIDAD"));
                c.setCalidad(rs.getString("COSCALIDAD"));
                c.setObservaciones(rs.getString("COSOBSERVACIONES"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    public boolean actualizar(Cosecha c) {

        String sql = "UPDATE cosechas SET ID_CULTIVO = ?, COSFECHACOSECHA = ?, "
                + "COSCANTIDAD = ?, COSCALIDAD = ?, COSOBSERVACIONES = ? "
                + "WHERE ID_COSECHA = ?";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, c.getIdCultivo());
            ps.setString(2, c.getFechaCosecha());
            ps.setDouble(3, c.getCantidad());
            ps.setString(4, c.getCalidad());
            ps.setString(5, c.getObservaciones());
            ps.setInt(6, c.getIdCosecha());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                conecta.disconnect();
            } catch (Exception ex) {
            }
        }
    }

    public boolean eliminar(int idCosecha) {

        String sql = "DELETE FROM cosechas WHERE ID_COSECHA = ?";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idCosecha);

            boolean ok = ps.executeUpdate() > 0;

            ps.close();
            conecta.disconnect();
            return ok;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cosecha> listarPorRangoFechas(String desde, String hasta) {

        List<Cosecha> lista = new ArrayList<>();

        String sql
                = "SELECT co.ID_COSECHA, co.ID_CULTIVO, cu.CULNOMBRE, "
                + "       co.COSFECHACOSECHA, co.COSCANTIDAD, co.COSCALIDAD, co.COSOBSERVACIONES "
                + "FROM cosechas co "
                + "JOIN cultivos cu ON cu.ID_CULTIVO = co.ID_CULTIVO "
                + "WHERE co.COSFECHACOSECHA BETWEEN ? AND ? "
                + "ORDER BY co.COSFECHACOSECHA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setString(1, desde); // formato: yyyy-mm-dd
            ps.setString(2, hasta); // formato: yyyy-mm-dd

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cosecha c = new Cosecha();
                c.setIdCosecha(rs.getInt("ID_COSECHA"));
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setNombreCultivo(rs.getString("CULNOMBRE"));
                c.setFechaCosecha(rs.getString("COSFECHACOSECHA"));
                c.setCantidad(rs.getDouble("COSCANTIDAD"));
                c.setCalidad(rs.getString("COSCALIDAD"));
                c.setObservaciones(rs.getString("COSOBSERVACIONES"));
                lista.add(c);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

}

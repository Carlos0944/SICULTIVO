package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CultivoDAO {

    private conexionBD conecta;

    public CultivoDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    // INSERT
    public boolean insertar(Cultivo c) {

        String sql = "INSERT INTO cultivos "
                + "(ID_PARCELA, CULNOMBRE, CULVARIEDAD, CULFECHASIEMBRA, CULCANTIDADSEMBRADA, CULESTADO, CULOBSERVACIONES) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        boolean ok = false;
        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, c.getIdParcela());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getVariedad());
            ps.setString(4, c.getFechaSiembra());
            ps.setInt(5, c.getCantidadSembrada());
            ps.setString(6, c.getEstado());
            ps.setString(7, c.getObservaciones());

            ps.executeUpdate();
            ok = true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            try {
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return ok;
    }

    // SELECT (LISTAR)
    public List<Cultivo> listar() {

        List<Cultivo> lista = new ArrayList<>();

        String sql = "SELECT c.ID_CULTIVO, c.ID_PARCELA, p.PARNOMBRE, " + "c.CULNOMBRE, c.CULVARIEDAD, c.CULFECHASIEMBRA, " + "c.CULCANTIDADSEMBRADA, c.CULESTADO, c.CULOBSERVACIONES "
                + "FROM cultivos c, parcelas p "
                + "WHERE c.ID_PARCELA = p.ID_PARCELA "
                + "ORDER BY c.ID_CULTIVO DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cultivo c = new Cultivo();
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setIdParcela(rs.getInt("ID_PARCELA"));
                c.setNombreParcela(rs.getString("PARNOMBRE"));
                c.setNombre(rs.getString("CULNOMBRE"));
                c.setVariedad(rs.getString("CULVARIEDAD"));
                c.setFechaSiembra(rs.getString("CULFECHASIEMBRA"));
                c.setCantidadSembrada(rs.getInt("CULCANTIDADSEMBRADA"));
                c.setEstado(rs.getString("CULESTADO"));
                c.setObservaciones(rs.getString("CULOBSERVACIONES"));

                lista.add(c);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<String> listarEstadosCultivo() {

        List<String> estado = new ArrayList<>();

        String sql = "SELECT DISTINCT CULESTADO FROM cultivos WHERE CULESTADO IS NOT NULL";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                estado.add(rs.getString("CULESTADO"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return estado;
    }

    public List<Cultivo> buscarPorNombre(String texto) {

        List<Cultivo> lista = new ArrayList<>();

        String sql
                = "SELECT c.ID_CULTIVO, c.ID_PARCELA, p.PARNOMBRE, "
                + "       c.CULNOMBRE, c.CULVARIEDAD, c.CULFECHASIEMBRA, "
                + "       c.CULCANTIDADSEMBRADA, c.CULESTADO, c.CULOBSERVACIONES "
                + "FROM cultivos c "
                + "LEFT JOIN parcelas p ON p.ID_PARCELA = c.ID_PARCELA "
                + "WHERE c.CULNOMBRE LIKE ? "
                + "ORDER BY c.ID_CULTIVO DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, "%" + texto + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cultivo c = new Cultivo();
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setIdParcela(rs.getInt("ID_PARCELA"));
                c.setNombreParcela(rs.getString("PARNOMBRE")); 
                c.setNombre(rs.getString("CULNOMBRE"));
                c.setVariedad(rs.getString("CULVARIEDAD"));
                c.setFechaSiembra(rs.getString("CULFECHASIEMBRA"));
                c.setCantidadSembrada(rs.getInt("CULCANTIDADSEMBRADA"));
                c.setEstado(rs.getString("CULESTADO"));
                c.setObservaciones(rs.getString("CULOBSERVACIONES"));

                lista.add(c);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Cultivo seleccionarPorId(int idCultivo) {

        String sql = "SELECT c.ID_CULTIVO, c.ID_PARCELA, p.PARNOMBRE, c.CULNOMBRE, c.CULVARIEDAD, "
                + "c.CULFECHASIEMBRA, c.CULCANTIDADSEMBRADA, c.CULESTADO, c.CULOBSERVACIONES "
                + "FROM cultivos c "
                + "JOIN parcelas p ON c.ID_PARCELA = p.ID_PARCELA "
                + "WHERE c.ID_CULTIVO = ? LIMIT 1";

        PreparedStatement ps = null;
        ResultSet rs = null;
        Cultivo c = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idCultivo);
            rs = ps.executeQuery();

            if (rs.next()) {
                c = new Cultivo();
                c.setIdCultivo(rs.getInt("ID_CULTIVO"));
                c.setIdParcela(rs.getInt("ID_PARCELA"));
                c.setNombreParcela(rs.getString("PARNOMBRE"));
                c.setNombre(rs.getString("CULNOMBRE"));
                c.setVariedad(rs.getString("CULVARIEDAD"));
                c.setFechaSiembra(rs.getString("CULFECHASIEMBRA"));
                c.setCantidadSembrada(rs.getInt("CULCANTIDADSEMBRADA"));
                c.setEstado(rs.getString("CULESTADO"));
                c.setObservaciones(rs.getString("CULOBSERVACIONES"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ex) {
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ex) {
            }
            try {
                conecta.disconnect();
            } catch (Exception ex) {
            }
        }

        return c;
    }

    public boolean actualizar(Cultivo c) {

        String sql = "UPDATE cultivos SET ID_PARCELA = ?, CULNOMBRE = ?, CULVARIEDAD = ?, "
                + "CULFECHASIEMBRA = ?, CULCANTIDADSEMBRADA = ?, CULESTADO = ?, CULOBSERVACIONES = ? "
                + "WHERE ID_CULTIVO = ?";

        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, c.getIdParcela());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getVariedad());
            ps.setString(4, c.getFechaSiembra());
            ps.setInt(5, c.getCantidadSembrada());
            ps.setString(6, c.getEstado());
            ps.setString(7, c.getObservaciones());
            ps.setInt(8, c.getIdCultivo());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ex) {
            }
            try {
                conecta.disconnect();
            } catch (Exception ex) {
            }
        }
    }

    public String eliminarCultivo(int idCultivo) {

        String sql = "DELETE FROM cultivos WHERE ID_CULTIVO = ?";
        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idCultivo);

            int filas = ps.executeUpdate();

            if (filas > 0) {
                return "OK";
            }
            return "No se encontró el cultivo.";

        } catch (SQLException e) {

            if (e.getErrorCode() == 1451 || "23000".equals(e.getSQLState())) {
                String m = (e.getMessage() != null) ? e.getMessage().toLowerCase() : "";

                if (m.contains("tareas")) {
                    return "No se puede eliminar el cultivo porque tiene TAREAS asociadas. "
                            + "Primero elimine las tareas de este cultivo.";
                }
                if (m.contains("cosechas")) {
                    return "No se puede eliminar el cultivo porque tiene COSECHAS asociadas. "
                            + "Primero elimine las cosechas de este cultivo.";
                }

                return "No se puede eliminar el cultivo porque tiene datos relacionados (tareas o cosechas). "
                        + "Primero elimine esos registros.";
            }

            e.printStackTrace();
            return "Error al eliminar el cultivo.";

        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException ex) {
            }
            try {
                conecta.disconnect();
            } catch (SQLException ex) {
            }
        }
    }

}

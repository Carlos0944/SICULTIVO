package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParcelaDAO {

    private conexionBD conecta;

    public ParcelaDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    public boolean existeParcelaPorNombre(String nombre) {

        String sql = "SELECT 1 FROM parcelas WHERE PARNOMBRE = ? LIMIT 1";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, nombre);

            ResultSet rs = ps.executeQuery();
            boolean existe = rs.next();

            rs.close();
            ps.close();
            conecta.disconnect();

            return existe;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🔹 INSERT
    public boolean insertar(Parcela p) {

        //  VALIDACIÓN DE NOMBRE REPETIDO
        if (existeParcelaPorNombre(p.getNombre())) {
            return false; // ya existe, no se inserta
        }

        String sql = "INSERT INTO parcelas "
                + "(ID_USUARIO, PARNOMBRE, PARUBICACION, PARAREA, PARTIPOSUELO, PARESTADO) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, p.getIdUsuario());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getUbicacion());
            ps.setDouble(4, p.getArea());
            ps.setString(5, p.getTipoSuelo());
            ps.setString(6, p.getEstado());

            ps.executeUpdate();
            ps.close();
            conecta.disconnect();

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> listarEstados() {

        List<String> estados = new ArrayList<>();

        String sql = "SELECT DISTINCT PARESTADO FROM parcelas WHERE PARESTADO IS NOT NULL";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                estados.add(rs.getString("PARESTADO"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estados;
    }

    public List<String> listarTiposSuelo() {
        List<String> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT PARTIPOSUELO FROM parcelas WHERE PARTIPOSUELO IS NOT NULL";
        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(rs.getString("PARTIPOSUELO"));
            }
            rs.close();
            ps.close();
            conecta.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Parcela> listar() {

        List<Parcela> lista = new ArrayList<>();

        String sql = "SELECT * FROM parcelas";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Parcela p = new Parcela();
                p.setIdParcela(rs.getInt("ID_PARCELA"));
                p.setIdUsuario(rs.getInt("ID_USUARIO"));
                p.setNombre(rs.getString("PARNOMBRE"));
                p.setUbicacion(rs.getString("PARUBICACION"));
                p.setArea(rs.getDouble("PARAREA"));
                p.setTipoSuelo(rs.getString("PARTIPOSUELO"));
                p.setEstado(rs.getString("PARESTADO"));
                p.setFechaCreado(rs.getString("PARFECHACREADO"));

                lista.add(p);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // 🔹 SELECT con buscador por nombre
    public List<Parcela> buscarPorNombre(String nombre) {

        List<Parcela> lista = new ArrayList<>();

        String sql = "SELECT ID_PARCELA, ID_USUARIO, PARNOMBRE, PARUBICACION, PARAREA, "
                + "PARTIPOSUELO, PARESTADO, PARFECHACREADO "
                + "FROM parcelas "
                + "WHERE PARNOMBRE LIKE ? "
                + "ORDER BY ID_PARCELA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, "%" + nombre + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Parcela p = new Parcela();
                p.setIdParcela(rs.getInt("ID_PARCELA"));
                p.setIdUsuario(rs.getInt("ID_USUARIO"));
                p.setNombre(rs.getString("PARNOMBRE"));
                p.setUbicacion(rs.getString("PARUBICACION"));
                p.setArea(rs.getDouble("PARAREA"));
                p.setTipoSuelo(rs.getString("PARTIPOSUELO"));
                p.setEstado(rs.getString("PARESTADO"));
                p.setFechaCreado(rs.getString("PARFECHACREADO"));

                lista.add(p);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Parcela seleccionarPorId(int idParcela) {

        String sql = "SELECT ID_PARCELA, ID_USUARIO, PARNOMBRE, PARUBICACION, PARAREA, "
                + "PARTIPOSUELO, PARESTADO, PARFECHACREADO "
                + "FROM parcelas WHERE ID_PARCELA = ? LIMIT 1";

        Parcela p = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idParcela);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new Parcela();
                p.setIdParcela(rs.getInt("ID_PARCELA"));
                p.setIdUsuario(rs.getInt("ID_USUARIO"));
                p.setNombre(rs.getString("PARNOMBRE"));
                p.setUbicacion(rs.getString("PARUBICACION"));
                p.setArea(rs.getDouble("PARAREA"));
                p.setTipoSuelo(rs.getString("PARTIPOSUELO"));
                p.setEstado(rs.getString("PARESTADO"));
                p.setFechaCreado(rs.getString("PARFECHACREADO"));
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

        return p;
    }

    public boolean actualizar(Parcela p) {

        String sql = "UPDATE parcelas SET ID_USUARIO = ?, PARNOMBRE = ?, PARUBICACION = ?, "
                + "PARAREA = ?, PARTIPOSUELO = ?, PARESTADO = ?, PARFECHACREADO = ? "
                + "WHERE ID_PARCELA = ?";

        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, p.getIdUsuario());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getUbicacion());
            ps.setDouble(4, p.getArea());
            ps.setString(5, p.getTipoSuelo());
            ps.setString(6, p.getEstado());
            String dt = p.getFechaCreado();
            if (dt != null && !dt.trim().isEmpty()) {
                dt = dt.replace("T", " ") + ":00";
                ps.setString(7, dt);
            } else {
                ps.setNull(7, Types.TIMESTAMP);
            }

            ps.setInt(8, p.getIdParcela());

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

    public String eliminarParcela(int idParcela) {
        String sql = "DELETE FROM parcelas WHERE ID_PARCELA = ?";
        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idParcela);

            int filas = ps.executeUpdate();

            if (filas > 0) {
                return "OK";
            }
            return "No se encontró la parcela.";

        } catch (SQLException e) {

            if (e.getErrorCode() == 1451 || "23000".equals(e.getSQLState())) {
                return "No se puede eliminar la parcela porque tiene CULTIVOS asociados. "
                        + "Primero elimine los cultivos de esta parcela.";
            }

            e.printStackTrace();
            return "Error al eliminar la parcela.";

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

    public int contarParcelasActivas() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM parcelas WHERE PARESTADO = 'ACTIVO'";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
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

        return total;
    }

}

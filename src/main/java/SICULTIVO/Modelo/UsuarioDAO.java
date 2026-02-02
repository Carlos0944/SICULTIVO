package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    private conexionBD conecta;

    public UsuarioDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    // ===================== LOGIN =====================
    public Usuario autenticar(String correo, String passwordPlano) {

        String sql
                = "SELECT u.ID_USUARIO, u.ID_ROL, u.USUNOMBRE, u.USUCORREO, u.USUESTADO, u.USUFECHACREADO, " + "u.USUCLAVE_HASH, r.ROLNOMBRE "
                + "FROM usuarios u " + "JOIN roles r ON r.ID_ROL = u.ID_ROL " + "WHERE u.USUCORREO = ? " + "LIMIT 1";

        Usuario u = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            conecta.connection();

            pstm = conecta.getjdbcConnection().prepareStatement(sql);
            pstm.setString(1, correo);

            rs = pstm.executeQuery();

            if (rs.next()) {
                String claveBD = rs.getString("USUCLAVE_HASH");

                // ⚠️ Aquí estás comparando "plano vs hash". Si ya tienes hash real, debes hashear passwordPlano.
                if (claveBD == null || !claveBD.trim().equals(passwordPlano)) {
                    return null;
                }

                u = new Usuario();
                u.setIdUsuario(rs.getInt("ID_USUARIO"));
                u.setIdRol(rs.getInt("ID_ROL"));
                u.setNombre(rs.getString("USUNOMBRE"));
                u.setCorreo(rs.getString("USUCORREO"));
                u.setEstado(rs.getString("USUESTADO"));
                u.setFechaCreado(rs.getString("USUFECHACREADO"));
                u.setRolNombre(rs.getString("ROLNOMBRE"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return u;
    }

    // ===================== LISTAR USUARIOS + ROL =====================
    public List<Usuario> listarUsuariosConRol() {
        List<Usuario> lista = new ArrayList<>();

        String sql
                = "SELECT u.ID_USUARIO, u.ID_ROL, u.USUNOMBRE, u.USUCORREO, u.USUESTADO, u.USUFECHACREADO, "
                + "       r.ROLNOMBRE "
                + "FROM usuarios u "
                + "JOIN roles r ON r.ID_ROL = u.ID_ROL "
                + "ORDER BY u.ID_USUARIO DESC";

        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            pstm = conecta.getjdbcConnection().prepareStatement(sql);
            rs = pstm.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("ID_USUARIO"));
                u.setIdRol(rs.getInt("ID_ROL"));
                u.setNombre(rs.getString("USUNOMBRE"));
                u.setCorreo(rs.getString("USUCORREO"));
                u.setEstado(rs.getString("USUESTADO"));
                u.setFechaCreado(rs.getString("USUFECHACREADO"));
                u.setRolNombre(rs.getString("ROLNOMBRE"));
                lista.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return lista;
    }

    // ===================== BUSCAR USUARIOS (NOMBRE/CORREO/ROL) =====================
    public List<Usuario> buscarUsuariosConRol(String buscar) {
        List<Usuario> lista = new ArrayList<>();

        String sql
                = "SELECT u.ID_USUARIO, u.ID_ROL, u.USUNOMBRE, u.USUCORREO, u.USUESTADO, u.USUFECHACREADO, "
                + "       r.ROLNOMBRE "
                + "FROM usuarios u "
                + "JOIN roles r ON r.ID_ROL = u.ID_ROL "
                + "WHERE u.USUNOMBRE LIKE ? OR u.USUCORREO LIKE ? OR r.ROLNOMBRE LIKE ? "
                + "ORDER BY u.ID_USUARIO DESC";

        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            conecta.connection();

            pstm = conecta.getjdbcConnection().prepareStatement(sql);
            String like = "%" + buscar + "%";
            pstm.setString(1, like);
            pstm.setString(2, like);
            pstm.setString(3, like);

            rs = pstm.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("ID_USUARIO"));
                u.setIdRol(rs.getInt("ID_ROL"));
                u.setNombre(rs.getString("USUNOMBRE"));
                u.setCorreo(rs.getString("USUCORREO"));
                u.setEstado(rs.getString("USUESTADO"));
                u.setFechaCreado(rs.getString("USUFECHACREADO"));
                u.setRolNombre(rs.getString("ROLNOMBRE"));
                lista.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return lista;
    }

    public boolean existeUsuarioPorCorreo(String correo) {

        String sql = "SELECT 1 FROM usuarios WHERE USUCORREO = ? LIMIT 1";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, correo);

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

    public boolean existeUsuarioPorNombre(String nombre) {

        String sql = "SELECT 1 FROM usuarios WHERE USUNOMBRE = ? LIMIT 1";

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

    public boolean insertarUsuario(Usuario u) {
        if (existeUsuarioPorCorreo(u.getCorreo())) {
            return false;
        }
        String sql
                = "INSERT INTO usuarios (ID_ROL, USUNOMBRE, USUCORREO, USUCLAVE_HASH, USUESTADO) "
                + "VALUES (?, ?, ?, ?, ?)";

        PreparedStatement pstm = null;

        try {
            conecta.connection();

            pstm = conecta.getjdbcConnection().prepareStatement(sql);
            pstm.setInt(1, u.getIdRol());
            pstm.setString(2, u.getNombre());
            pstm.setString(3, u.getCorreo());
            pstm.setString(4, u.getClaveHash());
            pstm.setString(5, u.getEstado());

            return pstm.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public Usuario seleccionarPorId(int idUsuario) {

        String sql
                = "SELECT u.ID_USUARIO, u.ID_ROL, u.USUNOMBRE, u.USUCORREO, u.USUESTADO, u.USUFECHACREADO, "
                + "       u.USUCLAVE_HASH, r.ROLNOMBRE "
                + "FROM usuarios u "
                + "JOIN roles r ON r.ID_ROL = u.ID_ROL "
                + "WHERE u.ID_USUARIO = ? "
                + "LIMIT 1";

        Usuario u = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            pstm = conecta.getjdbcConnection().prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            rs = pstm.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setIdUsuario(rs.getInt("ID_USUARIO"));
                u.setIdRol(rs.getInt("ID_ROL"));
                u.setNombre(rs.getString("USUNOMBRE"));
                u.setCorreo(rs.getString("USUCORREO"));
                u.setEstado(rs.getString("USUESTADO"));
                u.setFechaCreado(rs.getString("USUFECHACREADO"));
                u.setRolNombre(rs.getString("ROLNOMBRE"));
                u.setClaveHash(rs.getString("USUCLAVE_HASH"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return u;
    }

    public boolean actualizarUsuario(Usuario u) {

        String sql = "UPDATE usuarios SET ID_ROL = ?, USUNOMBRE = ?, USUCORREO = ?, USUCLAVE_HASH = ?, USUESTADO = ? , USUFECHACREADO = ?"
                + "WHERE ID_USUARIO = ?";

        PreparedStatement pstm = null;

        try {
            conecta.connection();
            pstm = conecta.getjdbcConnection().prepareStatement(sql);

            pstm.setInt(1, u.getIdRol());
            pstm.setString(2, u.getNombre());
            pstm.setString(3, u.getCorreo());
            pstm.setString(4, u.getClaveHash());
            pstm.setString(5, u.getEstado());
            pstm.setString(6, u.getFechaCreado());
            pstm.setInt(7, u.getIdUsuario());

            return pstm.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (pstm != null) {
                    pstm.close();
                }
                conecta.disconnect();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    // ===================== ELIMINAR USUARIO =====================

    public String eliminarUsuario(int idUsuario) {

        String sql = "DELETE FROM usuarios WHERE ID_USUARIO = ?";

        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idUsuario);

            int filas = ps.executeUpdate();

            if (filas > 0) {
                return "OK";
            }
            return "No se encontró el usuario.";

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState()) || e.getErrorCode() == 1451) {
                String m = (e.getMessage() == null) ? "" : e.getMessage().toLowerCase();

                if (m.contains("parcelas")) {
                    return "No se puede eliminar el usuario porque tiene PARCELAS asociadas. "
                            + "Primero elimine las parcelas del usuario.";
                }
                if (m.contains("historialacciones")) {
                    return "No se puede eliminar el usuario porque tiene HISTORIAL asociado. "
                            + "Primero elimine el historial del usuario.";
                }

                return "No se puede eliminar el usuario porque tiene datos relacionados.";
            }

            e.printStackTrace();
            return "Error al eliminar usuario.";

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
    public List<Usuario> listarOperarios() {

    List<Usuario> lista = new ArrayList<>();

    String sql =
        "SELECT u.ID_USUARIO, u.USUNOMBRE " +
        "FROM usuarios u " +
        "JOIN roles r ON r.ID_ROL = u.ID_ROL " +
        "WHERE UPPER(r.ROLNOMBRE) = 'OPERARIO' " +
        "AND UPPER(u.USUESTADO) = 'ACTIVO'";

    try {
        conecta.connection();
        PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Usuario u = new Usuario();
            u.setIdUsuario(rs.getInt("ID_USUARIO"));
            u.setNombre(rs.getString("USUNOMBRE"));
            lista.add(u);
        }

        rs.close();
        ps.close();
        conecta.disconnect();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return lista;
}


}

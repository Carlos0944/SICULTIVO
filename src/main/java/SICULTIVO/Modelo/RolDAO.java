package SICULTIVO.Modelo;

import java.sql.*;
import java.util.*;

public class RolDAO {

    private conexionBD conecta;

    public RolDAO(String jdbcURL, String jdbcUsername, String jdbcPassword)
            throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // 🔹 LISTAR ROLES
    public List<Rol> listar() {

        List<Rol> lista = new ArrayList<>();
        String sql = "SELECT ID_ROL, ROLNOMBRE FROM roles ORDER BY ROLNOMBRE";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Rol r = new Rol();
                r.setIdRol(rs.getInt("ID_ROL"));
                r.setNombre(rs.getString("ROLNOMBRE"));
                lista.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { conecta.disconnect(); } catch (Exception e) {}
        }

        return lista;
    }

    // 🔹 LISTAR ESTADOS DE USUARIO (OPCIONAL)
    public List<String> listarEstadosUsuario() {

        List<String> estados = new ArrayList<>();
        String sql = "SELECT DISTINCT USUESTADO FROM usuarios";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                estados.add(rs.getString("USUESTADO"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { conecta.disconnect(); } catch (Exception e) {}
        }

        return estados;
    }
}

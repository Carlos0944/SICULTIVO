package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistorialAccionesDAO {

    private conexionBD conecta;

    public HistorialAccionesDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    public boolean insertar(HistorialAccion h) {

        String sql = "INSERT INTO historialacciones (ID_USUARIO, HISTTABLAAFECTADA, HISTACCION, HISTDESCRIPCION) "
                + "VALUES (?, ?, ?, ?)";

        try {
            conecta.connection();//Abre la conexion 
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);// Preparar el SQL con parametros

            ps.setInt(1, h.getIdUsuario());//argar los valores en ? del SQL 
            ps.setString(2, h.getTablaAfectada());
            ps.setString(3, h.getAccion());
            ps.setString(4, h.getDescripcion());

            int filas = ps.executeUpdate();// Ejecucion del Insert, devuelve el numero de filas insertadas

            ps.close();
            conecta.disconnect();

            return filas > 0;// si se inserto una fila o mas devuelve True

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT ID_USUARIO, USUNOMBRE FROM usuarios";
        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();// Ejecucion del Select

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

    public List<String> listarTablas() {
        List<String> tablas = new ArrayList<>();
        String sql = "SELECT DISTINCT HISTTABLAAFECTADA FROM historialacciones";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                tablas.add(rs.getString("HISTTABLAAFECTADA"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tablas;
    }

    // ✅ SELECT (listar)
    public List<HistorialAccion> listar() {

        List<HistorialAccion> lista = new ArrayList<>();

        String sql = "SELECT h.ID_HISTORIAL, h.ID_USUARIO, u.USUNOMBRE AS USUARIO, "
                + "h.HISTTABLAAFECTADA, h.HISTACCION, h.HISTDESCRIPCION, h.HISTFECHAHORA "
                + "FROM historialacciones h, usuarios u "
                + "WHERE h.ID_USUARIO = u.ID_USUARIO "
                + "ORDER BY h.ID_HISTORIAL DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery(); //Ejecucion del select

            while (rs.next()) {
                HistorialAccion h = new HistorialAccion();
                h.setIdHistorial(rs.getInt("ID_HISTORIAL"));
                h.setIdUsuario(rs.getInt("ID_USUARIO"));
                h.setNombreUsuario(rs.getString("USUARIO"));
                h.setTablaAfectada(rs.getString("HISTTABLAAFECTADA"));
                h.setAccion(rs.getString("HISTACCION"));
                h.setDescripcion(rs.getString("HISTDESCRIPCION"));
                h.setFechaHora(String.valueOf(rs.getTimestamp("HISTFECHAHORA")));

                lista.add(h);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<HistorialAccion> filtrar(String idUsuario, String tabla, String desde, String hasta) {

        List<HistorialAccion> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT h.ID_HISTORIAL, h.ID_USUARIO, u.USUNOMBRE AS USUARIO, "
                + "h.HISTTABLAAFECTADA, h.HISTACCION, h.HISTDESCRIPCION, h.HISTFECHAHORA "
                + "FROM historialacciones h "
                + "LEFT JOIN usuarios u ON h.ID_USUARIO = u.ID_USUARIO "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>(); // Lista de parámetros para el PreparedStatement

        // Filtro por usuario
        if (idUsuario != null && !idUsuario.trim().isEmpty()) {
            sql.append(" AND h.ID_USUARIO = ? ");
            params.add(Integer.parseInt(idUsuario.trim()));
        }

        // Filtro por tabla afectada
        if (tabla != null && !tabla.trim().isEmpty()) {
            sql.append(" AND h.HISTTABLAAFECTADA = ? ");
            params.add(tabla.trim());
        }

        // Filtro desde (fecha inicial)
        if (desde != null && !desde.trim().isEmpty()) {
            sql.append(" AND DATE(h.HISTFECHAHORA) >= ? ");
            params.add(desde.trim());
        }

        // Filtro hasta (fecha final)
        if (hasta != null && !hasta.trim().isEmpty()) {
            sql.append(" AND DATE(h.HISTFECHAHORA) <= ? ");
            params.add(hasta.trim());
        }

        // Orden
        sql.append(" ORDER BY h.ID_HISTORIAL DESC ");

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql.toString());

            // Setear los ? según el orden de params
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery(); // Ejecución del SELECT

            while (rs.next()) {
                HistorialAccion h = new HistorialAccion();
                h.setIdHistorial(rs.getInt("ID_HISTORIAL"));
                h.setIdUsuario(rs.getInt("ID_USUARIO"));
                h.setNombreUsuario(rs.getString("USUARIO"));
                h.setTablaAfectada(rs.getString("HISTTABLAAFECTADA"));
                h.setAccion(rs.getString("HISTACCION"));
                h.setDescripcion(rs.getString("HISTDESCRIPCION"));
                h.setFechaHora(rs.getString("HISTFECHAHORA"));
                lista.add(h);
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

        return lista;
    }

    public HistorialAccion seleccionarPorId(int idHistorial) {

        String sql = "SELECT h.ID_HISTORIAL, h.ID_USUARIO, u.USUNOMBRE AS USUARIO, "
                + "h.HISTTABLAAFECTADA, h.HISTACCION, h.HISTDESCRIPCION, h.HISTFECHAHORA "
                + "FROM historialacciones h "
                + "LEFT JOIN usuarios u ON h.ID_USUARIO = u.ID_USUARIO "
                + "WHERE h.ID_HISTORIAL = ? LIMIT 1";

        PreparedStatement ps = null;
        ResultSet rs = null;
        HistorialAccion h = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idHistorial);
            rs = ps.executeQuery();

            if (rs.next()) {
                h = new HistorialAccion();
                h.setIdHistorial(rs.getInt("ID_HISTORIAL"));
                h.setIdUsuario(rs.getInt("ID_USUARIO"));
                h.setNombreUsuario(rs.getString("USUARIO"));
                h.setTablaAfectada(rs.getString("HISTTABLAAFECTADA"));
                h.setAccion(rs.getString("HISTACCION"));
                h.setDescripcion(rs.getString("HISTDESCRIPCION"));
                h.setFechaHora(String.valueOf(rs.getTimestamp("HISTFECHAHORA")));
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

        return h;
    }

    public boolean actualizar(HistorialAccion h) {

        String sql = "UPDATE historialacciones "
                + "SET ID_USUARIO = ?, HISTTABLAAFECTADA = ?, HISTACCION = ?, HISTDESCRIPCION = ?, HISTFECHAHORA = ? "
                + "WHERE ID_HISTORIAL = ?";

        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, h.getIdUsuario());// Setear parametros en orden de los ?
            ps.setString(2, h.getTablaAfectada());
            ps.setString(3, h.getAccion());
            ps.setString(4, h.getDescripcion());
            ps.setString(5, h.getFechaHora());
            ps.setInt(6, h.getIdHistorial());

            return ps.executeUpdate() == 1;// Ejecucion del Update, si se actualizo una fila True

        } catch (Exception e) {// Captura el error que ocurra en el try
            e.printStackTrace();// Imprimir error en consola
            return false;// indica que no se realizo correctamente
        } finally {
            try {
                if (ps != null) {// verificar si el Preparedstatement fue creado
                    ps.close();
                }
            } catch (Exception ex) {// Capturar errores al cerrar prepared sattemet
            }
            try {
                conecta.disconnect();// Cerrar conexion con la base de datos
            } catch (Exception ex) {// capturar errores al cerrar la conexion 
            }
        }
    }

    public boolean eliminar(int idHistorial) {

        String sql = "DELETE FROM historialacciones WHERE ID_HISTORIAL = ?";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idHistorial);

            boolean ok = ps.executeUpdate() > 0;

            ps.close();
            conecta.disconnect();

            return ok;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}

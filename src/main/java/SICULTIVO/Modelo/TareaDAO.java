package SICULTIVO.Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TareaDAO {

    private conexionBD conecta;

    public TareaDAO(String jdbcURL, String jdbcUSERName, String jdbcPassword) throws SQLException {
        conecta = new conexionBD(jdbcURL, jdbcUSERName, jdbcPassword);
    }

    public boolean insertar(Tarea t) {

        String sql = "INSERT INTO tareas "
                + "(ID_CULTIVO, TARETIPO, TAREFECHAPROGRAMADA, TARERESPONSABLE, TAREESTADO, TAREFECHAEJECUCION, TAREOBSERVACIONES) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        boolean ok = false;

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, t.getIdCultivo());
            ps.setString(2, t.getTipo());

            // date: viene del input type="date" como "YYYY-MM-DD"
            ps.setDate(3, Date.valueOf(t.getFechaProgramada()));

            ps.setString(4, t.getResponsable());
            ps.setString(5, t.getEstado());

            // fecha ejecución puede ser null/vacía
            if (t.getFechaEjecucion() == null || t.getFechaEjecucion().trim().isEmpty()) {
                ps.setNull(6, Types.DATE);
            } else {
                ps.setDate(6, Date.valueOf(t.getFechaEjecucion()));
            }

            ps.setString(7, t.getObservaciones());

            ps.executeUpdate();
            ok = true;

            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ok;
    }

    public List<String> listarTipoTarea() {
        List<String> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT TARETIPO FROM tareas WHERE TARETIPO IS NOT NULL";
        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(rs.getString("TARETIPO"));
            }
            rs.close();
            ps.close();
            conecta.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<String> listarEstadoTarea() {

        List<String> estado = new ArrayList<>();

        String sql = "SELECT DISTINCT TAREESTADO FROM tareas WHERE TAREESTADO IS NOT NULL";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                estado.add(rs.getString("TAREESTADO"));
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return estado;
    }

    public List<Tarea> listar() {

        List<Tarea> lista = new ArrayList<>();

        String sql = "SELECT t.ID_TAREA, t.ID_CULTIVO, c.CULNOMBRE, t.TARETIPO, t.TAREFECHAPROGRAMADA, t.TARERESPONSABLE, "
                + "t.TAREESTADO, t.TAREFECHAEJECUCION, t.TAREOBSERVACIONES "
                + "FROM tareas t, cultivos c "
                + "WHERE t.ID_CULTIVO = c.ID_CULTIVO "
                + "ORDER BY t.ID_TAREA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarea t = new Tarea();
                t.setIdTarea(rs.getInt("ID_TAREA"));
                t.setIdCultivo(rs.getInt("ID_CULTIVO"));
                t.setNombreCultivo(rs.getString("CULNOMBRE"));
                t.setTipo(rs.getString("TARETIPO"));
                Date fp = rs.getDate("TAREFECHAPROGRAMADA");
                t.setFechaProgramada(fp != null ? fp.toString() : null);
                t.setResponsable(rs.getString("TARERESPONSABLE"));
                t.setEstado(rs.getString("TAREESTADO"));
                Date fe = rs.getDate("TAREFECHAEJECUCION");
                t.setFechaEjecucion(fe != null ? fe.toString() : null);

                t.setObservaciones(rs.getString("TAREOBSERVACIONES"));

                lista.add(t);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Tarea> buscar(String texto) {

        List<Tarea> lista = new ArrayList<>();

        String sql
                = "SELECT t.ID_TAREA, t.ID_CULTIVO, c.CULNOMBRE, "
                + "       t.TARETIPO, t.TAREFECHAPROGRAMADA, t.TARERESPONSABLE, "
                + "       t.TAREESTADO, t.TAREFECHAEJECUCION, t.TAREOBSERVACIONES "
                + "FROM tareas t "
                + "JOIN cultivos c ON c.ID_CULTIVO = t.ID_CULTIVO "
                + "WHERE t.TARETIPO LIKE ? OR t.TARERESPONSABLE LIKE ? "
                + "ORDER BY t.ID_TAREA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, "%" + texto + "%");
            ps.setString(2, "%" + texto + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarea t = new Tarea();
                t.setIdTarea(rs.getInt("ID_TAREA"));
                t.setIdCultivo(rs.getInt("ID_CULTIVO"));
                t.setTipo(rs.getString("TARETIPO"));
                t.setNombreCultivo(rs.getString("CULNOMBRE"));

                Date fp = rs.getDate("TAREFECHAPROGRAMADA");
                t.setFechaProgramada(fp != null ? fp.toString() : null);

                t.setResponsable(rs.getString("TARERESPONSABLE"));
                t.setEstado(rs.getString("TAREESTADO"));

                Date fe = rs.getDate("TAREFECHAEJECUCION");
                t.setFechaEjecucion(fe != null ? fe.toString() : null);

                t.setObservaciones(rs.getString("TAREOBSERVACIONES"));

                lista.add(t);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    // ===================== SELECT POR ID =====================
    public Tarea seleccionarPorId(int idTarea) {

        String sql = "SELECT t.ID_TAREA, t.ID_CULTIVO, c.CULNOMBRE, t.TARETIPO, "
                + "t.TAREFECHAPROGRAMADA, t.TARERESPONSABLE, t.TAREESTADO, "
                + "t.TAREFECHAEJECUCION, t.TAREOBSERVACIONES "
                + "FROM tareas t "
                + "JOIN cultivos c ON t.ID_CULTIVO = c.ID_CULTIVO "
                + "WHERE t.ID_TAREA = ? LIMIT 1";

        PreparedStatement ps = null;
        ResultSet rs = null;
        Tarea t = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idTarea);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Tarea();
                t.setIdTarea(rs.getInt("ID_TAREA"));
                t.setIdCultivo(rs.getInt("ID_CULTIVO"));
                t.setNombreCultivo(rs.getString("CULNOMBRE"));
                t.setTipo(rs.getString("TARETIPO"));

                Date fp = rs.getDate("TAREFECHAPROGRAMADA");
                t.setFechaProgramada(fp != null ? fp.toString() : null);

                t.setResponsable(rs.getString("TARERESPONSABLE"));
                t.setEstado(rs.getString("TAREESTADO"));

                Date fe = rs.getDate("TAREFECHAEJECUCION");
                t.setFechaEjecucion(fe != null ? fe.toString() : null);

                t.setObservaciones(rs.getString("TAREOBSERVACIONES"));
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

        return t;
    }

// ===================== UPDATE =====================
    public boolean actualizar(Tarea t) {

        String sql = "UPDATE tareas SET ID_CULTIVO = ?, TARETIPO = ?, TAREFECHAPROGRAMADA = ?, "
                + "TARERESPONSABLE = ?, TAREESTADO = ?, TAREFECHAEJECUCION = ?, TAREOBSERVACIONES = ? "
                + "WHERE ID_TAREA = ?";

        PreparedStatement ps = null;

        try {
            conecta.connection();
            ps = conecta.getjdbcConnection().prepareStatement(sql);

            ps.setInt(1, t.getIdCultivo());
            ps.setString(2, t.getTipo());
            ps.setDate(3, Date.valueOf(t.getFechaProgramada()));
            ps.setString(4, t.getResponsable());
            ps.setString(5, t.getEstado());

            if (t.getFechaEjecucion() == null || t.getFechaEjecucion().trim().isEmpty()) {
                ps.setNull(6, Types.DATE);
            } else {
                ps.setDate(6, Date.valueOf(t.getFechaEjecucion()));
            }

            ps.setString(7, t.getObservaciones());
            ps.setInt(8, t.getIdTarea());

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

    public boolean eliminar(int idTarea) {

        String sql = "DELETE FROM tareas WHERE ID_TAREA = ?";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setInt(1, idTarea);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                conecta.disconnect();
            } catch (SQLException ex) {
            }
        }
    }

    public List<Tarea> listarPorResponsable(String responsable) {

        List<Tarea> lista = new ArrayList<>();

        String sql = "SELECT t.ID_TAREA, t.ID_CULTIVO, c.CULNOMBRE, t.TARETIPO, t.TAREFECHAPROGRAMADA, t.TARERESPONSABLE, "
                + "t.TAREESTADO, t.TAREFECHAEJECUCION, t.TAREOBSERVACIONES "
                + "FROM tareas t "
                + "JOIN cultivos c ON c.ID_CULTIVO = t.ID_CULTIVO "
                + "WHERE UPPER(t.TARERESPONSABLE) = UPPER(?) "
                + "ORDER BY t.ID_TAREA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, responsable);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarea t = new Tarea();
                t.setIdTarea(rs.getInt("ID_TAREA"));
                t.setIdCultivo(rs.getInt("ID_CULTIVO"));
                t.setNombreCultivo(rs.getString("CULNOMBRE"));
                t.setTipo(rs.getString("TARETIPO"));

                Date fp = rs.getDate("TAREFECHAPROGRAMADA");
                t.setFechaProgramada(fp != null ? fp.toString() : null);

                t.setResponsable(rs.getString("TARERESPONSABLE"));
                t.setEstado(rs.getString("TAREESTADO"));

                Date fe = rs.getDate("TAREFECHAEJECUCION");
                t.setFechaEjecucion(fe != null ? fe.toString() : null);

                t.setObservaciones(rs.getString("TAREOBSERVACIONES"));

                lista.add(t);
            }

            rs.close();
            ps.close();
            conecta.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Tarea> buscarPorResponsable(String responsable, String texto) {

        List<Tarea> lista = new ArrayList<>();

        String sql = "SELECT t.ID_TAREA, t.ID_CULTIVO, c.CULNOMBRE, t.TARETIPO, t.TAREFECHAPROGRAMADA, t.TARERESPONSABLE, "
                + "t.TAREESTADO, t.TAREFECHAEJECUCION, t.TAREOBSERVACIONES "
                + "FROM tareas t "
                + "JOIN cultivos c ON c.ID_CULTIVO = t.ID_CULTIVO "
                + "WHERE UPPER(t.TARERESPONSABLE) = UPPER(?) "
                + "AND (t.TARETIPO LIKE ? OR t.TAREESTADO LIKE ? OR c.CULNOMBRE LIKE ?) "
                + "ORDER BY t.ID_TAREA DESC";

        try {
            conecta.connection();
            PreparedStatement ps = conecta.getjdbcConnection().prepareStatement(sql);
            ps.setString(1, responsable);
            ps.setString(2, "%" + texto + "%");
            ps.setString(3, "%" + texto + "%");
            ps.setString(4, "%" + texto + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarea t = new Tarea();
                t.setIdTarea(rs.getInt("ID_TAREA"));
                t.setIdCultivo(rs.getInt("ID_CULTIVO"));
                t.setNombreCultivo(rs.getString("CULNOMBRE"));
                t.setTipo(rs.getString("TARETIPO"));

                Date fp = rs.getDate("TAREFECHAPROGRAMADA");
                t.setFechaProgramada(fp != null ? fp.toString() : null);

                t.setResponsable(rs.getString("TARERESPONSABLE"));
                t.setEstado(rs.getString("TAREESTADO"));

                Date fe = rs.getDate("TAREFECHAEJECUCION");
                t.setFechaEjecucion(fe != null ? fe.toString() : null);

                t.setObservaciones(rs.getString("TAREOBSERVACIONES"));

                lista.add(t);
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

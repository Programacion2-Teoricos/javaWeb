package modelo.dao;

import modelo.conexion.Conexion;
import modelo.vo.AlumnoVO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlumnoDAO {

    public List<AlumnoVO> listarAlumnos() {
        List<AlumnoVO> lista = new ArrayList<>();
        String sql = "SELECT p.codigo, p.nombre, a.telefono " +
                     "FROM personas p INNER JOIN alumnos a ON p.codigo = a.codigo";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new AlumnoVO(rs.getInt("codigo"), rs.getString("nombre"), rs.getString("telefono")));
            }
        } catch (SQLException e) { System.err.println("Error al listar alumnos: " + e.getMessage()); }
        return lista;
    }

    public AlumnoVO obtenerAlumnoPorCodigo(int codigo) {
        String sql = "SELECT p.codigo, p.nombre, a.telefono " +
                     "FROM personas p INNER JOIN alumnos a ON p.codigo = a.codigo WHERE p.codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new AlumnoVO(rs.getInt("codigo"), rs.getString("nombre"), rs.getString("telefono"));
                }
            }
        } catch (SQLException e) { System.err.println("Error al obtener alumno: " + e.getMessage()); }
        return null;
    }

    public boolean agregarAlumno(AlumnoVO alumno) {
        String sql1 = "INSERT INTO personas(nombre) VALUES (?)";
        String sql2 = "INSERT INTO alumnos(codigo, telefono) VALUES (?, ?)";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS)) {
            con.setAutoCommit(false);
            ps1.setString(1, alumno.getNombre());
            ps1.executeUpdate();
            int codigoGenerado = 0;
            try (ResultSet rs = ps1.getGeneratedKeys()) {
                if (rs.next()) codigoGenerado = rs.getInt(1);
                else throw new SQLException("No se obtuvo código autogenerado.");
            }
            try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
                ps2.setInt(1, codigoGenerado);
                ps2.setString(2, alumno.getTelefono());
                ps2.executeUpdate();
            }
            con.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Error al agregar alumno: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizarAlumno(AlumnoVO alumno) {
        String sql1 = "UPDATE personas SET nombre = ? WHERE codigo = ?";
        String sql2 = "UPDATE alumnos SET telefono = ? WHERE codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps1 = con.prepareStatement(sql1);
             PreparedStatement ps2 = con.prepareStatement(sql2)) {
            con.setAutoCommit(false);
            ps1.setString(1, alumno.getNombre());
            ps1.setInt(2, alumno.getCodigo());
            ps2.setString(1, alumno.getTelefono());
            ps2.setInt(2, alumno.getCodigo());
            int f1 = ps1.executeUpdate();
            int f2 = ps2.executeUpdate();
            if (f1 > 0 && f2 > 0) { con.commit(); return true; }
            else { con.rollback(); return false; }
        } catch (SQLException e) {
            System.err.println("Error al actualizar alumno: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarAlumno(int codigo) {
        String sql = "DELETE FROM personas WHERE codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar alumno: " + e.getMessage());
            return false;
        }
    }
}

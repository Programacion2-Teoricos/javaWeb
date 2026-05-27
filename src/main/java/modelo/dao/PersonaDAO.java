package modelo.dao;

import modelo.conexion.Conexion;
import modelo.vo.PersonaVO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonaDAO {

    public List<PersonaVO> listarPersonas() {
        List<PersonaVO> lista = new ArrayList<>();
        String sql = "SELECT * FROM personas";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new PersonaVO(rs.getInt("codigo"), rs.getString("nombre")));
            }
        } catch (SQLException e) {
            System.err.println("Error al listar personas: " + e.getMessage());
        }
        return lista;
    }

    public boolean agregarPersona(PersonaVO persona) {
        String sql = "INSERT INTO personas(codigo, nombre) VALUES (?, ?)";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, persona.getCodigo());
            ps.setString(2, persona.getNombre());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al agregar persona: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizarPersona(PersonaVO persona) {
        String sql = "UPDATE personas SET nombre = ? WHERE codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, persona.getNombre());
            ps.setInt(2, persona.getCodigo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar persona: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminarPersona(int codigo) {
        String sql = "DELETE FROM personas WHERE codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar persona: " + e.getMessage());
            return false;
        }
    }

    public PersonaVO obtenerPersonaPorCodigo(int codigo) {
        String sql = "SELECT * FROM personas WHERE codigo = ?";
        try (Connection con = Conexion.obtener();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PersonaVO(rs.getInt("codigo"), rs.getString("nombre"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener persona: " + e.getMessage());
        }
        return null;
    }
}

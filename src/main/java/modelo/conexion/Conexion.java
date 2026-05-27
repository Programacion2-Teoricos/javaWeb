package modelo.conexion;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Conexion {

    private static final String ARCHIVO = "db.properties";
    private static final Properties config = cargarPropiedades();

    private static Properties cargarPropiedades() {
        Properties props = new Properties();
        try (InputStream input = Conexion.class.getClassLoader().getResourceAsStream(ARCHIVO)) {
            if (input == null) { System.err.println("ERROR: No se encontró " + ARCHIVO); return props; }
            props.load(input);
        } catch (Exception e) { e.printStackTrace(); }
        return props;
    }

    public static Connection obtener() throws SQLException {
        return DriverManager.getConnection(
                config.getProperty("db.url"),
                config.getProperty("db.username"),
                config.getProperty("db.password"));
    }
}

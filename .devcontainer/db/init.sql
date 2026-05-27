-- Esquema para mini-crud-alumno-sql

CREATE TABLE IF NOT EXISTS personas (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS alumnos (
    codigo    INT PRIMARY KEY,
    telefono  VARCHAR(20),
    FOREIGN KEY (codigo) REFERENCES personas(codigo) ON DELETE CASCADE
);

-- Datos de ejemplo
INSERT IGNORE INTO personas (nombre) VALUES ('Ana García'), ('Luis Martínez'), ('Sofía López');
INSERT IGNORE INTO alumnos (codigo, telefono) VALUES (1, '099111222'), (2, '098333444'), (3, '097555666');

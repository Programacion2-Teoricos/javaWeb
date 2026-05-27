-- Esquema para mini-crud-sql

CREATE TABLE IF NOT EXISTS personas (
    codigo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Datos de ejemplo
INSERT IGNORE INTO personas (codigo, nombre) VALUES
  (1, 'Ana García'),
  (2, 'Luis Martínez'),
  (3, 'Sofía López');

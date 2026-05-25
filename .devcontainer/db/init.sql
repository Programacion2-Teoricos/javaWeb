-- ── Esquema inicial: base de datos escuela ────────────────

CREATE TABLE IF NOT EXISTS personas (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    nombre     VARCHAR(100) NOT NULL,
    apellido   VARCHAR(100) NOT NULL,
    email      VARCHAR(150) NOT NULL UNIQUE,
    edad       INT          NOT NULL,
    creado_en  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Datos de ejemplo
INSERT IGNORE INTO personas (nombre, apellido, email, edad) VALUES
  ('Ana',   'García',    'ana.garcia@mail.com',    22),
  ('Luis',  'Martínez',  'luis.martinez@mail.com', 25),
  ('Sofía', 'López',     'sofia.lopez@mail.com',   20),
  ('Pedro', 'Ramírez',   'pedro.ramirez@mail.com', 23);

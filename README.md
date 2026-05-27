# mini-crud-alumno-sql — Tema 4: CRUD con Herencia (MySQL)

CRUD de alumnos con **herencia Java y BD** (`AlumnoVO extends PersonaVO`, tablas `personas` + `alumnos` con FK ON DELETE CASCADE).

## Estructura

```
src/main/
├── java/
│   ├── controlador/AlumnoControladorServlet.java
│   ├── modelo/
│   │   ├── conexion/Conexion.java
│   │   ├── dao/AlumnoDAO.java
│   │   └── vo/
│   │       ├── PersonaVO.java
│   │       └── AlumnoVO.java
└── webapp/
    ├── index.jsp
    ├── css/styles.css
    ├── vista/alumno-form.jsp
    ├── vista/alumno-lista.jsp
    ├── vista/alumno-editar.jsp
    └── WEB-INF/web.xml
src/main/resources/
    └── db.properties
```

## Base de datos

Tablas creadas automáticamente al arrancar el Codespace:

```sql
personas(codigo AUTO_INCREMENT, nombre)
alumnos(codigo FK → personas, telefono) -- ON DELETE CASCADE
```

## Ejecutar en Codespace

```bash
tomcat-start
deploy
```

Abrí el puerto **8080** y navegá a `/mini-crud-alumno-sql`.

> Al reabrir el Codespace solo necesitás `tomcat-start` (MariaDB arranca solo).

---
*Programación Avanzada · Prof. Elizabeth Izquierdo*

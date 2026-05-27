# mini-crud-sql — Tema 3: CRUD con Base de Datos MySQL

CRUD completo con **MySQL 8**. Clase `Conexion` (Static Factory Method), `db.properties` y `PersonaDAO` con JDBC y `try-with-resources`.

## Estructura

```
src/main/
├── java/
│   ├── controlador/PersonaControladorServlet.java
│   ├── modelo/
│   │   ├── conexion/Conexion.java
│   │   ├── dao/PersonaDAO.java
│   │   └── vo/PersonaVO.java
└── webapp/
    ├── index.jsp
    ├── css/styles.css
    ├── vista/persona-form.jsp
    ├── vista/persona-lista.jsp
    ├── vista/persona-editar.jsp
    └── WEB-INF/web.xml
src/main/resources/
    └── db.properties
```

## Base de datos

La tabla `personas` se crea automáticamente al arrancar el Codespace.

```sql
CREATE TABLE personas (codigo INT PRIMARY KEY, nombre VARCHAR(100) NOT NULL);
```

Credenciales (en `db.properties`): usuario `java_dev`, contraseña `java2026`, base `escuela`.

## Ejecutar en Codespace

```bash
deploy
tomcat-start
```

Abrí el puerto **8080** en el navegador.

---
*Programación Avanzada · Prof. Elizabeth Izquierdo*

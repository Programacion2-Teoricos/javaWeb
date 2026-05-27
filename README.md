# mini-crud1 — Fase 2: Mini-CRUD completo (sin base de datos)

CRUD completo con **editar** y **eliminar**. Patrón MVC con Servlets y JSP. Sin base de datos (ArrayList).

## Estructura

```
src/main/
├── java/
│   ├── controlador/PersonaControladorServlet.java
│   ├── modelo/dao/PersonaDAO.java
│   └── modelo/vo/PersonaVO.java
└── webapp/
    ├── index.jsp
    ├── css/styles.css
    ├── vista/persona-form.jsp
    ├── vista/persona-lista.jsp
    ├── vista/persona-editar.jsp
    └── WEB-INF/web.xml
```

## Ejecutar en Codespace

```bash
deploy
tomcat-start
```

Abrí el puerto **8080** en el navegador.

---
*Programación Avanzada · Prof. Elizabeth Izquierdo*

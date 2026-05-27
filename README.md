# mini-crud0 — Fase 1: Mini-CRUD con MVC (sin base de datos)

Proyecto Java Web con el **patrón MVC** usando Servlets y JSP.
Almacenamiento en memoria (ArrayList). Sin base de datos.

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
    └── WEB-INF/web.xml
```

## Ejecutar en Codespace

```bash
# 1. Compilar y desplegar en Tomcat
deploy

# 2. Iniciar Tomcat
tomcat-start
```

GitHub Codespaces detectará el puerto **8080** — abrilo en el navegador.

---
*Programación Avanzada · Prof. Elizabeth Izquierdo*

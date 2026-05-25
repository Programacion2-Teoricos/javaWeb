# Java Web — Entorno de Desarrollo ☕

Configuración de **GitHub Codespaces** lista para usar con Java Web.  
Incluye: **Java 17 · Maven · Tomcat 9 · MySQL 8**

---

## ▶️ Cómo abrir el Codespace

1. Ingresa al repositorio en GitHub.
2. Haz clic en el botón verde **`< > Code`**.
3. Selecciona la pestaña **Codespaces**.
4. Haz clic en **"Create codespace on main"**.
5. Espera unos minutos mientras se instala todo automáticamente.

> ⏳ La primera vez tarda ~3 min. Las siguientes son mucho más rápidas.

---

## 🚀 Ejecutar tu proyecto

Una vez dentro del Codespace, abre la **Terminal** y ejecuta:

```bash
# 1. Compilar y empaquetar el proyecto Maven
deploy

# 2. Iniciar Tomcat
tomcat-start
```

GitHub Codespaces detectará el puerto **8080** y te ofrecerá abrirlo en el navegador.

---

## 🛑 Detener Tomcat

```bash
tomcat-stop
```

---

## 🔄 Comandos disponibles

| Comando | Qué hace |
|---|---|
| `deploy` | Compila con Maven y copia el `.war` a Tomcat |
| `tomcat-start` | Inicia Tomcat 9 |
| `tomcat-stop` | Detiene Tomcat 9 |
| `tomcat-log` | Muestra el log en tiempo real (`catalina.out`) |
| `mysql-escuela` | Abre la consola de MySQL con la base `escuela` |

---

## 🗄️ Base de datos

- **Motor:** MySQL 8
- **Base de datos:** `escuela`
- **Usuario:** `java_dev` / Contraseña: `java2026`
- **Puerto:** 3306

La tabla `personas` se crea automáticamente al levantar el Codespace.  
Para explorar los datos, ejecuta:

```bash
mysql-escuela
```

---

## 🛠️ Tecnologías incluidas

| Tecnología | Versión |
|---|---|
| Java | 17 |
| Maven | 3.9 |
| Tomcat | 9.0 |
| MySQL | 8.0 |

---

*Programación Avanzada · Prof. Elizabeth Izquierdo*

#!/bin/bash
set -e

echo ""
echo "🚀 Configurando entorno Java Web — Programación Avanzada..."
echo ""

# ── Maven (via apt-get, más confiable que el feature) ────
echo "📦 Instalando Maven..."
sudo apt-get update -qq 2>/dev/null || true   # ignorar repos con clave inválida (ej. yarn)
sudo apt-get install -y -qq maven
echo "✅ Maven $(mvn -q --version 2>&1 | head -1) instalado"

# ── MariaDB (compatible con MySQL, disponible en Debian Bullseye) ─────
echo "📦 Instalando MariaDB..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mariadb-server mariadb-client
sudo service mariadb start
echo "✅ MariaDB instalada y en ejecución"

# ── Apache Tomcat 9 ───────────────────────────────────
TOMCAT_VER="9.0.87"
TOMCAT_DIR="$HOME/tomcat"

if [ ! -d "$TOMCAT_DIR" ]; then
  echo "📦 Descargando Apache Tomcat $TOMCAT_VER..."
  wget -q "https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz" \
       -O /tmp/tomcat.tar.gz
  tar -xzf /tmp/tomcat.tar.gz -C "$HOME"
  mv "$HOME/apache-tomcat-${TOMCAT_VER}" "$TOMCAT_DIR"
  chmod +x "$TOMCAT_DIR/bin/"*.sh
  rm /tmp/tomcat.tar.gz
  echo "✅ Tomcat instalado en $TOMCAT_DIR"
else
  echo "✅ Tomcat ya instalado"
fi

# ── Aliases útiles ────────────────────────────────────
if ! grep -q "tomcat-start" ~/.bashrc; then
  cat >> ~/.bashrc << 'ALIASES'

# ── Java Web shortcuts ──────────────────────────────
alias tomcat-start='$HOME/tomcat/bin/startup.sh && echo "✅ Tomcat iniciado en puerto 8080"'
alias tomcat-stop='$HOME/tomcat/bin/shutdown.sh && echo "🛑 Tomcat detenido"'
alias tomcat-log='tail -f $HOME/tomcat/logs/catalina.out'
alias deploy='mvn clean package -q && find ~/.m2 -name "mysql-connector-j-*.jar" -exec cp {} $HOME/tomcat/lib/ \; 2>/dev/null; cp target/*.war $HOME/tomcat/webapps/ && echo "✅ Desplegado. Abrí el puerto 8080 en Codespaces."'
alias mysql-escuela='mysql -u java_dev -pjava2026 escuela'
ALIASES
fi

# ── Pre-descargar dependencias y copiar conector JDBC a Tomcat ───
echo "📦 Descargando dependencias Maven..."
mvn dependency:resolve -q 2>/dev/null || true
find ~/.m2 -name "mysql-connector-j-*.jar" -exec cp {} "$TOMCAT_DIR/lib/" \; 2>/dev/null || true

# ── MariaDB: esperar que inicie ───────────────────────
echo "⏳ Esperando que MariaDB esté lista..."
for i in {1..20}; do
  if sudo mysqladmin ping --silent 2>/dev/null; then
    break
  fi
  sleep 2
done

# ── Crear base de datos y usuario ─────────────────────
echo "🗄️  Configurando base de datos..."
# MariaDB en Debian usa auth_socket para root → sudo mysql sin contraseña
sudo mysql << 'SQL'
CREATE DATABASE IF NOT EXISTS escuela
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;
CREATE USER IF NOT EXISTS 'java_dev'@'localhost'
  IDENTIFIED BY 'java2026';
GRANT ALL PRIVILEGES ON escuela.* TO 'java_dev'@'localhost';
FLUSH PRIVILEGES;
SQL

# Cargar esquema inicial
mysql -u java_dev -pjava2026 escuela < .devcontainer/db/init.sql
echo "✅ Base de datos 'escuela' lista"

# ── Resumen final ─────────────────────────────────────
echo ""
echo "╔═══════════════════════════════════════════════════════╗"
echo "║   ✅  Entorno listo — Java Web / Programación Avanzada   ║"
echo "╠═══════════════════════════════════════════════════════╣"
echo "║  Java 17 + Maven + Tomcat 9 + MariaDB                ║"
echo "║                                                       ║"
echo "║  Base de datos:                                       ║"
echo "║    Host:     localhost:3306                           ║"
echo "║    DB:       escuela                                  ║"
echo "║    Usuario:  java_dev                                 ║"
echo "║    Password: java2026                                 ║"
echo "╠═══════════════════════════════════════════════════════╣"
echo "║  Comandos disponibles:                                ║"
echo "║    tomcat-start    →  iniciar Tomcat (puerto 8080)   ║"
echo "║    tomcat-stop     →  detener Tomcat                 ║"
echo "║    tomcat-log      →  ver logs en tiempo real        ║"
echo "║    deploy          →  compilar y desplegar en Tomcat ║"
echo "║    mysql-escuela   →  abrir consola MySQL            ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "👉 Para empezar: ejecuta 'tomcat-start' y luego 'deploy'"
echo ""

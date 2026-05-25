#!/bin/bash
set -e

echo ""
echo "🚀 Configurando entorno Java Web — Programación Avanzada..."
echo ""

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
alias deploy='mvn clean package -q && cp target/*.war $HOME/tomcat/webapps/ && echo "✅ Desplegado. Abrí el puerto 8080 en Codespaces."'
alias mysql-escuela='mysql -u java_dev -pjava2026 escuela'
ALIASES
fi

# ── MySQL: esperar que inicie ─────────────────────────
echo "⏳ Esperando que MySQL esté listo..."
for i in {1..20}; do
  if mysqladmin ping -u root -pjava2026 --silent 2>/dev/null; then
    break
  fi
  sleep 2
done

# ── Crear base de datos y usuario ─────────────────────
echo "🗄️  Configurando base de datos..."
mysql -u root -pjava2026 2>/dev/null << 'SQL'
CREATE DATABASE IF NOT EXISTS escuela
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_spanish_ci;

CREATE USER IF NOT EXISTS 'java_dev'@'localhost'
  IDENTIFIED BY 'java2026';

GRANT ALL PRIVILEGES ON escuela.* TO 'java_dev'@'localhost';
FLUSH PRIVILEGES;
SQL

# Cargar esquema inicial
mysql -u root -pjava2026 escuela < .devcontainer/db/init.sql 2>/dev/null
echo "✅ Base de datos 'escuela' lista"

# ── Resumen final ─────────────────────────────────────
echo ""
echo "╔═══════════════════════════════════════════════════════╗"
echo "║   ✅  Entorno listo — Java Web / Programación Avanzada   ║"
echo "╠═══════════════════════════════════════════════════════╣"
echo "║  Java 17 + Maven + Tomcat 9 + MySQL 8                ║"
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
echo "👉 Para empezar: ejecutá 'tomcat-start' y luego 'deploy'"
echo ""

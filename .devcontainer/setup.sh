#!/bin/bash
set -e

echo ""
echo "🚀 Configurando entorno Java Web — Programación Avanzada..."
echo ""

# ── Maven (via apt-get) ────────────────────────────────
echo "📦 Instalando Maven..."
sudo apt-get update -qq 2>/dev/null || true
sudo apt-get install -y -qq maven
echo "✅ Maven instalado"

# ── MariaDB (compatible con MySQL, disponible en Debian Bullseye) ─────
echo "📦 Instalando MariaDB..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq mariadb-server mariadb-client
sudo service mariadb start
echo "✅ MariaDB instalada y en ejecución"

# ── Aliases útiles ────────────────────────────────────
if ! grep -q "alias run=" ~/.bashrc; then
  cat >> ~/.bashrc << 'ALIASES'

# ── Java Web shortcuts ──────────────────────────────
alias run='mvn clean tomcat7:run'
alias mysql-escuela='mysql -u java_dev -pjava2026 escuela'
ALIASES
fi

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

# ── Pre-descargar dependencias Maven ──────────────────
echo "📦 Descargando dependencias Maven..."
mvn dependency:resolve -q 2>/dev/null || true

# ── Resumen final ─────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  ✅  Entorno listo — Java Web / Programación Avanzada  ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  Java 8 + Maven + Tomcat 7 (embebido) + MariaDB     ║"
echo "║                                                      ║"
echo "║  Base de datos:                                      ║"
echo "║    DB:       escuela                                 ║"
echo "║    Usuario:  java_dev  /  Password: java2026         ║"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  Comandos:                                           ║"
echo "║    run            →  compilar y correr en Tomcat 7  ║"
echo "║    mysql-escuela  →  abrir consola MariaDB           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "👉 Para empezar: ejecutá 'run' en la terminal"
echo ""

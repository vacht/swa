#!/usr/bin/env bash
# Crea etiquetas, hitos e incidencias en el repositorio de GitHub.
# Requisitos: GitHub CLI (https://cli.github.com) y haber hecho `gh auth login`.
# Uso (desde la raíz del repo, una sola vez, solo UNA persona): bash scripts/setup_github.sh
set -e

echo "== Etiquetas =="
mklabel() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null; echo "  $1"; }
mklabel feature   0e8a16 "Funcionalidad nueva"
mklabel bug       d73a4a "Error a corregir"
mklabel docs      0075ca "Documentación"
mklabel chore     c5def5 "Configuración y mantenimiento"
mklabel backend   5319e7 "Parte del servidor"
mklabel frontend  fbca04 "Parte visual"
mklabel database  b60205 "Base de datos"
mklabel ia        1d76db "Asistente de IA"

echo "== Hitos =="
mkms() { gh api repos/:owner/:repo/milestones -f title="$1" -f description="$2" >/dev/null; echo "  $1"; }
mkms "1 · Base y autenticación"        "Modelos, login, roles y mesas"
mkms "2 · Carta, comandas y solicitudes" "Núcleo de sala"
mkms "3 · Interfaces web"              "Cliente, camarero y encargado"
mkms "4 · Inventario"                  "Ingredientes, recetas y stock"
mkms "5 · Tiempo real, estadísticas e IA" "WebSockets, estadísticas y asistente"
mkms "6 · Pruebas y entrega"           "Tests, seguridad y memoria final"

echo "== Incidencias =="
# mk "Título" "hito" "etiquetas" "rama" "requisitos"
mk() {
  gh issue create --title "$1" --milestone "$2" --label "$3" \
    --body "**Rama sugerida:** \`$4\`
**Requisitos:** $5

## Criterios de aceptación
- [ ] Funciona según lo descrito en la memoria
- [ ] Probado en local
- [ ] PR revisado por el compañero" >/dev/null
  echo "  $1"
}

H1="1 · Base y autenticación"
H2="2 · Carta, comandas y solicitudes"
H3="3 · Interfaces web"
H4="4 · Inventario"
H5="5 · Tiempo real, estadísticas e IA"
H6="6 · Pruebas y entrega"

mk "Modelos SQLAlchemy de usuarios, roles y mesas" "$H1" "feature,backend,database" feature/modelos-base "RNF06"
mk "Registro y login con JWT y contraseñas cifradas" "$H1" "feature,backend" feature/autenticacion "RF07, RF08, RNF03"
mk "Dependencia de permisos por rol" "$H1" "feature,backend" feature/permisos-rol "RNF04"
mk "CRUD de mesas con generación de código QR" "$H1" "feature,backend" feature/mesas "RF01, RF09"
mk "Script de datos de prueba" "$H1" "chore,database" chore/datos-semilla "—"

mk "CRUD de categorías y productos" "$H2" "feature,backend" feature/carta-admin "RF18"
mk "Endpoint público de carta por QR" "$H2" "feature,backend" feature/carta-publica "RF01, RF02, RF03"
mk "Crear comanda y regla de una abierta por mesa" "$H2" "feature,backend" feature/comandas "RF10, RF11"
mk "Líneas de comanda, importe total y precio congelado" "$H2" "feature,backend" feature/lineas-comanda "RF14"
mk "Estados de comanda con validación de transiciones" "$H2" "feature,backend" feature/estados-comanda "RF13"
mk "Cerrar mesa de forma explícita" "$H2" "feature,backend" feature/cerrar-mesa "RF12"
mk "Solicitudes de atención y cuenta" "$H2" "feature,backend" feature/solicitudes "RF04, RF05"
mk "Valoraciones del servicio" "$H2" "feature,backend" feature/valoraciones "RF06"
mk "Comanda compartida: consulta pública por mesa" "$H2" "feature,backend" feature/comanda-compartida "RF15"

mk "Interfaz del cliente (carta móvil)" "$H3" "feature,frontend" feature/ui-cliente "RF01-RF06, RNF02"
mk "Pantalla de login y CSS base" "$H3" "feature,frontend" feature/ui-login "RNF01, RNF03"
mk "Panel del camarero" "$H3" "feature,frontend" feature/ui-camarero "RF09-RF13"
mk "Panel del encargado: navegación y dashboard" "$H3" "feature,frontend" feature/ui-encargado "RF17"
mk "Gestión de usuarios desde el encargado" "$H3" "feature,backend,frontend" feature/usuarios-admin "RF17"

mk "CRUD de ingredientes y unidades" "$H4" "feature,backend" feature/ingredientes "RF19"
mk "Recetas asociadas a productos" "$H4" "feature,backend" feature/recetas "RF20, RF28"
mk "Conversión de unidades compatibles" "$H4" "feature,backend" feature/conversion-unidades "RF21"
mk "Descuento de stock al servir" "$H4" "feature,backend" feature/consumo-stock "RF22, RF23"
mk "Ajustes manuales y movimientos de stock" "$H4" "feature,backend" feature/ajustes-stock "RF24, RF32"
mk "Alertas de stock mínimo y disponibilidad automática" "$H4" "feature,backend" feature/alertas-stock "RF25, RF26, RF27"
mk "Devoluciones sin reponer stock automáticamente" "$H4" "feature,backend" feature/devoluciones "RF29"

mk "WebSockets para la comanda compartida" "$H5" "feature,backend" feature/websockets "RF16, RNF10"
mk "Endpoints de estadísticas" "$H5" "feature,backend" feature/estadisticas "RF30"
mk "Elegir y probar modelo local de IA" "$H5" "feature,ia" feature/ia-prototipo "RF31"
mk "Asistente de IA de solo lectura" "$H5" "feature,ia,backend" feature/asistente-ia "RF31"

mk "Tests automáticos del backend" "$H6" "feature,backend" feature/tests-backend "RNF05"
mk "Revisión de seguridad y permisos" "$H6" "chore,backend" chore/revision-seguridad "RNF04"
mk "Valorar Docker" "$H6" "chore" chore/docker "—"
mk "Memoria final y manual de usuario" "$H6" "docs" docs/memoria-final "—"

echo "Listo. Revisa la pestaña Issues y Projects en GitHub."

#!/bin/bash

# ============================================================
# BUSINESS BRAIN — Instalador Universal
# Sistema de Inteligencia para Cualquier Negocio
# Compatible con vaults Obsidian existentes
# ============================================================
# Versión: 1.0
# Autor: Roberto Brisciani — RestaurantMind OS / The Pulse
# ============================================================

set -e
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ─── BANNER ────────────────────────────────────────────────
clear
echo ""
echo -e "${CYAN}${BOLD}"
echo "  ██████╗ ██╗   ██╗███████╗██╗███╗   ██╗███████╗███████╗███████╗"
echo "  ██╔══██╗██║   ██║██╔════╝██║████╗  ██║██╔════╝██╔════╝██╔════╝"
echo "  ██████╔╝██║   ██║███████╗██║██╔██╗ ██║█████╗  ███████╗███████╗"
echo "  ██╔══██╗██║   ██║╚════██║██║██║╚██╗██║██╔══╝  ╚════██║╚════██║"
echo "  ██████╔╝╚██████╔╝███████║██║██║ ╚████║███████╗███████║███████║"
echo "  ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝"
echo ""
echo "  ██████╗ ██████╗  █████╗ ██╗███╗   ██╗"
echo "  ██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║"
echo "  ██████╔╝██████╔╝███████║██║██╔██╗ ██║"
echo "  ██╔══██╗██╔══██╗██╔══██║██║██║╚██╗██║"
echo "  ██████╔╝██║  ██║██║  ██║██║██║ ╚████║"
echo "  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝"
echo -e "${NC}"
echo -e "${BOLD}  Sistema de Inteligencia Universal para Negocios${NC}"
echo -e "  Compatible con vaults Obsidian existentes"
echo ""
echo -e "${YELLOW}  Tu negocio lleva años acumulando experiencia.${NC}"
echo -e "${YELLOW}  Este sistema la convierte en inteligencia que puedes usar.${NC}"
echo ""
echo "  ─────────────────────────────────────────────────────"
echo ""

# ─── PREREQUISITES ─────────────────────────────────────────
echo -e "${BOLD}[1/6] Verificando requisitos...${NC}"
echo ""

if command -v claude &> /dev/null; then
    echo -e "  ${GREEN}✓${NC} Claude CLI instalado"
else
    echo -e "  ${YELLOW}⚠${NC}  Claude CLI no detectado"
    echo -e "  Para instalar: ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
    echo -e "  ${YELLOW}Puedes continuar. Los comandos estarán listos cuando instales Claude CLI.${NC}"
    echo ""
fi

if [ ! -d "$HOME/.claude/commands" ]; then
    mkdir -p "$HOME/.claude/commands"
    echo -e "  ${GREEN}✓${NC} Carpeta de comandos Claude creada"
else
    echo -e "  ${GREEN}✓${NC} Carpeta de comandos Claude encontrada"
fi

echo ""

# ─── CONFIGURACIÓN DEL NEGOCIO ─────────────────────────────
echo -e "${BOLD}[2/6] Configuración del negocio...${NC}"
echo ""

echo -e "  ${CYAN}¿Cómo se llama tu negocio?${NC}"
read -p "  > " BUSINESS_NAME

echo ""
echo -e "  ${CYAN}¿Tu nombre?${NC}"
read -p "  > " OWNER_NAME

echo ""
echo -e "  ${CYAN}¿En qué sector opera el negocio?${NC}"
echo "  1) Restauración / Hostelería"
echo "  2) Hotel / Alojamiento"
echo "  3) Retail / Comercio"
echo "  4) Servicios profesionales / Consultoría"
echo "  5) Salud / Bienestar"
echo "  6) Tecnología / SaaS"
echo "  7) Educación / Formación"
echo "  8) Otro (genérico)"
read -p "  Elige (1-8): " SECTOR_NUM

case $SECTOR_NUM in
    1)
        SECTOR="restauracion"
        SECTOR_LABEL="Restauración/Hostelería"
        UNIT_CLIENTE="cubiertos/comensales"
        UNIT_VENTA="servicio/ticket"
        UNIT_PRODUCTO="carta/menú"
        KPIS_PRINCIPALES="Food cost %, Labor cost %, Ticket medio, Covers/día, Margen neto %"
        KPIS_BENCHMARK="Food cost <30% | Labor <35% | Margen neto >12%"
        FOLDER_PRODUCTO="40_CARTA"
        FOLDER_LABEL="Carta/Menú"
        DAILY_QUESTIONS="Cubiertos del día, Ticket medio, Incidencias de servicio, Novedades del equipo"
        ;;
    2)
        SECTOR="hotel"
        SECTOR_LABEL="Hotel/Alojamiento"
        UNIT_CLIENTE="habitaciones/huéspedes"
        UNIT_VENTA="noche/estancia"
        UNIT_PRODUCTO="servicios/tarifas"
        KPIS_PRINCIPALES="ADR, RevPAR, Occupancy %, GOP %, NPS"
        KPIS_BENCHMARK="Occupancy >70% | ADR según categoría | RevPAR creciente"
        FOLDER_PRODUCTO="40_SERVICIOS"
        FOLDER_LABEL="Servicios/Tarifas"
        DAILY_QUESTIONS="Ocupación del día, ADR real, Check-ins/outs, Incidencias de huéspedes"
        ;;
    3)
        SECTOR="retail"
        SECTOR_LABEL="Retail/Comercio"
        UNIT_CLIENTE="transacciones/clientes"
        UNIT_VENTA="venta/ticket"
        UNIT_PRODUCTO="catálogo/productos"
        KPIS_PRINCIPALES="Ticket medio, Conversión %, Margen bruto %, Rotación de stock"
        KPIS_BENCHMARK="Conversión >3% | Margen bruto >40% | Stock rotation >4x/año"
        FOLDER_PRODUCTO="40_CATALOGO"
        FOLDER_LABEL="Catálogo/Productos"
        DAILY_QUESTIONS="Ventas del día, Productos top, Incidencias de stock, Feedback de clientes"
        ;;
    4)
        SECTOR="servicios"
        SECTOR_LABEL="Servicios/Consultoría"
        UNIT_CLIENTE="clientes activos"
        UNIT_VENTA="proyecto/contrato"
        UNIT_PRODUCTO="servicios/propuestas"
        KPIS_PRINCIPALES="MRR/ARR, LTV, CAC, Churn rate %, Margen por cliente"
        KPIS_BENCHMARK="Churn <5%/mes | CAC payback <12 meses | LTV/CAC >3"
        FOLDER_PRODUCTO="40_SERVICIOS"
        FOLDER_LABEL="Servicios/Propuestas"
        DAILY_QUESTIONS="Proyectos activos, Nuevas propuestas enviadas, Clientes en riesgo, Hitos completados"
        ;;
    5)
        SECTOR="salud"
        SECTOR_LABEL="Salud/Bienestar"
        UNIT_CLIENTE="pacientes/clientes"
        UNIT_VENTA="consulta/sesión"
        UNIT_PRODUCTO="tratamientos/servicios"
        KPIS_PRINCIPALES="Pacientes activos, Tasa de retorno, Ingresos/día, Ocupación de agenda"
        KPIS_BENCHMARK="Tasa retorno >60% | Ocupación agenda >80% | NPS >50"
        FOLDER_PRODUCTO="40_TRATAMIENTOS"
        FOLDER_LABEL="Tratamientos/Servicios"
        DAILY_QUESTIONS="Pacientes atendidos, Ingresos del día, Nuevas altas, Cancelaciones"
        ;;
    6)
        SECTOR="tech"
        SECTOR_LABEL="Tecnología/SaaS"
        UNIT_CLIENTE="usuarios/cuentas"
        UNIT_VENTA="suscripción/licencia"
        UNIT_PRODUCTO="producto/features"
        KPIS_PRINCIPALES="MRR, Churn rate, NPS, DAU/MAU, CAC, LTV"
        KPIS_BENCHMARK="Churn <2%/mes | NPS >40 | LTV/CAC >3 | DAU/MAU >40%"
        FOLDER_PRODUCTO="40_PRODUCTO"
        FOLDER_LABEL="Producto/Roadmap"
        DAILY_QUESTIONS="Nuevos usuarios, Churn del día, Bugs críticos, Features completadas"
        ;;
    7)
        SECTOR="educacion"
        SECTOR_LABEL="Educación/Formación"
        UNIT_CLIENTE="alumnos/estudiantes"
        UNIT_VENTA="matrícula/programa"
        UNIT_PRODUCTO="cursos/programas"
        KPIS_PRINCIPALES="Alumnos activos, Tasa de finalización, NPS, Revenue/alumno, Churn"
        KPIS_BENCHMARK="Finalización >70% | NPS >50 | Retención >80%"
        FOLDER_PRODUCTO="40_PROGRAMAS"
        FOLDER_LABEL="Programas/Cursos"
        DAILY_QUESTIONS="Nuevas matrículas, Alumnos activos esta semana, Feedback recibido, Clases impartidas"
        ;;
    *)
        SECTOR="generico"
        SECTOR_LABEL="Negocio General"
        UNIT_CLIENTE="clientes"
        UNIT_VENTA="venta/operación"
        UNIT_PRODUCTO="oferta/productos"
        KPIS_PRINCIPALES="Facturación, Margen %, Clientes activos, Costes operativos"
        KPIS_BENCHMARK="Margen >20% | Crecimiento >10%/año | Costes controlados"
        FOLDER_PRODUCTO="40_OFERTA"
        FOLDER_LABEL="Oferta/Productos"
        DAILY_QUESTIONS="Operaciones del día, Ventas, Incidencias, Equipo"
        ;;
esac

echo ""
echo -e "  ${CYAN}Perfil del negocio:${NC}"
echo "  1) Quiero delegar mas - tengo equipo pero sigo siendo imprescindible"
echo "  2) Quiero escalar - quiero crecer en facturacion o expandirme"
echo "  3) Ambas - delegar primero, escalar despues"
read -p "  Elige (1/2/3): " PROFILE_NUM
case $PROFILE_NUM in
    1) PROFILE="delegation"; PROFILE_LABEL="Delegación" ;;
    2) PROFILE="scale"; PROFILE_LABEL="Escalada" ;;
    *) PROFILE="both"; PROFILE_LABEL="Delegación → Escalada" ;;
esac

echo ""
echo -e "  ${GREEN}✓${NC} Configuración del negocio completada"
echo ""

# ─── MODO VAULT ─────────────────────────────────────────────
echo -e "${BOLD}[3/6] Configuración del vault...${NC}"
echo ""
echo -e "  ${CYAN}¿Ya tienes un vault en Obsidian configurado?${NC}"
echo ""
echo "  1) Sí — añadir Business Brain a mi vault existente (sin tocar nada)"
echo "  2) No — crear un vault nuevo"
echo ""
read -p "  Elige (1/2): " VAULT_MODE_NUM

TODAY=$(date +%Y-%m-%d)

if [ "$VAULT_MODE_NUM" = "1" ]; then
    INJECT_MODE="true"
    echo ""
    echo -e "  ${CYAN}Ruta completa de tu vault existente:${NC}"
    echo -e "  ${YELLOW}Ejemplo: /Users/tuusuario/Documents/Mi-Vault${NC}"
    read -p "  > " INPUT_VAULT_PATH
    VAULT_PATH="${INPUT_VAULT_PATH%/}"

    if [ ! -d "$VAULT_PATH" ]; then
        echo -e "  ${RED}✗ No se encontró el vault en esa ruta.${NC}"
        exit 1
    fi

    BRAIN_DIR="$VAULT_PATH/_BUSINESS_BRAIN"
    echo ""
    echo -e "  ${GREEN}✓${NC} Vault encontrado: ${CYAN}$VAULT_PATH${NC}"
    echo -e "  ${GREEN}✓${NC} Business Brain se instalará en: ${CYAN}$BRAIN_DIR${NC}"
    echo -e "  ${YELLOW}  Ningún archivo existente será modificado.${NC}"
else
    INJECT_MODE="false"
    echo ""
    echo -e "  ${CYAN}¿Dónde crear el vault? (Enter para usar Documentos)${NC}"
    echo -e "  Default: ${YELLOW}$HOME/Documents/${BUSINESS_NAME}-Brain${NC}"
    read -p "  > " VAULT_BASE
    if [ -z "$VAULT_BASE" ]; then
        VAULT_PATH="$HOME/Documents/${BUSINESS_NAME}-Brain"
    else
        VAULT_PATH="${VAULT_BASE%/}/${BUSINESS_NAME}-Brain"
    fi
    BRAIN_DIR="$VAULT_PATH"
fi

echo ""
echo -e "  ${BOLD}Resumen de configuración:${NC}"
echo -e "  • Negocio:  ${CYAN}$BUSINESS_NAME${NC}"
echo -e "  • Dueño:    ${CYAN}$OWNER_NAME${NC}"
echo -e "  • Sector:   ${CYAN}$SECTOR_LABEL${NC}"
echo -e "  • Perfil:   ${CYAN}$PROFILE_LABEL${NC}"
echo -e "  • Modo:     ${CYAN}${MODO_DISPLAY}${NC}"
echo -e "  • Vault:    ${CYAN}$VAULT_PATH${NC}"
echo ""
read -p "  ¿Todo correcto? Enter para continuar, Ctrl+C para cancelar..."

# ─── CREAR/INYECTAR ESTRUCTURA ──────────────────────────────
echo ""
echo -e "${BOLD}[4/6] Creando estructura...${NC}"
echo ""

FOLDERS=(
    "_BUSINESS_BRAIN"
    "_BUSINESS_BRAIN/00_CEREBRO"
    "_BUSINESS_BRAIN/10_OPERACIONES/DAILY_NOTES"
    "_BUSINESS_BRAIN/10_OPERACIONES/INCIDENCIAS"
    "_BUSINESS_BRAIN/10_OPERACIONES/PROTOCOLOS"
    "_BUSINESS_BRAIN/20_NUMEROS/INGRESOS"
    "_BUSINESS_BRAIN/20_NUMEROS/COSTES"
    "_BUSINESS_BRAIN/20_NUMEROS/KPIs"
    "_BUSINESS_BRAIN/30_EQUIPO/PERFILES"
    "_BUSINESS_BRAIN/30_EQUIPO/FORMACION"
    "_BUSINESS_BRAIN/30_EQUIPO/CONVERSACIONES"
    "_BUSINESS_BRAIN/${FOLDER_PRODUCTO}/ACTUAL"
    "_BUSINESS_BRAIN/${FOLDER_PRODUCTO}/RENDIMIENTO"
    "_BUSINESS_BRAIN/${FOLDER_PRODUCTO}/IDEAS"
    "_BUSINESS_BRAIN/50_CLIENTES/FEEDBACK"
    "_BUSINESS_BRAIN/50_CLIENTES/SEGMENTOS"
    "_BUSINESS_BRAIN/60_PROVEEDORES"
    "_BUSINESS_BRAIN/90_ESTRATEGIA/PROYECTOS"
    "_BUSINESS_BRAIN/90_ESTRATEGIA/DECISIONES"
    "_BUSINESS_BRAIN/90_ESTRATEGIA/HIPOTESIS"
    "_BUSINESS_BRAIN/90_ESTRATEGIA/VAULT_HEALTH"
)

if [ "$INJECT_MODE" = "true" ]; then
    BASE="$VAULT_PATH"
else
    BASE="$VAULT_PATH"
    mkdir -p "$VAULT_PATH/.obsidian"
fi

for folder in "${FOLDERS[@]}"; do
    mkdir -p "$BASE/$folder"
done

echo -e "  ${GREEN}✓${NC} Estructura de carpetas creada"

# Pre-computar textos dinamicos para evitar expansiones anidadas en heredocs
case $PROFILE in
    delegation) PROFILE_TEXT="Quiero delegar mas. Tengo equipo pero sigo siendo imprescindible. Objetivo: que el negocio funcione sin que yo este en todo." ;;
    scale)      PROFILE_TEXT="Quiero escalar. El negocio funciona y quiero crecer - mas volumen, mas unidades, o ambas. Objetivo: construir un sistema replicable." ;;
    *)          PROFILE_TEXT="Quiero primero delegar y despues escalar. En ese orden." ;;
esac

case $REVENUE_TIER in
    1) REVENUE_TEXT="300K-500K euros/año" ;;
    2) REVENUE_TEXT="500K-1M euros/año" ;;
    3) REVENUE_TEXT="Mas de 1M euros/año" ;;
    *) REVENUE_TEXT="No especificada" ;;
esac

if [ "$INJECT_MODE" = "true" ]; then
    VAULT_STRUCT_TEXT="### Vault principal (LEER COMPLETO con /bb-contexto):
- Raiz: ${VAULT_PATH}
- Contiene estructura propia del usuario

### Business Brain (sistema de inteligencia anadido):
- Ubicacion: ${BRAIN_DIR}"
else
    VAULT_STRUCT_TEXT="### Vault Business Brain:
- Raiz: ${VAULT_PATH}"
fi

if [ "$INJECT_MODE" = "true" ]; then
    MODO_DISPLAY="Inyeccion en vault existente"
else
    MODO_DISPLAY="Vault nuevo"
fi

# ── CLAUDE.md ──
cat > "$BASE/_BUSINESS_BRAIN/00_CEREBRO/CLAUDE.md" << CLAUDEEOF
# ${BUSINESS_NAME} - Business Brain

## Quien Soy
**${OWNER_NAME}**, responsable de **${BUSINESS_NAME}** (${SECTOR_LABEL}).

## Mi Situacion
${PROFILE_TEXT}

## Mi Negocio
- **Nombre:** ${BUSINESS_NAME}
- **Sector:** ${SECTOR_LABEL}
- **KPIs principales:** ${KPIS_PRINCIPALES}

## Estructura del Vault
${VAULT_STRUCT_TEXT}
- \`_BUSINESS_BRAIN/10_OPERACIONES/DAILY_NOTES/\` → Log diario del negocio
- \`_BUSINESS_BRAIN/20_NUMEROS/\` → Ingresos, costes, KPIs
- \`_BUSINESS_BRAIN/30_EQUIPO/\` → Perfiles, formación, conversaciones
- \`_BUSINESS_BRAIN/${FOLDER_PRODUCTO}/\` → ${FOLDER_LABEL}
- \`_BUSINESS_BRAIN/50_CLIENTES/\` → Feedback, segmentos
- \`_BUSINESS_BRAIN/60_PROVEEDORES/\` → Fichas de proveedores
- \`_BUSINESS_BRAIN/90_ESTRATEGIA/\` → Proyectos, decisiones, hipótesis
- \`_BUSINESS_BRAIN/90_ESTRATEGIA/VAULT_HEALTH/\` → Informes de /bb-organiza

## Comandos del Sistema
- \`/bb-contexto\` → Carga el vault completo + estado actual
- \`/bb-organiza\` → Analiza y propone mejoras del vault
- \`/bb-aplica\` → Ejecuta propuestas aprobadas de /bb-organiza
- \`/bb-dia\` → Briefing del día
- \`/bb-cierre\` → Cierre del día (5 min)
- \`/bb-semana\` → Review semanal
- \`/bb-emerge\` → Ideas latentes del negocio
- \`/bb-decision\` → Registrar decisión importante
- \`/bb-punto-ciego\` → Detector de sesgos antes de decidir

## Benchmarks del Sector
${KPIS_BENCHMARK}

## Cómo Ayudarme
- Usa SIEMPRE la información real del vault — no inventes datos
- Si no hay datos, dímelo y dime qué capturar
- Sé directo. Tengo un negocio que gestionar
- Prioriza lo accionable: qué hago mañana a primera hora

---
*Business Brain v1.0 — Instalado: ${TODAY}*
CLAUDEEOF

echo -e "  ${GREEN}✓${NC} CLAUDE.md (contexto AI central) creado"

# ── VISION.md ──
cat > "$BASE/_BUSINESS_BRAIN/00_CEREBRO/VISION.md" << VISIONEOF
# Visión — ${BUSINESS_NAME}

## ¿A dónde va este negocio en 12 meses?
> [Tu visión — qué quieres que sea el negocio en un año]

## ¿Qué significa el éxito para mí?
> [No en términos de facturación — en términos de cómo vivirías tú]

## Los 3 cambios más importantes
1. 
2. 
3. 

## Lo que NO voy a hacer
- 
- 

---
*Última revisión: ${TODAY}*
VISIONEOF

# ── HIPOTESIS.md ──
cat > "$BASE/_BUSINESS_BRAIN/90_ESTRATEGIA/HIPOTESIS/HIPOTESIS.md" << HIPEOF
# Hipótesis Activas — ${BUSINESS_NAME}

> Creencias sobre el negocio que aún no se han verificado.
> Cada una tiene un % de confianza que se actualiza con evidencia.
> Usadas por \`/bb-punto-ciego\` para detectar sesgos.

---

## H01 — [Primera hipótesis]
**Creencia:** "Si hacemos X, Y mejorará"
**Confianza:** 🟡 Medio (50%)
**Evidencia a favor:** Ninguna aún
**Evidencia en contra:** Ninguna aún
**Fecha de revisión:** [+30 días]

---

*Creado: ${TODAY}*
HIPEOF

# ── KPIs ──
cat > "$BASE/_BUSINESS_BRAIN/20_NUMEROS/KPIs/KPIs-PRINCIPALES.md" << KPIEOF
# KPIs Principales — ${BUSINESS_NAME}
> Sector: ${SECTOR_LABEL} | Actualizar mensualmente

## KPIs de ${SECTOR_LABEL}
*(${KPIS_PRINCIPALES})*

| Métrica | Objetivo | Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Oct | Nov | Dic |
|---------|---------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
|         |         |     |     |     |     |     |     |     |     |     |     |     |     |
|         |         |     |     |     |     |     |     |     |     |     |     |     |     |

## Benchmarks del Sector
${KPIS_BENCHMARK}

## Notas de Interpretación
*(contexto que los datos solos no cuentan)*

*Creado: ${TODAY}*
KPIEOF

# ── Primera daily note ──
cat > "$BASE/_BUSINESS_BRAIN/10_OPERACIONES/DAILY_NOTES/${TODAY}.md" << DAILYEOF
# ${TODAY} — Primera nota

> Primera nota del sistema Business Brain.

---

## 🎯 Las 3 cosas más importantes de hoy
1. 
2. 
3. 

## 👥 Equipo
*(incidencias, conversaciones importantes, comportamientos destacables)*

## 💰 Números del día
- ${DAILY_QUESTIONS}

## 🔑 Decisiones tomadas

## ⚡ Para mañana
- [ ] 
- [ ] 

## 💡 Ideas / observaciones

---
*Cerrado: ${TODAY}*
DAILYEOF

# ── DECISION-DNA.md ──
cat > "$BASE/_BUSINESS_BRAIN/90_ESTRATEGIA/DECISIONES/DECISION-DNA.md" << DNAEOF
# Decision DNA — ${BUSINESS_NAME}

> Registro histórico de decisiones. Analizado por \`/bb-punto-ciego\` para detectar patrones.

---

## DECISIONES REGISTRADAS
*(usa \`/bb-decision [descripción]\` para añadir)*

---

## PATRONES DETECTADOS
*(se completa con análisis mensual)*

### Decido bien cuando:
- 

### Evito decidir cuando:
- 

### Errores que repito:
- 

*Creado: ${TODAY}*
DNAEOF

echo -e "  ${GREEN}✓${NC} Archivos base del sistema creados"

# ── INDEX ──
if ! $INJECT_MODE; then
    cat > "$VAULT_PATH/_INDEX.md" << INDEXEOF
# ${BUSINESS_NAME} — Brain

> Sistema de inteligencia instalado el ${TODAY}

## Navegación

| Sección | Contenido |
|---------|-----------|
| [[_BUSINESS_BRAIN/00_CEREBRO/CLAUDE.md\|🧠 Contexto AI]] | Config del sistema |
| [[_BUSINESS_BRAIN/00_CEREBRO/VISION.md\|🎯 Visión]] | A dónde va el negocio |
| [[_BUSINESS_BRAIN/10_OPERACIONES/DAILY_NOTES\|📋 Daily Notes]] | Log diario |
| [[_BUSINESS_BRAIN/20_NUMEROS\|💰 Números]] | KPIs e ingresos |
| [[_BUSINESS_BRAIN/30_EQUIPO\|👥 Equipo]] | Perfiles y formación |
| [[_BUSINESS_BRAIN/${FOLDER_PRODUCTO}\|📦 ${FOLDER_LABEL}]] | Oferta |
| [[_BUSINESS_BRAIN/50_CLIENTES\|⭐ Clientes]] | Feedback |
| [[_BUSINESS_BRAIN/90_ESTRATEGIA\|🗺️ Estrategia]] | Proyectos y decisiones |

## Comandos
\`\`\`
/bb-contexto     → Cargar vault completo
/bb-organiza     → Analizar y mejorar el vault
/bb-dia          → Briefing del día
/bb-cierre       → Cierre del día
\`\`\`

---
*Business Brain v1.0 · ${TODAY}*
INDEXEOF
fi

echo -e "  ${GREEN}✓${NC} Estructura completada"

# ─── INSTALAR COMANDOS CLAUDE ──────────────────────────────
echo ""
echo -e "${BOLD}[5/6] Instalando comandos Claude...${NC}"
echo ""

COMMANDS_DIR="$HOME/.claude/commands"
mkdir -p "$COMMANDS_DIR"

# ── CONFIG ──
cat > "$COMMANDS_DIR/bb-config.md" << CONFIGEOF
# Business Brain — Configuración Global

## Variables del Sistema
- VAULT_PATH: ${VAULT_PATH}
- BRAIN_DIR: ${BRAIN_DIR}
- BUSINESS_NAME: ${BUSINESS_NAME}
- OWNER_NAME: ${OWNER_NAME}
- SECTOR: ${SECTOR_LABEL}
- PROFILE: ${PROFILE_LABEL}
- INJECT_MODE: ${INJECT_MODE}
- INSTALLED: ${TODAY}

## Benchmarks
${KPIS_BENCHMARK}

## Notas del Sistema
- Los comandos /bb-* leen el vault completo: ${VAULT_PATH}
- Los logs y análisis se guardan en: ${BRAIN_DIR}
- /bb-organiza guarda sus informes en: ${BRAIN_DIR}/90_ESTRATEGIA/VAULT_HEALTH/
CONFIGEOF

echo -e "  ${GREEN}✓${NC} bb-config instalado"

# ── BB-CONTEXTO ─────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-contexto.md" << 'BBCONTEXTOEOF'
# Comando: /bb-contexto — Cargar Vault Completo

## Propósito
Lee el vault ENTERO del usuario y construye una imagen viva del estado actual del negocio.
No asume ninguna estructura — descubre lo que hay y lo procesa.
Prerequisito obligatorio para sesiones de trabajo profundo.

---

## Instrucciones de Ejecución

### Paso 1: Leer configuración del sistema
Leer: `~/.claude/commands/bb-config.md`
Extraer: VAULT_PATH, BRAIN_DIR, BUSINESS_NAME, SECTOR.

### Paso 2: Verificar si Obsidian está activo (API local)
```bash
curl -s --max-time 2 "http://localhost:27123/vault/" > /dev/null 2>&1 && echo "API_ACTIVA" || echo "FALLBACK"
```
- Si API_ACTIVA: modo graph-aware (puede seguir backlinks)
- Si FALLBACK: modo lectura directa de archivos

### Paso 3: Mapear el vault completo
```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')
echo "=== MAPA DEL VAULT ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian/*" -not -path "*/.trash/*" | sort
echo ""
echo "=== ESTRUCTURA DE CARPETAS ==="
find "$VAULT_PATH" -type d -not -path "*/.obsidian/*" -not -path "*/.trash/*" | sort
echo ""
echo "=== CONTEO POR CARPETA ==="
find "$VAULT_PATH" -type d -not -path "*/.obsidian/*" -not -path "*/.trash/*" | while read dir; do
    count=$(find "$dir" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    [ "$count" -gt "0" ] && echo "$count archivos | $dir"
done | sort -rn
```

### Paso 4: Leer archivos de contexto central (PRIORIDAD ALTA)
Buscar y leer COMPLETAMENTE estos tipos de archivos (en este orden):
1. Cualquier archivo llamado `CLAUDE.md` en cualquier carpeta
2. Cualquier archivo llamado `README.md` o `_INDEX.md` en la raíz
3. Archivos en carpetas que contengan en su nombre: `CONTEXT`, `LLM`, `BRAIN`, `SISTEMA`, `00_`
4. Cualquier archivo llamado `VISION.md`, `GOALS.md`, `OBJETIVOS.md`

### Paso 5: Leer daily notes recientes (últimos 7 días)
```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')
for i in 0 1 2 3 4 5 6; do
    DATE=$(date -v -${i}d +%Y-%m-%d 2>/dev/null || date -d "-${i} days" +%Y-%m-%d 2>/dev/null)
    find "$VAULT_PATH" -name "${DATE}.md" -not -path "*/.obsidian/*" 2>/dev/null
done
```
Para cada daily note encontrada: leer completa y extraer — qué se trabajó, pendientes, decisiones.

### Paso 6: Leer tareas activas
Buscar archivos en cualquier carpeta con "TAREA", "TODO", "ACTIVA", "TASK" en el nombre.
Leer todos y extraer: tareas vencidas, vencen hoy, vencen esta semana.

### Paso 7: Leer hipótesis y decisiones
Buscar y leer:
- Cualquier archivo `HIPOTESIS.md` o `HYPOTHESES.md`
- Cualquier archivo `DECISION-DNA.md` o similar en carpetas de estrategia
- Los 3 archivos más recientes en carpetas de decisiones

### Paso 8: Muestreo del resto del vault
Para cada carpeta principal no cubierta arriba:
- Leer el primer archivo .md encontrado (primeras 40 líneas)
- Objetivo: entender qué hay en cada área sin leer todo

### Paso 9: Generar Snapshot de Contexto

```markdown
## ✅ CONTEXTO CARGADO — [FECHA]
**Modo:** [Graph-aware API / Lectura directa]
**Vault:** [ruta]
**Archivos totales:** [N] | **Daily notes leídas:** [N] | **Áreas mapeadas:** [N]

---

### 🗺️ MAPA DEL VAULT
[Árbol ASCII de carpetas principales con conteo de archivos]

### 💼 ESTADO DEL NEGOCIO
[Resumen ejecutivo en 3-5 líneas de lo que el vault revela sobre el negocio]

### 📅 ÚLTIMOS 7 DÍAS
[Bullets de lo más relevante de las daily notes recientes]
[Si no hay daily notes: "Sin daily notes recientes — el sistema empieza hoy"]

### ⚡ TAREAS URGENTES
[Lista de tareas vencidas o que vencen esta semana]
[O: "Sin tareas urgentes detectadas"]

### 🧠 HIPÓTESIS ACTIVAS DE BAJA CONFIANZA
[Las que necesitan evidencia urgente]
[O: "Sin hipótesis de baja confianza"]

### 📊 KPIs EN RADAR
[Si hay datos de KPIs — qué está fuera de rango]
[O: "KPIs pendientes de registro"]

### 🔍 ALERTA DEL SISTEMA
[Si /bb-organiza no se ha ejecutado aún: "Recomendado ejecutar /bb-organiza para analizar la estructura del vault"]
[Si el último bb-organiza tiene >30 días: "El último análisis de vault fue hace X días — considera re-ejecutar /bb-organiza"]

---
**Contexto cargado. ¿Por dónde empezamos?**
```
BBCONTEXTOEOF

echo -e "  ${GREEN}✓${NC} /bb-contexto instalado"

# ── BB-ORGANIZA ──────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-organiza.md" << 'BBORGANIZAEOF'
# Comando: /bb-organiza — Vault Surgeon

## Propósito
Analiza la arquitectura de información del vault COMPLETO y propone mejoras sustanciales:
estructura lógica, información mejor relacionada, backlinks faltantes, inconsistencias
de nomenclatura, y notas huérfanas. Genera un Vault Health Report con propuestas numeradas.

**NUNCA modifica archivos directamente. Solo propone. El usuario aprueba con /bb-aplica.**

---

## Instrucciones de Ejecución

### Fase 1 — Escaneo Estructural

```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
TODAY=$(date +%Y-%m-%d)

echo "=== TODAS LAS CARPETAS ==="
find "$VAULT_PATH" -type d -not -path "*/.obsidian*" -not -path "*/.trash*" | sort

echo ""
echo "=== ARCHIVOS POR CARPETA (ordenado por volumen) ==="
find "$VAULT_PATH" -type d -not -path "*/.obsidian*" -not -path "*/.trash*" | while read dir; do
    count=$(find "$dir" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    [ "$count" -gt "0" ] && printf "%4d | %s\n" "$count" "$dir"
done | sort -rn

echo ""
echo "=== ARCHIVOS EN RAÍZ DEL VAULT (sin subcarpeta) ==="
find "$VAULT_PATH" -maxdepth 1 -name "*.md" | sort

echo ""
echo "=== CARPETAS VACÍAS ==="
find "$VAULT_PATH" -type d -not -path "*/.obsidian*" -not -path "*/.trash*" | while read dir; do
    count=$(find "$dir" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    [ "$count" = "0" ] && echo "$dir"
done

echo ""
echo "=== TOTAL DE ARCHIVOS .md ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" -not -path "*/.trash*" | wc -l
```

### Fase 2 — Análisis de Nomenclatura

```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')

echo "=== MUESTRA DE NOMBRES DE ARCHIVO (primeros 100) ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" | sed 's|.*/||' | sort | head -100

echo ""
echo "=== ARCHIVOS CON ESPACIOS EN EL NOMBRE ==="
find "$VAULT_PATH" -name "* *.md" -not -path "*/.obsidian*" | head -30

echo ""
echo "=== ARCHIVOS MUY CORTOS (<5 líneas, posiblemente vacíos) ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" | while read f; do
    lines=$(wc -l < "$f" 2>/dev/null || echo "0")
    [ "$lines" -lt "5" ] && echo "$lines líneas | $f"
done | sort -n | head -20
```

### Fase 3 — Análisis de Conectividad (Backlinks)

```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')

echo "=== NOTAS HUÉRFANAS (no referenciadas por ningún otro archivo) ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" -not -path "*/.trash*" | while read file; do
    filename=$(basename "$file" .md)
    # Escapar caracteres especiales para grep
    safe_name=$(echo "$filename" | sed 's/[[\.*^$(){}?+|]/\\&/g')
    mentions=$(grep -rl "\[\[$safe_name" "$VAULT_PATH" --include="*.md" 2>/dev/null | grep -v "^$file$" | wc -l | tr -d ' ')
    [ "$mentions" = "0" ] && echo "HUÉRFANO | $file"
done | head -40

echo ""
echo "=== LINKS ROTOS (referencias a archivos que no existen) ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" | while read file; do
    # Extraer todos los [[wikilinks]]
    grep -o '\[\[[^]]*\]\]' "$file" 2>/dev/null | sed 's/\[\[//;s/\]\]//' | while read link; do
        # Quitar alias si existe (después del |)
        base_link=$(echo "$link" | sed 's/|.*//')
        # Buscar si existe un archivo con ese nombre
        found=$(find "$VAULT_PATH" -name "${base_link}.md" 2>/dev/null | head -1)
        [ -z "$found" ] && echo "LINK ROTO | $file → [[$link]]"
    done
done 2>/dev/null | head -30

echo ""
echo "=== NOTAS MÁS REFERENCIADAS (hubs del vault) ==="
find "$VAULT_PATH" -name "*.md" -not -path "*/.obsidian*" | while read file; do
    filename=$(basename "$file" .md)
    safe_name=$(echo "$filename" | sed 's/[[\.*^$(){}?+|]/\\&/g')
    count=$(grep -rl "\[\[$safe_name" "$VAULT_PATH" --include="*.md" 2>/dev/null | wc -l | tr -d ' ')
    [ "$count" -gt "2" ] && printf "%3d refs | %s\n" "$count" "$filename"
done | sort -rn | head -20
```

### Fase 4 — Muestreo de Contenido

Para cada carpeta principal con >2 archivos, leer las primeras 30 líneas del primer archivo.
Objetivo: entender qué hay en cada área para detectar solapamientos semánticos y oportunidades
de agrupación. Anotar: ¿hay carpetas distintas que tratan temas similares?

### Fase 5 — Generar Vault Health Report

Usando todos los datos recopilados, generar el informe completo:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🏥 VAULT HEALTH REPORT — [NOMBRE NEGOCIO]
Fecha: [FECHA] | Archivos totales: [N] | Carpetas: [N]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## PUNTUACIÓN GENERAL: [X]/100

| Dimensión       | Puntuación | Estado | Detalle rápido |
|-----------------|------------|--------|----------------|
| Estructura      | [X]/25     | 🟢/🟡/🔴 | [1 línea]    |
| Nomenclatura    | [X]/25     | 🟢/🟡/🔴 | [1 línea]    |
| Conectividad    | [X]/25     | 🟢/🟡/🔴 | [1 línea]    |
| Completitud     | [X]/25     | 🟢/🟡/🔴 | [1 línea]    |

---

## 🔴 PROBLEMAS CRÍTICOS
[Solo si hay problemas que afectan seriamente la usabilidad]

### PC-01 — [Nombre del problema]
**Qué está pasando:** [descripción específica con datos]
**Impacto:** [consecuencia concreta para productividad/AI]
**Archivos afectados:** [N archivos / lista]

[repetir PC-02, PC-03... para cada problema crítico]

---

## 🟡 MEJORAS SUSTANCIALES

### MS-01 — [Nombre]
**Situación actual:** [cómo está ahora, con datos]
**Propuesta:** [cómo debería estar]
**Impacto esperado:** [qué mejora específicamente]
**Esfuerzo:** [bajo 5-15min / medio 30-60min / alto 2h+]

[repetir MS-02, MS-03...]

---

## 🟢 QUICK WINS (hacer esta semana, <15 min cada uno)

| ID    | Acción concreta                      | Esfuerzo | Impacto |
|-------|--------------------------------------|----------|---------|
| QW-01 | [acción específica y ejecutable]     | 5 min    | [qué mejora] |
| QW-02 | ...                                  | ...      | ...     |

---

## 📋 PROPUESTAS DE REORGANIZACIÓN
[Propuestas concretas, ordenadas de mayor a menor impacto]

### PROPUESTA #1 — [Título descriptivo]
**Tipo:** [Renombrar / Mover archivos / Fusionar carpetas / Crear índice / Añadir backlinks / Eliminar duplicados]
**Impacto:** [Alto/Medio/Bajo] | **Esfuerzo:** [Alto/Medio/Bajo]

**ANTES:**
```
[estructura o nombre actual]
```

**DESPUÉS:**
```
[estructura o nombre propuesto]
```

**Por qué este cambio:**
[razonamiento — qué problema resuelve, por qué mejora el vault]

**Comandos para ejecutar:**
```bash
[comandos bash exactos y seguros para hacer este cambio]
```

> **Para aprobar:** escribe `/bb-aplica 1`

---

[repetir PROPUESTA #2, #3... para cada propuesta]

---

## 🔗 BACKLINKS SUGERIDOS
[Conexiones que deberían existir pero no existen]

| Nota A | Nota B | Por qué conectarlas |
|--------|--------|---------------------|
| [[X]]  | [[Y]]  | [tema común / relación] |

Para añadir: abre cada nota y añade el [[link]] en la sección relevante.

---

## 📊 MAPA ACTUAL DEL VAULT

```
[Árbol ASCII del vault con anotaciones:
- ✅ bien organizado
- ⚠️  necesita atención
- 🔴 problema crítico
- 💡 oportunidad]
```

---

## PLAN DE ACCIÓN RECOMENDADO

### Esta semana (quick wins):
[Lista de QW ordenados por impacto/esfuerzo]

### Este mes (mejoras sustanciales):
[Las 2-3 MS más importantes]

### Cuando tengas tiempo (opcional):
[Mejoras de baja prioridad]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Para aplicar cambios: /bb-aplica [número] o /bb-aplica todos
Para solo quick wins: /bb-aplica quick-wins
Próximo análisis recomendado: en 30 días
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Fase 6 — Guardar el informe

Guardar el informe completo en:
`[BRAIN_DIR]/90_ESTRATEGIA/VAULT_HEALTH/[FECHA]-vault-health.md`

Confirmar al usuario:
```
✅ Informe guardado en: _BUSINESS_BRAIN/90_ESTRATEGIA/VAULT_HEALTH/[FECHA]-vault-health.md
```
BBORGANIZAEOF

echo -e "  ${GREEN}✓${NC} /bb-organiza instalado"

# ── BB-APLICA ───────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-aplica.md" << 'BBAPLICAEOF'
# Comando: /bb-aplica — Ejecutar Propuestas Aprobadas

Propuesta(s) a aplicar: $ARGUMENTS

## Propósito
Ejecuta cambios específicos aprobados por el usuario del último /bb-organiza.
Solo actúa sobre lo que el usuario aprueba explícitamente.

---

## Instrucciones

### Paso 1: Identificar qué aplicar
- Si $ARGUMENTS es un número (ej: "1", "3"): aplicar solo esa propuesta
- Si $ARGUMENTS es "todos": aplicar todas las propuestas del último informe
- Si $ARGUMENTS es "quick-wins": aplicar solo los quick wins
- Si $ARGUMENTS es "QW-01" o similar: aplicar ese quick win específico

### Paso 2: Leer el último informe de /bb-organiza
```bash
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
ls -t "$BRAIN_DIR/90_ESTRATEGIA/VAULT_HEALTH/"*.md 2>/dev/null | head -1
```
Leer ese archivo y extraer la propuesta correspondiente al número solicitado.

### Paso 3: Confirmar antes de ejecutar
Mostrar al usuario:
```
⚠️  VAS A EJECUTAR:

[Nombre de la propuesta]
[Descripción de qué cambia]

Archivos/carpetas afectadas:
[lista específica]

¿Confirmar? Escribe "sí" para continuar o "no" para cancelar.
```
Esperar respuesta antes de continuar.

### Paso 4: Ejecutar los comandos bash
Si el usuario confirma con "sí":
- Ejecutar los comandos bash exactos de la propuesta
- Si algún comando falla: mostrar el error, detener la ejecución, NO continuar con el resto
- Si todo va bien: continuar con el siguiente paso

### Paso 5: Verificar resultado
```bash
# Verificar que los archivos/carpetas se movieron correctamente
[comandos de verificación específicos según la propuesta]
```

### Paso 6: Registrar en el informe
Actualizar el informe de VAULT_HEALTH marcando la propuesta como aplicada:
```
✅ PROPUESTA #[N] aplicada el [FECHA]
```

### Paso 7: Confirmar y siguiente paso
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ APLICADO: [nombre de la propuesta]

Cambios realizados:
[lista de lo que se hizo]

[Si hay más propuestas pendientes:]
Quedan [N] propuestas sin aplicar.
Para ver la lista: lee el informe en _BUSINESS_BRAIN/90_ESTRATEGIA/VAULT_HEALTH/
Para aplicar la siguiente: /bb-aplica [número]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
BBAPLICAEOF

echo -e "  ${GREEN}✓${NC} /bb-aplica instalado"

# ── BB-DIA ──────────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-dia.md" << BBDIAEOF
# Comando: /bb-dia — Briefing del Día

## Propósito
Comenzar el día con claridad. Leer lo de ayer, identificar pendientes, definir las 3 prioridades.

## Instrucciones

### Paso 1: Leer contexto
- Leer \`~/.claude/commands/bb-config.md\` para VAULT_PATH, BRAIN_DIR, BUSINESS_NAME
- Leer \`[BRAIN_DIR]/00_CEREBRO/CLAUDE.md\`
- Leer la daily note de ayer en \`[BRAIN_DIR]/10_OPERACIONES/DAILY_NOTES/\`
- Leer \`[BRAIN_DIR]/90_ESTRATEGIA/HIPOTESIS/HIPOTESIS.md\` si existe

### Paso 2: Revisar pendientes
- Buscar sección "Para mañana" en la última daily note
- Buscar proyectos activos en \`[BRAIN_DIR]/90_ESTRATEGIA/PROYECTOS/\`

### Paso 3: Output

\`\`\`
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌅 BRIEFING — ${BUSINESS_NAME} — [FECHA]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 DE AYER
[Resumen en 3 líneas de las daily notes anteriores]

⚠️ PENDIENTES CRÍTICOS
[Cosas que quedaron abiertas]

🎯 MIS 3 PRIORIDADES DE HOY
1. [Primera — la más importante]
2. [Segunda]
3. [Tercera]

🧠 ALERTA DEL SISTEMA
[Patrón, riesgo u oportunidad detectada en los datos]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
\`\`\`

Si no hay datos aún: "El sistema tiene [N] días de datos. A los 7 días los análisis son más precisos."
BBDIAEOF

echo -e "  ${GREEN}✓${NC} /bb-dia instalado"

# ── BB-CIERRE ───────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-cierre.md" << BBCIERREEOF
# Comando: /bb-cierre — Cierre del Día

## Propósito
Capturar lo más importante del día. 5 minutos que valen semanas de datos.

## Instrucciones

### Paso 1: Preguntas de cierre (una a una o en bloque)
1. **Números** — ¿${DAILY_QUESTIONS}?
2. **Equipo** — ¿Algo destacable del equipo hoy? (positivo o negativo)
3. **Operaciones** — ¿Incidencia, problema o mejora detectada?
4. **${UNIT_CLIENTE}** — ¿Feedback relevante? ¿Algo que se repitió?
5. **Decisiones** — ¿Tomaste alguna decisión hoy?
6. **Para mañana** — ¿Qué no puede quedarse sin resolver?

### Paso 2: Crear/actualizar daily note
Crear o actualizar \`[BRAIN_DIR]/10_OPERACIONES/DAILY_NOTES/[FECHA].md\` con el formato estándar.

### Paso 3: Detectar patrones
Si hay 7+ días de datos: ¿algo se repite esta semana? ¿alguna hipótesis confirmada o contradicha?

### Paso 4: Output de cierre

\`\`\`
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌙 CIERRE — [FECHA]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Registrado: [resumen de lo capturado]
📊 Dato del día: [el número más importante]
💡 Observación del sistema: [patrón o insight si hay]
➡️  Para mañana: [pendiente más crítico]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Días de datos en el sistema: [N]
\`\`\`
BBCIERREEOF

echo -e "  ${GREEN}✓${NC} /bb-cierre instalado"

# ── BB-SEMANA ───────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-semana.md" << 'BBSEMANAEOF'
# Comando: /bb-semana — Review Semanal

## Propósito
Mirar atrás para ver con claridad y hacia adelante para decidir con intención.
El ritual que convierte datos en aprendizaje. Ejecutar los lunes.

## Instrucciones

### Paso 1: Leer datos de la semana
```bash
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
# Leer las 7 daily notes de la semana pasada
for i in 1 2 3 4 5 6 7; do
    DATE=$(date -v -${i}d +%Y-%m-%d 2>/dev/null || date -d "-${i} days" +%Y-%m-%d 2>/dev/null)
    [ -f "$BRAIN_DIR/10_OPERACIONES/DAILY_NOTES/$DATE.md" ] && cat "$BRAIN_DIR/10_OPERACIONES/DAILY_NOTES/$DATE.md"
done
```
También leer: KPIs principales, decisiones de esta semana.

### Paso 2: Generar review

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 REVIEW SEMANAL — [SEMANA DEL X AL Y]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 NÚMEROS DE LA SEMANA
[Resumen de datos disponibles en el vault]

✅ LO QUE FUNCIONÓ
[3 cosas específicas con evidencia del vault]

⚠️  LO QUE NO FUNCIONÓ
[3 cosas que fallaron o quedaron sin hacer]

🔁 PATRÓN DE LA SEMANA
[Una observación de algo que se repite]

🎯 LAS 3 PRIORIDADES DE ESTA SEMANA
1. [La más importante]
2. 
3. 

💡 PREGUNTA DE LA SEMANA
[Una pregunta que el análisis genera]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Semanas de datos: [N]
```
BBSEMANAEOF

echo -e "  ${GREEN}✓${NC} /bb-semana instalado"

# ── BB-EMERGE ───────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-emerge.md" << 'BBEMEGEEOF'
# Comando: /bb-emerge — Ideas Latentes del Negocio

## Propósito
Tu negocio sabe cosas que tú no sabes que sabe.
Este comando lee el vault entero y extrae conclusiones que las notas IMPLICAN pero nunca ARTICULAN.

## Instrucciones

### Paso 1: Recopilar materiales
```bash
VAULT_PATH=$(grep "VAULT_PATH:" ~/.claude/commands/bb-config.md | sed 's/.*VAULT_PATH: //')
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
# Listar todas las daily notes disponibles
find "$BRAIN_DIR/10_OPERACIONES/DAILY_NOTES" -name "*.md" | sort | tail -14
# Listar decisiones
find "$BRAIN_DIR/90_ESTRATEGIA/DECISIONES" -name "*.md" | sort
```
Leer: últimas 14 daily notes, archivo de hipótesis, visión, perfiles de equipo, KPIs.

### Paso 2: Minar los 5 tipos de patrones

**2A. Problemas Repetidos Sin Resolver**
Problemas mencionados en 3+ daily notes sin decisión documentada.

**2B. Oportunidades No Capturadas**
Ideas mencionadas en daily notes que nunca se convirtieron en proyectos.

**2C. Tensiones Entre Visión y Comportamiento Real**
Comparar VISION.md con lo que realmente pasa en las notas.

**2D. Patrones de Equipo No Articulados**
Si los mismos nombres aparecen en contextos positivos/negativos consistentemente.

**2E. Señales de Clientes/Mercado No Procesadas**
Feedback que aparece pero nunca se convirtió en acción.

### Paso 3: Output

```markdown
## 💡 EMERGE — Ideas Latentes de [NEGOCIO]
Fecha: [FECHA] | Notas analizadas: [N]

---

### PATRÓN 1: [NOMBRE]
**Tipo:** [Problema / Oportunidad / Tensión / Equipo / Mercado]
**Aparece en:** [fechas de daily notes]
**Lo que el vault implica:** [conclusión no articulada]
**Por qué importa ahora:** [1 línea]
**Pregunta que activa:** "[Pregunta que deberías hacerte]"

---
[Repetir para 4-7 patrones]

---

### TOP ACCIÓN EMERGENTE
[El insight de mayor impacto + un paso concreto para esta semana]
```
BBEMEGEEOF

echo -e "  ${GREEN}✓${NC} /bb-emerge instalado"

# ── BB-DECISION ─────────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-decision.md" << 'BBDECISIONEOF'
# Comando: /bb-decision — Registrar Decisión Importante

Decisión: $ARGUMENTS

## Instrucciones

### 1: Extraer de lo que dice el usuario
- Qué se decidió, por qué, alternativas consideradas, área afectada, impacto

### 2: Si falta contexto, preguntar
- "¿Qué alternativas consideraste?"
- "¿Cuál es el principal riesgo?"
- "¿Cómo sabrás en 30 días si fue buena decisión?"

### 3: Crear archivo en BRAIN_DIR/90_ESTRATEGIA/DECISIONES/
```bash
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
```
Nombre: `[FECHA]-[titulo-corto].md`

### 4: Formato del archivo

```yaml
---
type: decision
fecha: [FECHA]
area: [equipo|producto|operaciones|marketing|finanzas|proveedor|estrategia]
impacto: [alto|medio|bajo]
status: activa
revisar: [fecha +30 días]
---
```

# [Título de la Decisión]

## Contexto
¿Qué situación llevó a esta decisión?

## Decisión Tomada
[Descripción clara]

## Razones
1. 
2. 

## Alternativas Descartadas
- **Opción A:** → Descartada porque:

## Riesgos y Mitigación
| Riesgo | Probabilidad | Mitigación |
|--------|--------------|------------|

## Criterios de Éxito (en 30 días)
- [ ] 

### 5: Confirmar
```
✅ Decisión registrada
📁 90_ESTRATEGIA/DECISIONES/[nombre].md
📅 Revisión: [fecha +30 días]
```
BBDECISIONEOF

echo -e "  ${GREEN}✓${NC} /bb-decision instalado"

# ── BB-PUNTO-CIEGO ──────────────────────────────────────────
cat > "$COMMANDS_DIR/bb-punto-ciego.md" << 'BBPUNTOCIEGOEOF'
# Comando: /bb-punto-ciego — Detector de Sesgos

Decisión a evaluar: $ARGUMENTS

## Propósito
Antes de una decisión importante: detectar qué estás ignorando, qué asumes sin verificar,
y qué sesgos tuyos están operando en este momento.

## Instrucciones

### Paso 1: Leer contexto
```bash
BRAIN_DIR=$(grep "BRAIN_DIR:" ~/.claude/commands/bb-config.md | sed 's/.*BRAIN_DIR: //')
```
Leer: CLAUDE.md, HIPOTESIS.md, DECISION-DNA.md, daily notes recientes.

### Paso 2: Análisis en 6 dimensiones

**1. ¿Qué información no tienes?**
Datos que existirían y cambiarían la decisión.

**2. ¿Qué asumes que es verdad?**
Las premisas implícitas que no cuestionas.

**3. ¿Qué patrón histórico está operando?**
Del Decision DNA: ¿decides bien o mal este tipo de decisiones?

**4. ¿Qué dice el optimista y el pesimista?**
La versión más positiva y más negativa de este movimiento.

**5. ¿Cuál es el coste real de no decidir?**
El sesgo del status quo es uno de los más caros.

**6. ¿Hay una versión más pequeña y reversible?**
¿Se puede probar antes de comprometerse completamente?

### Paso 3: Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 PUNTO CIEGO — [DECISIÓN]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

❓ LO QUE NO SABES (y deberías saber antes)
[información faltante]

⚠️  LO QUE ASUMES (sin verificar)
[premisas implícitas]

🔁 TU PATRÓN EN DECISIONES COMO ESTA
[basado en Decision DNA]

📊 OPTIMISTA VS. PESIMISTA
+ [escenario positivo]
- [escenario negativo]

⚡ VERSIÓN REVERSIBLE
[la forma más pequeña de probar esto]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Recomendación: [proceder / posponer / reformular]
```
BBPUNTOCIEGOEOF

echo -e "  ${GREEN}✓${NC} /bb-punto-ciego instalado"

# ─── RECORDATORIO DIARIO ────────────────────────────────────
echo ""
echo -e "${BOLD}[5.5/6] Recordatorio diario...${NC}"
echo ""
echo -e "  ${CYAN}¿Activar recordatorio nocturno para /bb-cierre?${NC}"
read -p "  (s/n): " SETUP_REMINDER

if [[ "$SETUP_REMINDER" =~ ^[Ss]$ ]]; then
    echo -e "  ${CYAN}¿A qué hora? (Enter para 22:30)${NC}"
    read -p "  HH:MM > " REMIND_TIME
    [ -z "$REMIND_TIME" ] && REMIND_TIME="22:30"

    CRON_HOUR="${REMIND_TIME%%:*}"
    CRON_MIN="${REMIND_TIME##*:}"
    CRON_CMD="osascript -e 'display notification \"¿Has hecho tu /bb-cierre hoy? Son 5 minutos.\" with title \"Business Brain 🧠 — ${BUSINESS_NAME}\" sound name \"Glass\"' 2>/dev/null"
    EXISTING_CRONTAB=$(crontab -l 2>/dev/null | grep -v "Business Brain" || true)
    echo "$EXISTING_CRONTAB" | { cat; echo "${CRON_MIN} ${CRON_HOUR} * * * ${CRON_CMD}"; } | crontab - 2>/dev/null

    echo -e "  ${GREEN}✓${NC} Recordatorio activado a las ${REMIND_TIME}"
    REMINDER_STATUS="ACTIVO — ${REMIND_TIME}"
else
    REMINDER_STATUS="No configurado"
fi

# ─── RESUMEN FINAL ──────────────────────────────────────────
echo ""
echo -e "${BOLD}[6/6] Finalizando...${NC}"
echo ""

TOTAL_FILES=$(find "$BASE/_BUSINESS_BRAIN" -type f 2>/dev/null | wc -l | tr -d ' ')
TOTAL_COMMANDS=$(ls "$COMMANDS_DIR"/bb-*.md 2>/dev/null | wc -l | tr -d ' ')

sleep 0.5
clear

echo ""
echo -e "${GREEN}${BOLD}"
echo "  ╔═══════════════════════════════════════════════════════╗"
echo "  ║                                                       ║"
echo "  ║   ✅  BUSINESS BRAIN INSTALADO                       ║"
echo "  ║                                                       ║"
echo "  ╚═══════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "  ${BOLD}Negocio:${NC}      ${CYAN}${BUSINESS_NAME}${NC}"
echo -e "  ${BOLD}Sector:${NC}       ${CYAN}${SECTOR_LABEL}${NC}"
echo -e "  ${BOLD}Modo:${NC}         ${CYAN}${MODO_DISPLAY}${NC}"
echo -e "  ${BOLD}Vault:${NC}        ${CYAN}${VAULT_PATH}${NC}"
echo -e "  ${BOLD}Archivos:${NC}     ${CYAN}${TOTAL_FILES} archivos creados${NC}"
echo -e "  ${BOLD}Comandos:${NC}     ${CYAN}${TOTAL_COMMANDS} comandos instalados${NC}"
echo -e "  ${BOLD}Recordatorio:${NC} ${CYAN}${REMINDER_STATUS}${NC}"
echo ""
echo "  ─────────────────────────────────────────────────────────"
echo ""
echo -e "  ${BOLD}🚀 TUS PRIMEROS 3 PASOS:${NC}"
echo ""
echo -e "  ${CYAN}Paso 1 - Ahora mismo:${NC}"
if [ "$INJECT_MODE" = "true" ]; then
    echo -e "  Abre Obsidian - la carpeta _BUSINESS_BRAIN aparece en tu vault."
    echo -e "  Abre _BUSINESS_BRAIN/00_CEREBRO/VISION.md y escribe tu vision."
else
    echo -e "  Abre Obsidian - Open folder as vault - selecciona: ${CYAN}${VAULT_PATH}${NC}"
    echo -e "  Abre _BUSINESS_BRAIN/00_CEREBRO/VISION.md y escribe tu vision."
fi
echo ""
echo -e "  ${CYAN}Paso 2 — Ejecuta el primer análisis:${NC}"
echo -e "  En terminal escribe ${BOLD}claude${NC} y luego: ${BOLD}/bb-contexto${NC}"
echo -e "  Te da un mapa completo del estado actual de tu vault."
echo ""
echo -e "  ${CYAN}Paso 3 — Analiza y mejora el vault:${NC}"
echo -e "  Escribe ${BOLD}/bb-organiza${NC}"
echo -e "  Recibes un Vault Health Report con propuestas concretas."
echo -e "  Aprueba lo que quieras con ${BOLD}/bb-aplica [número]${NC}"
echo ""
echo "  ─────────────────────────────────────────────────────────"
echo ""
echo -e "  ${BOLD}📋 TODOS LOS COMANDOS:${NC}"
echo ""
echo -e "  ${CYAN}/bb-contexto${NC}     → Cargar vault completo (inicio de sesión)"
echo -e "  ${CYAN}/bb-organiza${NC}     → Analizar y mejorar el vault"
echo -e "  ${CYAN}/bb-aplica${NC}       → Ejecutar propuestas aprobadas"
echo -e "  ${CYAN}/bb-dia${NC}          → Briefing de la mañana"
echo -e "  ${CYAN}/bb-cierre${NC}       → Cierre del día (5 min)"
echo -e "  ${CYAN}/bb-semana${NC}       → Review semanal (lunes)"
echo -e "  ${CYAN}/bb-emerge${NC}       → Ideas latentes del negocio (mensual)"
echo -e "  ${CYAN}/bb-decision${NC}     → Registrar decisión importante"
echo -e "  ${CYAN}/bb-punto-ciego${NC}  → Detector de sesgos antes de decidir"
echo ""
echo "  ─────────────────────────────────────────────────────────"
echo ""
echo -e "  ${YELLOW}Benchmarks del sector (${SECTOR_LABEL}):${NC}"
echo -e "  ${YELLOW}${KPIS_BENCHMARK}${NC}"
echo ""
echo -e "  ${BOLD}Business Brain v1.0 · RestaurantMind OS · The Pulse${NC}"
echo ""

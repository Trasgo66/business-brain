# 🧠 Business Brain

**Sistema de Inteligencia Operativa para Empresarios**
Compatible con cualquier sector y con vaults Obsidian existentes.

Desarrollado por [Roberto Brisciani](https://thepulserestaurant.com) — RestaurantMind OS · The Pulse

---

## ¿Qué es Business Brain?

Business Brain convierte el Obsidian de cualquier empresario en un sistema de inteligencia conectado a Claude AI. En 10 minutos tienes:

- **Un vault estructurado** (nuevo o integrado en el tuyo)
- **9 comandos Claude** listos para usar desde terminal
- **Un análisis completo** de tu vault con propuestas de mejora

El sistema aprende contigo: cuantos más días lo usas, más preciso se vuelve.

---

## Instalación en 1 línea

```bash
curl -fsSL https://raw.githubusercontent.com/Trasgo66/business-brain/main/install.sh | bash
```

### Requisitos previos
- [Obsidian](https://obsidian.md) — gratuito
- [Claude CLI](https://claude.ai/code) — `npm install -g @anthropic-ai/claude-code`

---

## Sectores disponibles

El instalador adapta vocabulario, KPIs y benchmarks según tu sector:

| # | Sector | KPIs principales |
|---|--------|-----------------|
| 1 | Restauración / Hostelería | Food cost, Labor cost, Ticket medio, Covers/día |
| 2 | Hotel / Alojamiento | ADR, RevPAR, Occupancy %, GOP % |
| 3 | Retail / Comercio | Ticket medio, Conversión %, Margen bruto, Rotación |
| 4 | Servicios / Consultoría | MRR, LTV, CAC, Churn rate |
| 5 | Salud / Bienestar | Pacientes activos, Tasa retorno, Ocupación agenda |
| 6 | Tecnología / SaaS | MRR, Churn, NPS, DAU/MAU |
| 7 | Educación / Formación | Alumnos activos, Tasa finalización, NPS |
| 8 | Genérico | Facturación, Margen, Clientes activos |

---

## Funciona con tu vault existente

El instalador tiene dos modos:

**Modo A — Vault existente:** añade una carpeta `_BUSINESS_BRAIN/` dentro de tu vault sin tocar nada de lo que ya tienes.

**Modo B — Vault nuevo:** crea un vault completo desde cero.

---

## Los 9 comandos

Una vez instalado, escribe `claude` en terminal y usa estos comandos:

| Comando | Qué hace | Cuándo |
|---------|---------|--------|
| `/bb-contexto` | Lee el vault COMPLETO y genera un snapshot del estado del negocio | Inicio de cada sesión |
| `/bb-organiza` | Analiza el vault y propone mejoras concretas (Vault Surgeon) | Primera vez + mensualmente |
| `/bb-aplica [N]` | Ejecuta la propuesta N aprobada por ti | Después de /bb-organiza |
| `/bb-dia` | Briefing ejecutivo del día | Cada mañana |
| `/bb-cierre` | 5 preguntas en 5 minutos para cerrar el día | Cada noche |
| `/bb-semana` | Review semanal completa | Cada lunes |
| `/bb-emerge` | Extrae ideas latentes que el vault implica pero no articula | Mensualmente |
| `/bb-decision [X]` | Registra una decisión con contexto y criterios de éxito | Al decidir algo importante |
| `/bb-punto-ciego [X]` | Detecta sesgos antes de una decisión importante | Antes de decidir |

---

## El Vault Surgeon (`/bb-organiza`)

La función más potente del sistema. Analiza tu Obsidian en 5 fases:

1. **Escaneo estructural** — mapea todas las carpetas y archivos
2. **Análisis de nomenclatura** — detecta inconsistencias, archivos vacíos, mezcla de idiomas
3. **Conectividad** — encuentra notas huérfanas, links rotos y hubs
4. **Muestreo de contenido** — detecta solapamientos semánticos entre carpetas
5. **Vault Health Report** — puntuación 0-100, propuestas numeradas con comandos bash exactos

**Nunca modifica nada sin tu aprobación.** Aprueba con `/bb-aplica [número]`.

---

## Cómo funciona después de instalar

```
Día 1    → /bb-contexto    (mapa del vault)
           /bb-organiza    (Vault Health Report)

Cada día → /bb-dia         (mañana)
           /bb-cierre      (noche, 5 min)

Cada lunes → /bb-semana

Cada mes → /bb-emerge
           /bb-organiza    (re-análisis)
```

---

## Estructura que crea el instalador

```
_BUSINESS_BRAIN/
├── 00_CEREBRO/
│   ├── CLAUDE.md          ← Contexto central del AI
│   └── VISION.md          ← A dónde va el negocio
├── 10_OPERACIONES/
│   └── DAILY_NOTES/       ← Un archivo por día
├── 20_NUMEROS/
│   └── KPIs/              ← Adaptado a tu sector
├── 30_EQUIPO/
├── 40_[SECTOR]/           ← CARTA / SERVICIOS / CATALOGO / etc.
├── 50_CLIENTES/
├── 60_PROVEEDORES/
└── 90_ESTRATEGIA/
    ├── DECISIONES/
    ├── HIPOTESIS/
    └── VAULT_HEALTH/      ← Informes de /bb-organiza
```

---

## Sobre este proyecto

Business Brain es un módulo del ecosistema **RestaurantMind OS** — el sistema operativo para empresarios de hostelería y restauración creado por Roberto Brisciani.

- 🌐 [The Pulse Restaurant](https://thepulserestaurant.com)
- 📚 [RestaurantMind OS](https://restaurantmind.es)
- 🔧 [Restaurant Brain](https://github.com/Trasgo66/restaurant-brain) — versión específica para restaurantes

---

## Licencia

MIT — libre para usar, modificar y distribuir.

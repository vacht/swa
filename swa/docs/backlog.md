# Backlog del proyecto SWA

Cada fila es una incidencia de GitHub. Se crean automáticamente con `scripts/setup_github.sh`.
Reparto sugerido: **M** = Marcos, **S** = Sebastián (se puede cambiar; lo importante es que no trabajéis a la vez en el mismo módulo).

## Hito 1 · Base y autenticación (semanas 1-4)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 1 | Modelos SQLAlchemy de usuarios, roles y mesas | feature/modelos-base | RNF06 | M |
| 2 | Registro y login con JWT y contraseñas cifradas | feature/autenticacion | RF07, RF08, RNF03 | M |
| 3 | Dependencia de permisos por rol (camarero/encargado) | feature/permisos-rol | RNF04 | M |
| 4 | CRUD de mesas con generación de código QR | feature/mesas | RF01, RF09 | S |
| 5 | Script de datos de prueba (usuarios, mesas, carta) | chore/datos-semilla | — | S |

## Hito 2 · Carta, comandas y solicitudes (semanas 5-8)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 6 | CRUD de categorías y productos (encargado) | feature/carta-admin | RF18 | S |
| 7 | Endpoint público de carta por QR | feature/carta-publica | RF01, RF02, RF03 | S |
| 8 | Crear comanda y regla de una abierta por mesa | feature/comandas | RF10, RF11 | M |
| 9 | Añadir y quitar líneas, importe total y precio congelado | feature/lineas-comanda | RF14 | M |
| 10 | Cambios de estado pendiente → servida (validación de transiciones) | feature/estados-comanda | RF13 | M |
| 11 | Cerrar mesa de forma explícita | feature/cerrar-mesa | RF12 | M |
| 12 | Solicitudes de atención y cuenta | feature/solicitudes | RF04, RF05 | S |
| 13 | Valoraciones del servicio (1-5 y comentario) | feature/valoraciones | RF06 | S |
| 14 | Comanda compartida: consulta pública por mesa | feature/comanda-compartida | RF15 | M |

## Hito 3 · Interfaces web (semanas 7-10)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 15 | Interfaz del cliente: carta móvil y botones de acción | feature/ui-cliente | RF01-RF06, RNF02 | S |
| 16 | Pantalla de login y estructura común (CSS base) | feature/ui-login | RNF01, RNF03 | M |
| 17 | Panel del camarero: mesas, solicitudes y comandas | feature/ui-camarero | RF09-RF13 | M |
| 18 | Panel del encargado: navegación lateral y dashboard | feature/ui-encargado | RF17 | S |
| 19 | Gestión de usuarios desde el encargado | feature/usuarios-admin | RF17 | S |

## Hito 4 · Inventario (semanas 9-11)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 20 | CRUD de ingredientes y unidades | feature/ingredientes | RF19 | S |
| 21 | Recetas asociadas a productos | feature/recetas | RF20, RF28 | S |
| 22 | Conversión de unidades compatibles | feature/conversion-unidades | RF21 | M |
| 23 | Descuento de stock al servir (sin duplicar, sin negativos) | feature/consumo-stock | RF22, RF23 | M |
| 24 | Ajustes manuales y movimientos de stock | feature/ajustes-stock | RF24, RF32 | S |
| 25 | Alertas de stock mínimo y disponibilidad automática | feature/alertas-stock | RF25, RF26, RF27 | M |
| 26 | Devoluciones sin reponer stock automáticamente | feature/devoluciones | RF29 | M |

## Hito 5 · Tiempo real, estadísticas e IA (semanas 11-12)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 27 | WebSockets para la comanda compartida | feature/websockets | RF16, RNF10 | M |
| 28 | Endpoints de estadísticas | feature/estadisticas | RF30 | S |
| 29 | Elegir y probar modelo local de IA | feature/ia-prototipo | RF31 | M |
| 30 | Asistente de IA de solo lectura con consultas acotadas | feature/asistente-ia | RF31 | M |

## Hito 6 · Pruebas y entrega (semanas 13-16)
| # | Tarea | Rama | RF/RNF | Quién |
|---|---|---|---|---|
| 31 | Tests automáticos del backend | feature/tests-backend | RNF05 | S |
| 32 | Revisión de seguridad y permisos | chore/revision-seguridad | RNF04 | M |
| 33 | Valorar Docker | chore/docker | — | S |
| 34 | Memoria final y manual de usuario | docs/memoria-final | — | M y S |

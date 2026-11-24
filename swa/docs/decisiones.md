# Decisiones técnicas

| Fecha | Decisión | Motivo |
|---|---|---|
| 2026-11-23 | El estado (pendiente…servida) va en `lineas_comanda`, no en `comandas` | La memoria habla de "pedido servido" y de consumo de stock; por línea permite servir platos por separado. `comandas.abierta` indica si la mesa sigue en servicio. **A confirmar entre los dos.** |
| 2026-11-23 | Una comanda abierta por mesa forzada en BD (columna generada + UNIQUE) | RF10: que no dependa solo del backend |
| 2026-11-23 | SQLAlchemy 2 + PyMySQL | ORM estándar con FastAPI |

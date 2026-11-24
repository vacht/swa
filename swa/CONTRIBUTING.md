# Guía de trabajo del equipo

Equipo: Marcos Domínguez y Sebastián Vallejo.

## Regla de oro
`main` siempre debe funcionar. **Nadie sube directamente a `main`**: todo entra mediante Pull Request.

## Flujo de una tarea (incidencia → rama → PR)
1. Coge una incidencia de GitHub (pestaña *Issues*) y asígnatela.
2. Actualiza `main` y crea la rama con el nombre indicado en la incidencia:
   ```bash
   git checkout main
   git pull
   git checkout -b feature/nombre-corto
   ```
3. Trabaja en commits pequeños:
   ```bash
   git add .
   git commit -m "feat(auth): añadir login con JWT"
   git push -u origin feature/nombre-corto
   ```
4. Abre un Pull Request hacia `main`. Escribe `Closes #N` en la descripción (N = número de la incidencia) para que se cierre sola al fusionar.
5. Tu compañero lo revisa. Cuando esté aprobado, **Squash and merge**.
6. Borra la rama y actualiza tu `main`:
   ```bash
   git checkout main
   git pull
   ```

## Nombres de ramas
| Prefijo | Uso | Ejemplo |
|---|---|---|
| `feature/` | funcionalidad nueva | `feature/autenticacion` |
| `fix/` | corrección de errores | `fix/stock-negativo` |
| `docs/` | documentación | `docs/memoria-final` |
| `chore/` | configuración, mantenimiento | `chore/docker` |

## Mensajes de commit
Formato: `tipo(ámbito): descripción en imperativo`

Tipos: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`.
Ejemplos: `feat(mesas): crear endpoint de listado`, `fix(comandas): evitar segunda comanda abierta`.

## Para evitar conflictos
- Un archivo = una persona a la vez. Repartid las tareas por módulo.
- Haced `git pull` de `main` antes de empezar y trae `main` a tu rama a diario (`git merge main`).
- PRs pequeños (menos de ~400 líneas) y revisados en menos de 24 h.
- Si cambiáis `database/schema.sql`, avisad al otro por WhatsApp: afecta a todos.

## Antes de abrir un PR
- [ ] El backend arranca (`uvicorn app.main:app --reload`)
- [ ] Los tests pasan (`pytest` dentro de `backend/`)
- [ ] No hay contraseñas ni `.env` en los cambios (`git status`)

## Entorno local
Ver `README.md`. Para tests: `pip install -r requirements-dev.txt` y `pytest`.

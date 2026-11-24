# SWA · Smart Waiter Assistant

Aplicación web para gestión de sala de restaurante (QR, comandas, inventario, IA local).

## Estructura
- `backend/` API en Python + FastAPI
- `database/` esquema MySQL
- `frontend/` HTML/CSS/JS (cliente, camarero, encargado)
- `docs/` documentación y decisiones

## Puesta en marcha
1. Crear la base de datos: `mysql -u root -p < database/schema.sql`
2. Crear un usuario MySQL limitado:
   ```sql
   CREATE USER 'swa_user'@'localhost' IDENTIFIED BY 'tu_clave';
   GRANT SELECT, INSERT, UPDATE, DELETE ON swa.* TO 'swa_user'@'localhost';
   ```
3. Backend:
   ```bash
   cd backend
   python -m venv .venv
   source .venv/bin/activate        # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   cp ../.env.example .env          # y edita los valores
   uvicorn app.main:app --reload
   ```
4. Comprobar: http://localhost:8000/api/health y http://localhost:8000/docs

from fastapi import FastAPI

from app.routers import health

app = FastAPI(title="SWA · Smart Waiter Assistant", version="0.1.0")

app.include_router(health.router, prefix="/api")

# Próximas fases:
# app.include_router(auth.router, prefix="/api/auth")
# app.include_router(mesas.router, prefix="/api/mesas")
# app.include_router(comandas.router, prefix="/api/comandas")

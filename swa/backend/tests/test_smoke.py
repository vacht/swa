from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_docs_disponible():
    """El backend arranca y expone la documentación OpenAPI."""
    assert client.get("/openapi.json").status_code == 200

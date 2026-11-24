-- SWA · Esquema inicial v1 (MySQL 8+)
-- Uso: mysql -u root -p < database/schema.sql

CREATE DATABASE IF NOT EXISTS swa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE swa;

-- ---------- Usuarios y roles ----------
CREATE TABLE roles (
  id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30) NOT NULL UNIQUE          -- 'camarero', 'encargado'
);

CREATE TABLE usuarios (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(80) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  rol_id TINYINT UNSIGNED NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- ---------- Mesas ----------
CREATE TABLE mesas (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  numero INT UNSIGNED NOT NULL UNIQUE,
  codigo_qr VARCHAR(64) NOT NULL UNIQUE,      -- token que va dentro del QR
  estado ENUM('libre','ocupada') NOT NULL DEFAULT 'libre'
);

-- ---------- Carta ----------
CREATE TABLE categorias (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(60) NOT NULL UNIQUE,
  orden SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE productos (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  categoria_id INT UNSIGNED NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(255),
  precio DECIMAL(8,2) NOT NULL CHECK (precio >= 0),
  no_disponible_manual BOOLEAN NOT NULL DEFAULT FALSE,   -- RF27
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- ---------- Ingredientes, recetas e inventario ----------
CREATE TABLE unidades (
  id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL UNIQUE,          -- 'g','kg','ml','l','ud'
  magnitud ENUM('masa','volumen','unidad') NOT NULL,
  factor_base DECIMAL(12,6) NOT NULL           -- a g / ml / ud (kg=1000, l=1000)
);

CREATE TABLE ingredientes (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  unidad_id TINYINT UNSIGNED NOT NULL,         -- unidad en la que se guarda el stock
  stock_actual DECIMAL(12,3) NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),  -- RF23
  stock_minimo DECIMAL(12,3) NOT NULL DEFAULT 0,
  FOREIGN KEY (unidad_id) REFERENCES unidades(id)
);

CREATE TABLE recetas (
  producto_id INT UNSIGNED NOT NULL,
  ingrediente_id INT UNSIGNED NOT NULL,
  cantidad DECIMAL(12,3) NOT NULL CHECK (cantidad > 0),
  unidad_id TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (producto_id, ingrediente_id),
  FOREIGN KEY (producto_id) REFERENCES productos(id),
  FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(id),
  FOREIGN KEY (unidad_id) REFERENCES unidades(id)
);

CREATE TABLE movimientos_stock (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  ingrediente_id INT UNSIGNED NOT NULL,
  tipo ENUM('entrada','consumo','ajuste') NOT NULL,
  cantidad DECIMAL(12,3) NOT NULL,             -- positiva o negativa, en unidad del ingrediente
  motivo VARCHAR(255),
  usuario_id INT UNSIGNED NULL,
  linea_comanda_id BIGINT UNSIGNED NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(id),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- ---------- Comandas ----------
CREATE TABLE comandas (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  mesa_id INT UNSIGNED NOT NULL,
  abierta BOOLEAN NOT NULL DEFAULT TRUE,
  creada_por INT UNSIGNED NULL,
  creada_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  cerrada_en DATETIME NULL,
  -- RF10: solo una comanda abierta por mesa (NULL no choca en UNIQUE)
  mesa_abierta INT UNSIGNED AS (IF(abierta, mesa_id, NULL)) STORED,
  UNIQUE KEY uq_una_abierta_por_mesa (mesa_abierta),
  FOREIGN KEY (mesa_id) REFERENCES mesas(id),
  FOREIGN KEY (creada_por) REFERENCES usuarios(id)
);

CREATE TABLE lineas_comanda (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  comanda_id BIGINT UNSIGNED NOT NULL,
  producto_id INT UNSIGNED NOT NULL,
  cantidad SMALLINT UNSIGNED NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(8,2) NOT NULL,       -- precio congelado al pedir
  estado ENUM('pendiente','confirmada','en_preparacion','lista','servida')
         NOT NULL DEFAULT 'pendiente',
  stock_descontado BOOLEAN NOT NULL DEFAULT FALSE,  -- evita descontar dos veces
  devuelta BOOLEAN NOT NULL DEFAULT FALSE,          -- RF29
  FOREIGN KEY (comanda_id) REFERENCES comandas(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- ---------- Solicitudes y valoraciones ----------
CREATE TABLE solicitudes (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  mesa_id INT UNSIGNED NOT NULL,
  tipo ENUM('atencion','cuenta') NOT NULL,
  estado ENUM('pendiente','atendida') NOT NULL DEFAULT 'pendiente',
  creada_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atendida_por INT UNSIGNED NULL,
  atendida_en DATETIME NULL,
  FOREIGN KEY (mesa_id) REFERENCES mesas(id),
  FOREIGN KEY (atendida_por) REFERENCES usuarios(id)
);

CREATE TABLE valoraciones (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  mesa_id INT UNSIGNED NOT NULL,
  puntuacion TINYINT UNSIGNED NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),  -- RF06
  comentario VARCHAR(500),
  creada_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mesa_id) REFERENCES mesas(id)
);

-- ---------- Datos semilla ----------
INSERT INTO roles (nombre) VALUES ('camarero'), ('encargado');
INSERT INTO unidades (nombre, magnitud, factor_base) VALUES
  ('g','masa',1), ('kg','masa',1000),
  ('ml','volumen',1), ('l','volumen',1000),
  ('ud','unidad',1);

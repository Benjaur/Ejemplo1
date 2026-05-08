-- Creación de BD
CREATE DATABASE tienda_online;
-- 2 Creación de la tabla usuario
CREATE TABLE Usuario(
    id_usuario SERIAL PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL, 
    direccion TEXT
);
-- 3 Creación de la tabla Productos 
CREATE TABLE Productos(
    id_Productos  SERIAL PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    precio DECIMAL(10, 2) NOT NULL,
    stock INTEGER NOT NULL
);
-- 4 Creación de la tabla Pedido
CREATE TABLE Pedido(
    id_Pedido SERIAL PRIMARY KEY, 
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    estado VARCHAR(50) CHECK (estado IN ('pendiente', 'enviado', 'entregado')),
    id_usuario INTEGER NOT NULL, 
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
-- 5. Creación de la tabla intermedia (Detalle del Pedido)
CREATE TABLE Pedido_Contiene (
    id_Pedido INTEGER NOT NULL,
    id_Productos INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10, 2) NOT NULL, -- Histórico del precio al momento de compra
    PRIMARY KEY (id_Pedido, id_Productos),
    CONSTRAINT fk_pedido FOREIGN KEY (id_Pedido) REFERENCES Pedido(id_Pedido),
    CONSTRAINT fk_producto FOREIGN KEY (id_Productos) REFERENCES Productos(id_Productos)
);

SELECT 
    u.nombre AS cliente, 
    p.id_Pedido, 
    prod.nombre AS producto, 
    pc.cantidad,
    (pc.cantidad * pc.precio_unitario) AS subtotal
FROM Usuario u
JOIN Pedido p ON u.id_usuario = p.id_usuario
JOIN Pedido_Contiene pc ON p.id_Pedido = pc.id_Pedido
JOIN Productos prod ON pc.id_Productos = prod.id_Productos;
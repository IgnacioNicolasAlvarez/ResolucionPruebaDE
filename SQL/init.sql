CREATE DATABASE exercises_db;

\c exercises_db;

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_carga DATE
);

INSERT INTO
    productos (nombre, fecha_carga)
VALUES
    ('Producto A', '2022-01-01'),
    ('Producto B', '2022-01-02'),
    ('Producto C', '2022-01-03'),
    ('Producto D', '2022-01-04'),
    ('Producto E', '2022-01-05'),
    ('Producto F', '2022-01-06'),
    ('Producto G', '2022-01-07'),
    ('Producto H', '2022-01-08'),
    ('Producto I', '2022-01-09'),
    ('Producto J', '2022-01-10'),
    ('Producto default', '2022-01-12');

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    genero VARCHAR(10)
);

INSERT INTO
    clientes (nombre, genero)
VALUES
    ('Cliente 1', 'Femenino'),
    ('Cliente 2', 'Masculino'),
    ('Cliente 3', 'Femenino'),
    ('Cliente 4', 'Masculino'),
    ('Cliente 5', 'Femenino'),
    ('Cliente 6', 'Masculino'),
    ('Cliente 7', 'Femenino'),
    ('Cliente 8', 'Masculino'),
    ('Cliente 9', 'Femenino'),
    ('Cliente 10', 'Masculino'),
    ('Cliente default', 'Masculino');

CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    cliente_id INT,
    producto_id INT,
    cantidad INT,
    monto DECIMAL(10, 2),
    fecha_hora_venta TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

INSERT INTO
    ventas (
        cliente_id,
        producto_id,
        cantidad,
        monto,
        fecha_hora_venta
    )
VALUES
    (
        1,
        1,
        3,
        150.00,
        '2022-01-01 10:00:00'
    ),
    (
        2,
        2,
        2,
        100.00,
        '2022-01-02 11:30:00'
    ),
    (
        3,
        3,
        1,
        50.00,
        '2022-01-03 09:45:00'
    ),
    (
        4,
        4,
        5,
        250.00,
        '2022-01-04 14:20:00'
    ),
    (
        5,
        5,
        2,
        100.00,
        '2022-01-05 16:10:00'
    ),
    (
        6,
        6,
        4,
        200.00,
        '2022-01-06 12:15:00'
    ),
    (
        7,
        7,
        3,
        150.00,
        '2022-01-07 10:30:00'
    ),
    (
        8,
        8,
        2,
        100.00,
        '2022-01-08 13:45:00'
    ),
    (
        9,
        9,
        1,
        50.00,
        '2022-01-09 15:20:00'
    ),
    (
        10,
        10,
        5,
        250.00,
        '2022-01-10 11:00:00'
    );
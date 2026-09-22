IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDealDB')
BEGIN
    CREATE DATABASE AutoDealDB;
END;
GO

USE AutoDealDB
GO

CREATE TABLE Marca (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    pais_origen VARCHAR(60),

    CONSTRAINT uq_marca_nombre UNIQUE (nombre)
);


CREATE TABLE Modelos (
    id_modelo INT IDENTITY(1,1) PRIMARY KEY,
    id_marca INT NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    tipo_vehiculo VARCHAR(20) NOT NULL,

    CONSTRAINT fk_modelo_marca
        FOREIGN KEY (id_marca)
        REFERENCES Marca(id_marca)
        ON UPDATE CASCADE,

    CONSTRAINT uq_modelo_marca_nombre
        UNIQUE (id_marca, nombre),

    -- CHECK 1
    CONSTRAINT chk_modelo_tipo_vehiculo
        CHECK (
            tipo_vehiculo IN (
                'Sedan',
                'SUV',
                'Pickup',
                'Hatchback',
                'Coupe',
                'Van',
                'Convertible'
            )
        )
);


CREATE TABLE Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    telefono VARCHAR(25) NOT NULL,
    correo VARCHAR(120),
    fecha_registro DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT uq_cliente_telefono UNIQUE (telefono),
    CONSTRAINT uq_cliente_correo UNIQUE (correo),

    -- CHECK 2
    CONSTRAINT chk_cliente_correo
        CHECK (
            correo IS NULL
            OR correo LIKE '%_@_%._%'
        )
);

CREATE TABLE Vehiculos (
    id_vehiculo INT IDENTITY(1,1) PRIMARY KEY,
    id_modelo INT NOT NULL,
    vin CHAR(17) NOT NULL,
    anio SMALLINT NOT NULL,
    color VARCHAR(40) NOT NULL,
    kilometraje INT NOT NULL DEFAULT 0,
    precio DECIMAL(12,2) NOT NULL,
    condicion VARCHAR(10) NOT NULL,
    estado VARCHAR(15) NOT NULL DEFAULT 'Disponible',

    CONSTRAINT fk_vehiculo_modelo
        FOREIGN KEY (id_modelo)
        REFERENCES Modelos(id_modelo)
        ON UPDATE CASCADE,

    CONSTRAINT uq_vehiculo_vin UNIQUE (vin),

    -- CHECK 3
    CONSTRAINT chk_vehiculo_anio
        CHECK (anio BETWEEN 1900 AND 2030),

    -- CHECK 4
    CONSTRAINT chk_vehiculo_kilometraje
        CHECK (kilometraje >= 0),

    -- CHECK 5
    CONSTRAINT chk_vehiculo_precio
        CHECK (precio > 0),

    -- CHECK 6
    CONSTRAINT chk_vehiculo_condicion
        CHECK (condicion IN ('Nuevo', 'Usado')),

    -- CHECK 7
    CONSTRAINT chk_vehiculo_estado
        CHECK (estado IN ('Disponible', 'Reservado', 'Vendido'))
);


CREATE TABLE Cotizaciones (
    id_cotizacion INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_cotizacion DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    precio_cotizado DECIMAL(12,2) NOT NULL,
    vigencia_hasta DATE NOT NULL,
    estado VARCHAR(15) NOT NULL DEFAULT 'Pendiente',
    observaciones VARCHAR(500),

    -- Relación con Cliente
    CONSTRAINT fk_cotizacion_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente),

    -- Relación con Vehiculos
    CONSTRAINT fk_cotizacion_vehiculo
        FOREIGN KEY (id_vehiculo)
        REFERENCES Vehiculos(id_vehiculo),

    -- Validaciones (CHECKs)
    CONSTRAINT chk_cotizacion_precio
        CHECK (precio_cotizado > 0),

    CONSTRAINT chk_cotizacion_vigencia
        CHECK (vigencia_hasta >= fecha_cotizacion),

    CONSTRAINT chk_cotizacion_estado
        CHECK (estado IN ('Pendiente', 'Aceptada', 'Rechazada', 'Vencida'))
);
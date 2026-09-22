INSERT INTO Cotizaciones (
    id_cliente,
    id_vehiculo,
    fecha_cotizacion,
    precio_cotizado,
    vigencia_hasta,
    estado,
    observaciones
) VALUES
-- Ana cotiza un Corolla usado
(1, 1, '2026-09-10', 20490.00, '2026-09-20', 'Pendiente',
 'Cliente interesada en financiamiento a 60 meses.'),

-- Carlos reserva una Toyota RAV4 usada
(2, 3, '2026-09-12', 28900.00, '2026-09-22', 'Aceptada',
 'Pendiente de aprobación final del crédito.'),

-- Sofía compra una Honda CR-V usada
(3, 8, '2026-09-01', 27950.00, '2026-09-10', 'Aceptada',
 'Operación cerrada con pago inicial y financiamiento.'),

-- Diego cotiza una Ford F-150
(4, 9, '2026-09-14', 41900.00, '2026-09-24', 'Pendiente',
 'Solicitó incluir paquete de garantía extendida.'),

-- Valentina consulta por una Nissan Sentra
(5, 13, '2026-08-25', 18500.00, '2026-09-04', 'Vencida',
 'No hubo respuesta posterior del cliente.'),

-- Miguel cotiza una Mazda CX-5
(6, 16, '2026-09-08', 27250.00, '2026-09-18', 'Rechazada',
 'Cliente eligió un vehículo de otra categoría.'),

-- Laura cotiza un Honda Civic nuevo
(7, 7, '2026-09-16', 28490.00, '2026-09-26', 'Pendiente',
 'Interesada en entrega inmediata y seguro incluido.'),

-- Javier reserva una Chevrolet Silverado
(8, 12, '2026-09-17', 44000.00, '2026-09-27', 'Aceptada',
 'Reserva realizada; pendiente de entrega.');
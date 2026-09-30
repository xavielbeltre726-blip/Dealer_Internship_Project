SELECT
    'Vehiculos' AS tabla,
    id_vehiculo AS id_registro,
    'Precio o kilometraje inválido' AS problema
FROM Vehiculos
WHERE precio <= 0
   OR kilometraje < 0

UNION ALL

SELECT
    'Cotizaciones',
    id_cotizacion,
    'Precio o vigencia inválidos'
FROM Cotizaciones
WHERE precio_cotizado <= 0
   OR vigencia_hasta < fecha_cotizacion;





   SELECT
    id_vehiculo,
    vin,
    CHAR_LENGTH(vin) AS longitud
FROM Vehiculos
WHERE CHAR_LENGTH(vin) <> 17;
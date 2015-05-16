-- Antes de eliminar una Cotizacion 
-- Activo Trigger Por Evento
-- Guarda Datos en Tabla Bitacora ( Registro Cambios)
--Si EL estado es 'EMITIDA'

Create or Replace  TRIGGER cot_del 
BEFORE DELETE ON Cotizacion
FOR EACH ROW
DECLARE x INT;
  
BEGIN
  
  IF :old.Estado = 'EMITIDA' THEN
  
  insert into Bitacora values (:old.codigo,
                              :old.fecha,
                              :old.codigoCliente,
                              :old.codigoVendedor,
                              :old.condicionesPago,
                              :old.condicionesEntrega,
                              :old.vigencia,
                              :old.observaciones,
                              :old.listaPrecios,
                              :old.moneda ,
                              :old.estado,
                               :old.totalCotizacion
                              );
 
    END IF;
END;
 
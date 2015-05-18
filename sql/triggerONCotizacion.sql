-- Antes de eliminar una Cotizacion 
-- Activo Trigger Por Evento
-- Guarda Datos en Tabla Bitacora ( Registro Cambios)
--Si EL estado es 'EMITIDA'

Create or Replace  TRIGGER cot_del 
BEFORE DELETE ON Cotizaciones_obj
FOR EACH ROW

  
BEGIN
  
  IF :old.Estado = 'EMITIDA' THEN
  
  -- Inserta EN BITACORA LOS ATRIBUTOS DE LA COTIZACION A BORRAR
  insert into BCotizaciones_OBJ values (:old.codigo,
                              :old.fecha,
                              :old.condicionesPago,
                              :old.condicionesEntrega,
                              :old.vigencia,
                              :old.observaciones,
                              :old.listaPrecios,
                              :old.moneda ,
                              :old.estado,
                              :old.codigoCliente,
                              :old.codigoUsuario,
                              T_BARTCOTIZADO_LISTA()
                              );
                              
  --RECORRER LA LISTA HE INSERTAR EN LA SUBLISTA DE BITACORA DE COTIZACION
  

DECLARE  V_CODIGO VARCHAR2(25); V_CANTIDAD NUMBER(5); V_TOTAL FLOAT (2) ;
  
 
CURSOR C_PROD  IS 

select deref(column_value).codigoarticulo as cod,  deref(column_value).cantidad as cant , deref(column_value).preciocotizado as precioTotal 
      from ( TABLE ( select lista_art_cotizados from cotizaciones_obj where codigo = :old.codigo) cotizaciones);
  
BEGIN 

  OPEN C_PROD ;

  LOOP
    FETCH C_PROD INTO V_CODIGO,V_CANTIDAD,V_TOTAL ;
          EXIT WHEN C_PROD%NOTFOUND ;
          --------------------------------Inserta linea en Bitacora Articulos Cotizados--------------------------------------
         Insert_Art_BCotizado_List (V_CODIGO,:old.codigo,V_Cantidad);
          
          ----------------------------------------------------------------------
          
  END LOOP ;
  CLOSE C_PROD ;/*<--- CERRAMOR EL CURSOR*/    
  EXCEPTION 
    WHEN OTHERS 
      THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ;
                              
    
 
    END IF;
END;
 

create or replace TRIGGER TRIG_ONINSERT_FACTCOMPRA
BEFORE INSERT ON FacturaCompra_Obj FOR EACH ROW

DECLARE art_id     VARCHAR(25);
DECLARE art_new_id VARCHAR(25);

BEGIN

  --Busco si existe el articulo y asigno en variable
  SELECT codigo INTO art_id  FROM Articulos_Obj  WHERE nombre = :new.nombre ;
      
    IF art_id IS NOT NULL THEN
    
    UPDATE Articulos_obj SET Precio = :new.Precio WHERE codigoArticulo = :new.codigoArticulo;
    
    END IF;
 
    Exception when no_data_found then

    --Auto Incremente con Sequence
    SELECT fact_seq.NEXTVAL
    INTO   :new.numeroFactura
    FROM   dual;
  
    --Asigno fecha actual para la compraFactura
    SELECT TO_CHAR (SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" 
    INTO   :new.fechaCompra
    FROM   dual;
   --Asigno codigo random
    SELECT dbms_random.string('U', 10) str  INTO  art_new_id FROM   dual;
  
 
  INSERT INTO Articulos_OBJ
        Values (
        art_new_id, 
        :new.nombre,
        :new.marca, 
        :new.modelo,
        :new.cantMinima,
        :new.cantMaxima,
        :new.precio,
        :new.fechaCompra,
        :new.fechaCompra,
        
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'Default'),
        T_Componente_lista(),
        
        (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = :new.usuario),
        T_Componente_lista(),
        
        (SELECT REF(f) FROM UnidadMedida_OBJ f WHERE f.codigo = :new.unidad),
        T_Componente_lista(),
        
        )
  
  END;   
 
 
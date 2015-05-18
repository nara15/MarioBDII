create or replace 
TRIGGER TRIG_ONINSERT_FACTCOMPRA
BEFORE INSERT ON FacturaCompra_Obj FOR EACH ROW

DECLARE art_id     VARCHAR(25);
        art_new_id VARCHAR(25);
        codigoUsuario VARCHAR(20);

BEGIN

  --Busco si existe el articulo y asigno en variable
  SELECT codigo INTO art_id  FROM Articulos_Obj  WHERE nombre = :new.nombre ;
      
    IF art_id IS NOT NULL THEN
    
    UPDATE Articulos_obj SET Precio = :new.Precio WHERE codigo = :new.codigo;
    
    END IF;
 
    Exception when no_data_found then

    --Auto Incremente con Sequence
    SELECT fact_seq.NEXTVAL
    INTO   :new.codigo
    FROM   dual;
  
    --Asigno fecha actual para la compraFactura
    SELECT SYSDATE
    INTO   :new.fechaRegistro
    FROM   dual;
    
   --Asigno codigo random
    SELECT dbms_random.string('U', 10) str  INTO  art_new_id FROM   dual;
    
    --Extraigo el código de la referencia del usuario
    SELECT DEREF(:new.usuario).codigo INTO codigoUsuario FROM DUAL;
    
  INSERT INTO Articulos_OBJ VALUES (
              art_new_id, 
              :new.nombre,
              :new.marca, 
              :new.modelo,
              :new.cantMin,
              :new.cantMax,
              :new.precio,
              :new.fecharegistro,
              :new.fecharegistro,
              (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = codigoUsuario) ,
              (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'Default'),
              (SELECT REF(f) FROM UnidadMedidad_OBJ f WHERE f.codigo = 'PE'),
              T_Componente_lista()
              
            );
  
  END;
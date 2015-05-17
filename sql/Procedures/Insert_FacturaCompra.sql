-- Procedure para insertar FacturasCompra

create or replace Procedure Insert_FacturaCompra
   ( nombreArt IN varchar2 , marcaArt IN varchar2,modelo IN varchar2,cantMin IN NUMBER,cantMax IN NUMBER,precio IN FLOAT,
     proveedorID IN varchar2,usuarioID IN varchar2,unidadCod IN varchar2
   )
   
IS
 
BEGIN

   INSERT INTO facturaCompra_obj values ('',nombreArt,marcaArt,modelo,cantMin,cantMax,precio,'',

 (SELECT REF(f) FROM Proveedores_OBJ f WHERE f.codigo = proveedorID)
,(SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = usuarioID)
,(SELECT REF(f) FROM UnidadMedidad_OBJ f WHERE f.codigo = unidadCod));


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Factura Compra- '||SQLCODE||' -ERROR- '||SQLERRM);
END;
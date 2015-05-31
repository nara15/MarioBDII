
  --Crear View Factura Compra
  
  CREATE OR REPLACE VIEW facturacompra_view OF t_facturacompra WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.nombre, f.marca,f.modelo,to_number(f.cantmin),to_number(cantmax)
               ,to_number(precio),NULL,
  
  (SELECT REF(f) FROM Proveedores_OBJ f WHERE f.codigo = f.proveedor),
  (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = f.usuario),
  (SELECT REF(f) FROM unidadmedidad_OBJ f WHERE f.codigo = f.unidad)
  FROM facturacompra f;
  
  
  ALTER TABLE facturacompra
  MODIFY fecharegistro varchar(50);
  
  select * from articulo;
  select * from facturacompra_view;
  
  insert into facturacompra values ('F1','MiP','Marca','Model','1','20','5000','','1234','1234','PE');
  insert into facturacompra values ('','MiP','Marca','Model','1','20','5000','','1234','1234','PE');

 select * from unidadmedida

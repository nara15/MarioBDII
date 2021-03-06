
--VISTAS////////////////////////////////////////////////////////////////////////
  -- Crear view de Clientes
  CREATE OR REPLACE VIEW clientes_view OF t_clientes WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.nombre, f.nombrecliente, (SELECT REF(f) FROM Info_OBJ f WHERE f.codigo = f.infocliente)
  FROM clientes f;

  
  SELECT * FROM CLIENTES_VIEW;
  
  
CREATE OR REPLACE VIEW familias_view OF t_familia WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.codigoindice, f.codigo
  FROM Familia f;
  
  Select * from familias_view;
--///////////////////////////////////////////////////////
CREATE OR REPLACE VIEW articulos_view OF t_articulo WITH OBJECT IDENTIFIER (codigo)
AS
  SELECT ar.codigo, ar.nombre, ar.marca, ar.modelo, ar.cantminima,
          ar.cantmaxima, ar.precio, ar.fechaactuprecio, ar.fecharegistro,
          (select ref(f) from familias_view f where f.codigo = ar.codigofamilia_fk)as ref_familia,
          CAST ( MULTISET( --Selecciona la lista de componentes para el articulo
                      select MAKE_REF(componentes_view, co.componente_fk)
                      from componentesxarticulo co
                      where co.articulo_fk = ar.codigo)
                      as t_componente_lista) as componentes
               
  FROM Articulo ar;

select * from articulo;
-------------------------------------------------------------------------------- 
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  select co.id_componente, MAKE_REF(articulos_view, co.articulo_fk)
  from componentes co;
  
-------------------------------------------------------------------------------



--VISTAS////////////////////////////////////////////////////////////////////////


CREATE TABLE Cotizaciones (
         codigo      VARCHAR2(25) NOT NULL ,
         fecha      VARCHAR2(25) NOT NULL ,
         
         condicionesPago      VARCHAR2(55) NOT NULL ,
         condicionesEntrega      VARCHAR2(55) NOT NULL ,
         vigencia      VARCHAR2(25) NOT NULL ,
         observaciones      VARCHAR2(55) NOT NULL ,
         listaPrecios      VARCHAR2(25) NOT NULL ,
         moneda      VARCHAR2(25) NOT NULL ,
         estado      VARCHAR2(25) NOT NULL ,
         codigoCliente      VARCHAR2(25) NOT NULL CONSTRAINT cotizaciom_cliente_fk REFERENCES Clientes
                     (codigo) ON delete Cascade,
         codigoVendedor      VARCHAR2(25) NOT NULL CONSTRAINT cotizacion_usuario_fk REFERENCES Usuarios
                     (cedula) ON delete Cascade 
         
        )
         
         
   TABLESPACE proyecto
   STORAGE ( INITIAL 50K);


CREATE OR REPLACE VIEW cotizaciones_view OF t_cotizaciones WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.fecha, f.condicionespago, f.condicionesEntrega,
  f.vigencia , f.observaciones , f.listaprecios, f.moneda , f.estado, (SELECT REF(f) FROM Clientes_OBJ f WHERE f.codigo = f.codigocliente),
  (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigovendedor = f.codigovendedor)
  FROM Cotizaciones f;
  
--------------------------------------------------------------------------------
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  SELECT id_componente, null
  FROM Componentes;
  
  
  
  
-------------------------------------------------------------------------------- 
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
               
  FROM Articulos ar;

-------------------------------------------------------------------------------- 
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  select co.id_componente, MAKE_REF(articulos_view, co.articulo_fk)
  from componentes co;

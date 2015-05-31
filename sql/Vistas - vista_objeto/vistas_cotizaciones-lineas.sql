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
CREATE OR REPLACE VIEW cotizaciones_view OF t_cotizacion WITH OBJECT IDENTIFIER (componente_id)
AS
  SELECT id_cotizacion, null
  FROM Cotizacion;
  
  
  
  
-------------------------------------------------------------------------------- 
CREATE OR REPLACE VIEW articulosCotizados_view OF t_articulosCotizados WITH OBJECT IDENTIFIER (codigo)
AS
  SELECT ar.codigo, ar.nombre, ar.marca, ar.modelo, ar.cantminima,
          ar.cantmaxima, ar.precio, ar.fechaactuprecio, ar.fecharegistro,
          (select ref(f) from articulosCotizados_view f where f.codigo = ar.codigo_fk)as ref_cotizados,
          CAST ( MULTISET( --Selecciona la lista de componentes para el articulo
                      select MAKE_REF(cotiza_view, co.artCotizado_fk)
                      from componentesxarticulo co
                      where co.articulo_fk = ar.codigo)
                      as t_cotiza_lista) as articulosCotizados
               
  FROM ArticulosCotizados ar;
-- Select * from Articulos_OBJ ;
-------------------------------------------------------------------------------- 


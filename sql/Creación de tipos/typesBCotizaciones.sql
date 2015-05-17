

-- Creación del Tipo T_Cotizaciones
CREATE OR REPLACE TYPE T_Bitacora_Cotizaciones AS OBJECT
  (
         codigo              VARCHAR2(25) ,
         fecha               DATE ,
         condicionesPago     VARCHAR2(55) ,
         condicionesEntrega  VARCHAR2(55) ,
         vigencia            VARCHAR2(25)  ,
         observaciones       VARCHAR2(55) ,
         listaPrecios        VARCHAR2(25)  ,
         moneda              VARCHAR2(25) ,
         estado              VARCHAR2(25) ,
         codigoCliente       ref T_Clientes,
         codigoUsuario       ref T_Usuarios,
         lista_bit_cotizados  T_ArtCotizado_Lista,
   
    CONSTRUCTOR FUNCTION T_Bitacora_Cotizaciones(
    
         pCodigo              IN VARCHAR2,
         pFecha               IN VARCHAR2 ,
         pCondicionesPago      IN VARCHAR2,
         pCondicionesEntrega   IN VARCHAR2 ,
         pVigencia            IN VARCHAR2 ,
         pObservaciones        IN VARCHAR2 ,
         pListaPrecios         IN VARCHAR2,
         pMoneda               IN VARCHAR2 ,
         pEstado               IN VARCHAR2 
         
        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
      
--/////////////////////////////////////////////////////////////////////////////
-- Crea Tabla Cotizaciones_OBJ
CREATE TABLE BCotizaciones_OBJ OF T_Bitacora_Cotizaciones
  (
         codigo              NOT NULL ,
         fecha               NOT NULL ,
         condicionesPago     NOT NULL ,
         condicionesEntrega  NOT NULL ,
         vigencia            NOT NULL ,
         observaciones       NOT NULL ,
         listaPrecios        NOT NULL ,
         moneda              NOT NULL ,
         estado              NOT NULL ,
        
       CONSTRAINT BCotizaciones_PK PRIMARY KEY ( codigo ),
       CONSTRAINT BCotizacion_Cliente_FK FOREIGN KEY (codigoCliente) REFERENCES Clientes_OBJ,
       CONSTRAINT BCotizacion_Usuario_FK FOREIGN KEY (codigoUsuario) REFERENCES Usuarios_OBJ
   
  ) NESTED TABLE lista_bit_cotizados STORE AS LBArtCotizadosNTAB;
  
  
  
--___________________________________________________________________________________________
  
 -- Crea Type Articulos Cotizados 
CREATE OR REPLACE TYPE T_Bitacora_ArticulosCotizados AS OBJECT
  (
    codigo              VARCHAR2 (20 CHAR) ,
    codigoArticulo      VARCHAR2 (50 CHAR) ,
    cantidad            NUMBER (5) ,
    precioCotizado      FLOAT ,
   
    CONSTRUCTOR FUNCTION T_Bitacora_ArticulosCotizados(
    
        pCodigo             IN VARCHAR2 ,
        codigoArticulo      IN VARCHAR2 ,
        cantidad            IN NUMBER ,
        precioCotizado      IN FLOAT

        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
      
      --////////////////////////////////////
      
      CREATE TABLE BArticulosCotizados_OBJ OF T_ArticulosCotizados
  (
      codigo              NOT NULL ,
    codigoArticulo      NOT NULL ,
    cantidad            NOT NULL ,
    precioCotizado      NOT NULL ,
    CONSTRAINT BArtCotizados_Cotizacion_FK FOREIGN KEY ( codigo ) REFERENCES BCotizaciones_OBJ
  ) ;

--/////////////////////////////////////////////////////////////////////////////
--Drop table Info_Obj

CREATE OR REPLACE TYPE T_BArtCotizado_Lista
IS
  TABLE OF REF T_Bitacora_ArticulosCotizados ;


 
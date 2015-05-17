

-- Creación del Tipo T_Cotizaciones
CREATE OR REPLACE TYPE T_Cotizaciones AS OBJECT
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
         lista_art_cotizados  T_ArtCotizado_Lista,
   
    CONSTRUCTOR FUNCTION T_Cotizaciones(
    
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
CREATE TABLE Cotizaciones_OBJ OF T_Cotizaciones
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
        
       CONSTRAINT Cotizaciones_PK PRIMARY KEY ( codigo ),
       CONSTRAINT Cotizacion_Cliente_FK FOREIGN KEY (codigoCliente) REFERENCES Clientes_OBJ,
       CONSTRAINT Cotizacion_Usuario_FK FOREIGN KEY (codigoUsuario) REFERENCES Usuarios_OBJ
   
  ) NESTED TABLE lista_art_cotizados STORE AS LArtCotizadosNTAB;
  
  
  
--___________________________________________________________________________________________
  
 -- Crea Type Articulos Cotizados 
CREATE OR REPLACE TYPE T_ArticulosCotizados AS OBJECT
  (
    codigo              VARCHAR2 (20 CHAR) ,
    codigoArticulo      VARCHAR2 (50 CHAR) ,
    cantidad            NUMBER (5) ,
    precioCotizado      FLOAT ,
   
    CONSTRUCTOR FUNCTION T_ArticulosCotizados(
    
        pCodigo             IN VARCHAR2 ,
        codigoArticulo      IN VARCHAR2 ,
        cantidad            IN NUMBER ,
        precioCotizado      IN FLOAT

        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
--/////////////////////////////////////////////////////////////////////////////
--Drop table Info_Obj

CREATE OR REPLACE TYPE T_ArtCotizado_Lista
IS
  TABLE OF REF T_ArticulosCotizados ;


 
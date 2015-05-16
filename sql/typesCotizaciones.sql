--/////////////////////////////////////////////////////////////////////////////
-- Crea Tipo T_Cotizaciones
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
         codigoCliente       NOT NULL ,
         codigoUsuario       NOT NULL ,
         CONSTRAINT Info_PK PRIMARY KEY ( codigo )
   
  ) ;
  
--___________________________________________________________________________________________
  
  
CREATE OR REPLACE TYPE T_Info AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    correo     VARCHAR2 (50 CHAR) ,
    edad      NUMBER (5) ,
    fechaIngreso    DATE ,
   
    CONSTRUCTOR FUNCTION T_Info(
    
        pCodigo     IN VARCHAR2 ,
        pCorreo    IN VARCHAR2 ,
        pEdad     IN VARCHAR2 ,
        pFechaIngreso    IN DATE

        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
--/////////////////////////////////////////////////////////////////////////////
--Drop table Info_Obj
CREATE TABLE Info_OBJ OF T_Info
  (
    codigo  NOT NULL ,
    correo  NOT NULL ,
    edad    NOT NULL ,
    fechaIngreso  NOT NULL, 
    CONSTRAINT Info_PK PRIMARY KEY ( codigo )
   
  ) ;
-- creando tablas 
CREATE TABLE USUARIOS 
(
  CODIGO VARCHAR2(25 BYTE) NOT NULL 
, NOMBRE VARCHAR2(25 BYTE) NOT NULL 
, NOMBRE_USUARIO VARCHAR2(15 BYTE) NOT NULL 
, CONTRASEÑA VARCHAR2(15 BYTE) 
, INFOUSUARIO VARCHAR2(10 BYTE) 

, CONSTRAINT PK_USUARIOS PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "PROYECTO" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 57344 
  NEXT 106496 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
) ;
-------------------------------------------------------------------------------

CREATE TABLE CLIENTES 
(
  CODIGO VARCHAR2(25 BYTE) NOT NULL 
, NOMBRE VARCHAR2(25 BYTE) NOT NULL 
, NOMBRE_CLIENTE VARCHAR2(15 BYTE) NOT NULL 
, INFOCLIENTE VARCHAR2(10 BYTE) 

, CONSTRAINT PK_CLIENTES PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "PROYECTO" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 57344 
  NEXT 106496 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
) ;
-------------------------------------------------------------------------------
CREATE TABLE Cotizacion (
         codigo      VARCHAR2(25) NOT NULL Primary Key,
         fecha      VARCHAR2(25) NOT NULL , 
         condicionesPago      VARCHAR2(55) NOT NULL ,
         condicionesEntrega      VARCHAR2(55) NOT NULL ,
         vigencia      VARCHAR2(25) NOT NULL ,
         observaciones      VARCHAR2(55) NOT NULL ,
         listaPrecios      VARCHAR2(25) NOT NULL ,
         moneda      VARCHAR2(25) NOT NULL ,
         estado      VARCHAR2(25) NOT NULL ,
        
         codigoCliente      VARCHAR2(25) NOT NULL CONSTRAINT cotiza_cliente_fk REFERENCES Clientes
                     (CODIGO) ON delete Cascade,
         codigoVendedor      VARCHAR2(25) NOT NULL CONSTRAINT cotiza_usuario_fk REFERENCES Usuarios
                     (CODIGO) ON delete Cascade 
         
        )
         
         
   TABLESPACE proyecto
   STORAGE ( INITIAL 50K NEXT 250K);

-------------------------------------------------------------------------------
CREATE TABLE ArticulosCotizados (
         CODIGO      VARCHAR2(25) NOT NULL primary key,
         CODIGOARTICULO      VARCHAR2(25) NOT NULL,
         CANTIDAD      VARCHAR2(25) NOT NULL,
         PRECIOCOTIZADO    VARCHAR2(15) NOT NULL)
         
         
   TABLESPACE proyecto
   STORAGE ( INITIAL 50K);



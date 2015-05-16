--Script Creacion
-- Factura Compra, Unidades Medida
-- CLientes , Usuarios , Proveedores



-- UNIDAD MEDIDA

CREATE OR REPLACE TYPE T_UnidadMedida AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    descripcion     VARCHAR2 (50 CHAR) ,
   
   
    CONSTRUCTOR FUNCTION T_UnidadMedida(
    
        pCodigo     IN VARCHAR2 ,
        pDescripcion    IN VARCHAR2 
      )
      RETURN SELF
    AS
      RESULT ) FINAL ;

--Drop table Info_Obj
CREATE TABLE UnidadMedidad_OBJ OF T_UnidadMedida
  (
    codigo  NOT NULL ,
    descripcion  NOT NULL ,
   
    CONSTRAINT Unidad_PK PRIMARY KEY ( codigo )
   
  ) ;

--CREATE TYPE T_Info;

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

--Drop table Info_Obj
CREATE TABLE Info_OBJ OF T_Info
  (
    codigo  NOT NULL ,
    correo  NOT NULL ,
    edad    NOT NULL ,
    fechaIngreso  NOT NULL, 
    CONSTRAINT Info_PK PRIMARY KEY ( codigo )
   
  ) ;


--CREATE OR REPLACE TYPE T_Usuarios;

CREATE OR REPLACE TYPE T_Usuarios AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    nombreusuario      VARCHAR2 (20 CHAR) ,
    contraseña     VARCHAR2 (20) ,
    infoUsuario ref T_Info ,
   
   
    CONSTRUCTOR FUNCTION T_Usuarios(
    
        pCodigo     IN VARCHAR2 ,
        pNombre     IN VARCHAR2 ,
        pNombreUsuario     IN VARCHAR2 ,
        pContraseña    IN VARCHAR2 

        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
      

CREATE TABLE Usuarios_OBJ OF T_Usuarios
  (
    codigo NOT NULL,
    nombre NOT NULL ,
    nombreUsuario NOT NULL ,
    contraseña NOT NULL ,
    CONSTRAINT Usuarios_PK PRIMARY KEY ( codigo ),
    CONSTRAINT Usuarios_Info_FK FOREIGN KEY (infoUsuario) REFERENCES Info_OBJ
  ) ;

      
--CREATE OR REPLACE TYPE T_Clientes;

CREATE OR REPLACE TYPE T_Clientes AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    nombrecliente      VARCHAR2 (20 CHAR) ,
    infoCliente ref T_Info ,
   
   
    CONSTRUCTOR FUNCTION T_Clientes(
    
        pCodigo     IN VARCHAR2 ,
        pNombre     IN VARCHAR2 ,
        pNombreCliente     IN VARCHAR2 
       
        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
      
CREATE TABLE Clientes_OBJ OF T_Clientes
  (
    codigo NOT NULL ,
    nombre NOT NULL ,
    nombreCliente NOT NULL ,
    CONSTRAINT Clientes_PK PRIMARY KEY ( codigo ),
    CONSTRAINT Clientes_Info_FK FOREIGN KEY (infoCliente) REFERENCES Info_OBJ
  ) 
      


--CREATE OR REPLACE TYPE T_Proveedores;


CREATE OR REPLACE TYPE T_Proveedores AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    nombreproveedor      VARCHAR2 (20 CHAR) ,
    infoProveedor ref T_Info ,
   
   
    CONSTRUCTOR FUNCTION T_Proveedores(
    
        pCodigo     IN VARCHAR2 ,
        pNombre     IN VARCHAR2 ,
        pNombreProveedor    IN VARCHAR2 
       
        )
      RETURN SELF
    AS
      RESULT ) FINAL ;
      
CREATE TABLE Proveedores_OBJ OF T_Proveedores
  (
    codigo NOT NULL ,
    nombre NOT NULL ,
    nombreProveedor NOT NULL ,
    CONSTRAINT Proveedores_PK PRIMARY KEY ( codigo ),
    CONSTRAINT Proveedores_Info_FK FOREIGN KEY (infoProveedor) REFERENCES Info_OBJ
  ) 
      

  
--CREATE OR REPLACE TYPE T_FacturaCompra;

CREATE OR REPLACE TYPE T_FacturaCompra AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    marca      VARCHAR2 (20 CHAR) ,
    modelo     VARCHAR2 (20) ,
    cantMin NUMBER (3) ,
    cantMax NUMBER (5) ,
    precio FLOAT ,
    fechaRegistro   DATE ,
    proveedor ref T_Proveedores,
    usuario ref T_Usuarios,
    unidad ref T_UnidadMedida,
    
   
    CONSTRUCTOR FUNCTION T_FacturaCompra(
    
        pCodigo     IN VARCHAR2 ,
        pNombre     IN VARCHAR2 ,
        pMarca      IN VARCHAR2 ,
        pModelo     IN VARCHAR2 ,
        pCantMin    IN NUMBER ,
        pCantMax    IN NUMBER ,
        pPrecio     IN FLOAT ,
        fechaRegistro IN  DATE 
     
        )
      RETURN SELF
    AS
      RESULT ) FINAL ;

CREATE TABLE FacturaCompra_OBJ OF T_FacturaCompra
  (
    codigo NOT NULL,
    nombre NOT NULL ,
    marca NOT NULL ,
    modelo NOT NULL ,
    cantMin NOT NULL ,
    cantMax NOT NULL ,
    precio NOT NULL ,
    fechaRegistro NOT NULL ,
       
    CONSTRAINT facCompra_PK PRIMARY KEY ( codigo ),
    CONSTRAINT facCompra_userI_FK FOREIGN KEY (usuario) REFERENCES Usuarios_OBJ,
    CONSTRAINT facCompra_prove_FK FOREIGN KEY (proveedor) REFERENCES Proveedores_OBJ,
    CONSTRAINT facCompra_unidad_FK FOREIGN KEY (unidad) REFERENCES UnidadMedidad_OBJ
    
  ) ;

--CREATE OR REPLACE TYPE T_Cotizaciones;

--CREATE OR REPLACE TYPE T_ArticulosCotizados;

--CREATE OR REPLACE TYPE T_UnidadesMedida;





  

      
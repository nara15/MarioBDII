--Script Creacion
-- Factura Compra, Unidades Medida
-- CLientes , Usuarios , Proveedores




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


      







  

      
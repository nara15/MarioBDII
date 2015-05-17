--Creación del tipo T_Usuario
CREATE OR REPLACE TYPE T_Usuario AS OBJECT
  (
    codigo     VARCHAR2 (20) ,
    nombre     VARCHAR2 (50 CHAR) ,
    nbrUsuario VARCHAR2 (15 CHAR) ,
    pass       VARCHAR2 (20 CHAR) ,
    CONSTRUCTOR FUNCTION T_Usuario(
      pCodigo     IN VARCHAR2 ,
      pNombre     IN VARCHAR2 ,
      pNbrUsuario IN VARCHAR2 ,
      pPass       IN VARCHAR2 ) RETURN SELF AS RESULT 
  ) FINAL ;
  /
CREATE OR REPLACE TYPE BODY T_Usuario AS
  CONSTRUCTOR FUNCTION T_Usuario(
    pCodigo     IN VARCHAR2 ,
    pNombre     IN VARCHAR2 ,
    pNbrUsuario IN VARCHAR2 ,
    pPass       IN VARCHAR2 ) RETURN SELF AS RESULT
  AS
  BEGIN
    SELF.codigo := pCodigo;
    SELF.nombre := pNombre;
    SELF.nbrUsuario := pNbrUsuario;
    SELF.pass := pPass;
    RETURN;
  END;
END ;
/

--//////////////////////////////////////////////////////////////////////////////
--Creación de la tabla de usuarios
CREATE TABLE Usuarios_OBJ OF T_Usuario
  (
    codigo NOT NULL ,
    nombre NOT NULL ,
    nbrUsuario NOT NULL ,
    pass NOT NULL ,
    CONSTRAINT Usuario_OBJ_PK PRIMARY KEY ( codigo )
  ) ;
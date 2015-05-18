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
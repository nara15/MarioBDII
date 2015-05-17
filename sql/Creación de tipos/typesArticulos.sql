--Creación del tipo T_Articulos
create or replace TYPE T_Articulo AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (50 CHAR) ,
    marca      VARCHAR2 (20 CHAR) ,
    modelo     VARCHAR2 (20) ,
    cantMinima NUMBER (3) ,
    cantMaxima NUMBER (5) ,
    precio FLOAT ,
    fechaActuPrecio DATE ,
    fechaRegistro   DATE ,
    usuarioInserta REF T_Usuario ,
    ref_familia REF T_Familia ,
    ref_T_UnidadMedida REF T_UnidadMedida ,
    list_ref_T_Componente T_Componente_Lista ,
    
    CONSTRUCTOR FUNCTION T_Articulo(
      pCodigo     IN VARCHAR2 ,
      pNombre     IN VARCHAR2 ,
      pMarca      IN VARCHAR2 DEFAULT 'PD' ,
      pModelo     IN VARCHAR2 DEFAULT 'PD' ,
      pCantMin    IN NUMBER ,
      pCantMax    IN NUMBER ,
      pPrecio     IN FLOAT ,
      pCodFamilia IN VARCHAR2 )
    RETURN SELF AS RESULT ,
    MAP MEMBER FUNCTION precioMap RETURN FLOAT ) FINAL ;
/
create or replace TYPE BODY T_Articulo
AS
   MAP MEMBER FUNCTION precioMap RETURN FLOAT
	AS
	BEGIN
  		 RETURN precio;
	END;

	CONSTRUCTOR FUNCTION T_Articulo(
	    pCodigo     IN VARCHAR2 ,
	    pNombre     IN VARCHAR2 ,
	    pMarca      IN VARCHAR2 ,
	    pModelo     IN VARCHAR2 ,
	    pCantMin    IN NUMBER ,
	    pCantMax    IN NUMBER ,
	    pPrecio     IN FLOAT ,
	    pCodFamilia IN VARCHAR2 )
	  RETURN SELF AS RESULT AS
		BEGIN
			SELF.codigo := pCodigo;
			SELF.nombre := pNombre;
			SELF.marca := pMarca;
			SELF.modelo := pModelo;
			SELF.cantMinima := pCantMin;
			SELF.cantMaxima := pCantMax;
			SELF.precio := pPrecio;
			SELF.ref_familia := null;
		 	RETURN;
		END;
END ;
/

--//////////////////////////////////////////////////////////////////////////////
--Creación del tipo de datos T_Componente
CREATE OR REPLACE TYPE T_Componente AS OBJECT
  (
    Componente_ID NUMBER (3) ,
    ref_T_Articulo REF T_Articulo ,
    CONSTRUCTOR FUNCTION T_Componente(
      pCodArt IN VARCHAR2 ) RETURN SELF AS RESULT 
  ) FINAL ;
  /
CREATE OR REPLACE TYPE BODY T_Componente AS
  CONSTRUCTOR FUNCTION T_Componente(
    pCodArt IN VARCHAR2 )
  RETURN SELF AS RESULT
  AS
    BEGIN
      Componente_ID := pCodArt;
      RETURN;
    END;
END ;
/
--//////////////////////////////////////////////////////////////////////////////
--Tipo de dato: Tabla de referencias a componentes
CREATE OR REPLACE TYPE T_Componente_Lista
IS
  TABLE OF REF T_Componente ;
  /

--//////////////////////////////////////////////////////////////////////////////
--Creación de la tabla de articulos y componentes
CREATE TABLE Articulos_OBJ OF T_Articulo
  (
    codigo NOT NULL ,
    nombre NOT NULL ,
    cantMinima NOT NULL ,
    precio NOT NULL ,
    usuarioInserta NOT NULL ,
    ref_familia NOT NULL ,
    ref_T_UnidadMedida NOT NULL ,
    CONSTRAINT Articulos_PK PRIMARY KEY ( codigo )
  ) NESTED TABLE list_ref_T_Componente STORE AS Componentes_NTAB;

CREATE TABLE Componente_OBJ OF T_Componente
  (
    Componente_ID NOT NULL ,
    ref_T_Articulo NOT NULL ,
    CONSTRAINT Componente_PK PRIMARY KEY ( Componente_ID )
  ) ;
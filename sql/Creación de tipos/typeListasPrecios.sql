--Creación del tipo para las líneas de detalle de la lista de precios
CREATE OR REPLACE TYPE T_LineaLPArticulo AS OBJECT
  (
    lineaNo NUMBER (3) ,
    precio FLOAT ,
    ref_T_Articulo REF T_Articulo ) FINAL ;
  /

--//////////////////////////////////////////////////////////////////////////////
--Creación del tipo para contener la linea de detalles de la lista de precios
CREATE OR REPLACE TYPE T_LineaLPArticulo_NTab IS
    TABLE OF T_LineaLPArticulo ;
  /

--//////////////////////////////////////////////////////////////////////////////
--Creación del tipo ListaPrecio
CREATE OR REPLACE TYPE T_ListaPrecio AS OBJECT
  (
    ID_lp       NUMBER (3) ,
    nombre      VARCHAR2 (50 CHAR) ,
    descripcion VARCHAR2 (100 CHAR) ,
    porcGastAdmi FLOAT ,
    porcUtilidad FLOAT ,
    porcOtros FLOAT ,
    listaArticulos T_LineaLPArticulo_NTab ,
    CONSTRUCTOR FUNCTION T_ListaPrecio(
      pID           IN NUMBER ,
      pNombre       IN VARCHAR2 ,
      pDescripcion  IN VARCHAR2 ,
      pPorGastoAdmi IN FLOAT ,
      pPorUti       IN FLOAT ,
      pPorOtros     IN FLOAT ) RETURN SELF AS RESULT 
    ) FINAL ;
  /
  CREATE OR REPLACE TYPE BODY T_ListaPrecio AS
    CONSTRUCTOR FUNCTION T_ListaPrecio(
      pID           IN NUMBER ,
      pNombre       IN VARCHAR2 ,
      pDescripcion  IN VARCHAR2 ,
      pPorGastoAdmi IN FLOAT ,
      pPorUti       IN FLOAT ,
      pPorOtros     IN FLOAT )
    RETURN SELF AS RESULT AS
      SELF.ID_lp := pID;
      SELF.nombre := pNombre;
      SELF.descripcion := pDescripcion;
      SELF.porcGastosAdmi := pPorGastoAdmi;
      SELF.porcUtilidad := pPorUti;
      SELF.porcOtros := pPorOtros;
      RETURN;
  END ;
  /

--////////////////////////////////////////////////////////////////////////////// 
--Creación de la tabla de la lista de precios
CREATE TABLE ListaPrecios_OBJ OF T_ListaPrecio
  (
    ID_lp NOT NULL ,
    nombre NOT NULL ,
    descripcion NOT NULL ,
    porcGastAdmi NOT NULL ,
    porcUtilidad NOT NULL ,
    porcOtros NOT NULL ,
    CONSTRAINT ListaPrecios_PK PRIMARY KEY ( ID_lp )
  ) NESTED TABLE listaArticulos STORE AS LP_Detalles_NTAB;
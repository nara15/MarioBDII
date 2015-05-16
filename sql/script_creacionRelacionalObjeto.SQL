--DEFINICIÓN GENERAL DE LOS TIPOS
CREATE OR REPLACE TYPE T_Familia ;
/
CREATE OR REPLACE TYPE T_Articulo ;
/
CREATE OR REPLACE TYPE T_Componente ;
/
CREATE OR REPLACE TYPE T_ListaPrecio ;
/
CREATE OR REPLACE TYPE T_Cliente ;
/
CREATE OR REPLACE TYPE T_Moneda ;
/
CREATE OR REPLACE TYPE T_Usuario ;
/
CREATE OR REPLACE TYPE T_Proveedor ;
/

--CREACIÓN DE TIPOS DE RECOMPILACIÓN////////////////////////////////////////////
  --Estos son los tipos de datos para el manejo de colecciones: componentes de 
  --un artículo, lineas d facturas o cotizaciones

	--Tipo de dato: Tabla de referencias a componentes
CREATE OR REPLACE TYPE T_Componente_Lista
IS
  TABLE OF REF T_Componente ;
  /
  --Tipo de dato: tabla de referencias a las lineas de detalle de una lista de precios
  CREATE OR REPLACE TYPE T_LineaLPArticulo_NTab
IS
  TABLE OF T_LineaLPArticulo ;
  /

-- CREACIÓN DE TIPOS ///////////////////////////////////////////////////////////

	--Tipo de datos: Familia
CREATE OR REPLACE TYPE T_Familia AS OBJECT
  (
    codigo      VARCHAR2 (10 CHAR) ,
    descripcion VARCHAR2 (50 CHAR) ,
    porcCompraArt FLOAT ,
    CONSTRUCTOR
  FUNCTION T_Familia(
      pCodigo     IN VARCHAR2 ,
      pDescripcion IN VARCHAR2 ,
      pPorCompra  IN FLOAT DEFAULT 0 )
    RETURN SELF
  AS
    RESULT ) FINAL ;
  /

  	--Tipo de dato: Articulo
CREATE OR REPLACE TYPE T_Articulo AS OBJECT
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
    ref_T_Usuario REF T_Usuarios ,
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

 	-- Tipo de dato: Componente
CREATE OR REPLACE TYPE T_Componente AS OBJECT
  (
    Componente_ID NUMBER (3) ,
    ref_T_Articulo REF T_Articulo ,
    CONSTRUCTOR FUNCTION T_Componente(
      pCodArt IN VARCHAR2 )
    RETURN SELF AS RESULT 
  ) FINAL ;
  /
  
  --Tipo de dato: Moneda
  CREATE OR REPLACE TYPE T_Moneda AS OBJECT
  (
    ID_moneda NUMBER (3) ,
    nombre    VARCHAR2 (25 CHAR) ,
    CONSTRUCTOR FUNCTION T_Moneda(
      pIDMoneda IN NUMBER ,
      pNombre   IN VARCHAR2 )
    RETURN SELF
  AS
    RESULT ) FINAL ;
  /
  
  --Tipo de dato: Unidad de medida
  CREATE OR REPLACE TYPE T_UnidadMedida AS OBJECT
  (
    codigo VARCHAR2 (10) ,
    nombre VARCHAR2 (20) ) FINAL ;
  /
  
  --Tipo de dato: Tipo de cambio
  CREATE OR REPLACE TYPE T_TipoDeCambio AS OBJECT
  (
    TipoCambio_ID NUMBER (3) ,
    valorTipoCambio FLOAT ,
    fecha        DATE ,
    esProyectado NUMBER ,
    ref_T_Moneda1 REF T_Moneda ,
    ref_T_Moneda2 REF T_Moneda ,
    CONSTRUCTOR FUNCTION T_TipoDeCambio(
      ID           IN NUMBER ,
      pValor       IN FLOAT ,
      pFecha       IN DATE ,
      pEsProyectado IN NUMBER ,
      pMoneda1     IN VARCHAR2 ,
      pMoneda2     IN VARCHAR2 )
    RETURN SELF AS RESULT ,
    MAP MEMBER FUNCTION valorTCMap RETURN FLOAT
  ) FINAL ;
  /
  
  
  --Tipo de dato: Linea de detalle de una lista de precios
  CREATE OR REPLACE TYPE T_LineaLPArticulo AS OBJECT
  (
    lineaNo NUMBER (3) ,
    precio FLOAT ,
    ref_T_Articulo REF T_Articulo ) FINAL ;
  /
    
  --Tipo de dato: Lista de precios
  CREATE OR REPLACE TYPE T_ListaPrecio AS OBJECT
  (
    ID_lp       NUMBER (3) ,
    nombre      VARCHAR2 (50 CHAR) ,
    descripcion VARCHAR2 (100 CHAR) ,
    porcGastAdmi FLOAT ,
    porcUtilidad FLOAT ,
    porcOtros FLOAT ,
    T_LineaLPArticulo_tab T_LineaLPArticulo_NTab ,
    
    CONSTRUCTOR FUNCTION T_ListaPrecio(
      pID           IN NUMBER ,
      pNombre       IN VARCHAR2 ,
      pDescripcion  IN VARCHAR2 ,
      pPorGastoAdmi IN FLOAT ,
      pPorUti       IN FLOAT ,
      pPorOtros     IN FLOAT )
    RETURN SELF AS RESULT 
  ) FINAL ;
  /
  
  --Tipo de dato: Proyecciones
  CREATE OR REPLACE TYPE T_Proyeccion AS OBJECT
  (
    Proyeccion_ID    NUMBER (6) ,
    fecha            DATE ,
    fechaProyecccion DATE ,
    codArt           VARCHAR2 (20 CHAR) ,
    montoProyeccion FLOAT ,
    ref_T_Moneda REF T_Moneda ) FINAL ;
  /

-- CREACIÓN DEL CUERPO DE ALGUNOS TIPOS DEFINICIDOS/////////////////////////////

CREATE OR REPLACE TYPE BODY T_Articulo
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

CREATE OR REPLACE TYPE BODY T_Familia
AS
  CONSTRUCTOR FUNCTION T_Familia(
    pCodigo     IN VARCHAR2 ,
    pDescripcion IN VARCHAR2 ,
    pPorCompra  IN FLOAT DEFAULT 0 )
  RETURN SELF AS RESULT AS
	BEGIN
	  SELF.codigo := pCodigo;
	  SELF.descripcion := pDescripcion;
	  SELF.porcCompraArt := pPorCompra;
	  RETURN;
	END;
END ;
/

CREATE OR REPLACE TYPE BODY T_Componente
AS
  CONSTRUCTOR FUNCTION T_Componente(
    pCodArt IN VARCHAR2 )
  RETURN SELF AS RESULT AS
	BEGIN
	  --Vacio
	END;
END ;
/

CREATE OR REPLACE TYPE BODY T_Moneda
AS
  CONSTRUCTOR FUNCTION T_Moneda(
    pIDMoneda IN NUMBER ,
    pNombre   IN VARCHAR2 )
  RETURN SELF AS RESULT AS
  BEGIN
    SELF.ID_moneda := pIDMoneda;
    SELF.nombre := pNombre;
    RETURN;
  END;
END ;
/

CREATE OR REPLACE TYPE BODY T_TipoDeCambio
AS
  CONSTRUCTOR FUNCTION T_TipoDeCambio(
    ID           IN NUMBER ,
    pValor       IN FLOAT ,
    pFecha       IN DATE ,
    pEsProyectado IN NUMBER ,
    pMoneda1     IN VARCHAR2 ,
    pMoneda2     IN VARCHAR2 )
  RETURN SELF AS RESULT AS
  BEGIN
    SELF.TipoCambio_ID := ID;
    SELF.valorTipoCambio := pValor;
    SELF.fecha := pFecha;
    SELF.esProyectado := pEsProyectado;
    RETURN;
  END;
  MAP MEMBER FUNCTION valorTCMap RETURN FLOAT
  AS
  BEGIN
    RETURN SELF.valorTipoCambio;
  END;
END ;
/

CREATE OR REPLACE TYPE BODY T_ListaPrecio
AS
  CONSTRUCTOR FUNCTION T_ListaPrecio(
    pID           IN NUMBER ,
    pNombre       IN VARCHAR2 ,
    pDescripcion  IN VARCHAR2 ,
    pPorGastoAdmi IN FLOAT ,
    pPorUti       IN FLOAT ,
    pPorOtros     IN FLOAT )
  RETURN SELF AS RESULT
  AS
    SELF.ID_lp;
    SELF.nombre;
    SELF.descripcion;
    SELF.porcGastosAdmi;
    SELF.porcUtilidad;
    SELF.porcOtros;
    RETURN;
END ;
/


-- DEFINICIÓN DE TABLAS OBJETO//////////////////////////////////////////////////

	--Tabla: Familias
CREATE TABLE Familias_OBJ OF T_Familia
  (
    codigo NOT NULL ,
    descripcion NOT NULL ,
    CONSTRAINT Familias_PK PRIMARY KEY ( codigo )
  ) ;


	--Tabla: Articulos  
CREATE TABLE Articulos_OBJ OF T_Articulo
  (
    codigo NOT NULL ,
    nombre NOT NULL ,
    cantMinima NOT NULL ,
    precio NOT NULL ,
    ref_T_Usuario NOT NULL ,
    ref_familia NOT NULL ,
    ref_T_UnidadMedida NOT NULL ,
    CONSTRAINT Articulos_PK PRIMARY KEY ( codigo )
  ) NESTED TABLE list_ref_T_Componente STORE AS LComponentesNTAB;


  	--Tabla: Componentes
CREATE TABLE Componente_OBJ OF T_Componente
  (
    Componente_ID NOT NULL ,
    ref_T_Articulo NOT NULL ,
    CONSTRAINT Componenteobj_PK PRIMARY KEY ( Componente_ID )
  ) ;
ALTER TABLE Componente_OBJ ADD CONSTRAINT Componente_Articulo_FK FOREIGN KEY (ref_T_Articulo) REFERENCES Articulos_OBJ;

    --Tabla: Monedas
CREATE TABLE Monedas_OBJ OF T_Moneda
  (
    ID_moneda NOT NULL ,
    nombre NOT NULL ,
    CONSTRAINT Monedas_PK PRIMARY KEY ( ID_moneda )
  );
  
  --Tabla: Unidades de medida
 CREATE TABLE UnidadesMedida_OBJ OF T_UnidadMedida
  (
    codigo NOT NULL ,
    nombre NOT NULL
  ) ;
  
  --Tabla: Tipos de cambio de una moneda respecto a otra
  CREATE TABLE TiposDeCambio_OBJ OF T_TipoDeCambio
  (
    TipoCambio_ID NOT NULL ,
    valorTipoCambio NOT NULL ,
    fecha NOT NULL ,
    esProyectado NOT NULL ,
    ref_T_Moneda1 NOT NULL ,
    ref_T_Moneda2 NOT NULL ,
    CONSTRAINT TiposDeCambio_PK PRIMARY KEY ( TipoCambio_ID )
  ) ;
ALTER TABLE TiposDeCambio_OBJ ADD CONSTRAINT TiposDeCambio_Monedas_FK FOREIGN KEY ( ref_T_Moneda1 ) REFERENCES Monedas_OBJ ;
ALTER TABLE TiposDeCambio_OBJ ADD CONSTRAINT TiposDeCambio_Monedas_FKv1 FOREIGN KEY ( ref_T_Moneda2 ) REFERENCES Monedas_OBJ ;

  --Tabla: Lista de precios
  CREATE TABLE ListaPrecios_OBJ OF T_ListaPrecio
  (
    ID_lp NOT NULL ,
    nombre NOT NULL ,
    descripcion NOT NULL ,
    porcGastAdmi NOT NULL ,
    porcUtilidad NOT NULL ,
    porcOtros NOT NULL ,
    CONSTRAINT ListaPrecios_PK PRIMARY KEY ( ID_lp )
  ) NESTED TABLE T_LineaLPArticulo_tab STORE AS LDetallesLPNTAB;
  
  --Tabla: Proyecciones
  CREATE TABLE Proyecciones_OBJ OF T_Proyeccion
  (
    Proyeccion_ID NOT NULL ,
    fecha NOT NULL ,
    fechaProyecccion NOT NULL ,
    codArt NOT NULL ,
    montoProyeccion NOT NULL ,
    ref_T_Moneda NOT NULL ,
    CONSTRAINT Proyecciones_OBJ_PK PRIMARY KEY ( Proyeccion_ID )
  ) ;
--Tabla de familias
CREATE TABLE Familias
  (
    codigo VARCHAR(10 CHAR) ,
    descripcion VARCHAR(50 CHAR) ,
    porcCompra FLOAT(3),
    CONSTRAINT Familias_PK PRIMARY KEY ( codigo )
  ) ;
  
--Tabla de artículos
CREATE  TABLE Articulos
 (
  codigo VARCHAR2(20 CHAR),
  NOMBRE	VARCHAR2(50 CHAR),
  MARCA	VARCHAR2(20 CHAR),
  MODELO	VARCHAR2(20 BYTE),
  CANTMINIMA	NUMBER(3,0),
  CANTMAXIMA	NUMBER(5,0),
  PRECIO	FLOAT(3),
  FECHAACTUPRECIO	DATE,
  FECHAREGISTRO	DATE,
  CODIGOFAMILIA_FK VARCHAR (10 CHAR) REFERENCES FAMILIAS(codigo),
  CONSTRAINT Articulos_PK PRIMARY KEY(codigo)
 );

--Tabla de componentes
CREATE TABLE Componentes
(
  ID_componente NUMBER(3),
  ARTICULO_FK VARCHAR2(20 CHAR) REFERENCES ARTICULOS(codigo),
  CONSTRAINT ID_componente_PK PRIMARY KEY (ID_componente)
);

--Tabla de componentes por artículo
CREATE TABLE ComponentesXArticulo
(
  ID NUMBER(3),
  ARTICULO_FK VARCHAR(20 CHAR) REFERENCES ARTICULOS(codigo),
  COMPONENTE_FK NUMBER(3) REFERENCES Componentes(ID_componente),
  CONSTRAINT CXA_PK PRIMARY KEY(ID)
);

--TIPOS/////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE TYPE T_Familia AS OBJECT (
  codigo VARCHAR(10 CHAR) ,
  descripcion VARCHAR(50 CHAR) ,
  porcCompra FLOAT(3)
);

CREATE OR REPLACE TYPE T_Articulo ;
/
CREATE OR REPLACE TYPE T_Componente ;
/

CREATE OR REPLACE TYPE T_Componente AS OBJECT
  (
    Componente_ID NUMBER (3) ,
    ref_T_Articulo REF T_Articulo
   ) FINAL ;
  /

CREATE OR REPLACE TYPE T_Componente_Lista
IS
  TABLE OF REF T_Componente ;
  /
  
CREATE OR REPLACE TYPE T_Articulo AS OBJECT
  (
    codigo     VARCHAR2 (20 CHAR) ,
    nombre     VARCHAR2 (20 CHAR) ,
    marca      VARCHAR2 (20 CHAR) ,
    modelo     VARCHAR2 (20) ,
    cantMinima NUMBER (3) ,
    cantMaxima NUMBER (5) ,
    precio FLOAT ,
    fechaActuPrecio DATE ,
    fechaRegistro   DATE ,
    familia REF T_Familia ,
    list_ref_T_Componente T_Componente_Lista
   ) FINAL ;
/

--VISTAS////////////////////////////////////////////////////////////////////////

CREATE OR REPLACE VIEW familias_view OF t_familia WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.descripcion, f.porccompra
  FROM Familias f;
--------------------------------------------------------------------------------
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  SELECT id_componente, null
  FROM Componentes;
-------------------------------------------------------------------------------- 
CREATE OR REPLACE VIEW articulos_view OF t_articulo WITH OBJECT IDENTIFIER (codigo)
AS
  SELECT ar.codigo, ar.nombre, ar.marca, ar.modelo, ar.cantminima,
          ar.cantmaxima, ar.precio, ar.fechaactuprecio, ar.fecharegistro,
          (select ref(f) from familias_view f where f.codigo = ar.codigofamilia_fk)as ref_familia,
          CAST ( MULTISET( --Selecciona la lista de componentes para el articulo
                      select MAKE_REF(componentes_view, co.componente_fk)
                      from componentesxarticulo co
                      where co.articulo_fk = ar.codigo)
                      as t_componente_lista) as componentes
               
  FROM Articulos ar;

-------------------------------------------------------------------------------- 
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  select co.id_componente, MAKE_REF(articulos_view, co.articulo_fk)
  from componentes co;




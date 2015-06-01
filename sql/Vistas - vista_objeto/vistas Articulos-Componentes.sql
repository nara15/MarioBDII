--TABLAS RELACIONALES//////////////////////////////////////////////////////////////////////////

CREATE TABLE Familias
  (
    codigo VARCHAR(10 CHAR) ,
    descripcion VARCHAR(50 CHAR) ,
    porcCompra FLOAT(3),
    CONSTRAINT Familias_PK PRIMARY KEY ( codigo )
  ) ;
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
 
 INSERT INTO FAMILIAS VALUES ('TARJ','Tarjetas', 1);
 INSERT INTO FAMILIAS VALUES ('CPU','CPU bonito', 1);
 INSERT INTO ARTICULOS VALUES ('TM', 'Tarjeta madre', null, null, null, null, null, null,null,'TARJ');
 INSERT INTO ARTICULOS VALUES ('CPU2G', 'CPU super', null, null, null, null, null, null,null,'CPU');
COMMIT;

CREATE TABLE Componentes
(
  ID_componente NUMBER(3),
  ARTICULO_FK VARCHAR2(20 CHAR) REFERENCES ARTICULOS(codigo),
  CONSTRAINT ID_componente_PK PRIMARY KEY (ID_componente)
);

INSERT INTO Componentes VALUES (1, 'TM');
COMMIT;

CREATE TABLE ComponentesXArticulo
(
  ID NUMBER(3),
  ARTICULO_FK VARCHAR(20 CHAR) REFERENCES ARTICULOS(codigo),
  COMPONENTE_FK NUMBER(3) REFERENCES Componentes(ID_componente),
  CONSTRAINT CXA_PK PRIMARY KEY(ID)
);


--TIPOS ////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE TYPE T_Familia AS OBJECT (
  codigo VARCHAR(10 CHAR) ,
  descripcion VARCHAR(50 CHAR) ,
  porcCompra FLOAT(3)
);



CREATE OR REPLACE TYPE T_Articulo ;
/
CREATE OR REPLACE TYPE T_Componente ;
/

CREATE OR REPLACE TYPE T_Componente_Lista
IS
  TABLE OF REF T_Componente ;
  /

CREATE OR REPLACE TYPE T_Componente AS OBJECT
  (
    Componente_ID NUMBER (3) ,
    ref_T_Articulo REF T_Articulo
   ) FINAL ;
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





select ar.codigo, ar.nombre,
        CAST (MULTISET(
                select co.id_componente, ref(ar)
                from componentes co
                where ar.codigo = co.articulo_fk) AS T_COMPONENTE_LISTA
              ) 
from articulos ar;




  
  
  
CREATE OR REPLACE VIEW familias_view OF t_familia WITH OBJECT IDENTIFIER (codigo)
  AS SELECT f.codigo, f.descripcion, f.porccompra
  FROM Familias f;




--VISTA CIRCULAR!!!!!!!!!! 
CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  SELECT id_componente, null
  FROM Componentes;
  
CREATE OR REPLACE VIEW articulos_view OF t_articulo WITH OBJECT IDENTIFIER (codigo)
AS
  SELECT ar.codigo, ar.nombre, ar.marca, ar.modelo, ar.cantminima,
          ar.cantmaxima, ar.precio, ar.fechaactuprecio, ar.fecharegistro,
          (select ref(f) from familias_view f where f.codigo = ar.codigofamilia_fk)as ref_familia,
          CAST ( MULTISET(
                      select MAKE_REF(componentes_view, co.componente_fk)
                      from componentesxarticulo co
                      where co.articulo_fk = ar.codigo)
                      as t_componente_lista) as componentes
               
  FROM Articulos ar;
  

CREATE OR REPLACE VIEW componentes_view OF t_componente WITH OBJECT IDENTIFIER (componente_id)
AS
  select co.id_componente, MAKE_REF(articulos_view, co.articulo_fk)
  from componentes co;
  
  
select * from componentes_view;
select * from articulos_view;

select * from articulos;

update articulos_view
  set marca = 'Camway'
where codigo = 'TM';


--OBTIENE EL NOMBRE DE LOS COMPONENTES DE UN ARTICULO 
SELECT e.column_value.componente_id, deref(e.column_value.ref_T_Articulo).nombre
FROM TABLE(select list_ref_t_componente from articulos_view where codigo = 'CPU2G') e;

--OBTIENE EL NOMBRE DE LOS COMPONENTES
select deref(ref_t_articulo).nombre from componentes_view;


--DEFINICIÓN DEL PROCEDIMIENTO
CREATE PROCEDURE sp_listarComponente (pCodArticulo VARCHAR(20), pCursor OUT SYS_REFCURSOR)
IS
  BEGIN
    OPEN pCursor FOR
      SELECT e.column_value.componente_id, deref(e.column_value.ref_T_Articulo).nombre
      FROM TABLE(select list_ref_t_componente from articulos_view where codigo = pCodArticulo) e;
  END;

--CREACIÓN DE PROCEDIMIENTO/////////////////////////////////////////////////////
CREATE OR REPLACE PROCEDURE sp_insertarArticuloInView ( 
                            pCodigo IN VARCHAR2, pNombre IN VARCHAR2, pMarca IN VARCHAR2, pModelo IN VARCHAR2,
                            pCantMinima IN NUMBER, pCantMaxima IN NUMBER, pPrecio IN FLOAT,
                            pCodFamilia IN VARCHAR2
                            )
IS
  
  BEGIN
      INSERT INTO Articulos_view
      SELECT pCodigo, pNombre, pMarca, pModelo,
              pCantMinima, pCantMaxima, pPrecio, null, SYSDATE, 
              (SELECT REF(f) FROM Familias_view f WHERE f.codigo = pCodFamilia),
              NULL
      FROM DUAL;
  END;

--DEFINICIÓN DE TRIGGERS/////////////////////////////////////////////////////////
CREATE OR REPLACE TRIGGER insertarAticuloInView
INSTEAD OF INSERT ON Articulos_view
FOR EACH ROW
BEGIN
    INSERT INTO Articulos VALUES (:new.codigo, :new.nombre, :new.marca, :new.modelo, :new.cantMinima,
                                  :new.cantMaxima, :new.precio, :new.fechaactuprecio, :new.fecharegistro,
                                  (select deref(:new.familia).codigo from Dual));

END;












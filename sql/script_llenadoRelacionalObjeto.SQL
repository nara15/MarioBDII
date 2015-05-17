--SCRIPT DE LLENADO
--Ingreso de usuarios
INSERT INTO Usuarios_OBJ VALUES('ALL', 'Allan Rojas','allrojas', '123');
COMMIT;
--Ingreso de familias ************************************************************************************************************
INSERT INTO Familias_OBJ VALUES('Default', 'Instancia default', 0.01);
INSERT INTO Familias_OBJ VALUES('CPU', 'Unidades de procesamiento central', 0.2);
INSERT INTO Familias_OBJ VALUES('MEM', 'Memorias', 0.2);
INSERT INTO Familias_OBJ VALUES('CIRC', 'PLacas de circuitos', 0.1);
INSERT INTO Familias_OBJ VALUES('TARJ', 'Tarjetas', 0);
COMMIT;

--Inserción de artículos *********************************************************************************************************
INSERT INTO Articulos_OBJ
SELECT 'TM', 'Tarjeta Madre Asrock', 'Intel', NULL,
        1, 10, 26300, null, SYSDATE,
        (SELECT REF(u) FROM Usuarios_OBJ u WHERE u.codigo = 'ALL'),
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'),
        (SELECT REF(um) FROM UnidadMedidad_OBJ um WHERE um.codigo = 'UN'),
        NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'TGR5230-SL-1GD3-L', 'Tarjeta gráfica Radeon', 'ASUS', 'R5 230',
        1, 10, 10000, null, SYSDATE, 
        (SELECT REF(u) FROM Usuarios_OBJ u WHERE u.codigo = 'ALL'),
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'), 
        (SELECT REF(um) FROM UnidadMedidad_OBJ um WHERE um.codigo = 'UN'),
        NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'TS1', 'Tarjeta sonido', 'Genius', 'R5 230',
        1, 10, 9000, null, SYSDATE, 
        (SELECT REF(u) FROM Usuarios_OBJ u WHERE u.codigo = 'ALL'),
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'), 
        (SELECT REF(um) FROM UnidadMedidad_OBJ um WHERE um.codigo = 'UN'),
        NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'MEMRAM.2GB', 'Memoria RAM 2 GB', 'Kingston', null,
        1, 10, 12300, null, SYSDATE, 
        (SELECT REF(u) FROM Usuarios_OBJ u WHERE u.codigo = 'ALL'),
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'MEM'),
        (SELECT REF(um) FROM UnidadMedidad_OBJ um WHERE um.codigo = 'UN'),
        NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'SL02.8G08ME500SSD', 'CPU grant', 'Dell', '260s',
        1, 10, 800000, null, SYSDATE, 
         (SELECT REF(u) FROM Usuarios_OBJ u WHERE u.codigo = 'ALL'),
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'),
        (SELECT REF(um) FROM UnidadMedidad_OBJ um WHERE um.codigo = 'UN'),
        T_Componente_lista()
FROM DUAL;
COMMIT;

--Inserción (registro) de componentes*********************************************************************************************
INSERT INTO Componentes_OBJ --Se inserta el componente: tarjeta gráfica
SELECT 1, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TM')
FROM DUAL;

INSERT INTO Componentes_OBJ --Se inserta el componente: tarjeta madre
SELECT 2, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TGR5230-SL-1GD3-L')
FROM DUAL;

INSERT INTO Componentes_OBJ --Se inserta el componente: tarjeta de sonido
SELECT 3, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TS1')
FROM DUAL;

INSERT INTO Componentes_OBJ --Se inserta el componente: tarjeta de sonido
SELECT 4, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'MEMRAM.2GB')
FROM DUAL;
COMMIT;

--Relacionar los articulos con sus componentes************************************************************************************

/*
INSERT INTO TABLE (SELECT ar.list_ref_t_componente 
                    FROM Articulos_OBJ ar
                    WHERE ar.codigo = 'SL02.8G08ME500SSD')
SELECT REF(co) FROM Componentes_obj co;*/
                   
--Inserción de monedas***********************************************************************************************************
INSERT INTO Monedas_OBJ VALUES (1, 'Colón');
INSERT INTO Monedas_OBJ VALUES (2, 'Dolar');
COMMIT;

--Inserción de unidades de medida*************************************************************************************************
INSERT INTO UnidadesDeMedida VALUES('U', 'Unidad');
INSERT INTO UnidadesDeMedida VALUES('PE', 'Peso');

--Inserción de tipos de cambio de meses anteriores********************************************************************************
INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.44, ADD_MONTHS(sysdate - 14,-12), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 15,-11), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 15,-10), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.57, ADD_MONTHS(sysdate - 15,-9), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.82, ADD_MONTHS(sysdate - 15,-8), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.94, ADD_MONTHS(sysdate - 15,-7), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.27, ADD_MONTHS(sysdate - 15,-6), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.27, ADD_MONTHS(sysdate - 15,-5), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.31, ADD_MONTHS(sysdate - 15,-4), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.65, ADD_MONTHS(sysdate - 15,-3), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.77, ADD_MONTHS(sysdate - 15,-2), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.80, ADD_MONTHS(sysdate - 15,-1), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.80, sysdate - 15, 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 2)
FROM DUAL;

--Inserción de una listas de precio
INSERT INTO LISTAPRECIOS_OBJ 
VALUES (1, 'Público', 'Precios para particulares', 0.1, 0.1, 0, 
        T_LineaLPArticulo_NTab(T_LineaLPArticulo(1, 40, (select ref(art) from articulos_obj art where codigo = 'TM')),
                              T_LineaLPArticulo(2, 45, (select ref(art) from articulos_obj art where codigo = 'TGR5230-SL-1GD3-L')),
                              T_LineaLPArticulo(3, 40, (select ref(art) from articulos_obj art where codigo = 'TS1')),
                              T_LineaLPArticulo(4, 40, (select ref(art) from articulos_obj art where codigo = 'MEMRAM.2GB')),
                              T_LineaLPArticulo(5, 45, (select ref(art) from articulos_obj art where codigo = 'SL02.8G08ME500SSD'))
                              )
        
        );
commit;
--Ingreso de familias **********************************************************
INSERT INTO Familias_OBJ VALUES('Default', 'Instancia default', 0.01);
INSERT INTO Familias_OBJ VALUES('CPU', 'Unidades de procesamiento central', 0.2);
INSERT INTO Familias_OBJ VALUES('MEM', 'Memorias', 0.2);
INSERT INTO Familias_OBJ VALUES('CIRC', 'PLacas de circuitos', 0.1);
INSERT INTO Familias_OBJ VALUES('TARJ', 'Tarjetas', 0);
COMMIT;

--Inserci�n de art�culos *******************************************************
INSERT INTO Articulos_OBJ
SELECT 'TM', 'Tarjeta Madre Asrock', 'Intel', NULL,
        1, 10, 26300, null, SYSDATE,
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'),
        T_Componente_lista()
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'TGR5230-SL-1GD3-L', 'Tarjeta gr�fica Radeon', 'ASUS', 'R5 230',
        1, 10, 10000, null, SYSDATE, 
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'), NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'TS1', 'Tarjeta sonido', 'Genius', 'R5 230',
        1, 10, 9000, null, SYSDATE, 
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'), NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'MEMRAM.2GB', 'Memoria RAM 2 GB', 'Kingston', null,
        1, 10, 12300, null, SYSDATE, 
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'MEM'), NULL
FROM DUAL;

INSERT INTO Articulos_OBJ
SELECT 'SL02.8G08ME500SSD', 'CPU grant', 'Dell', '260s',
        1, 10, 800000, null, SYSDATE, 
        (SELECT REF(f) FROM Familias_OBJ f WHERE f.codigo = 'TARJ'),
        T_Componente_lista()
FROM DUAL;
COMMIT;

--Inserci�n (registro) de componentes*******************************************
INSERT INTO Componente_OBJ --Se inserta el componente: tarjeta gr�fica
SELECT 1, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TM')
FROM DUAL;

INSERT INTO Componente_OBJ --Se inserta el componente: tarjeta madre
SELECT 2, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TGR5230-SL-1GD3-L')
FROM DUAL;

INSERT INTO Componente_OBJ --Se inserta el componente: tarjeta de sonido
SELECT 3, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'TS1')
FROM DUAL;

INSERT INTO Componente_OBJ --Se inserta el componente: tarjeta de sonido
SELECT 4, (SELECT REF(ar) FROM Articulos_OBJ ar WHERE ar.codigo = 'MEMRAM.2GB')
FROM DUAL;
COMMIT;

--Relacionar los articulos con sus componentes**********************************

/*
INSERT INTO TABLE (SELECT ar.list_ref_t_componente 
                    FROM Articulos_OBJ ar
                    WHERE ar.codigo = 'SL02.8G08ME500SSD')
SELECT REF(co) FROM Componente_obj co;*/
                   
--Inserci�n de monedas
INSERT INTO Monedas_OBJ VALUES (1, 'Col�n');
INSERT INTO Monedas_OBJ VALUES (2, 'Dolar');
COMMIT;

--Inserci�n de unidades de medida
INSERT INTO UnidadesDeMedida VALUES(1, 'Unidad');
INSERT INTO UnidadesDeMedida VALUES(2, 'Peso');

--Inserci�n de tipos de cambio de meses anteriores
INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.44, ADD_MONTHS(sysdate - 14,-12), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 15,-11), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 14,-10), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.57, ADD_MONTHS(sysdate - 14,-9), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.82, ADD_MONTHS(sysdate - 14,-8), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;
--****************************************
INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.94, ADD_MONTHS(sysdate - 14,-7), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.27, ADD_MONTHS(sysdate - 14,-6), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.27, ADD_MONTHS(sysdate - 14,-5), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 526.31, ADD_MONTHS(sysdate - 14,-4), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 14,-3), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 14,-2), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;

INSERT INTO TiposDeCambio_OBJ 
SELECT NULL, 525.36, ADD_MONTHS(sysdate - 14,-1), 0, (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1), (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_moneda = 1)
FROM DUAL;
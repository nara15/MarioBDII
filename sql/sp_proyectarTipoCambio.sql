--ENTRADAS

--VARIABLES INTERNAS QUE UTILIZA EL PROCEDIMIENTO
/*
  Variables para el cálculo de la proyección del tipo de cambio
  v_tipoAnt FLOAT := 0.0;  
  v_tipoAct FLOAT := 0.0;
  
  totalProyect FLOAT := 0.0;  --Variable que contendrá el costo total de la proyección del tipo de cambio
  ultFecha DATE; --Variable para la fecha del último tipo de cambio no proyectado
  n NUMBER := -0; --Contador de la iteración para el cálculo
  
  --Referencias  a las monedas por la que se hará la proyección del tipo de cambio
  moneda1 REF T_Moneda;
  moneda2 REF T_Moneda;
*/

CREATE OR REPLACE PROCEDURE sp_proyectarTipoCambio (pCantMeses NUMBER, pMoneda1 VARCHAR, pMoneda2 VARCHAR)
IS
  v_tipoAnt FLOAT := 0.0;  
  v_tipoAct FLOAT := 0.0;
  totalProyect FLOAT := 0.0;  
  ultFecha DATE; 
  n NUMBER := -0;
  
  moneda1 REF T_Moneda;
  moneda2 REF T_Moneda;
  
  --Definición de un cursor para la extracción de todos los tipos de cambio pasados, que no sean proyectado
  CURSOR TiposDeCambio(c_pMoneda1 VARCHAR, c_pMoneda2 VARCHAR) IS
      SELECT VALORTIPOCAMBIO FROM TIPOSDECAMBIO_OBJ T
      WHERE T.ESPROYECTADO = 0 AND (DEREF(T.REF_T_MONEDA1).nombre = c_pMoneda1)
                          AND (DEREF(T.REF_T_MONEDA2).nombre = c_pMoneda2);
  
  BEGIN
  
    --Se obtienen las referencias de las monedas de la proyección
    SELECT REF(m)INTO moneda1 FROM MONEDAS_OBJ m WHERE m.nombre = pMoneda1;
    SELECT REF(m)INTO moneda2 FROM MONEDAS_OBJ m WHERE m.nombre = pMoneda2;
    
    --Se obtiene la útltimo fecha del tipo de cambio, que no sea de un tipo de cambio proyectado
    SELECT fecha INTO ultFecha  FROM TIPOSDECAMBIO_OBJ
    WHERE ROWID IN (SELECT MAX(ROWID) FROM TIPOSDECAMBIO_OBJ T
                    WHERE esProyectado = 0 AND DEREF(T.REF_T_MONEDA1).nombre = 'Colón' AND DEREF(T.REF_T_MONEDA2).nombre = 'Dolar'
                    );
    
    --Se abre el cursor de los tipos de cambio registrados
    OPEN TiposDeCambio(pMoneda1, pMoneda2);
    FETCH TiposDeCambio INTO v_tipoAnt;
    LOOP
      FETCH TiposDeCambio INTO v_tipoAct;
      EXIT WHEN TiposDeCambio%NOTFOUND;
      totalProyect := totalProyect + (v_tipoAct - v_tipoAnt);
      v_tipoAnt := v_tipoAct;
      n := n + 1;
    END LOOP;
    CLOSE TiposDeCambio;
    
    --Se inserta la proyección del tipo de cambio calculado
    IF EXTRACT( MONTH FROM SYSDATE ) = EXTRACT( MONTH FROM ultFecha) THEN
      INSERT INTO TIPOSDECAMBIO_OBJ VALUES (NULL, v_tipoAct + (totalProyect / n) * pCantMeses, ADD_MONTHS(ultFecha, pCantMeses), 1, moneda1, moneda2);
    END IF;
    
    --NO existe una moneda especificada o no hay registro de tipos de cambio anteriormente
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20103, 'No existe tipos de cambios anteriormente registrados o la moneda no existe');
    
  END;

CREATE OR REPLACE PROCEDURE sp_proyeccionArticulo (pCodLP NUMBER, pCantMesesPro NUMBER)
IS
  mesProyectado NUMBER := EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, pCantMesesPro));
  tipoCambio NUMBER := NULL;
  
  codigoAr varchar2(20);
  precio NUMBER;
  
  --Obtenemos todos los artículos de la lista de precios
  CURSOR Articulos_LP (c_pCodLP NUMBER) IS
    SELECT precio, DEREF(REF_T_ARTICULO).codigo FROM 
    TABLE(
          SELECT LISTAARTICULOS
          FROM LISTAPRECIOS_OBJ WHERE ID_lp = c_pCodLP);
          
  BEGIN
    
    --Se extrae la proyección del tipo de cambio para el mes indicado
    SELECT tc.valorTipoCambio INTO tipoCambio FROM TiposDeCambio_OBJ tc
    WHERE EXTRACT(MONTH FROM tc.fecha) = mesProyectado
          AND tc.esProyectado = 1
          AND DEREF(tc.ref_t_moneda1).nombre = 'Colón'
          AND DEREF(tc.ref_t_moneda2).nombre = 'Dolar';
    
    OPEN Articulos_LP (pCodLP);
    
    LOOP
        FETCH Articulos_LP INTO precio, codigoAr;
        EXIT WHEN Articulos_LP%NOTFOUND;
        --Se inserta la proyección del precio del artículo en las proyecciones
        INSERT INTO Proyecciones_OBJ VALUES (NULL, SYSDATE, ADD_MONTHS(SYSDATE, pCantMesesPro), 
                                              codigoAr, precio * tipoCambio,
                                              (SELECT REF(m) FROM Monedas_OBJ m WHERE m.ID_Moneda = 1)
                                              );
    END LOOP;
    
    CLOSE Articulos_LP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20102, 'No existe una proyección de tipo de cambio para el mes especificado');
  END;
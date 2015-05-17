
CREATE OR REPLACE PROCEDURE sp_proyeccionArticulo (pCodLP NUMBER, pCantMesesPro NUMBER)
IS
  mesProyectado NUMBER := EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, pCantMesesPro));
  tipoCambio NUMBER := NULL;
  
  codigoAr varchar2(20);
  precio NUMBER;

  CURSOR Articulos_LP (c_pCodLP NUMBER) IS
    SELECT precio, DEREF(REF_T_ARTICULO).codigo FROM 
    TABLE(
          SELECT T_LINEALPARTICULO_TAB
          FROM LISTAPRECIOS_OBJ WHERE ID_lp = c_pCodLP);
          
  BEGIN
    
    --Se extrae la proyección del tipo de cambio para el mes indicado
    SELECT tc.valorTipoCambio INTO tipoCambio FROM TiposDeCambio_OBJ tc
    WHERE EXTRACT(MONTH FROM tc.fecha) = mesProyectado
          AND DEREF(tc.ref_moneda1).nombre = 'Colón'
          AND DEREF(tc.ref_moneda2).nombre = 'Dolar';
    
    OPEN Articulos_LP (pCodLP);
  
  END;
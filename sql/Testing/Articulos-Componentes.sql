
-- Pruebas Sobre Articulos-Componentes
SELECT * FROM FACTURACOMPRA_OBJ;

SELECT * FROM ARTICULOS_OBJ;

Select * from componentes_obj;

-- First Insert -- Look Down To Call Procedure ;--
execute insert_compp (  1   ,'PTIISYIGNU');
execute insert_compp (  2   ,'RMTDONOLAX');
execute insert_compp (  3   ,'NNUNYNXJLL');

execute insert_compp (4,'PTIISYIGNU');
-------------------------------- TESTING ------------------------------------------------------------------
-- PARAM1 'CODIGO DE ARTICULO'     SELECT * FROM ARTICULOS_OBJ
-- PARAM2 'CODIGO DE COMPONENTE'   SELECT * FROM COMPONENTE_OBJ

--CALL SP TO INSERT COMPONENTE ON ARTICULO LIST
execute Insert_Art_Comp_List ('SPYLQYBYXG','1');
execute Insert_Art_Comp_List ('SPYLQYBYXG','2');
execute Insert_Art_Comp_List ('SPYLQYBYXG','3');

-- add another to test
execute Insert_Art_Comp_List ('SPYLQYBYXG','N');

-- SELECT LIST_REF_T_COMPONENTE FROM ANY ARTICULO
select list_ref_t_componente from articulos_obj  where codigo = 'SPYLQYBYXG';


-- LIST THE NAMES OF ARTICULOS
select deref(deref(column_value).ref_t_articulo).nombre
from (
  TABLE(select LIST_REF_T_COMPONENTE from articulos_obj
  where codigo = 'YYCOHSYUZV') componentes );
  


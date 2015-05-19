
-- Pruebas Sobre Articulos-Componentes
SELECT * FROM FACTURACOMPRA_OBJ;

SELECT * FROM ARTICULOS_OBJ;


-- First Insert -- Look Down To Call Procedure ;--
insert into componentes_obj values (  1   ,(SELECT REF(f) FROM Articulos_OBJ f WHERE f.codigo = 'PTIISYIGNU'));
insert into componentes_obj values (  2   ,(SELECT REF(f) FROM Articulos_OBJ f WHERE f.codigo = 'RMTDONOLAX'));
insert into componentes_obj values (  3   ,(SELECT REF(f) FROM Articulos_OBJ f WHERE f.codigo = 'NNUNYNXJLL'));

-------------------------------- TESTING ------------------------------------------------------------------
-- PARAM1 'CODIGO DE ARTICULO'     SELECT * FROM ARTICULOS_OBJ
-- PARAM2 'CODIGO DE COMPONENTE'   SELECT * FROM COMPONENTE_OBJ

--CALL SP TO INSERT COMPONENTE ON ARTICULO LIST
execute Insert_Art_Comp_List ('CDKLJOJBZL','1');
execute Insert_Art_Comp_List ('CDKLJOJBZL','2');
execute Insert_Art_Comp_List ('CDKLJOJBZL','3');

-- add another to test
execute Insert_Art_Comp_List ('QPKUSFSMOG','N');

-- SELECT LIST_REF_T_COMPONENTE FROM ANY ARTICULO
select list_ref_t_componente from articulos_obj  where codigo = 'CDKLJOJBZL';


-- LIST THE NAMES OF ARTICULOS
select deref(deref(column_value).ref_t_articulo).nombre
from (
  TABLE(select LIST_REF_T_COMPONENTE from articulos_obj
  where codigo = 'CDKLJOJBZL') componentes );
  


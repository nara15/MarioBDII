

--// Procedure para editar un articulo cotizado.
create or replace Procedure Update_ArtCot
   ( idCot IN varchar2 , codArt IN varchar2,cant IN NUMBER
   )
   
IS
 
BEGIN
  --// Levanta Trigger Before Update 
   update  articuloscotizados_obj set CANTIDAD = cant where codigo = idCot and CODIGOARTICULO = codArt;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Actualizando Articulo Cotizado- '||SQLCODE||' -ERROR- '||SQLERRM);
END;


--////////////////////////// Test //////////////////////////

execute Update_ArtCot ('COT3','QPKUSFSMOG',3);


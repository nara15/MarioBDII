create or replace Procedure Delete_ArtComp
   ( idComp IN varchar2 
   )
   
IS
 
BEGIN
   delete from componente_obj where componente_id = idComp ;
   --update  articuloscotizados_obj set CANTIDAD = cant where codigo = idCot and CODIGOARTICULO = codArt;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;


 select * from componente_obj ;
 
 select * from cotizaciones_obj
 
execute Delete_ArtComp ('1');
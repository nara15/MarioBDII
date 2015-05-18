create or replace Procedure Delete_ArtCot
   ( idCot IN varchar2 , codArt IN varchar2
   )
   
IS
 
BEGIN
   delete from articuloscotizados_obj where codigo = idCot and CODIGOARTICULO = codArt;
   --update  articuloscotizados_obj set CANTIDAD = cant where codigo = idCot and CODIGOARTICULO = codArt;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;


 select * from articuloscotizados_obj ;
 
 select * from cotizaciones_obj
 
execute Delete_ArtCot ('COT3','QPKUSFSMOG');
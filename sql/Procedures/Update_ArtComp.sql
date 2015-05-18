


create or replace Procedure Update_ArtCot
   ( idCot IN varchar2 , codArt IN varchar2,cant IN NUMBER
   )
   
IS
 
BEGIN

   update  articuloscotizados_obj set CANTIDAD = cant where codigo = idCot and CODIGOARTICULO = codArt;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;



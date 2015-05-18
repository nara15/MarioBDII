create or replace Procedure Delete_Art
   ( idArt IN varchar2 
   )
   
IS
 
BEGIN
   delete from articulos_obj where codigo = idArt ;
   --update  articuloscotizados_obj set CANTIDAD = cant where codigo = idCot and CODIGOARTICULO = codArt;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;

select * from articulos_obj
execute delete_art ('EOXMTJOSYB');

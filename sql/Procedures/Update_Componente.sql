create or replace Procedure Update_Comp
   ( idComp IN varchar2 , codArt IN varchar2
   )
   
IS
 
BEGIN

   update  componentes_obj set ref_t_articulo = (SELECT REF(f) FROM articulos_obj f WHERE f.codigo = codArt)
   
   where componente_id = idComp ;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;


select * from componente_obj;
select * from articulos_obj;
execute update_comp ('2','HPLPMCHSUX');

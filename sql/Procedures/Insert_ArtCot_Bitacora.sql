create or replace 
Procedure Insert_Art_BCotizado_List
   ( art_id IN varchar2 , cot_id IN varchar2 , cant In Number )
   
IS
    
    preciox NUmber(5);
    precioxCant Float(5);
 
BEGIN
  
  --Cant Correct About Family
   select precio into preciox from articulos_obj where codigo = art_id;
   
   select (preciox * cant) into precioxCant from dual ;
   
   -- Inserto en tabla articulos Cotizados
   insert into barticulosCotizados_obj values (cot_id,art_id,cant,precioxCant);
   


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en lista Componentes- '||SQLCODE||' -ERROR- '||SQLERRM);
END;
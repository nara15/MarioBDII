create or replace Procedure Insert_Art_BCotizado_List
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
   
   --Inserto en lista de cotizacion el articulo recien insertado
   insert into table(
            select lista_bit_cotizados  from bcotizaciones_obj where codigo = cot_id  )
             values 
             (
             (SELECT REF(f) FROM barticulosCotizados_OBJ f WHERE f.codigo = cot_id and f.codigoArticulo = art_id)
             );


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en lista Componentes- '||SQLCODE||' -ERROR- '||SQLERRM);
END;
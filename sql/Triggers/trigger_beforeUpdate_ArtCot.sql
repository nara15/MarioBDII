
-- Before Update Articulo Cotizado
create or replace TRIGGER before_update_artCot
BEFORE DELETE ON articuloscotizados_obj
FOR EACH ROW

DECLARE
   v_newTotal FLOAT(5);
    preciox NUmber(5);
    precioxCant Float(5);
   
BEGIN

  select precio into preciox from articulos_obj where codigo = :old.codigoArticulo;
  select (preciox * :new.cantidad) into precioxCant from dual ;
  
  UPDATE :new.precioCotizado SET preciox WHERE codigo = :old.codigo and codigoarticulo = :old.codigoArticulo; 

END;

select * from articuloscotizados_obj;

update articuloscotizados_obj  set cantidad = 1  where CODIGO = 'COT6' and CODIGOARTICULO = 'HPLPMCHSUX';

drop trigger before_update_artCot
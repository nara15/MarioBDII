
-- Before Update Articulo Cotizado
create or replace 
trigger before_update_artCot
BEFORE UPDATE ON articuloscotizados_obj
FOR EACH ROW

DECLARE
   
    preciox NUmber(5);
    precioxCant Float(5);
   
BEGIN

  select precio into preciox from articulos_obj where codigo = :old.codigoarticulo;
  select (preciox * :new.cantidad) into precioxCant from dual;
 
  SELECT precioxCant INTO :new.precioCotizado
   FROM dual;
   
END;

select * from articuloscotizados_obj;

update articuloscotizados_obj  set cantidad = 1  where CODIGO = 'COT6' and CODIGOARTICULO = 'HPLPMCHSUX';

drop trigger before_update_artCot
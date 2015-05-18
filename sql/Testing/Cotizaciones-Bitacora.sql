-- Insertando Datos En Cotizaciones


--Cotizacion de Prueba
execute Insert_Cotizacion ('COT1','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');

--Cotizaciones Testing (Cotizaciones EMITIDAS ---- 2 - 4 - 6) -- Select * from cotizaciones_obj;

execute Insert_Cotizacion ('COT2','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT3','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','NO EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT4','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT5','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','NO EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT6','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');

execute Insert_Cotizacion ('COT9','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');

COMMIT;

--Insertar Articulo Cotizados sobre Cotizacion -- select * from articulosCotizados_obj;
                                               -- select * from articulos_obj

-- Raise ERROR - Not When Found Cotizacion -- insert into articulosCotizados_obj values ('ABJ','HPLPMCHSUX',1,12000);

-- Testing Articulos Cotizados Prueba ( Nombre Articulo , ID Cotizacion , Cantidad Articulos)
execute Insert_Art_Cotizado_List('RMTDONOLAX','COT2',1);
execute Insert_Art_Cotizado_List('PTIISYIGNU','COT3',2);
execute Insert_Art_Cotizado_List('NNUNYNXJLL','COT4',2);
--___________________________________________________________________________________________
execute Insert_Art_Cotizado_List('NNUNYNXJLL','COT9',2);

execute Insert_Art_Cotizado_List('PTIISYIGNU','COT5',1);
execute Insert_Art_Cotizado_List('RMTDONOLAX','COT5',1);

-- SELECT LIST_REF_T_COMPONENTE FROM ANY ARTICULO
select lista_art_cotizados from cotizaciones_obj  where codigo = 'COT5';

-- // Mejor hacer el result set :D
-- LIST THE NAMES OF ARTICULOS (INCLUIR EN STORE PROCEDURE )
select deref(column_value).codigoarticulo as cod, 
       deref(column_value).cantidad as cant ,
       deref(column_value).preciocotizado as precioTotal
from (
  TABLE(select lista_art_cotizados from cotizaciones_obj where codigo = 'COT3') cotizaciones);

--//////////////////////////Update Articulo Cotizado de Cotizadion///////////////////////////////////////////////////////
execute Update_ArtCot ('COT2','RMTDONOLAX',2);

--update  articuloscotizados_obj set CANTIDAD = 2 where codigo = 'COT3' and CODIGOARTICULO = 'QPKUSFSMOG';
--/////////////////////////Delete Cotizacion - Trigger ON DELETE -////////////////////////////////////////////

delete from cotizaciones_obj where codigo = 'COT9';
--///Had to DROP the Constrait 'cause dont alow to drop on child found
--ALTER TABLE articuloscotizados_obj DROP CONSTRAINT ArtCotizados_Cotizacion_FK;

SELECT * from barticuloscotizados_obj;   

SELECT * from cotizaciones_obj;

SELECT * from articuloscotizados_obj;

SELECT * from articuloscotizados_obj WHERE codigo = 'COT9';

delete from articuloscotizados_obj where codigo = 'COT9';






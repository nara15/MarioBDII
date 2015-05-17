-- Insertando Datos En Cotizaciones


--Cotizacion de Prueba
execute Insert_Cotizacion ('COT1','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');

--Cotizaciones Testing (Cotizaciones EMITIDAS ---- 2 - 4 - 6) -- Select * from cotizaciones_obj;

execute Insert_Cotizacion ('COT2','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT3','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','NO EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT4','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT5','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','NO EMITIDA','UFO','ARD');
execute Insert_Cotizacion ('COT6','-CondicPago-','CondicEntrega','20 Dias','Ninguna','-Cliente No Frecuente','Dolar','EMITIDA','UFO','ARD');
COMMIT;

--Insertar Articulo Cotizados sobre Cotizacion -- select * from articulosCotizados_obj;
                                               -- select * from articulos_obj

-- Raise ERROR - Not When Found Cotizacion -- insert into articulosCotizados_obj values ('ABJ','HPLPMCHSUX',1,12000);

-- Testing Articulos Cotizados Prueba
execute Insert_Art_Cotizado_List('HPLPMCHSUX','COT2',1);
execute Insert_Art_Cotizado_List('QPKUSFSMOG','COT3',2);
execute Insert_Art_Cotizado_List('QPKUSFSMOG','COT4',2);


execute Insert_Art_Cotizado_List('QYUDNADHTW','COT5',2);


                     
                          

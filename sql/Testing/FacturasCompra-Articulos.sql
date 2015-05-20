-- Pruebas Sobre Facturas Compra  - Articulos  @aallanrd @itcr @2015

--Factura Compra 

select * from facturacompra_view;

select  * from facturacompra;
--------------- Insercion en Factura Compra -------------------------------------------------

-- Insercion Facturas de Prueba
execute Insert_FacturaCompra ('MiProducto','Marca','Modelo',1,100,4500,'INTEL','ARD','PE');
execute Insert_FacturaCompra ('OtroProducto','Marca','Modelo',1,100,4500,'INTEL','ARD','PE');
execute Insert_FacturaCompra ('OtroMas','Marca','Modelo',1,100,4500,'INTEL','ARD','PE');

-- Testing Factura Compra

execute Insert_FacturaCompra ('Tarjeta Madre UPOX','ATHEROS','SPG01',1,100,4500,'INTEL','ARD','PE');

execute Insert_FacturaCompra ('Pantalla Plana','ATHEROS','SPG01',1,100,8550,'INTEL','ARD','PE');

execute Insert_FacturaCompra ('','NewArticulo','Proyecto',1,100,100.000,'INTEL','ARD','PE');

select * from FACTURACOMPRA_OBJ;

select * from ARTICULOS_OBJ;

--delete from articulos_obj where codigo = 'ZCNJQPYTRM';

select * from proveedores_obj;

--delete from facturacompra_obj where codigo = '507';
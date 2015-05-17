insert into cotizaciones_obj SELECT 'COT1',SYSDATE,'CondicionPago','CondicionEntrega','Vigencia','Observaciones','ListaPrecios','Moneda','Estado',
                                    (SELECT REF(f) FROM Clientes_OBJ f WHERE f.codigo = 'UFO'),
                                    (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = 'ARD'),
                                    T_ARTCOTIZADO_LISTA()
                                    FROM DUAL;
COMMIT;

insert into cotizaciones_obj SELECT 'COT2',SYSDATE,'CotizacionPrueba','CondicionEntrega','Vigencia','Observaciones','-Cliente Frecuente-','Colones','EMITIDA',
                                    (SELECT REF(f) FROM Clientes_OBJ f WHERE f.codigo = 'UFO'),
                                    (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = 'ARD'),
                                    T_ARTCOTIZADO_LISTA()
                                    FROM DUAL;
COMMIT;



                     
                     
                          


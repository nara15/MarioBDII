create or replace Procedure Insert_Cotizacion
   ( idCot IN varchar2 , condicionesPago IN varchar2,condicionesEntrega IN varchar2,vigencia IN varchar2,observaciones IN varchar2,
     listaPrecio IN varchar2,moneda IN varchar2,estado IN varchar2,
     clienteID IN varchar2,usuarioID IN varchar2
   )
   
IS
 
BEGIN

  insert into cotizaciones_obj SELECT idCot,SYSDATE,condicionesPago,condicionesEntrega,vigencia,observaciones,listaPrecio,moneda,estado,
                                    (SELECT REF(f) FROM Clientes_OBJ f WHERE f.codigo = clienteID),
                                    (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = usuarioID),
                                    T_ARTCOTIZADO_LISTA()
                                    FROM DUAL;


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Cotizacion- '||SQLCODE||' -ERROR- '||SQLERRM);
END;
create or replace Procedure Update_Articulo
   ( codArt In varchar2, nombreArt IN varchar2 , marcaArt IN varchar2,modeloArt IN varchar2,cantMin IN NUMBER,
   cantMax IN NUMBER,precioArt IN FLOAT  ,usuarioID IN varchar2,unidadCod IN varchar2
   )
   
IS
 
BEGIN

   
  Update articulos_obj 
     set nombre = nombreArt,
         marca = marcaArt,
         modelo = modeloArt,
         cantMinima = cantMin,
         cantMaxima = cantMax,
         precio = precioArt,
         fechaactuprecio = SYSDATE,
         usuarioinserta = (SELECT REF(f) FROM Usuarios_OBJ f WHERE f.codigo = usuarioID)
         
  where codigo = codArt;
    

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en Factura Compra- '||SQLCODE||' -ERROR- '||SQLERRM);
END;


select * from articulos_obj

execute update_articulo ('QPKUSFSMOG','MiProducto(Editado)','Marca(Ed)','Modelo(Ed)',1,100,3000,'JGM','PE');
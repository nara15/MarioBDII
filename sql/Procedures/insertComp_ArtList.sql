--insert into table(select list_ref_t_componente from articulos_obj where codigo = 'EOXMTJOSYB') values ((SELECT REF(f) FROM Componente_OBJ f WHERE f.componente_id = '1'));
--select list_ref_t_componente from articulos_obj where codigo = 'EOXMTJOSYB';

-- Procedure para insertar en la lista de componentes de un articulo
select * from FACTURAcOMPRA_OBJ;
select * from articulos_obj;
select * from componente_obj;

CREATE OR REPLACE Procedure Insert_Art_Comp_List
   ( art_id IN varchar2 , comp_id IN varchar2 )
   
IS
 
BEGIN

   insert into
       table(
             select list_ref_t_componente   from articulos_obj where codigo = art_id
             )
             values 
             (
             (SELECT REF(f) FROM Componente_OBJ f WHERE f.componente_id = comp_id)
             );


EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'Error Insertando en lista Componentes- '||SQLCODE||' -ERROR- '||SQLERRM);
END;

execute Insert_Art_Comp_List ('QPKUSFSMOG','2');

select list_ref_t_componente from articulos_obj where codigo = 'QPKUSFSMOG';
  
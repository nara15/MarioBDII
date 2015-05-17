

select deref(deref(column_value).ref_t_articulo).nombre
from (
  TABLE(select LIST_REF_T_COMPONENTE from articulos_obj
  where codigo = 'SL02.8G08ME500SSD') componentes );
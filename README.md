##INSTITUTO TECNOLOGICO DE COSTA RICA
### ESCUELA  DE COMPUTACION 
###### BASE DE DATOS II, I SEMESTRE 2015,  PROYECTO II.

Para el sistema descrito para el proyecto I, desarrolle:

1.	los diagramas de base de datos para el modelo relacional-objeto y de vistas-objeto utilizando el “datamodeler” de Oracle.  Los diagramas deben ser impresos tal que su lectura sea posible sin requerir consulta a pantalla.  En la entrega del proyecto se debe presentar la siguiente documentación impresa:

	Portada
	Tabla de contenidos
	Introducción
	Descripción del problema
	Diagramas de relacional-objeto y vistas-objeto
	Diccionario de datos
	Conclusiones
•	puntos concluidos y pendientes
•	experiencia adquirida y recomendaciones
•	distribución de la carga de trabajo entre los integrantes del grupo
	 Bibliografía 
	Anexo  
•	 “Scripts” 							         20%

2.	un "script" que genere una base de datos relacional-objeto, la cual debe implantar  una herencia,  así como las agregaciones  para los casos en que se estime que el uso de colecciones de referencias optimizan el acceso a los datos.  Se debe incluir para cada tipo: el constructor,  el método de comparación, y la carga de datos.   Adicionalmente se deben programar las consultas y procedimientos almacenados y ”triggers”, solicitados en el proyecto I.			                                                     					           40%

3.	un   "script" que implante las vistas-objeto requeridas tal que el modelo relacional utilizado en el proyecto I sea equivalente al modelo relacional-objeto desarrollado en el punto 2,  el cual debe soportar las consultas y procedimiento almacenados, y “triggers” desarrollados en ese punto,  al sustituir el nombre de la tabla relacional-objeto por el de la vista-objeto.   Se debe realizar la carga de datos para permitir verificar la  equivalencia.   										          40%


Fecha de entrega: 18 de mayo,  2015


-- ERROR
ORA-01536: space quota exceeded for tablespace 'PROYECTO'

When your user was created your received a space quota on the users tablespace from your dba. It means that you cannot create more than that amount of space in that tablespace. you are now creating a table. Upon doing so, a number of extents of a certain size are created (reserved) for it. Seeing as you don't explicitely mention them, you get the defaults of the tablespace. Most likely the initial/next extents and the minimum number of extents on the tablespace for a new table exceed your quota. For a solution you can do the following:
- ask for more quota from your dba
- specify explicite low extent sizes (make sure the tablespace is not 'uniform extent size', though)




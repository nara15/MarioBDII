##INSTITUTO TECNOLOGICO DE COSTA RICA
### ESCUELA  DE COMPUTACION 
###### BASE DE DATOS II, I SEMESTRE 2015,  PROYECTO II.


Requerimientos del Proyecto II.

1. "script" que genere una base de datos relacional-objeto, la cual debe implantar  una herencia,  así como las agregaciones  para los casos en que se estime que el uso de colecciones de referencias optimizan el acceso a los datos.  Se debe incluir para cada tipo: el constructor,  el método de comparación, y la carga de datos.   Adicionalmente se deben programar las consultas y procedimientos almacenados y ”triggers”, solicitados en el [Proyecto 1](https://github.com/aallanrd/ProyectoOracle). 40%



2.	un   "script" que implante las vistas-objeto requeridas tal que el modelo relacional utilizado en el proyecto I sea equivalente al modelo relacional-objeto desarrollado en el punto 2,  el cual debe soportar las consultas y procedimiento almacenados, y “triggers” desarrollados en ese punto,  al sustituir el nombre de la tabla relacional-objeto por el de la vista-objeto.   Se debe realizar la carga de datos para permitir verificar la  equivalencia.   										          40%


Fecha de entrega: 18 de mayo,  2015

#Requerimientos del Sistema

SQL Developer 
___________________________________________________________________________________________________________________________
#Conexion
 1. Local ALLAN PC - Instancia ORCL , Plugablee Data Base
 2. ITCR OraServer .... 
    2.1 Conectar a RED de la Escuela Ingeniera en Computacion
    2.2 Nombre Conexion : proyectoConnect
    2.3 Nombres de Usuario-PASS (jonaranjo , allrojas)
    2.4 SSID : ProyectoPDB

#Herencia
Para permitir la herencia entre objetos debemos especificar la opción NOT FINAL en la creación del objeto para que otros objetos puedan heredar de él (valor por defecto). Si queremos que de un objeto no se pueda heredar, debemos especificar FINAL. Lo mismo podemos hacer para los procedimientos o funciones miembro.
 CREATE TYPE nombreSuperObj AS
 OBJECT(nombreAtr TIPO,
 ... ,
 FINAL MEMBER FUNCTION nombreFuncion1 RETURN NUMBER,
 MEMBER FUNCTION nombreFuncion2 RETURN VARCHAR2

) *NOT FINAL*;
___________________________________________________________________________________________________________________________

# ERROR
ORA-01536: space quota exceeded for tablespace *PROYECT'

When your user was created your received a space quota on the users tablespace from your dba. It means that you cannot create more than that amount of space in that tablespace. you are now creating a table. Upon doing so, a number of extents of a certain size are created (reserved) for it. Seeing as you don't explicitely mention them, you get the defaults of the tablespace. Most likely the initial/next extents and the minimum number of extents on the tablespace for a new table exceed your quota. For a solution you can do the following:
- ask for more quota from your dba
- specify explicite low extent sizes (make sure the tablespace is not 'uniform extent size', though)




La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año, mes, dia e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato mostrado a continuación:
Año : --- Mes:-- 1
día:-- 1
idUsuario 1 -------- idusuario N
Tiempo Total
de acceso en de acceso en
de acceso en de acceso en
de acceso en de acceso en
de acceso en de acceso en
el dia 1 mes 1 el dia 1 mes 1
el dia N mes 1 el dia N mes 1
el dia 1 mes 12 el dia 1 mes 12
el dia N mes 12 el dia N mes 12
Tiempo total Tiempo total acceso dia 1 mes 1
------------- día N
idUsuario 1 Tiempo Total --------
idusuario N Tiempo total
Tiempo total acceso dia N mes 1 Total tiempo de acceso mes 1
------
Mes 12
día 1
Tiempo total acceso dia 1 mes 12 -------------
día N
idUsuario 1 Tiempo Total --------
idusuario N Tiempo total
idUsuario 1 Tiempo Total --------
idusuario N Tiempo total
Tiempo total acceso dia N mes 12 Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no
encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.
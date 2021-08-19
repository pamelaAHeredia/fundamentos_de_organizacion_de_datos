Dada la siguiente estructura:
type
tTitulo = String[50]; 
tArchRevistas = file of tTitulo ;

Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
 tTitulo = String[50]; tArchRevistas = file of tTitulo ;
número 0 implica que no hay registros borrados y N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
{Abre el archivo y agrega el título de la revista, recibido como parámetro manteniendo la política descripta anteriormente}
procedure agregar (var a: tArchRevistas ; titulo: string);
b. Liste el contenido del archivo omitiendo las revistas eliminados. Modifique lo que
considere necesario para obtener el listado.
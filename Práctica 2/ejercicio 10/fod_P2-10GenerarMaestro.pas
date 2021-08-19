{
departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado. 
Se sabe que el archivo se encuentra ordenado por departamento, luego por división, y por último, por número de empleado. 
Presentar en pantalla un listado con el siguiente formato:

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al iniciar el programa con el valor de la hora extra para cada categoría. 
La categoría varía de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número de categoría y el valor de la hora, 
pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el número de categoría.
      
}


program untitled;
const 
	corte = -1; 
	tam = 15; 
type
	rango = 1..tam;
	
	registro = record
		depto: integer; 
		division: integer; 
		nroEmpleado: integer; 
		cat: rango; 
		hsExtra: integer; 
	end; 
	
	horas = record
		cat: integer; 
		precio: real; 
	end; 
	
	maestro = file of registro;  

//----------------------------------------------------------------------
procedure leer(var r: registro); 
begin
	with r do begin
		write('Departamento: '); readln(depto); 
		if(depto <> corte) then begin	
			write('División: '); readln(division); 
			write('Núm empleado: '); readln(nroEmpleado); 
			write('Categoría: '); readln(cat); 
			write('Horas Extra: '); readln(hsExtra); 
			writeln(); 
		end; 
	end; 
End;
//----------------------------------------------------------------------
procedure leerR(var r: horas); 
begin
	with r do begin
		write('Categoría: '); readln(cat);
		if(cat <> corte) then begin
			write('Precio: '); readln(precio);  
			writeln(''); 
		end;  
	end; 
End; 
//----------------------------------------------------------------------
procedure generarMaestro();
var
	m: maestro; 
	r: registro; 
begin
	assign(m, 'archivoTrabajadores'); 
	rewrite(m);
	writeln('-------- CARGA DE MAESTRO --------');  
	leer(r);	
	while(r.depto <> corte) do begin
		write(m,r);
		leer(r);  
	end;  
	close(m);  
End; 
//----------------------------------------------------------------------
procedure generarTxt(var r: horas); 
var
	t: Text;  
begin
	writeln('---------- Generando txt -------------'); 
	assign(t, 'archHoras.txt'); 
	rewrite(t); 
	leerR(r); 
	while(r.cat <> corte) do begin
		writeln(t, r.cat ,' ', r.precio:0:2);
		leerR(r);  
	end; 
	close(t); 
End; 
//----------------------------------------------------------------------
//var
	//r: horas; 
	
BEGIN
	generarMaestro(); 
	//generarTxt(r); 
	
END.


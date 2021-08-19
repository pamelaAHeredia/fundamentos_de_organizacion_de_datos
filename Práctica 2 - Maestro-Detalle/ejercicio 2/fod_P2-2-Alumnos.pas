{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. 
Por cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias 
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, 

se tiene un archivo detalle con el código de alumno e información correspondiente a una 
materia (esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede 
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un programa con opciones para:

e. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin final.
f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

NOTA: Para la actualización del inciso e) los archivos deben ser recorridos sólo una vez.   
}
program fodP2E2;
const 
	corte = -1; 
	valorAlto = 9999; 
type
	registroMaestro = record
		codigo: integer; 
		apellido: string[10]; 
		nombre: string[10];
		cantMateriasCursadas: integer; 
		cantAprobadas: integer; 
	end; 
	
	maestro = file of registroMaestro;
	
	registroDetalle = record
		cod: integer;
		info: string; 
	end; 
	
	////archivo detalle. información de una materia que indica si aprobó la cursada o aprobó el final).
	detalle = file of registroDetalle; 	

//---- a. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”. -------

procedure crearMaestro(var m: maestro; var t: Text); 
var
	nombreFisicoMaestro: string[15]; 
	nombreFisicoTexto: string[15]; 
	rm: registroMaestro; 
begin
	write('* Nombre del archivo maestro: '); 
	readln(nombreFisicoMaestro); 
	assign(m, nombreFisicoMaestro); 
	
	nombreFisicoTexto:= 'alumnos.txt';
	assign(t, nombreFisicoTexto); 
	
	reset(t); 
	rewrite(m); 
	while (not eof(t)) do begin
		with rm do begin
			readln(t, codigo, cantMateriasCursadas, cantAprobadas); 
			readln(t, apellido); 
			readln(t, nombre); 
		end; 
		write(m,rm); 
	end; 
	close(t);
	close(m);   
End; 

//------------- IMPRIMIR ARCHIVO DETALLE ------------------
procedure imprimirArchivo(var d: detalle; var m:maestro); 
var
	nombreD, nombreM: string[20]; 
	rd: registroDetalle;
	rm: registroMaestro;  
begin
	nombreD:= 'archivoDetalle'; 
	nombreM:= 'archivoMaestro'; 
	assign(d, nombreD); 
	assign(m, nombreM); 
	reset(d); 
	while (not eof(d)) do begin
		read(d,rd); 
		writeln('* codigo: ', rd.cod, ' * estado: ', rd.info); 
	end; 
	close(d); 
	
	reset(m); 
	while (not eof(m)) do begin
		read(m,rm); 
		writeln('* código: ',rm.codigo, ' * Cursadas: ', rm.cantMateriasCursadas,' * aprobadas: ', rm.cantAprobadas); 
		writeln('* nombre: ', rm.nombre); 
		writeln('* apellido: ', rm.apellido); 
	end; 
	close(m); 
End; 

//----- b. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.------
procedure crearDetalle(var d: detalle; var td: Text); 
var
	nomFisicoD: String[15]; 
	nomFisicoT: string[15]; 
	rd: registroDetalle; 
begin
	write('* Nombre Físico del Archivo Detalle: '); readln(nomFisicoD);
	assign(d, nomFisicoD); 
	
	nomFisicoT:= 'detalle.txt';
	assign(td, nomFisicoT); 

	reset(td); 
	rewrite(d);
	while (not eof(td)) do begin
		with rd do
			readln(td, cod, info); 
		write(d, rd); 
	end;  
	close(td); 
	close(d); 
End; 

//---- c. Listar el contenido del archivo maestro en un archivo de texto llamado “reporteAlumnos.txt”. ---
procedure listarMaestroEnTxt(var m: maestro; var t: Text); 
var
	nomFisicoM: string[15]; 
	nomFisicoT: string[20]; 
	r: registroMaestro; 
begin
	write('* Nombre del archivo Maestro a exportar: '); readln(nomFisicoM);
	assign(m, nomFisicoM);
	
	nomFisicoT:= 'reporteAlumnos.txt'; 
	assign(t, nomFisicoT);
	
	reset(m); 
	rewrite(t);
	
	while(not eof(m)) do begin
		read(m, r); 
		with r do begin
			writeln(t,' ',codigo,' ', cantMateriasCursadas,' ', cantAprobadas);
			writeln(t,' ',apellido); 
			writeln(t,' ',nombre);
		end; 
	end;  
End;

//--- d. Listar el contenido del archivo detalle en un archivo de texto llamado “reporteDetalle.txt”. ---
procedure listarDetalleEnTxt(var d: detalle; var t: Text); 
var
	nombreT, nombreD: string[20]; 
	rd: registroDetalle; 
begin
	nombreT:= 'reporteDetalle.txt'; 
	assign(t, nombreT);
	write('* Nombre del archivo Detalle a exportar: '); readln(nombreD);
	assign(d, nombreD); 	
	reset(d); 
	rewrite(t); 
	while(not eof(d)) do begin
		read(d,rd); 
		with rd do
			writeln(t,' ',cod,' ', info); 
	End; 
	close(d);
	close(t);   
End;  

//---------- ACTUALIZAR -------------------------------------
procedure leerHastaValorAlto(var d: detalle; var rd: registroDetalle); 
begin
	if (not eof(d)) then 
		read(d,rd)
	else
		rd.cod := valorAlto; 
End;  

//i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
procedure actualizarFinales(var m: maestro; var d: detalle);
var
	nm,nd: string[15]; 
	rd: registroDetalle; 
	rm: registroMaestro;
	totalF: integer;
	totalC: integer;  
	actual: integer;  
begin
	nd:= 'archivoDetalle'; 
	nm:= 'archivoMaestro';
	assign(m, nm);
	assign(d, nd);
	reset(m); 
	reset(d); 
	read(m, rm);	
	leerHastaValorAlto(d, rd); 
	while (rd.cod <> valorAlto) do begin
		actual:= rd.cod; 
		totalF := 0;
		totalC:= 0;  
		writeln(rd.cod,' = ',actual,'?'); 
		while (rd.cod = actual) do begin
			writeln('info: ', rd.info); 
			if (rd.info = ' f ') then 
				totalF:= totalF +1
			else
				totalC := totalC +1; 
			writeln('total finales y cursadas: ', totalF, ' ', totalC); 	 
			leerHastaValorAlto(d, rd);  	
		end;
		while (rm.codigo <> actual) do 
			read(m,rm); 
		rm.cantAprobadas := totalF;
		rm.cantMateriasCursadas := totalC;   
		seek(m, filepos(m)-1); 
		write(m, rm);
		if (not eof(m)) then 
			read(m,rm); 
	end; 
	close(d); 
	close(m);   
End;

//---------- Listar los alumnos que hayan aprobado 4 cursadas y 0 finales ---------------
procedure sinFinalesAprobados(var m: maestro);
var
	nm: string[15]; 
	rm: registroMaestro; 
begin
	nm:= 'archivoMaestro';
	assign(m, nm);
	reset(m); 
	while (not (eof(m))) do begin
		read(m, rm); 
		if ((rm.cantMateriasCursadas = 4) and (rm.cantAprobadas = 0)) then begin
			writeln('* código: ',rm.codigo, ' * Cursadas: ', rm.cantMateriasCursadas,' * aprobadas: ', rm.cantAprobadas); 
			writeln('* nombre: ', rm.nombre); 
			writeln('* apellido: ', rm.apellido); 
		end; 
	end; 
	close(m);   
End;  

//---------prog ppal -------
var
	t: Text; 
	m: maestro; 
	d: detalle; 
BEGIN
	crearMaestro(m, t); 
	crearDetalle(d, t);
	imprimirArchivo(d, m); 
	listarMaestroEnTxt(m,t);
	writeln('ppal exportar detalle');  
	listarDetalleEnTxt(d,t); 
	writeln('act finales'); 
	actualizarFinales(m, d);
	writeln('**** Alumnos que no aprobaron finales: ****');  
	sinFinalesAprobados(m); 
END.


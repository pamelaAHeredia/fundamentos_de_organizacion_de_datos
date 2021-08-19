program fod_P32;
const
	marca = '*'; 
	maximo = 8; 
	corte = -1;
	valorAlto = 9999; 
type
	registro = record
		codigo: integer; 
		apYnom: string[30]; 
		direccion: string[30]; 
		telefono: string; 
		dni: integer; 
		fechaNac: string[10]; //dd/mm/aaaa
	end; 
	
	archivo = file of registro; 
//----------------------------------------------------------------------
procedure leerR(var r: registro); 
begin
	with r do begin
		write('* Código de empleado: '); readln(codigo);
		if(r.codigo <> corte) then begin
			write('* Apellido y Nombre: '); readln(apYnom);
			write('* Direccion: '); readln(direccion);
			write('* Teléfono: '); readln(telefono);
			write('* Dni: '); readln(dni);
			write('* Fecha de nacimiento: '); readln(fechaNac);
			writeln(); 
		end;  
	end; 
End; 

//----------------------------------------------------------------------
procedure generarArchivo(var a: archivo); 
var
	r: registro; 
begin
	writeln('****** GENERANDO ARCHIVO ******');
	writeln(); 
	assign(a,'empresaPrivada'); 
	rewrite(a); 
	leerR(r);
	while(r.codigo <> corte) do begin
		write(a,r);
		leerR(r);  
	End; 
	close(a); 	 
End; 
//----------------------------------------------------------------------
procedure leerArchivo(var a: archivo; var r: registro);
begin 
	if (not eof(a)) then 
		read(a,r)
	else
		r.codigo := valorAlto; 
End; 

//----------------------------------------------------------------------
procedure marcar(var a: archivo);
var
	r: registro; 
begin
	reset(a);
	leerArchivo(a,r); 
	while (r.codigo <> valorAlto) do begin 
		if(r.dni < maximo) then begin
			r.apYnom:= marca + r.apYnom ;
			seek(a, filepos(a)-1); 	
			write(a,r); 
		end; 		 
		leerArchivo(a,r); 
	end; 
	close(a); 
End;  

//----------------------------------------------------------------------
procedure imprimir(var a: archivo); 
var 
	r: registro; 
begin
	assign(a,'empresaPrivada');
	reset(a); 
	while (not eof(a)) do begin
		read(a,r); 
		writeln('* Dni: ',r.dni,' * Nombre: ', r.apYnom); 
	end; 
	close(a); 	
End; 
//----------------------------------------------------------------------

VAR
	a: archivo; 
BEGIN
	assign(a,'empresaPrivada');
	generarArchivo(a);
	writeln();
	imprimir(a); 
	marcar(a); 
	writeln();
	imprimir(a); 	
END.


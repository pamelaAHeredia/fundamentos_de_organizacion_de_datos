program fodE3;
const
	valorAlto = 9999; 
	corte = 0; 
type
	registro = record
		codigo : integer; 
		nombre: string; 
		genero: string; 
	end; 
	
	archivo = file of registro; 

//----------------------------------------------------------------------	
procedure leerRegistro(var r: registro); 
begin
	with r do begin
		write('* Código de novela: '); readln(codigo); 
		if(codigo <> corte) then begin
			write('* Nombre: '); readln(nombre); 
			write('* Género: '); readln(genero); 
			writeln(); 
		end; 
	end; 
End; 

//----------------------------------------------------------------------
procedure leer(var a: archivo; var r: registro);
begin
	if(not eof(a)) then 
		read(a,r)
	else
		r.codigo := valorAlto; 
End;  

//----------------------------------------------------------------------	
procedure generarArchivo(var a: archivo);
var
	r: registro; 
	n: string; 
begin
	write('* Nombre del archivo nuevo: '); readln(n);
	assign(a,n);
	rewrite(a);
	r.codigo := 0; 
	write(a,r); //registro de cabecera
	writeln(); 
	writeln('============== CARGANDO ', n,' ==============');   
	writeln(); 
	leerRegistro(r); 
	while (r.codigo <> corte) do begin
		write(a,r); 
		leerRegistro(r); 
	end; 	
	close(a); 
End;  
 
//----------------------------------------------------------------------	
procedure alta(var a: archivo); 
var
	r, nuevo: registro; 
	cabecera: integer; 
begin
	writeln('* Ingrese los datos de la novela a dar de Alta.'); 
	leerRegistro(nuevo); 
	writeln(); 
	reset(a);
	leer(a,r); 
	cabecera:= r.codigo; 

	if(cabecera< 0) then begin
		seek(a, (-1 * r.codigo));
		read(a,r); 
		seek(a, filepos(a)-1);  
		cabecera:= r.codigo; 		
		write(a, nuevo); 
		seek(a,0); 		
		r.codigo := cabecera; 
		write(a,r); 
	end
	else begin
		seek(a, filesize(a));
		write(a, nuevo);  
	end; 
	close(a);    
End; 

//----------------------------------------------------------------------
procedure eliminar(var a: archivo);
var
	cabecera,, aux, cod: integer; 
	n: string; 
	found: boolean; 
	r: registro; 
begin
	write('* Código de la novela a eliminar: '); readln(cod); 
	writeln(); 
	reset(a);
	
	leer(a,r);
	cabecera := r.codigo; 
	while((r.codigo <> valorAlto) and (r.codigo <> cod)) do
		leer(a,r); 
	
	if(r.codigo = cod) then begin 
		seek(a, filepos(a) -1);
		aux := -1 * filepos(a); 
		r.codigo := cabecera; 
		write(a,r); 
		seek(a,0); 
		r.codigo := aux; 	
		write(a,r);
	end 	 
	else
		writeln('== Código inexistente == '); 
	close(a); 	
End; 

//----------------------------------------------------------------------
procedure modificar(); //funciona, pero el código es feo
var
	a: archivo; 
	r: registro; 
	n: string; 
	found: boolean;
	cod: integer;  
begin
	writeln(); 
	write('* Nombre del archivo donde se encuentra el registro: ');
	readln(n);
	write('* Código de la novela a modificar: '); readln(cod);   
	assign(a,n);
	reset(a); 
	leer(a,r); 
	leer(a,r); 
	found:= false; 
	while ((r.codigo <> valorAlto) and not found) do begin
		if (r.codigo = cod) then 
			found := true
		else
			leer(a,r); 
	end;
	if (found) then begin
		writeln('* Nombre nuevo: '); readln(n); 
		r.nombre:= n; 
		writeln('* Género nuevo: '); readln(n); 
		r.genero := n; 
		seek(a, filepos(a)-1); 
		write(a,r); 
	end
	else
		writeln('* código inexistente. ');
	close(a); 	 
End; 
//----------------------------------------------------------------------
procedure menu(); 
begin
	writeln();
	writeln('=========== Ingrese la opción deseada ============');  
	writeln(); 
	writeln('1_ Dar de alta una novela.'); 
	writeln();
	writeln('2_ Modificar una novela.'); 
	writeln();
	writeln('3_ Eliminar una novela.');
	writeln();
	writeln('0_ Salir del menú.');
	writeln; 
End; 

procedure print(); 
var
	a: archivo; 
	r: registro; 
begin
	assign(a,'archivo3');
	reset(a);  
	while (not eof(a)) do begin
		read(a,r); 
		writeln('* código: ', r.codigo, ' * Nombre: ', r.nombre); 
	end; 	
End; 

//----------------------------------------------------------------------
procedure mantenimiento(var a: archivo; var num: integer); 
begin
	menu(); 
	readln(num);
	while num <> 0 do begin 
		case num of
			1: alta(archivo); 
			2: modificar(); 
			3: eliminar(archivo);
			4: print();  
		else 
			writeln(' OPCIÓN INVÁLIDA ');
		end;	
		menu(); 
		readln(num); 	
	end; 	 
end;

//----------------------------------------------------------------------

VAR
	a: archivo;
	num: integer;  
	n; string; 
BEGIN
	write('* Nombre del archivo: '); readln(n); 
	assign(a,n);
	generarArchivo(a);
	print(); 
	mantenimiento(a,num); 
	
END.


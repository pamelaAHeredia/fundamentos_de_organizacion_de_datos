program crearArchivo;
const
	corte = -1; 
	tam = 4; 
type
	registroMaestro = record
		codigo: integer; 
		nombre: string[15]; 
		desc: string[20]; 
		stockD: integer; 
		stockM: integer; 
		precio: real; 
	end; 
	
	rango = 1..tam; 
	
	registroDetalle = record
		cod: integer; 
		cantV: integer; 
	end; 
	
	maestro = file of registroMaestro; 
	detalle = file of registroDetalle; 
	
	vector = array [rango] of detalle; 
	
//----------- crear Maestro -------------------	
procedure leerMaestro(var r: registroMaestro); 
begin
	with r do begin
		write('* código: '); readln(codigo);
		if (codigo <> corte) then begin
			write('* Nombre: '); readln(nombre); 
			write('* Descripción: '); readln(desc); 
			write('* Stock Disponible: '); readln(stockD); 
			write('* Stock mínimo: '); readln(stockM); 
			write('* Precio: '); readln(precio); 
			writeln(); 
		end;  	
	end; 
End; 

procedure cargarArchivoMaestro(var m: maestro); 
var
	nm: string[20]; 
	rm: registroMaestro; 
begin
	nm:= 'archivoProductos'; 
	assign(m, nm);
	writeln('**** CARGANDO ARCHIVO MAESTRO ****'); 	
	rewrite(m); 
	leerMaestro(rm); 
	while (rm.codigo <> corte) do begin
		write(m,rm); 
		leerMaestro(rm); 
	end; 
	close(m); 
End;

// ------------ crear Detalle ---------------
procedure leerDetalle(var rd: registroDetalle);
begin
	with rd do begin
		write('* Código: '); readln(cod);
		if (cod <> corte) then begin
			write('* Cantidad Vendida: '); readln(cantV);
			writeln(); 
		end; 	
	end; 	
End;
 
procedure cargarVectorDetalles(var v: vector; var d: detalle); 
var
	nd: string; 
	rd: registroDetalle;
	i: integer;  
begin 
	writeln('**** CARGANDO VECTOR DE DETALLES ****'); 
	for i:= 1 to tam do  begin
		Str(i, nd);
		assign(v[i], 'Sucursal'+nd); 
		rewrite(v[i]);
		writeln(); 
		writeln('-------------------------'); 
		writeln('* Cargando sucursal ', i); 
		writeln();		
		leerDetalle(rd); 
		while (rd.cod <> corte) do begin
			write(v[i], rd); 
			leerDetalle(rd); 
		end; 
		close(v[i]); 
	end;  
End;  

VAR
	m: maestro; 
	d: detalle;
	v: vector;  
BEGIN
	cargarArchivoMaestro(m); 
	cargarVectorDetalles(v, d); 
	
END.


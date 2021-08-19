program fod_P2E4CrearArchivoMaquinas;
const
	maquinas = 5; 
	corte = -1; 
type
	rDetalle = record
		cod_usuario: integer; 
		fecha : integer; 
		tiempo_sesion: real; 
	end; 
	
	rango = 1..maquinas; 
	detalle = file of rDetalle; 
	vArch = array[rango] of detalle; 

//--------------------------------
procedure leerMaquinas(var m: rDetalle);
begin
	with m do begin
		write('* Código de usuario: '); readln(cod_usuario);
		if (cod_usuario <> corte) then begin
			write(' fecha: '); readln(fecha);  
			write('* tiempo de sesión (en reales): '); readln(tiempo_sesion);
			writeln();  
		end;  
	end; 
End; 

//---------------------------------
procedure generarArchivoDetalle(var v: vArch);
var
	rd: rDetalle; 
	i: integer; 
	nd: string; 
begin
	writeln('**** Cargando Archivo Detalle ****'); 
	for i:= 1 to maquinas do begin
		writeln(); 
		writeln('----------------------------------'); 
		writeln('* Cargando máquina ', i); 
		Str(i, nd);
		assign(v[i], 'machine'+nd); 
		rewrite(v[i]); 
		leerMaquinas(rd);
		while (rd.cod_usuario <> corte) do begin
			write(v[i], rd); 
			leerMaquinas(rd); 
		end; 
		close(v[i]);  
	end; 	 
End;  

VAR 
	v: vArch; 
BEGIN
	generarArchivoDetalle(v); 
	
END.


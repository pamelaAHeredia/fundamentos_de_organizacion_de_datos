program untitled;
const 
	corte = 'zzzz';
	tam = 2;  
type 
	rMaestro = record
		destino: string; 
		fecha: integer; 
		horaSalida: integer;
		asientosDisp: integer;  
	end; 
	
	rDetalle = record
		destino: string; 
		fecha: integer; 
		horaSalida: integer;
		asientosOcup: integer; 
	end;
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array[1..tam] of rDetalle;

procedure leerM(var rm: rMaestro); 
begin
	with rm do begin
		write('* Destino: '); readln(destino); 
		if(rm.destino <> corte) then begin
			write('* Fecha: '); readln(fecha); 
			write('* Hora Salida: '); readln(horaSalida); 
			write('* Asientos Disponibles: '); readln(asientosDisp); 
			writeln(); 
		end; 
	end; 	
End;

procedure leerD(var rm: rDetalle); 
begin
	with rm do begin
		write('* Destino: '); readln(destino); 
		if(rm.destino <> corte) then begin
			write('* Fecha: '); readln(fecha); 
			write('* Hora Salida: '); readln(horaSalida); 
			write('* Asientos Ocupados: '); readln(asientosOcup); 
			writeln(); 
		end; 
	end; 	
End; 

procedure generarMaestro(); 
var
	m: maestro; 
	rm: rMaestro; 
begin
	writeln('======= CARGANDO MAESTRO ======='); 
	assign(m, 'maestroVuelos');
	rewrite(m); 
	leerM(rm);
	while(rm.destino <> corte) do begin
		write(m,rm); 
		leerM(rm); 
	end;  	
	close(m); 
End; 

procedure generarDetalle(); 
var
	v: vector; 
	rd: rDetalle; 
	i: integer; 
	nd: string; 
	
begin
	for i:= 1 to tam do begin
		writeln('==== CARGANDO DETALLE ', i, ' ====='); 
		str(i, nd); 
		assign(v[i], 'archVuelos'+nd);
		rewrite(v[i]); 
		leerD(rd);
		while (rd.destino <> corte) do begin
			write(v[i], rd);
			leerD(rd); 
		end; 
		close(v[i]);   
	end; 
End; 

BEGIN
	//generarMaestro(); 
	generarDetalle(); 	
END.


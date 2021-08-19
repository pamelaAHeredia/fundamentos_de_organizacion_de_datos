program untitled;
const 
	corte = -1; 
	tam = 3; 
type
	rMaestro = record
		dni: integer; 
		cod: integer; 
		monto: real; 
	end; 
	
	rDetalle = record
		dni: integer; 
		cod: integer; 
		montoPagado: real; 
	end; 	
	
	maestro = file of rMaestro; 
	detalle = file of rDetalle; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array[1..tam] of rDetalle;

procedure leerM(var rm: rMaestro); 
begin
	with rm do begin
		write('* Dni: '); readln(dni); 
		if(dni <> corte) then begin
			write('* Cod carrera: '); readln(cod);
			write('* Monto pagado: '); readln(monto);
			writeln(); 
		end; 
	end; 
End; 

procedure leerD(var rm: rDetalle); 
begin
	with rm do begin
		write('* Dni: '); readln(dni); 
		if(dni <> corte) then begin
			write('* Cod carrera: '); readln(cod);
			write('* Monto: '); readln(montoPagado);
			writeln(); 
		end; 
	end; 
End; 

procedure generarMaestro();
var
	m: maestro; 
	rm: rMaestro; 	
begin
	writeln('======= GENERANDO MAESTRO ========'); 
	assign(m, 'rapipagoMaestro');
	rewrite(m); 
	leerM(rm); 
	while(rm.dni <> corte) do begin
		write(m,rm); 
		leerM(rm); 
	end;  
	close(m); 
End;

procedure generarDetalle(var v: vector; var vr: vectorR);
var
	i: integer;  
	rd: rDetalle; 
	nd: string;  	
begin 
	for i:= 1 to tam do begin
		writeln('======= GENERANDO DETALLE ',i ,' ========');
		Str(i,nd); 
		assign(v[i], 'rapipagoDetalle'+ nd); 
		rewrite(v[i]); 
		leerD(rd);
		while(rd.dni <> corte) do begin
			write(v[i], rd); 
			leerD(rd); 
		end; 
		close(v[i]);  
	end; 	
End;  

VAR 
	v: vector; 
	vr: vectorR; 
BEGIN
	generarMaestro(); 
	generarDetalle(v,vr);  
	
END.


program untitled;
const
	corte = -1; 
	tam = 3; //100
type
	rMaestro = record
		fecha: integer; 
		cod: integer; 
		//nombre: string; 
		//desc: string; 
		//precio: real; 
		total: integer; 
		totalVentas: integer; 
	end; 
	
	rDetalle = record
		fecha: integer; 
		cod: integer; 
		cantVentas : integer; 
	end; 
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array [1..tam] of rDetalle; 

procedure leerM(var rm: rMaestro); 
begin
	with rm do begin
		write('* fecha: '); readln(fecha); 
		if(fecha <> corte) then begin
			write('* cod: '); readln(cod);
			write('* Stock: '); readln(total);
			write('* total ventas: '); readln(totalVentas);
			writeln(); 
		end; 
	end; 
End; 

procedure leerD(var rm: rDetalle); 
begin
	with rm do begin
		write('* fecha: '); readln(fecha); 
		if(fecha <> corte) then begin
			write('* Cod: '); readln(cod);
			write('* cant vendida: '); readln(cantVentas);
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
	assign(m, 'semanarioMaestro');
	rewrite(m); 
	leerM(rm); 
	while(rm.fecha <> corte) do begin
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
		assign(v[i], 'semanarioDetalle'+ nd); 
		rewrite(v[i]); 
		leerD(rd);
		while(rd.fecha <> corte) do begin
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
	//generarMaestro(); 
	generarDetalle(v,vr); 
	
END.


program untitled;
const
	corte = 'zzzz';
	tam = 2;   
type
	regMaestro = record
		prov: string; 
		cantPersonas: integer; 
		totalEnc: integer; 
	end; 
	
	regDetalle = record
		prov: string; 
		codLoc: integer; 
		cantPersonas: integer; 
		totalEnc: integer; 
	end; 
	
	maestro = file of regMaestro; 
	detalle = file of regDetalle; 
	
	vector = array[1..tam] of detalle; 
	vRegistros = array[1..tam] of regDetalle;  

procedure leerM(var r: regMaestro); 
begin
	with r do begin
		write('* provincia: ');readln(prov); 
		if(prov <> corte) then begin
			write('*Cantidad alfabetizados: ');readln(cantPersonas); 
			write('*Total de encuestados: ');readln(totalEnc); 
			writeln(); 
		end;  
	end; 
End;

procedure leerD(var r: regDetalle);
begin
	with r do begin
		write('* provincia: '); readln(prov); 
		if(r.prov <> corte) then begin
			write('* Código localidad: '); readln(codLoc); 
			write('* Cant alfabetizados: '); readln(cantPersonas); 
			write('* Total Encuestados: '); readln(totalEnc); 
			writeln(); 
		end; 	
	end; 
End;   

procedure generarMaestro(); 
var
	m: maestro; 
	rm: regMaestro; 
begin
	assign(m,'Censo');
	rewrite(m); 
	writeln('======== Generando maestro ========'); 
	leerM(rm); 
	while(rm.prov <> corte) do begin
		write(m,rm);
		leerM(rm);  
	end;
	close(m); 
End; 

procedure generarDetalles(Var v: vector); 
var
	nd: string; 
	rd: regDetalle; 
	i: integer; 
begin
	for i:= 1 to tam do begin 
		writeln('======== cargando archivo ', i,' ========'); 
		writeln(); 
		Str(i, nd);
		assign(v[i], 'DetalleCenso'+nd);
		rewrite(v[i]); 
		leerD(rd);
		while(rd.prov <> corte) do begin
			write(v[i], rd); 
			leerD(rd); 
		end; 
		close(v[i]); 
	end; 	 
End; 

//VAR
	//v: vector; 
BEGIN

	generarMaestro(); 
	//generarDetalles(v); 
END.


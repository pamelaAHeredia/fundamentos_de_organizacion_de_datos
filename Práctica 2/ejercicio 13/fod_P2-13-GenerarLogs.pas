program untitled;
const 
	corte = -1; 
type
	rMaestro = record
		nroUser: integer; 
		//nom_user: string; 
		//nombre: string; 
		//apellido: string; 
		cantMails: integer; 
	end; 
	
	rDetalle = record
		nroUser: integer; 
		//ctaDestino: string;
		//cuerpoMsj: string;  
	end; 
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 

procedure leerM(var r: rMaestro); 
begin
	with r do begin
		write('* num usuario: '); readln(nroUser);
		if(nroUser <> corte) then begin
			write('* cant Mails: '); readln(cantMails);
			writeln(); 
		end;  
	end; 
End;

procedure leerD(var r: rDetalle); 
begin
	with r do begin
		write('* num usuario: '); readln(nroUser);
	end; 
End;

procedure generarM(var m: maestro); 
var
	rm: rMaestro; 
begin
	writeln('==== GENERANDO MAESTRO ===='); 
	rewrite(m); 
	leerM(rm); 
	while(rm.nroUser <> corte) do begin
		write(m, rm); 
		leerM(rm);
	end; 
End; 

procedure generarD(var d: detalle); 
var
	rd: rDetalle; 
begin
	writeln('==== GENERANDO DETALLE ===='); 
	rewrite(d); 
	leerD(rd); 
	while(rd.nroUser <> corte) do begin
		write(d, rd); 
		leerD(rd);
	end; 
End; 

VAR 	
	m: maestro; 
	d: detalle; 
BEGIN
	assign(m, 'logsMaestro'); 
	assign(d, 'logsDetalle'); 
	//generarM(m); 
	generarD(d); 
END.


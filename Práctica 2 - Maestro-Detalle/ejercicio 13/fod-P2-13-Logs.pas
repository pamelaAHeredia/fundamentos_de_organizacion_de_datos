program untitled;
const 
	valorAlto = 9999; 
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

procedure leerD(var d: detalle; var rd: rDetalle); 
begin
	if(not eof(d)) then 
		read(d, rd)
	else
		rd.nroUser := valorAlto; 
end; 

procedure leerM(var m: maestro; var rm: rMaestro); 
begin
	if(not eof(m)) then 
		read(m,rm)
	else
		rm.nroUser := valorAlto; 
End;

procedure actualizarMaestro(var m: maestro; var d: detalle); 
var
	rd: rDetalle; 
	rm: rmaestro; 
	codAct, total: integer; 
begin
	reset(m); 
	reset(d); 
	leerD(d, rd); 
	
	while(rd.nroUser <> valorAlto) do begin
		leerM(m, rm);
		while (rm.nroUser <> rd.nroUser) do
			leerM(m, rm); 		
		
		codAct := rd.nroUser; 
		total := 0; 	
		
		while(rd.nroUser <> valorAlto) and (codAct = rd.nroUser) do begin 
			total := total +1; 
			leerD(d,rd);
		end; 	
 
		rm.cantMails := total;
		seek(m, filepos(m)-1); 
		write(m,rm); 
	end; 
	close(m); 
	close(d); 
End; 

procedure generarTxt(var m: maestro); 
var
	rm: rMaestro; 
	t: Text; 
begin
	assign(t, 'logs.txt'); 
	rewrite(t); 
	reset(m);
	leerM(m, rm); 
	while(rm.nroUser <> valorAlto) do begin
		writeln('escbriendo user ', rm.nroUser, ' cant: ', rm.cantMails); 
		writeln(t, rm.nroUser, ' ', rm.cantMails); 
		leerM(m, rm); 
	end; 
	close(m); 
	close(t); 
End; 

VAR 	
	m: maestro; 
	d: detalle; 
BEGIN
	assign(m, 'logsMaestro'); 
	assign(d, 'logsDetalle'); 
	actualizarMaestro(m, d); 
	generarTxt(m); 
	//actualizarM(m,d); 
END.


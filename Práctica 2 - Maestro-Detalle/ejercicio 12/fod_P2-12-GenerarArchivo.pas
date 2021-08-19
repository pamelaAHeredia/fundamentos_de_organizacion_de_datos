program untitled;
const 
	corte = -1; 
	
type
	registro = record
		cod: integer; 
		mes: integer; 
		anio: integer; 
		dia: integer; 
		tiempo: integer; 
	end; 
	
	archivo = file of registro; 

procedure leer(var r: registro); 
begin
	with r do begin
		write('* año: '); readln(anio);
		if(anio <> corte) then begin
			write('* mes: '); readln(mes); 
			write('* día: '); readln(dia); 
			write('* código: '); readln(cod); 
			write('* tiempo: '); readln(tiempo); 
			writeln(); 
		end;  
	end; 
End;

procedure generar(var a: archivo); 
var
	r: registro; 
begin
	rewrite(a); 
	writeln('====== CARGA ======');
	leer(r); 
	while(r.anio <> corte) do begin
		write(a,r); 
		leer(r);
	end; 
	close(a); 
End;  	

VAR 
	a: archivo; 
BEGIN
	assign(a,'archivoAnual'); 
	generar(a); 
	
END.


program p2e9; 
const 
	corte = -1; 
type 
	registro = record
		codProv: integer; 
		codLoc: integer;
		mesa: integer; 
		cantVotos: integer;  
	end;

	maestro = file of registro; 

//----------------------------------------------------------------------
procedure leer(var r: registro); 
begin
	with r do begin
		write('Código de provincia: '); readln(codProv); 
		if(codProv <> corte) then begin
			write('Código de localidad: '); readln(codLoc); 
			write('Mesa: '); readln(mesa); 
			write('Cantidad de votos: '); readln(cantVotos);
			writeln();  
		end; 	
	end; 
End; 

procedure generarMaestro(); 
var
	m: maestro; 
	r: registro; 
begin
	writeln('CREANDO ARCHIVO'); 
	assign(m, 'archProvincias');
	rewrite(m); 
	leer(r); 
	while (r.codProv <> corte) do begin
		write(m,r); 
		leer(r); 
	end; 
	close(m); 
end; 	
//----------------------------------------------------------------------	

BEGIN
	generarMaestro(); 
	
END.


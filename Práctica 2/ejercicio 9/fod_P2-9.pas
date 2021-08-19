program p2e9;
const valorAlto = 9999; 
type 
	registro = record
		codProv: integer; 
		codLoc: integer;
		mesa: integer; 
		cantVotos: integer;  
	end;

	maestro = file of registro; 

//----------------------------------------------------------------------
procedure leer(var m: maestro; var r: registro ); 
begin
	if (not eof(m)) then 
		read(m, r)
	else
		r.codProv := valorAlto; 
end; 
	
//----------------------------------------------------------------------	
procedure contabilizar(var m: maestro; var r: registro); 
var
	votosxprov, votosxloc, provActual, locActual: integer; 
	
begin
	reset(m);
	leer(m,r);
	while(r.codProv <> valorAlto) do begin
		provActual := r.codProv; 
		votosxprov := 0;   
		while (provActual = r.codProv) do begin 
			locActual := r.codLoc; 
			votosxloc := 0; 
			while((provActual = r.codProv) and (locActual = r.codLoc)) do begin
				votosxloc := votosxloc + r.cantVotos; 
				votosxprov := votosxprov + r.cantVotos; 
				leer(m,r); 
			end; 
			writeln('Código de provincia: ', provActual);
			writeln('Localidad: ', locActual, ' cantidad de votos: ', votosxloc);  
		end; 
	writeln('total de votos Provincia: ', votosxprov); 
	end; 
	
	close(m); 
end; 

procedure leerArchivo(); 
var
	r: registro; 
	m: maestro; 
begin
	assign(m, 'archProvincias'); 
	reset(m); 
	while(not eof(m)) do begin
		read(m,r); 
		writeln('CODIGO: ', r.codProv); 
	end; 
	close(m); 
End; 
//----------------------------------------------------------------------
VAR 
	m: maestro; 
	r: registro; 
BEGIN
	assign(m, 'archProvincias'); 
	contabilizar(m, r); 
	leerArchivo(); 
	
END.


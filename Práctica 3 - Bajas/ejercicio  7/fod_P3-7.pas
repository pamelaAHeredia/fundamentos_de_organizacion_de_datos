program fodP3E7;
const 
	corte = 500000; valorAlto = 9999; 
type
	registro = record
		codigo: longint; 
		especie: string[30]; 
		//familia: string[30]; 
		//desc: string[30]; 
		//zona: string[30]; 
	end; 
	
	archivo = file of registro; 

//----------------------------------------------------------------------
procedure print(var a: archivo);
var
	r: registro; 
begin
	reset(a); 
	while(not eof(a)) do begin
		read(a,r); 
		writeln('*Código: ', r.codigo); 
	end; 
end;  
  
//----------------------------------------------------------------------
procedure compactarVersionDos(var a: archivo); 
var
	r: registro; 
	pos: integer; 
begin
	reset(a); 
	while(not eof(a)) do begin
		read(a,r); 
		if(r.codigo < 0) then begin
			pos := filepos(a)-1; 
			seek(a, filesize(a)-1); 
			read(a,r); 
			seek(a, pos); 
			write(a, r);
			seek(a, filesize(a) -1); 
			truncate(a); 
			seek(a, pos); 
		end; 
	end; 
	close(a); 
End; 
//----------------------------------------------------------------------
procedure leer(var a: archivo; var r: registro); 
begin
	if(not eof(a)) then 
		read(a,r)
	else
		r.codigo := valorAlto; 
End; 

//----------------------------------------------------------------------
procedure bajaLogica(var a: archivo); 
var
	r: registro; 
	cod: longint; 
begin
	reset(a); 
	write('* codigo a eliminar: '); readln(cod); 
	while(cod <> corte) do begin
		leer(a,r); 
		while(r.codigo <> valorAlto) and (r.codigo <> cod) do 
			leer(a,r); 
		if(r.codigo = cod) then begin
			seek(a, filepos(a)-1); 
			r.codigo := r.codigo * -1; 
			write(a,r); 
		end
		else
			writeln('Cod inexistente'); 
		seek(a, 0); 
		write('* codigo a eliminar: '); readln(cod); 
	end; 
	close(a); 
End; 
//----------------------------------------------------------------------

VAR
	a:archivo;  
BEGIN
	assign(a,'archivoDeAves');
	print(a); 
	writeln(); 
	bajaLogica(a); 
	writeln(); 
	compactarVersionDos(a);
	writeln();  
	print(a); 
END.


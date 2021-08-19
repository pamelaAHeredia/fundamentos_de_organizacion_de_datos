program fodP3E4;
uses SysUtils; //hace funcionar las funciones de conversión 
const
	 corte = '0'; 
type
	tTitulo = String[50]; 
	tArchRevistas = file of tTitulo ;
//----------------------------------------------------------------------	
procedure generarArchivo(var a: tArchRevistas);
var
	t: tTitulo; 
begin
	//assign(a,'revista1'); 
	rewrite(a);
	t := corte; 
	write(a,t); 
	write('* Nombre de la revista: '); readln(t); 
	while(t <> corte) do begin
		write(a,t); 
		write('* Nombre de la revista: '); readln(t);
	end;  
	close(a); 
End;  
	
//----------------------------------------------------------------------
procedure agregar (var a: tArchRevistas ; titulo: string); 
var
	r, aux: tTitulo;
	pos:  integer;  
begin
	reset(a);
	leer(a,r);
	aux := titulo;  
	if(r <> '0') then begin
		pos:= IntToStr(r); 
		leer(a,r); 
		seek(a, pos); 
		write(a,aux); 
		seek(a,0); 
		write(a,r);   
	end
	else begin
		seek(a,filesize(a));
		write(a,aux);  
	end; 
	close(a); 	
End; 

//----------------------------------------------------------------------
procedure print(); 
var
	r: tTitulo; 
	a: tArchRevistas;  
begin
	assign(a,'revista1'); 
	reset(a); 
	while(not eof(a)) do begin
		read(a,r); 
		writeln(r); 
	end; 
	close(a);  
End; 
//----------------------------------------------------------------------
procedure leer(var a: tArchRevistas; var r:tTitulo); 
begin
	if (nor eof(a)) then 
		read(a,r)
	else
		r := valorAlto; 	
end; 
//----------------------------------------------------------------------
procedure eliminar (var a: tArchRevistas ; titulo: string);
var
	r: tTitulo; 
	cabecera, aux: string; 
begin
	reset(a);
	leer(a,r); 
	cabecera := r; 

	leer(a,r); 
	while(r <> valorAlto) and (r <> titulo) do 
		leer(a,r); 

	if(r = codigo) then begin
		seek(a, filepos(a)-1); 
		aux := IntToStr(filepos(a)); 
		r := cabecera; 
		write(a,r); 
		seek(a,0); 
		r := aux; 
		write(a,r); 
	end
	else
		writeln('Nombre inexistente.'); 
	close(a); 	
End; 

//----------------------------------------------------------------------
function convertir(texto: string): integer;
var
    valor, codigoDeError: integer;
begin
    valor := 0;
    val(texto, valor, codigoDeError);
    convertir := codigoDeError;
end

//----------------------------------------------------------------------
procedure listarValidas(var a: tArchRevistas); 
var
	r: tTitulo; 
begin
	reset(a);
	while (not eof(a)) do begin
		read(a,r); 
		if (convertir(r) <> 0) then 
			writeln(r); 
	end;
	close(a); 
End; 
//----------------------------------------------------------------------
var
	a: tArchRevistas; 
	n: string; 
BEGIN
	assign(a,'revista1');
	//generarArchivo(a); 
	writeln(''); //
	print(); 
	writeln('');
	write('* Nombre del archivo a agregar: ');   readln(n); 
	agregar(a,n); 
	writeln('');
	print();

END.


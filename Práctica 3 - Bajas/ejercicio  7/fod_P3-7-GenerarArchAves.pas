{
  Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción, 
  * para ello se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica. 
  * El archivo no está ordenado por ningún criterio.
   
   
}


program generarArchivoEj7;
const 
	corte = -1; 
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
procedure leer(var r: registro); 
begin
	with r do begin
		write('* Código: ');readln(codigo); 
		if(codigo <> corte) then begin
			write('* Especie: ');readln(especie); 
			writeln(); 
		end; 
	end; 	
End; 

//----------------------------------------------------------------------
procedure generarArchivo();
var
	a: archivo;
	r: registro; 
begin
	assign(a,'archivoDeAves'); 
	rewrite(a);
	leer(r);
	while(r.codigo <> corte) do begin
		write(a,r); 
		leer(r); 
	end;   
End;  

//----------------------------------------------------------------------
BEGIN
	generarArchivo(); 	
END.


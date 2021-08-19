{
Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con la información correspondiente a las prendas que se encuentran a la venta. 
De cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario. 
Ante un eventual cambio de temporada, se deben actualizar las prendas a la venta. 
Para ello reciben un archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas. 
Deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda 
correspondiente a valor negativo. 
   
}


program untitled;
const
	corte = 0; 
type
	prenda = record
		cod_prenda: integer; 
		//desc: string[50]; 
		//colores: string[50]; 
		//tipo_prenda: string[50];
		stock: integer; 
		precio_unitario: real;  
	end; 
	
	cod = integer; 
	
	maestro = file of prenda; 
	archivo = file of cod; //codigos de achivos
	
//----------------------------------------------------------------------	
procedure leerPrenda(var p: prenda); 
begin
	with p do begin
		write('* Código de prenda: '); readln(cod_prenda); 
		if(cod_prenda <> corte) then begin
			write('* Stock: '); readln(stock); 
			write('* Precio unitario: '); readln(precio_unitario); 
			writeln(); 
		end; 
	end; 
End;

//----------------------------------------------------------------------	

procedure generarMaestro(); 
var
	a: maestro; 
	p: prenda; 
begin
	writeln('============ GENERANDO MAESTRO =============='); 
	assign(a, 'archivoDePrendas');
	rewrite(a);
	leerPrenda(p); 
	while(p.cod_prenda <> corte) do begin
		write(a,p);
		leerPrenda(p);  
	end; 
	close(a);   
End; 

procedure generarArchivo(); 
var
	a: archivo; 
	n: cod; 
begin
	writeln('============ GENERANDO DETALLE =============='); 
	assign(a, 'archivoDeCodigos');
	rewrite(a);
	write('* Código de la prenda: '); readln(n);
	writeln(); 
	while (n <> corte) do begin
		write(a,n);
		write('* Código de la prenda; '); readln(n);
		writeln();  
	end;   
	close(a);  
End; 
	
//----------------------------------------------------------------------		
BEGIN
	generarMaestro(); 
	generarArchivo(); 
		
END.


program fodP2E7GenerarEmpresa;
const
	corte = -1;
type
	cliente = record

	end; 
	
	fecha = record
		anio: integer; 
		mes: integer; 
		dia: integer; 
	end; 
	
	registroMaestro = record
		codigo: integer; 
		nombre: string; 
		apellido: string; 	
		fech: fecha; 
		monto: real; 
	end;
	
	maestro = file of registroMaestro; 
//----------------------------------------------------------------------
procedure leerFecha(var f: fecha);
begin
	with f do begin
		write('* Año: '); readln(anio); 
		write('* Mes: '); readln(mes); 
		write('* Día: '); readln(dia); 
	end; 
End;  	 

procedure leerRM(var r: registroMaestro);
var
	f: fecha; 
	c: cliente; 
begin
	with r do begin
		write('* código de cliente: '); readln(codigo);
		if(codigo <> corte) then begin 
			write('* nombre: '); readln(nombre); 
			write('* apellido: '); readln(apellido);  		
			leerFecha(f); 
			write('* Monto total de la venta: '); readln(monto);
			writeln();  
		end; 	
	end; 
End;  

//----------------------------------------------------------------------
procedure generarMaestro(var m: maestro); 
var
	rm: registroMaestro; 
begin
	writeln('******** RESGISTRO MAESTRO ********');
	writeln();  
	assign(m, 'archivoEmpresa'); 
	rewrite(m);
	leerRM(rm); 
	while(rm.cli.codigo <> corte) do begin
		write(m,rm);
		leerRM(rm);  
	end;  
End; 


//----------------------------------------------------------------------
VAR
	m: maestro; 
BEGIN
	generarMaestro(m); 
END.


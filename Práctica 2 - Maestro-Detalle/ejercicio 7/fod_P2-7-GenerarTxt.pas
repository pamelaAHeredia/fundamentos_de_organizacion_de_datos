program fodP2E7GenerarTxt;
const 
	corte = -1; 
type
	registroMaestro = record
		codigo: integer; 
		nombre: string; 
		precio: real; 
		stockAct: integer; 
		stockMin: integer; 
	end; 
	
	registroDetalle = record
		codigo: integer; 
		ventas: integer; 
	end; 
	
	detalle = file of registroDetalle; 
	maestro = file of registroMaestro; 

//----------------------------------------------------------------------
procedure leerRM(var rm: registroMaestro);
begin
	with rm do begin
		write('* Código: '); readln(codigo); 
		if (codigo <> corte) then begin
			write('* Nombre: '); readln(nombre);
			write('* Precio: '); readln(precio);
			write('* Stock Actual: '); readln(stockAct);
			write('* Stock Mínimo: '); readln(stockMin);
			writeln(); 
		end; 	
	end; 	
End;

procedure leerRD(var rd: registroDetalle);
begin
	with rd do begin
		write('* codigo: '); readln(codigo);
		if(codigo <> corte)then begin
			write('* Total de ventas: '); readln(ventas);
			writeln(); 
		end; 
	end; 
End;    

//----------------------------------------------------------------------
procedure generarMaestroTxt(var t: Text);
var
	rm: registroMaestro;
begin
	writeln('********* GENERANDO TXT MAESTRO **********'); 
	writeln(); 
	assign(t,'productos.txt'); 
	rewrite(t); 
	leerRM(rm); 
	while (rm.codigo <> corte) do begin
		with rm do begin
			writeln(t,codigo,' ',precio:0:2,' ',nombre); 
			writeln(t,stockAct,' ',stockMin); 
		end; 
		leerRM(rm); 	
	end; 
	close(t); 
End; 

procedure generarDetalleTxt(var t: Text);
var
	rd: registroDetalle; 
begin
	writeln('********* GENERANDO TXT DETALLE **********'); 
	writeln();
	assign(t,'ventas.txt'); 
	rewrite(t); 
	leerRD(rd); 
	while(rd.codigo <> corte) do begin
		with rd do 
			writeln(t,codigo,' ',ventas); 
		leerRD(rd); 	
	end; 
	close(t); 
End;   

//----------------------------------------------------------------------
VAR
	t: Text; 
BEGIN
	//generarMaestroTxt(t); 
	generarDetalleTxt(t); 
END.


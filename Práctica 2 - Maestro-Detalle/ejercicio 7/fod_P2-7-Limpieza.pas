program fodEj7Limpieza;
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
procedure generarMaestro(var m: maestro; var t: Text); 
var
	rm: registroMaestro; 
begin
	assign(t, 'productos.txt');
	assign(m, 'productosMaestro');
	reset(t); 
	rewrite(m); 
	while (not eof(t)) do begin
		with rm do begin
			readln(t,codigo,precio,nombre); 
			readln(t,stockAct, stockMin); 
		end; 
		write(m,rm); 
	end; 
	close(t); 
	close(m); 
End; 

//----------------------------------------------------------------------
procedure generarDetalle(var d: detalle; var t: Text);
var
	rd: registroDetalle; 
begin
	assign(t,'ventas.txt'); 
	assign(d,'detalleDeVentas');
	reset(t); 
	rewrite(d); 
	while (not eof(t)) do begin
		with rd do 
			readln(t,codigo, ventas); 
		write(d,rd); 	
	end;  
	close(t); 
	close(d); 
End; 

//---------------------------------------------------------------------- 
procedure imprimir(var d: detalle);
var
	rd: registroDetalle; 
begin
	assign(d,'detalleDeVentas'); 
	reset(d);   
	while (not eof(d)) do begin
		read(d,rd); 
		writeln('* Código: ', rd.codigo,' *Cantidad de Ventas: ', rd.ventas);
	end; 
	close(d); 
End; 

procedure imprimir(var m : maestro);
var
	rm: registroMaestro; 
begin
	assign(m,'productosMaestro'); 
	reset(m);   
	while (not eof(m)) do begin
		read(m,rm); 
		writeln('* Código: ', rm.codigo,' *Stock actual: ', rm.stockAct);
	end; 
	close(m); 
End; 
//----------------------------------------------------------------------
procedure actualizarMaestro(var m: maestro; var d:detalle);
var
	rm: registroMaestro; 
	rd: registroDetalle; 
	found: boolean; 
begin
	assign(m,'productosMaestro'); 
	assign(d,'detalleDeVentas'); 
	reset(m); 
	reset(d); 
	while (not eof(d)) do begin
		read(d,rd);
		found := false; 
		while(not eof(m) and (not found)) do begin
			read(m,rm);
			writeln('cod m: ',rm.codigo, ' cod d: ',rd.codigo); 
			if (rm.codigo = rd.codigo) then 
				found := true; 
		end; 
		rm.stockAct:= rm.stockAct - rd.ventas; 
		seek(m,filepos(m)-1); 
		write(m,rm); 
	end; 
	close(m); 
	close(d);
End;  

//----------------------------------------------------------------------
VAR
	m: maestro; 
	d: detalle; 
	t: Text; 
BEGIN
	generarMaestro(m,t);
	imprimir(m); 
	writeln(); 
	generarDetalle(d,t);  
	imprimir(d);
	actualizarMaestro(m,d); 
	writeln(); 
	imprimir(m); 
END.


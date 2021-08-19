{Se cuenta con un archivo maestro con los artículos de una cadena de venta de indumentaria. 

De cada artículo se almacena: código del artículo, nombre, descripción,talle, color, stock disponible, stock mínimo y precio del artículo.

Se recibe diariamente un archivo detalle de cada una de las 15 sucursales de la cadena. 

Se debe realizar el procedimiento que recibe los 15 detalles y actualiza el stock del archivo maestro. 

La información que se recibe en los detalles es: código de artículo y cantidad vendida. 

Además, se deberá informar en un archivo de texto: nombre de artículo, descripción, stock disponible y precio de aquellos artículos 
que tengan stock disponible por debajo del stock mínimo.

Nota: todos los archivos se encuentran ordenados por código de artículo. 

En cada detalle puede venir 0 o N registros de un determinado artículo.
}


program fod6_generarMaestro;
const
	corte = -1; 
	tam = 3;
	valorAlto = 9999;  
type
	registroMaestro = record
		nombre: string; 
		codigo: integer; 
		desc: string; 
		talle: string; 
		color: string; 
		stockD: integer; 
		stockM: integer; 
		precio: real; 
	end; 
	
	registroDetalle = record
		codigo: integer; 
		cantidadVendida: integer; 
	end; 
	
	detalle = file of registroDetalle; 
	maestro = file of registroMaestro; 
	
	vectorDetalles = array[1..tam] of detalle; 
	vectorRegistros = array[1..tam] of registroDetalle; 

//----------------------------------------------------------------------	
procedure leer(var d: detalle; var rd:registroDetalle); 
begin
	if (not eof(d)) then 
		read(d,rd)
	else
		rd.codigo := valorAlto; 
End; 

//----------------------------------------------------------------------
procedure minimo(var v: vectorDetalles; var vr: vectorRegistros; var min: registroDetalle);
var
	i, posMin: integer;  
begin
	min.codigo := valorAlto; 
	for i:= 1 to tam do begin
		if (vr[i].codigo < min.codigo) then begin
			posMin:= i; 
			min:= vr[i]; 
		end; 
	end; 
	if(min.codigo <> valorAlto) then 
		leer(v[posMin], vr[posMin]); 
End; 

//----------------------------------------------------------------------
{Se debe realizar el procedimiento que recibe los 15 detalles y actualiza el stock del archivo maestro. }
procedure actualizarMaestro(var m: maestro; var vd: vectorDetalles; var vr: vectorRegistros);
var
	totalVentas, actual, i: integer; 
	min: registroDetalle;  
	rm: registroMaestro; 
	found: boolean; 
begin
	assign(m,'tiendaDeRopa.maestro'); 
	reset(m); 
	minimo(vd,vr,min); 
	while (min.codigo <> valorAlto) do begin
		actual := min.codigo; 
		totalVentas := 0;
		found:= false; 	
		while(min.codigo = actual) do begin
			totalVentas := totalVentas + min.cantidadVendida; 
			minimo(vd,vr,min); 
		end;    
		while(not eof(m) and not found) do begin 
			read(m,rm);
			writeln('código del maestro: ', rm.codigo, ' codigo buscado: ', actual);
			if (rm.codigo = actual) then
				found := true; 
		end; 	
		rm.codigo := actual; 
		rm.stockD:= rm.stockD - totalVentas;	
		writeln('Elcodigo ', rm.codigo, ' vendió ',totalVentas,'. El stock es ',rm.stockD);		
		seek(m,filepos(m)-1); 
		write(m,rm); 
	end; 
	close(m); 
	for i:= 1 to tam do 
		close(vd[i]); 
End;  

procedure imprimir(var m: maestro);
var
	rm: registroMaestro; 
begin
	assign(m,'tiendaDeRopa.maestro'); 
	reset(m);   
	while (not eof(m)) do begin
		read(m,rm); 
		writeln('Código: ', rm.codigo,' *Stock Disponible: ', rm.stockD); 
	end; 
	close(m); 
End; 

//----------------------------------------------------------------------
{Además, se deberá informar en un archivo de texto: nombre de artículo, descripción, stock disponible y precio de aquellos artículos 
que tengan stock disponible por debajo del stock mínimo.}
procedure exportarATxt(var m: maestro; var t:Text); 
var
	rm: registroMaestro; 
begin
	assign(m,'tiendaDeRopa.maestro'); 
	reset(m);
	assign(t,'tiendaDeRopa.txt');
	rewrite(t);
	while (not eof(m)) do begin
		read(m,rm); 
		if(rm.stockM > rm.stockD) then begin
			with rm do begin
				writeln(t, desc,' ',stockD,' ',precio:0:2); 
			end; 
		end; 
	end; 
	close(m); 	
	close(t); 
End; 

//----------------------------------------------------------------------
VAR
	m: maestro; 
	v: vectorDetalles; 
	vr: vectorRegistros; 
	i: integer; 
	nd: string; 
	t: text; 
BEGIN
	for i:= 1 to tam do begin
		str(i,nd); 
		assign(v[i], ' TiendaNumero'+nd);
		reset(v[i]); 
		leer(v[i], vr[i]); 
	end; 
	imprimir(m); 
	writeln(); 
	actualizarMaestro(m,v,vr); 
	imprimir(m); 
	exportarATxt(m,t); 
	
END.


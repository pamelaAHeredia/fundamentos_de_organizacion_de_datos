{
3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. 
De cada producto se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto.

Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. 

Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro. 

La información que se recibe en los detalles es: código de producto y cantidad vendida. 

Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo.

Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle puede venir 0 o N registros de un determinado producto.  
   
}


program fod_P2E3;
const
	valorAlto = 9999; 
	tam = 4;  
type
	registroMaestro = record
		codigo: integer; 
		nombre: string[15]; 
		desc: string[20]; 
		stockD: integer; 
		stockM: integer; 
		precio: real; 
	end; 
	
	rango = 1..tam; 
	
	registroDetalle = record
		cod: integer; 
		cantV: integer; 
	end; 
	
	maestro = file of registroMaestro; 
	detalle = file of registroDetalle; 
	
	vector = array [rango] of detalle; 
	vectorR = array[rango] of registroDetalle; 

//----------- recibe los 30 detalles y actualiza el stock del archivo maestro -------------

procedure leerHastaValorAlto(var d: detalle; var rd: registroDetalle); 
begin
	if (not eof(d)) then 
		read(d,rd)
	else
		rd.cod := valorAlto; 
End;

procedure minimo(var v: vector; var vr: vectorR; var min:registroDetalle);
var
    i,posMin:integer;
begin
    min.cod:=9999;
    for i:=1 to tam do begin 
        if (vr[i].cod < min.cod) then begin
            min:=vr[i]; 
            posMin:=i;
        end;
    end;
    if (min.cod <> valoralto) then
        leerHastaValorAlto(v[posMin], vr[posMin]); //próximo registro del detalle - registro
end;

//-------------------------------------------------------------

procedure actualizarMaestro(var v: vector; var vr: vectorR; var m: maestro); 
var
	min: registroDetalle; 
	rm: registroMaestro;
	i: integer;  
begin
	writeln('ATCUALIZAR MAESTRO');
	writeln('calculando min'); 
	minimo(v,vr, min); 
	writeln('entrando al while ---> ', min.cod, '<>', valorAlto);
	while(min.cod <> valorAlto) do begin
		writeln('Haciendo read del maestro');
		read(m,rm); 
		writeln('segundo while ', rm.codigo,'=',min.cod);
		while (rm.codigo =  min.cod) do begin
			rm.stockD := rm.stockD - min.cantV; 
			minimo(v,vr,min); 
		end; 
		writeln('* seek'); 
		seek(m, filepos(m)-1); 
		write(m,rm);
	end;
	writeln('cerrando archivos');
	close(m); //cierro maestro
	for i:= 1 to tam do 
		close(v[i]);  //cierro detalles
	writeln('End; ');	
End; 

//---------------------------------------------------

procedure imprimir(var m: maestro); //debug
var
	rm: registroMaestro; 
begin
	assign(m,'archivoProductos'); 
	reset(m); 
	while (not eof(m)) do begin
		read(m,rm); 
		writeln('Codigo: ', rm.codigo,' * stockDisp: ', rm.stockD);
	end;
	close(m);  
End; 

//----------------------------------------------------

procedure exportarATxtStockMin(var m: maestro; var t: Text); 
var
	rm: registroMaestro; 
begin
	assign(t, 'stockMin.txt'); 
	assign(m, 'archivoProductos');
	rewrite(t); 
	reset(m); 
	while (not eof(m)) do begin;
		read(m, rm);
		if (rm.stockD < rm.stockM) then begin
			with rm do begin
				writeln(t,' ',stockD,' ', nombre);
				writeln(t,' ', precio:0:2, ' ', desc);  
			end; 
		end;  
	end; 
	close(m); 
	close(t);  
End; 
//------------ prog ppal -----------------	
VAR	
	m: maestro; 
	v: vector;  
	vr: vectorR; 
	nd: string; 
	nm: string[20]; 
	i: integer; 
	t: Text; 	

BEGIN
	for i:= 1 to tam do begin //abrir archivos para lectura
		Str(i, nd);
		assign(v[i], 'Sucursal'+nd);
		reset(v[i]); 
		leerHastaValorAlto(v[i], vr[i]); 
	end; 	
	nm:= 'archivoProductos'; 
	assign(m, nm);
	imprimir(m); 
	reset(m); 	
	actualizarMaestro(v,vr,m); 	
	imprimir(m);  
	exportarATxtStockMin(m,t); 
	
END.


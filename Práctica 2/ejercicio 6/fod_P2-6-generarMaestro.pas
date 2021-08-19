{Se cuenta con un archivo maestro con los artículos de una cadena de venta de indumentaria. 

De cada artículo se almacena: código del artículo, nombre, descripción,talle, color, stock disponible, stock mínimo y precio del artículo. 

Nota: todos los archivos se encuentran ordenados por código de artículo.  

Se recibe diariamente un archivo detalle de cada una de las 15 sucursales de la cadena. 

La información que se recibe en los detalles es: código de artículo y cantidad vendida.
}


program fod6_generarMaestro;
const
	corte = -1; 
	tam = 3; 
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

//----------------------------------------------------------------------
procedure leerRM(var rm: registroMaestro); 
begin
	with rm do begin
		write('* Código: '); readln(codigo);
		if (codigo <> corte) then begin
			write('* Nombre: '); readln(nombre); 
			write('* Descripción: '); readln(desc);
			write('* Talle: '); readln(talle);
			write('* Color: '); readln(color);
			write('* Stock disponible: '); readln(stockD);
			write('* Stock mínimo: '); readln(stockM);
			write('* Precio: '); readln(precio);
			writeln(); 
		end;  
	end; 	
End; 	

procedure leerRD(var rd: registroDetalle);
begin
	with rd do begin
		write('* Código: '); readln(codigo);
		if (codigo <> corte) then begin
			write('* Cantidad Total vendida: '); readln(cantidadVendida);
			writeln(); 
		end; 
	end; 
End; 

//----------------------------------------------------------------------
procedure generarArchivosDetalle(var v: vectorDetalles);  
var
	rd: registroDetalle; 
	i: integer; 
	nd: String; 
begin
	writeln('********** CARGANDO ARCHIVOS DETALLE **********'); 
	for i := 1 to tam do begin	
		writeln(); 	
		writeln('------- Sucursal ', i,' -------'); 
		str(i,nd); 
		assign(v[i], ' TiendaNumero'+nd);
		rewrite(v[i]);
		leerRD(rd); 
		while(rd.codigo <>corte) do begin
			write(v[i], rd); 
			leerRD(rd); 
		end;
		close(v[i]);   
	end; 
End; 

procedure generarMaestro(var m: maestro); 
var
	rm: registroMaestro; 
begin
	writeln('********** CARGANDO ARCHIVO MAESTRO **********'); 
	assign(m, 'tiendaDeRopa.maestro'); 
	rewrite(m); 
	leerRM(rm); 
	while (rm.codigo <> corte) do begin
		write(m,rm); 
		leerRM(rm); 
	end; 
End; 

//----------------------------------------------------------------------
VAR
	m: maestro; 
	//d: vectorDetalles; 
BEGIN
	//generarArchivosDetalle(d); 
	generarMaestro(m); 
	
END.


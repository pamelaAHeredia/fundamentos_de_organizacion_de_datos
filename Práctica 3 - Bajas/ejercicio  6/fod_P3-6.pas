program fodP3E6;
const
	valorAlto = 9999; 
type
	rMaestro= record
		cod_prenda: integer; 
		//desc: string[50]; 
		//colores: string[50]; 
		//tipo_prenda: string[50];
		stock: integer; 
		precio_unitario: real;  
	end; 
	
	rDetalle = record
		codPrenda: integer; 
	end; 	 
	
	maestro = file of rMaestro; 
	detalle = file of rDetalle; 

//----------------------------------------------------------------------
procedure leerM(var m: maestro; var rm: rMaestro);
begin
	if(not eof(m)) then 
		read(m,rm)
	else
		rm.cod_prenda := valorAlto; 
end; 

procedure leerD(var d: detalle; var rd: rDetalle);  
begin
	if (not eof(d)) then 	
		read(a,rd)
	else
		rd:= valorAlto; 
end; 
//----------------------------------------------------------------------	
procedure bajaLogica(var d: detalle; var m: maestro);
var
	rm: rMaestro; 
	rd: rDetalle;  
begin
	reset(d); 
	reset(m); 
	leerD(d,rd); 	 	 
	while(rd.codPrenda <> valorAlto) do begin 
		leerM(m,rm); 
		while((rm.cod_prenda <>valorAlto) and (rd.codPrenda <> rm.cod_prenda)) do 
			leerM(m,rm); 
		rm.cod_prenda := rm.cod_prenda * -1; 
		seek(m, filepos(m)-1); 
		write(m,rm); 
		seek(m,0);		
		leerD(d,rd); 
	end; 
	close(d); 
	close(m); 	
end;  	

//----------------------------------------------------------------------
procedure print();
var
	m: maestro; 
	rm: rMaestro; 
begin
	assign(m, 'archivoDePrendas');
	reset(m); 
	while(not eof(m)) do begin
		read(m,rm); 
		writeln('* stock: ', rm.stock); 
	end; 	
	close(m);
end;

procedure printA();
var
	a:detalle; 
	rd: rDetalle; 
begin
	assign(a, 'archivoDeCodigos');
	reset(a); 
	while(not eof(a)) do begin
		read(a,rd); 
		writeln('* codigo: ', rd.codPrenda); 
	end; 	
	close(a);
end;

procedure compactar(var m: maestro); 
var	
	aux: maestro; 
	r: rMaestro; 
begin
	assign(aux, 'auxiliar'); 
	rewrite(aux);
	reset(m); 
	while (not eof(m)) do begin
		read(m,r); 
		if (r.stock > 0) then 
			write(aux,r); 
	end;
	close(m); 
	erase(m); 
	close(aux);	
	rename(aux, 'archivoDePrendas'); 
End; 

//----------------------------------------------------------------------
VAR
	a: archivo; 
	m: maestro; 
BEGIN
	assign(m, 'archivoDePrendas');
	assign(a, 'archivoDeCodigos');	
	bajaLogica(a,m);	
	compactar(m); 
	print(); 
END.


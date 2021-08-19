program untitled;
const
	valorAlto = 9999; 
	tam = 3; //100
type
	rMaestro = record
		fecha: integer; 
		cod: integer; 
		//nombre: string; 
		//desc: string; 
		//precio: real; 
		total: integer; 
		totalVentas: integer; 
	end; 
	
	rDetalle = record
		fecha: integer; 
		cod: integer; 
		cantVentas : integer; 
	end; 
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array [1..tam] of rDetalle; 

procedure leerD(var d: detalle; var rd: rDetalle); 
begin
	if (not eof(d)) then 
		read(d, rd)
	else
		rd.fecha := valorAlto; 
End; 	

procedure leerM(var m: maestro; var rm: rMaestro); 
begin
	if (not eof(m)) then 
		read(m,rm)
	else
		rm.fecha := valorAlto; 
End; 

procedure minimo(var v: vector; var vr: vectorR; var min: rDetalle); 
var
	i, posmin: integer; 
begin
	min.fecha: valorAlto; 
	min.cod:  valorAlto; 
	for i:= 1 to tam do begin
		if(vr[i].fecha <= min.fecha) and (vr[i].cod <= min.cod)then begin
			posmin:= i; 
			min:= vr[i]; 
		end; 
	end; 
	leerD(v[posmin], vr[posmin]); 
End; 

procedure actualizarMaestro(var v: vector; var vr: vectorR; var m: maestro);
var
	rm: rMaestro; 
	totalVentas, i: integer; 
	min: rDetalle; 
begin
	reset(m); 
	minimo(v, vr, min); 
	while(min.fecha <> valorAlto) do begin
		leerM(m,rm);
		while((rm.fecha <> mi.fecha) and (rm.cod <> min.cod) do 
			leerM(m,rm); 

		totalVentas := 0; 		
		while (min.fecha = rm.fecha) and (min.cod = rm.cod) do begin
			totalVentas := totalVentas + min.cantVentas; 
			minimo(v,vr,min); 
		end; 
		

		if(totalVentas <= rm.total) then begin
			rm.total := rm.total - totalVentas;
			rm.totalVentas := rm.totalVentas + totalVentas;  
			seek(m, filepos(m) - 1); 
			write(m,rm); 
		end
		else
			writeln('Sin stock Disponible'); 
	end; 
	for i := 1 to tam do 
		close(v[i]); 
	close(m); 	
End;  

procedure print(var m: maestro); 
var
	rm: rMaestro; 
begin
	reset(m);
	leerM(m,rm);  
	while(rm.fecha <> valorAlto) do begin
		writeln('Fecha: ', rm.fecha, ' Cod: ', rm.cod, ' Stock Disp: ', rm.total, ' Vendidos: ', rm.totalVentas); 
		leerM(m, rm); 
	end; 
End; 	

VAR 
	i: integer; 
	nd: string; 
	v: vector; 
	vr: vectorR; 
	m: maestro; 
BEGIN
	assign(m, 'semanarioMaestro'); 
	print(m);
	writeln(); 
	for i:= 1 to tam do begin
		Str(i,nd); 
		assign(v[i], 'semanarioDetalle'+ nd); 
		reset(v[i]); 
		leerD(v[i], vr[i]); 
	end; 
	actualizarMaestro(v, vr, m); 	
	writeln('====== ACTUALIZADO =======');
	print(m);  
	
END.


program untitled;
const
	tam = 2; 
	valorAlto = 9999; 
	valorAltoString = 'zzzzz'; 
	
type 
	rMaestro = record
		destino: string; 
		fecha: integer; 
		horaSalida: integer;
		asientosDisp: integer;  
	end; 
	
	rDetalle = record
		destino: string; 
		fecha: integer; 
		horaSalida: integer;
		asientosOcup: integer; 
	end; 
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array[1..tam] of rDetalle;

procedure leerM(var m: maestro; var rm: rMaestro); 
begin
	if (not eof(m)) then
		read(m, rm)
	else
		rm.destino := valorAltoString; 
End; 

procedure leerD(var d: detalle; var rd: rDetalle); 
begin
	if (not eof(d)) then
		read(d, rd)
	else
		rd.destino := valorAltoString; 
End; 

procedure minimo(var v: vector; var vr: vectorR; var min: rDetalle); 
var
	i, posmin: integer; 
begin
	min.destino := valorAltoString; 
	min.fecha := valorAlto; 
	min.horaSalida := valorAlto; 

	for i:= 1 to tam do begin
		if (vr[i].destino <= min.destino) and (vr[i].fecha <= min.fecha) and (vr[i].horaSalida <= min.horaSalida) then begin
			min := vr[i]; 
			posmin := i; 
		end; 
	end;  
	leerD(v[posmin], vr[posmin]); 
End; 

procedure actualizarMaestro(var v: vector; var vr: vectorR; var m: maestro);
var
	rm: rMaestro; 
	i, cant, ventas: integer; 
	min: rDetalle; 

begin	
	reset(m); 

	writeln('Cantidad a comparar: '); readln(cant); 
	minimo(v, vr, min);
	 
	while(min.destino <> valorAltoString) do begin
		leerM(m,rm);
		while(rm.destino <> min.destino)and (rm.fecha <> min.fecha) and (rm.horaSalida <> min.horaSalida) do
			leerM(m,rm); 
		
		ventas := 0; 
		while(rm.destino = min.destino)and (rm.fecha = min.fecha) and (rm.horaSalida = min.horaSalida) do begin
			ventas := ventas + min.asientosOcup; 
			minimo(v,vr,min); 
		end; 
		
		seek(m, filepos(m)-1); 
		rm.asientosDisp := rm.asientosDisp - ventas; 
		write(m,rm); 
			
		if (ventas < cant) then 
			writeln('Vuelo que no alcanzó la cantidad mínima de asientos ocupados. Destino:  ',rm.destino, ' fecha: ',rm.fecha, ' hora: ', rm.horaSalida,' ventas: ', ventas); 		

	end;
	 
	for i:= 1 to tam do 
		close(v[i]);
	close(m); 	
	
End;  

procedure imprimir(var m: maestro); 
var
	rm: rMaestro; 
begin
	reset(m); 
	leerM(m,rm); 
	while(rm.destino <> valorAltoString) do begin
		writeln('Destino:  ',rm.destino, ' fecha: ',rm.fecha, ' hora: ', rm.horaSalida,' asientos libres: ', rm.asientosDisp); 
		leerM(m,rm); 
	end; 
	close(m); 
End; 	

VAR 
	v: vector; 
	vr: vectorR; 
	m: maestro; 
	i: integer; 
	nd: string; 
BEGIN
	assign(m, 'maestroVuelos');
	writeln('====== RM ======'); 
	imprimir(m); 
	writeln(''); 
	for i:= 1 to tam do begin
		str(i, nd); 
		assign(v[i], 'archVuelos'+nd);
		reset(v[i]); 
		leerD(v[i], vr[i]);  
	end; 
	actualizarMaestro(v,vr, m);  
	writeln(''); 
	writeln('====== RM act ======'); 
	imprimir(m); 		
END.


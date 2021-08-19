program untitled;
const 
	valorAlto = 9999; 
	tam = 3; 
type
	rMaestro = record
		dni: integer; 
		cod: integer; 
		monto: real; 
	end; 
	
	rDetalle = record
		dni: integer; 
		cod: integer; 
		montoPagado: real; 
	end; 	
	
	maestro = file of rMaestro; 
	detalle = file of rDetalle; 
	
	vector = array[1..tam] of detalle; 
	vectorR = array[1..tam] of rDetalle; 
	
procedure leerM(var m: maestro; var rm: rMaestro); 
begin
	if (not eof(m)) then 
		read(m, rm)
	else
		rm.dni := valorAlto; 
End; 

procedure leerD(var m: detalle; var rm: rDetalle); 
begin
	if (not eof(m)) then 
		read(m, rm)
	else
		rm.dni := valorAlto; 
End; 	

dni_alumno y luego por codigo_carrera

procedure minimo(var v: vector; var vr: vectorR; var min: rDetalle); 
var
	i, posmin, mindni: integer; 
begin
	min.dni := valorAlto; 
	min.cod = valorAlto; 
	for i := 1 to tam do begin
		if ((vr[i].dni <= min.dni) and (vr[i].cod <= min.cod)) then begin
			min := vr[i];
			posmin := i; 
		end; 
	end; 
	leerD(v[posmin], vr[posmin]); 
End; 

procedure actualizarMaestro(var v: vector; var vr: vectorR; var m: maestro); 
var
	rm: rMaestro; 
	i: integer; 
	min: rDetalle; 
	totalPagado: real; 
	dniAct, codAct : integer; 

begin
	reset(m); 
	minimo(v, vr, min); 
	while(min.dni <> valorAlto) do begin
		leerM(m,rm);  
		while (rm.dni <> dniAct) do 	
			leerM(m,rm);

		totalPagado := 0; 
		while ((min.dni = rm.dni) and (min.cod = rm.cod)) do begin
				totalPagado := totalPagado + min.montoPagado; 
				minimo(v,vr,min);
		end; 

		rm.monto := rm.monto + totalPagado; 
		seek(m, filepos(m) - 1); 
		write(m,rm); 
	end; 	
	for i:= 1 to tam do
		close(v[i]); 
	close(m); 	
End; 

procedure generarTxt(var m: maestro); 
var
	t: Text; 
	rm: rMaestro; 
begin
	assign(t, 'rapipago.txt'); 
	rewrite(t); 
	reset(m); 
	leerM(m, rm); 
	while(rm.dni <> valorAlto) do begin
		if(rm.monto = 0) then 
			writeln(t, rm.dni, ' ', rm.cod,' ', 'alumno moroso'); 
		leerM(m, rm); 	
	end; 
	close(m); 
	close(t); 
End;

VAR
	m: maestro; 
	v: vector;  
	vr: vectorR; 
	nd: string; 
	i: integer; 
BEGIN
	assign(m, 'rapipagoMaestro'); 
	for i:= 1 to tam do begin
		Str(i,nd); 
		assign(v[i], 'rapipagoDetalle'+ nd); 
		reset(v[i]); 
		leerD(v[i], vr[i]); 
	end; 
	actualizarMaestro(v, vr, m); 
	generarTxt(m); 
END.


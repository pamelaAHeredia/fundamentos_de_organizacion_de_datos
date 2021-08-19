program untitled;
const
	corte = -1;
	valorAlto = 'zzzz';
	tam = 2;   
type
	regMaestro = record
		prov: string; 
		cantPersonas: integer; 
		totalEnc: integer; 
	end; 
	
	regDetalle = record
		prov: string; 
		codLoc: integer; 
		cantPersonas: integer; 
		totalEnc: integer; 
	end; 
	
	maestro = file of regMaestro; 
	detalle = file of regDetalle; 
	
	vector = array[1..tam] of detalle; 
	vRegistros = array[1..tam] of regDetalle;  

//----------------------------------------------------------------------
procedure leer(var d: detalle; var rd: regDetalle); 
begin
	if(not eof(d)) then 
		read(d,rd)
	else
		rd.prov := valorAlto; 
End; 

//----------------------------------------------------------------------
procedure leerM(var m: mestro; var rm: regMaestro); 
begin
	if(not eof(m)) then 
		read(m,rm)
	else
		rm.prov := valorAlto; 
End; 

//----------------------------------------------------------------------
procedure minimo(var v: vector; var vr: vRegistros; var min:regDetalle);
var
    i,posMin:integer;
begin
    min.prov:= 'zzzz';
    for i:=1 to tam do begin 
        if (vr[i].prov <= min.prov) then begin
            min:=vr[i]; 
            posMin:=i;
        end;
    end;
    if (min.prov <> valoralto) then
        leer(v[posMin], vr[posMin]); 
end;

//----------------------------------------------------------------------
procedure actualizarMaestro(var v: vector; var vr: vRegistros; var m: maestro); 
var
	min: regDetalle; 
	rm: regMaestro;
	i: integer; 
begin
	reset(m); 
	minimo(v,vr, min); 
	
	while(min.prov <> valorAlto) do begin
		leerM(m,rm); 
		while(rm.prov <> min.prov) do 
			leerM(m,rm)
	
		while (rm.prov =  min.prov) do begin
			rm.totalEnc := rm.totalEnc + min.totalEnc; 
			rm.cantPersonas := rm.cantPersonas + min.cantPersonas; 
			minimo(v,vr,min); 
		end; 
		seek(m, filepos(m)-1); 
		write(m,rm);
	end;
	
	close(m); 
	for i:= 1 to tam do 
		close(v[i]);  
End; 

procedure print(var m: maestro); 
var
	rm: regMaestro; 
begin
	reset(m); 
	while(not eof(m)) do begin
		read(m,rm); 
		writeln('* prov: ', rm.prov, ' Cant alf: ', rm.cantPersonas, ' Cant enc: ', rm.totalEnc); 
	end; 
	close(m); 
end; 
//----------------------------------------------------------------------
VAR
	i: integer; 
	m: maestro; 
	v: vector; 
	vr: vRegistros; 
	nd: string; 
BEGIN
	for i:= 1 to tam do begin //abrir archivos para lectura
		Str(i, nd);
		assign(v[i], 'DetalleCenso'+nd);
		reset(v[i]); 
		leer(v[i], vr[i]); 
	end; 	
	assign(m,'Censo'); 
	actualizarMaestro(v, vr, m); 
	print(m); 
END.


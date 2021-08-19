program untitled;
const 
	valorAlto = 9999; 
	tam = 15; 
type
	rango = 1..tam;
	
	registro = record
		depto: integer; 
		division: integer; 
		nroEmpleado: integer; 
		cat: rango; 
		hsExtra: integer; 
	end; 
	
	horas = record
		cat: rango; 
		precio: real; 
	end; 
	vector = array [1..15] of real; 
	maestro = file of registro; 
//----------------------------------------------------------------------
procedure leer(var m: maestro; var r: registro);
begin
	if (not eof(m)) then
		read(m,r)
	else
		r.depto := valorAlto; 
End; 
//---------------------------------------------------------------------- 
procedure procesar(var m: maestro; var v:vector); 
var
	r: registro; 
	departamento, division, horasDepto, horasDiv: integer; 
	montoDepto, montoDiv,monto: real; 
begin
	reset(m); 
	leer(m,r); 
	 	
	while (r.depto <> valorAlto) do begin
		departamento := r.depto; 
		writeln('=========== DEPARTAMENTO ', departamento, ' ============');
		
		horasDepto := 0; 
		montoDepto := 0; 
		
		while((departamento = r.depto)) do begin
			division := r.division; 
			writeln('=========== DIVISIÓN ', division, ' ============'); 
			horasDiv := 0; 
			montoDiv := 0; 
			
			while((departamento = r.depto) and (division = r.division)) do begin
				
				writeln('Horas: ',r.hsExtra, ' precio por hora: ',v[r.cat]:0:2, ' Categoría: ', r.cat); 
				
				monto := r.hsExtra * v[r.cat];  
				writeln('MONTO: ', monto:0:2); 
				writeln('Empleado: ', r.nroEmpleado,' Total de horas: ',r.hsExtra,' Importe a cobrar: ', monto:0:2); 
				horasDiv := horasDiv + r.hsExtra; 
				montoDiv := montoDiv + monto; 
				leer(m,r); 
				writeln(); 
			end; 	
			montoDepto := montoDepto +  montoDiv; 
			horasDepto:= horasDepto + horasDiV;	
			writeln('Total de horas división ', division, ': ',horasDiV); 
			writeln('Monto total $', montoDiv:0:2); 
			writeln(); 
		end; 
		
		writeln('======= Depto: ', departamento, ' Total horas: ', horasDepto, ' Monto total: ', montoDepto:0:2, ' ======='); 
		writeln(); 
	end; 
	
	close(m); 
End; 
//----------------------------------------------------------------------
procedure convertirABinario(var v: vector); 
var 
	t: Text; 
	r: horas; 
	i: integer; 
begin
	assign(t, 'archHoras.txt'); 
	reset(t); 
	for i:= 1 to 15 do begin
		readln(t,r.precio);
		v[i] := r.precio;  
	end; 
	close(t); 		
End; 
//----------------------------------------------------------------------

procedure imprimir(v: vector); 
var
	i: integer; 
begin
	for i:= 1 to 15 do
		writeln('cat: ', i, ' precio: ',v[i]:0:2); 
End; 
//----------------------------------------------------------------------
procedure archivo(var m: maestro);
var
	r: registro; 
begin
	reset(m); 
	while(not eof(m)) do begin
		read(m,r); 
		writeln('Depto: ', r.depto, ' Div: ', r.division, ' Cod Empleado: ', r.nroEmpleado, ' Horas: ', r.hsExtra, ' Categ: ', r.cat); 
	end; 
	close(m); 	
End;  
//----------------------------------------------------------------------
VAR
	m: maestro; 
	v: vector; 
BEGIN	
	assign(m, 'archivoTrabajadores'); 
	convertirABinario(v);
	procesar(m,v); 
	writeln(); 
	
	archivo(m); 
	//imprimir(v);  
END.


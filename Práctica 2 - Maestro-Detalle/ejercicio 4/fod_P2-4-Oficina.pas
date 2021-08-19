{
4. Suponga que trabaja en una oficina donde está montada una LAN (red local). 

La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central. 

Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta. 

Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. 

Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: 
cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.

Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo dia en la misma o en diferentes máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.  
}


program fodP2E4;
const
	maquinas = 5;
	valorAlto = 9999;  
type
	rDetalle = record
		cod_usuario: integer; 
		fecha : integer; 
		tiempo_sesion: real; 
	end; 
	
	rango = 1..maquinas; 
	
	rMaestro = record
		cod_usuario: integer; 
		fecha: integer; 
		tiempo_total_de_sesiones_abiertas: real; 
	end;
	
	detalle = file of rDetalle; 
	maestro = file of rMaestro; 
	vArch = array[rango] of detalle; 
	vRegD = array[rango] of rDetalle; 

//---------------------------------------------------
procedure leer(var d: detalle; var rd: rDetalle); 	
begin
	if (not eof(d)) then 
		read(d,rd)
	else	
		rd.cod_usuario := valorAlto; 
End; 
//----------------- Módulo Auxiliar ----------------------------------
procedure leerM(var m: maestro; var rm: rMaestro); 	
begin
	if (not eof(m)) then 
		read(m,rm)
	else begin
		rm.cod_usuario := valorAlto; 
	end;
End; 

//----------------------------------------------------
procedure minimo(var v: vArch; var vr: vRegD; var min: rDetalle); 
var
	i, posMin: integer; 
begin
	min.cod_usuario := 9999; 
	min.fecha := 9999; 
	for i:= 1 to maquinas do begin
		if ((vr[i].cod_usuario <= min.cod_usuario) and (vr[i].fecha <= min.fecha)) then begin
			min:= vr[i]; 
			posMin:= i; 
		end; 	
	end;
	leer(v[posMin], vr[posMin]); 
End; 

//-----------------------------------------------------
procedure Merge (var m: maestro; var v: vArch; var vr: vRegD);
var
	actual,i: integer; 
	total: real; 
	rm: rMaestro; 
	min: rDetalle; 
	fechaActual : integer; 
begin
	assign(m, 'OFICINA'); 	
	rewrite(m); 
	minimo(v,vr, min);
	
	while (min.cod_usuario <> valorAlto) do begin
		actual := min.cod_usuario; 
		while (actual = min.cod_usuario) do begin 
			total:= 0;
			fechaActual := min.fecha; 
			while ((actual = min.cod_usuario) and (fechaActual = min.fecha)) do begin
				total := total + min.tiempo_sesion; 
				minimo(v,vr,min);  	
				writeln('M I N : ', min.cod_usuario); 		
			end;
			rm.tiempo_total_de_sesiones_abiertas := total;
			rm.cod_usuario := actual; 
			rm.fecha := fechaActual; 				
			write(m, rm);
		end; 	
					
	end;
	for i:= 1 to maquinas do
		close(v[i]); 
	close(m); 
End; 

//-------------------------------------------------------
procedure imprimir(var m: maestro);
var
	rm: rMaestro; 
begin
	assign(m, 'OFICINA'); 
	reset(m); 
	leerM(m,rm); 
	while (rm.cod_usuario <> valorAlto) do begin
		writeln('.Código: ', rm.cod_usuario, ' *fecha: ', rm.fecha,' *tiempo total de sesion: ', rm.tiempo_total_de_sesiones_abiertas:0:2); 
		leerM(m,rm);
	end; 
	close(m); 
End;
 
procedure imprimirD(); 
var
		i: integer; 
		v: vArch; 
		vr: vRegD; 
		nd: string; 
begin
	for i:= 1 to maquinas do begin
		writeln('======= ARCHIVO ', i,' ========'); 
		Str(i, nd);
		assign(v[i], 'machine'+nd); 
		reset(v[i]);
		leer(v[i], vr[i]);
		while (vr[i].cod_usuario <> valorAlto) do begin
			writeln('Código de usuario: ',vr[i].cod_usuario, ' *Fecha: ', vr[i].fecha); 
			leer(v[i], vr[i]);
			writeln('C O D : ', vr[i].cod_usuario); 
		end; 
		close(v[i]); 	
	end
End; 
 	
VAR
	i: integer; 
	v: vArch; 
	vr: vRegD; 
	nd: string; 
	m: maestro; 
BEGIN
	imprimirD(); 
	for i:= 1 to maquinas do begin
		Str(i, nd);
		assign(v[i], 'machine'+nd); 
		reset(v[i]);
		leer(v[i], vr[i]);
	end; 
	Merge(m,v,vr); 
	imprimir(m); 
END.


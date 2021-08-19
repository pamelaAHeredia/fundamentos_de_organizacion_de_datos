{En pos de recuperar dicha información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, 
un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: 

nro partida nacimiento, nombre, apellido, dirección detallada(calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, 
DNI madre, nombre y apellido del padre, DNI del padre.

En cambio los 50 archivos de fallecimientos tendrán: 
nro partida nacimiento, DNI, nombre y apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. 
   
}


program generarActas;
const 
	tam = 5; //50
	corte = -1; 
type
	direccion = record
		calle: string; 
		nro: integer; 
		piso: integer; 
		depto: string; 
		ciudad: string; 
	end; 
	rango = 1..tam; 
	
	rDNac = record
		nroPartida: integer; 
		nomYap: string; 
		direcc: direccion; 
		matMedica: integer; 
		mDni: integer;
		mNomYAp: string;  
		pDni: integer; 
		pNomYap: string; 
	end; 
	
	rDFall = record
		nroPartida: integer; 
		dni: integer; 
		nomYap: string; 
		matMedica: integer; 
		fecha: string; 
		hora: string; 
		lugar: string; 
	end; 
	
	dNac = file of rDNac; 
	dFall = file of rDFall; 
	
	vDN = array [rango] of dNac; //vectores para carga	
	vDF = array[rango] of dFall; 

//----------------------------------------------------------------------
procedure leerDir(var dir: direccion); 
begin
	with dir do begin
		write('* Calle: '); readln(calle); 
		write('* nro: '); readln(nro);
		write('* piso: '); readln(piso);
		write('* depto: '); readln(depto);
		write('* ciudad: '); readln(ciudad);
	end; 
end; 

procedure leerNacimiento(var n: rDNac);
var
	dir: direccion; 
begin
	with n do begin
		write('* Nro de part de nacimiento: '); readln(nroPartida);
		if (nroPartida <> corte) then begin
			write('* Nombre y Apellido: '); readln(nomYap);		
			leerDir(dir);
			write('* Matrícula del médico: '); readln(matMedica);
			write('* Dni de la Madre: '); readln(mDni);
			write('* Nombre y apellido de la madre: '); readln(mNomYAp);
			write('* Dni del padre: '); readln(pDni);
			write('* Nombre y apellido del Padre: '); readln(pNomYAp);
			writeln(); 	
		end; 
	end; 
End;

procedure leerFallecimiento(var f: rDFall); 
begin
	with f do begin
		write('* Nro de partida de nacimiento: '); readln(nroPartida);
		if (nroPartida <> corte) then begin
			write('* DNI: '); readln(dni);
			write('* Nombre y apellido: '); readln(nomYap);
			write('* Matrícula del médico que firmó el certificado: '); readln(matMedica);
			write('* Fecha del deceso: '); readln(fecha);
			write('* Hora de deceso: '); readln(hora);
			writeln(); 
		end; 
	end; 
End;  

//----------------------------------------------------------------------
procedure generarDetalleNacimiento(var v: vDN);
var
	rdn: rDNac; 
	i: integer; 
	nd: string; 
begin
	writeln(); 
	writeln('****** CARGANDO ARCHIVO DE NACIMIENTOS ******'); 
	writeln();
	for i:= 1 to tam do begin 
		writeln('-----------------------------'); 
		writeln('Cargando Delegación nro ', i); 
		writeln(); 
		Str(i, nd);
		assign(v[i], 'ArchivoDeNacimientos-DelegacionN'+nd); 
		rewrite(v[i]); 
		leerNacimiento(rdn); 
		while (rdn.nroPartida <> corte) do begin
			write(v[i], rdn); 
			leerNacimiento(rdn); 
		end;  
		close(v[i]); 
	end; 
End; 

//----------------------------------------------------------------------
procedure generarDetalleFallecimiento(var f: vDF); 
var
	rdf: rDFall; 
	i: integer; 
	nd: string; 
begin
	writeln(); 
	writeln('****** CARGANDO ARCHIVO DE FALLECIMIENTOS ******'); 
	writeln(); 
	for i:= 1 to tam do begin
		writeln('-----------------------------'); 
		writeln('Cargando Delegación nro ', i); 
		writeln(); 
		Str(i, nd);
		assign(f[i], 'ArchivoDeFallecimientos-DelegacionN'+nd); 
		rewrite(f[i]); 
		leerFallecimiento(rdf); 
		while (rdf.nroPartida <> corte) do begin
			write(f[i], rdf); 
			leerFallecimiento(rdf); 
		end;  
		close(f[i]); 		
	end;	
End; 

//----------------------------------------------------------------------
VAR
	dn: vDN; 
	df: vDF; 
BEGIN
	generarDetalleNacimiento(dn); 
	generarDetalleFallecimiento(df); 
	
END.


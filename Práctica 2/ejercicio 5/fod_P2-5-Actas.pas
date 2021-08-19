{
5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de toda la provincia de buenos aires de los últimos diez años. 

En pos de recuperar dicha información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, 
un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: 

nro partida nacimiento, nombre, apellido, dirección detallada(calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, 
DNI madre, nombre y apellido del padre, DNI del padre.

En cambio los 50 archivos de fallecimientos tendrán: 
nro partida nacimiento, DNI, nombre y apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información los archivos. 

Se debe almacenar en el maestro: nro partida nacimiento, nombre, apellido, dirección detallada
(calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre 
y si falleció, además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. 

Se deberá, además, listar en un archivo de texto la información recolectada de cada persona.

Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única. 
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y además puede no haber fallecido.

}
program actas;
const 
	tam = 5; //50
	corte = -1; 
	valorAlto = 9999; 
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
		lugar: String;  
	end; 
	
	rMaestro = record 
		nroPartida: integer; 
		direc : direccion; 
		matMedico: integer; 
		mNomYAp: string; 
		mDni: integer; 
		pNomYAp: string; 
		pDni: integer; 
		fallecio: boolean; 
		matMedicoDeceso: integer; 
		fecha: string; 
		hora: string; 
		lugar: string; 
	end; 
	
	dNac = file of rDNac; 
	dFall = file of rDFall; 
	maestro = file of rMaestro; 
	
	vDN = array [rango] of dNac; //vectores de archivos	
	vDF = array[rango] of dFall;
	
	vrn = array[rango] of rDNac; //vectores para lectura de registros
	vrf = array[rango] of rDFall; 

//----------------------------------------------------------------------
procedure leerN(var dn: dNac; var rd: rDNac); 
begin
	if (not eof(dn)) then 
		read(dn, rd)
	else
		rd.nroPartida := valorAlto; 
end; 

procedure leerF(var df: dFall; var rf: rDFall); 
begin
	if (not eof(df)) then 
		read(df, rf)
	else
		rf.nroPartida := valorAlto; 
end; 

//----------------------------------------------------------------------

procedure minimoFallecimiento(var vF: vDF; var vRF: vrf; var minF: rDFall); //parámetros: vector de arch detalle; vector de registros; registro mínimo
var
	i, posMin: integer; 
begin
	minF.nroPartida := valorAlto;
	for i:= 1 to tam do begin
		if (vrf[i].nroPartida < minF.nroPartida) then begin
			posMin:= i; 
			minF:= vrf[i]; 
		end; 
	end;  
	if (minF.nroPartida <> valorAlto) then 
		leerF(vf[posMin], vrf[posMin]); 
End; 

//----------------------------------------------------------------------

procedure minimoNacimiento(var vecNac: vDN; var vecRegNac: vrn; var minN: rDNac); //parámetros: vector de arch detalle; vector de registros; registro mínimo
var
	i, posMin: integer; 
begin
	minN.nroPartida := valorAlto; 
	for i:= 1 to tam do begin
		if (vecRegNac[i].nroPartida < minN.nroPartida) then begin
			posMin:= i; 
			minN:= vecRegNac[i]; 
		end; 
	end; 
	if(minN.nroPartida <> valorAlto) then 
		leerN(vecNac[posMin], vecRegNac[posMin]); 
End; 

//----------------------------------------------------------------------

procedure generarMaestro(var m: maestro; var dn: vDN; var vRN: vrn; var df: vDF; var vRF: vrf); //vecDetalle, vecRegistro x2
var
	minF: rDfall; //registro detalle
	minN: rDNac;  //reg detalle 
	rm: rMaestro; 
	i: integer; 
begin
	assign(m, 'archivoMaestroDeActas'); 
	rewrite(m); 

	minimoFallecimiento(df,vRF, minF); //parámetros: vector de arch detalle; vector de registros; registro mínimo
	minimoNacimiento(dn,vRN,minN);
	 
	while(minN.nroPartida <> valorAlto) do begin
		rm.fallecio := true; 
		rm.nroPartida:= minN.nroPartida; 
		rm.direc := minN.direcc; 
		rm.matMedico:= minN.matMedica; 
		rm.mNomYAp:= minN.NomYAp; 
		rm.mDni:= minN.mDni;   
		rm.pNomYAp:= minN.pNomYAp; 
		rm.pDni:= minN.pDni; 
		if (minN.nroPartida = minF.nroPartida) then begin
			rm.fallecio:= true; 
			rm.matMedicoDeceso:= minF.matMedica; 
			rm.fecha:= minF.fecha; 
			rm.hora:= minF.hora; 
			rm.lugar:= minF.lugar;	
			minimoFallecimiento(df,vRF, minF);
		end; 
		write(m, rm);
		minimoNacimiento(dn,vRN,minN); 	
	end;  
	close(m); 
	for i:= 1 to tam do begin
		close(dn[i]);
		close(df[i]);  
	end; 	
	close(m); 
End; 

//---------------------------------------------------------------------- 
VAR	
	m: maestro; 
	vecDetalleFall: vDF; //vectores de archivos
	vecDetalleNac: vDN; 
	vecRegFall: vrf; //vectores de registros
	vecRegNac: vrn; 
	regNac: rDNac; //registros detalle
	regFall: rDFall; 
	dn: dNac; //archivos detalle
	df: dFall; 
	i: integer; 
	nd: string; 
BEGIN
	//abrir archivos para generar el maestro
	for i:= 1 to tam do begin
		Str(i, nd);
		assign(vecDetalleFall[i], 'ArchivoDeFallecimientos-DelegacionN'+nd); 
		reset(vecDetalleFall[i]); 
		assign(vecDetalleNac[i], 'ArchivoDeNacimientos-DelegacionN'+nd); 
		reset(vecDetalleNac[i]); 
		leerN(dn, regNac); 
		leerF(df, regFall); 
	end; 
	
	generarMaestro(m,vecDetalleNac, vecRegNac,vecDetalleFall, vecRegFall); //vecDetalle, vecRegistro x2
	
END.


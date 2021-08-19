program untitled;
const 
	valorAlto = 9999; 
type
	registro = record
		cod: integer; 
		mes: integer; 
		anio: integer; 
		dia: integer; 
		tiempo: integer; 
	end; 
	
	archivo = file of registro; 
	
procedure leer(var a: archivo; var r: registro); 
begin
	if (not eof(a)) then 
		read(a,r)
	else
		r.anio := valorAlto; 
End; 

procedure totalizar(var a: archivo); 
var
	r: registro; 
	year: integer; 
	diAct, mesAct, userAct : integer;
	totxdia, totxanio, totxmes, totxuser: integer; 
begin
	write('* Año a buscar: '); readln(year); 
	reset(a); 
	leer(a,r);
	
	while(r.anio <> valorAlto) and (r.anio <> year) do
		leer(a, r); 
	
	if(r.anio = year) then begin
		writeln('Año: ', year); 
		totxanio := 0; 
		while((r.anio <> valorAlto) and (r.anio = year)) do begin
			mesAct := r.mes; 
			totxmes := 0; 
			writeln('Mes: ', mesAct);
			while((r.anio = year) and (r.mes = mesAct)) do begin
				diAct := r.dia; 
				totxdia := 0; 
				writeln('Dia: ', diAct);
				while((r.anio = year) and (r.mes = mesAct) and (r.dia = diAct)) do begin
					userAct := r.cod; 
					totxuser := 0; 
					while((r.anio = year) and (r.mes = mesAct) and (r.dia = diAct) and (r.cod = userAct)) do begin
						totxuser := totxuser + r.tiempo; 
						leer(a,r); 
					end; 
					writeln('* Usuario: ', userAct,' Día: ', diAct, ' Mes: ', mesAct, ' Tiempo: ',totxuser); 
					totxdia := totxdia + totxuser; 
				end;  	
				writeln('*Día: ', diAct, ' Mes: ', mesAct, ' Tiempo x día: ',totxdia); 
				totxmes := totxmes + totxdia;
				writeln();  
			end;  
			writeln('*Mes: ', mesAct, ' Tiempo x mes: ',totxmes); 
			totxanio := totxanio + totxmes;
			writeln();  
		end; 
		writeln('*Tiempo total x año: ',totxanio); 
	end
	else
		write('* El año no existe en el archivo.'); 
	close(a); 	
End;

VAR 
	a: archivo; 
BEGIN
	assign(a,'archivoAnual'); 
	totalizar(a); 
	
END.


program fodP2E2_txt;
const 
	corte = -1; 
type
	registroMaestro = record
		codigo: integer; 
		apellido: string[10]; 
		nombre: string[10];
		cantMateriasCursadas: integer; 
		cantAprobadas: integer; 
	end;

	registroDetalle = record
		cod: integer; 
		info: string; 
	end; 	

procedure leerM(var m: registroMaestro); 
begin
	with m do begin
		write('* Código de alumno: '); readln(codigo); 
		if (codigo <> corte) then begin
			write('* Cantidad de materias con cursadas aprobada: '); readln(cantMateriasCursadas); 
			write('* Cantidad de materias aprobadas con final: '); readln(cantAprobadas);		
			write('* Apellido: '); readln(apellido); 
			write('* Nombre: '); readln(nombre);  
			writeln(); 
		end; 
	end; 	
End; 

procedure leerD(var d: registroDetalle); 
begin
	with d do begin
		write('* Código de Alumno: '); readln(cod); 
		if(cod <> corte) then begin   
			write('* Cursada aprobada = c / Final aprobado = f: '); readln(info);
			writeln(); 	
		end; 	
	end; 
End; 
//-------- crear txt maestro ---------
procedure generarTxtMaestro(var t: Text);
var
	m: registroMaestro; 
	nombreFisico: String[15]; 
begin
	writeln('******* CARGA DEL ARCHIVO MAESTRO *******');
	writeln();	
	nombreFisico:= 'alumnos.txt';  
	assign(t, nombreFisico); 	
	rewrite(t); 
	leerM(m); 
	while(m.codigo <> corte) do begin
		with m do begin
			writeln(t,' ',codigo,' ',cantMateriasCursadas,' ', cantAprobadas,' '); 
			writeln(t,' ', apellido, ' '); 
			writeln(t,' ',nombre,' '); 
		end; 
		leerM(m); 	
	end;
	close(t);   
End; 

//--------- crear txt detalle ----------
procedure generarTxtDetalle(var t: Text);
var
	nombreFisico: string[15]; 
	rd: registroDetalle;  
begin
	writeln('***** CARGA DEL ARCHIVO DETALLE *****'); 
	writeln(); 
	nombreFisico := 'detalle.txt'; 
	assign(t, nombreFisico);	
	rewrite(t); 
	leerD(rd); 
	while (rd.cod <> corte) do begin
		writeln(t,' ', rd.cod, ' ', rd.info, ' '); 
		leerD(rd); 
	end;  
	close(t); 
End; 

 	
//------- prog ppal ----------	
VAR	
	t: Text; 
BEGIN
	//generarTxtMaestro(t); 	
	generarTxtDetalle(t); 
END.


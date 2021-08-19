{
Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto de comisión, 
* de cada uno de ellos se conoce: código de empleado, nombre y monto de la comisión. 
* La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer 
* más de una vez en el archivo de comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. 
* En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una única 
* vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única vez.
   
}


program untitled;
uses crt;
const
	corte = -1; 
	valorAlto = 9999; 
type
	registro = record
		codEmp: integer; 
		nombre: String[20]; 
		comision: real;
	end; 
	
	archivo = file of registro; 
		
procedure leer(var r: registro);
begin
	with r do begin
		write('* Código de Empleado: '); readln(codEmp); 
		if (codEmp <> corte) then begin
			write('* Nombre: '); readln(nombre); 
			write('* Comisión: '); readln(comision); 
			writeln(); 
		end; 
	end; 	  
End;  		

//--------- ya se dispone --------------
procedure cargarArchivo(var a: archivo); 
var
	r: registro; 
	nombreFisico: string[10]; 
begin
	writeln('***** CARGA DE ARCHIVO *****');
	writeln(); 
	write('* Nombre físico del archivo: '); readln(nombreFisico); 
	assign(a, nombreFisico); 
	rewrite(a); 
	leer(r);
	while (r.codEmp <> corte) do begin
		write(a,r);
		leer(r);
	end; 
	close(a); 		
End;

//----- lee hasta que se termina el archivo----
procedure leerHastaValorAlto(var a: archivo; var r: registro); 
begin
	if (not eof(a)) then 
		read(a,r)
	else
		r.codEmp := valorAlto; 
End;  

//------- recibir el archivo y compactar --------
procedure compactarArchivo(var nuevo: archivo; var a: archivo); 
var 
	nombreFisico: string; 
	r: registro; 
	regAct: registro; 
	total: real;
	actual : integer;   
begin
	write('* Nombre físico del nuevo archivo: ');readln(nombreFisico);
	assign(nuevo, nombreFisico); 
	reset(a); 
	rewrite(nuevo); 
	
	leerHastaValorAlto(a, r);
	while (r.codEmp <> valorAlto) do begin
		regAct := r;    
		total := 0; 
		actual := r.codEmp; 
		while (r.codEmp = actual) do begin
			total := total + r.comision; 
			leerHastaValorAlto(a,r);
		end; 
		regAct.comision := total;  
		write(nuevo, regAct);
	end; 	   
	close(a); 
	close(nuevo); 
End; 

procedure imprimir(var a2: archivo);
var
	r: registro; 
begin
	reset(a2); 
	while (not eof(a2)) do begin
		read(a2, r); 
		writeln('código: ', r.codEmp, ' comisión total: ', r.comision:0:2); 
	end; 
	close(a2); 
End; 	 
//--------------- prog ppal ------------------
VAR
	arch1, arch2: archivo; 
BEGIN
	cargarArchivo(arch1); 
	imprimir(arch1); 
	compactarArchivo(arch2, arch1);
	imprimir(arch2);  
END.


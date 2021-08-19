program fodP3E1;
uses
   crt;
const
	corte = 'fin'; 
	max = 70; 
type
	empleado = record
		nro: integer; 
		apellido: string[15]; 
		nombre: string[15]; 
		edad: integer; 
		dni: integer; 
	end; 
	
	archivoDeEmpleados = file of empleado; 

procedure leer(var e: empleado); 
begin
	with e do begin
		write('* Apellido: '); readln(apellido);
		if (apellido <> corte) then begin
			write('* Nombre: '); readln(nombre); 
			write('* Edad: '); readln(edad);
			write('* Dni: '); readln(dni);
			write('* Núm de empleado: '); readln(nro);
			writeln(''); 
		end;  
	end; 
End; 

procedure cargarArchivo(var emp: archivoDeEmpleados); 
var	
	e: empleado; 
	nombreFisico: string[15]; 
begin
	writeln(); 
	write('* Nombre físico del archivo: '); readln(nombreFisico);
	assign(emp, nombreFisico); 
	writeln('----------------------------------------------------------'); 
	writeln(' Comenzando la carga del archivo ', nombreFisico); 
	writeln('----------------------------------------------------------'); 
	
	rewrite(emp); 
	leer(e); 
	while (e.apellido <> corte) do begin
		write(emp,e); 
		leer(e); 
	end; 
	close(emp); 
	Clrscr; 	
End; 		

procedure mostrar(e: empleado); 
begin
	writeln('* Nombre: ',e.nombre,' ',e.apellido,', DNI: ',e.dni,', edad: ',e.edad,', Nro: ',e.nro);
End; 

//i. Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.
procedure mostrarXNomAp(var emp: archivoDeEmpleados); 
var
	e: empleado; 
	nombre: string; 
begin
	writeln(''); 
	write('* Nombre a buscar: ');readln(nombre); 
	writeln(); 
	writeln('------ EMPLEADOS CON EL NOMBRE / APELLIDO ', nombre,' ------');  
	writeln(); 
	reset(emp); 	 
	while (not eof(emp)) do begin
		read(emp, e);
		if (e.apellido = nombre) or (e.nombre = nombre) then
			mostrar(e); 	
	end; 
	close(emp); 
End; 

//Listar en pantalla los empleados de a uno por línea.
procedure mostrarEmplados(var emp: archivoDeEmpleados);
var
	e: empleado; 
begin
	writeln();
	writeln('------------ LISTA DE EMPLEADOS -------------');
	writeln();
	reset(emp); 
	while(not eof(emp)) do begin
		read(emp,e);
		mostrar(e); 
	end; 
	close(emp); 
End;  

procedure mostrarProxAJubilarse(var emp: archivoDeEmpleados);
var
	e: empleado; 
begin
	writeln();
	writeln('----------- EMPLEADOS PRÓXIMOS A JUBILARSE -----------');  
	writeln(); 
	reset(emp);
		while(not eof(emp)) do begin
			read(emp,e); 
			if (e.edad >= max) then
				mostrar(e); 
		end; 	 
	close(emp); 
End;  

//a. Añadir una o más empleados al final del archivo con sus datos ingresados por teclado.
procedure agregarInformacion(var ade: archivoDeEmpleados); 
var
	emp: empleado; 
begin
	reset(ade); 
	seek(ade , filesize(ade));
	leer(emp); 
	while(emp.apellido <> corte) do begin
		write(ade, emp); 
		leer(emp); 
	end; 
	close(ade); 
End; 

//b. Modificar edad a una o más empleados.
procedure modificarEdad(var ade: archivoDeEmpleados);
var
	emp: empleado;
	num: integer; 
	age: integer;
	ok: boolean;   
begin
	ok:= false; 
	write('* Numero del empleado: '); readln(num); 	  
	reset(ade); 
	while (num <> -1) do begin
		while (not eof(ade)) and (not ok) do begin
			read(ade, emp); 
			if(emp.nro = num) then begin
				ok := true; 
				write('* Actualizar Edad con: '); readln(age);
				emp.edad := age; 
			end; 	
			seek(ade, filepos(ade)-1); 
			write(ade,emp); 	
		end; 
		write('* Número del empleado al que desea modificar edad: '); readln(num); 
		write('* Actualizar edad con: '); readln(age);	
	end; 
	close(ade); 
End;  

//c. Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.
procedure exportarATxt(var ade: archivoDeEmpleados);
var
	archTxt: string; 
	cargaTxt: Text;
	emp: empleado;  
begin
	archTxt:='todos_empleados.txt'; 
	assign(cargaTxt, archTxt);
	
	rewrite(cargaTxt); 
	reset(ade); 
	
	while(not eof(ade)) do begin
		read(ade, emp); 
		with emp do
			writeln(nro:5, apellido:5, nombre:5, edad:5, dni:5); 
		with emp do 
			writeln(cargaTxt,nro, '', apellido, '', nombre,'', edad, '', dni); //archivo de txt + campos 
	end;  
	close(cargaTxt); 
	close(ade);  
End;  

//Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).
procedure exportarFaltaDni(var ade: archivoDeEmpleados);
var
	archTxt: string; 
	cargaTxt: Text;
	emp: empleado;  
begin
	archTxt:='faltaDNIEmpleado.txt'; 
	assign(cargaTxt, archTxt);
	
	rewrite(cargaTxt); 
	reset(ade); 
	
	while(not eof(ade)) do begin
		read(ade, emp); 
		if (emp.dni = 00) then begin
			with emp do
				writeln(nro:5, apellido:5, nombre:5, edad:5, dni:5); 
			with emp do 
				writeln(cargaTxt,nro, '', apellido, '', nombre,'', edad, '', dni); 
		end; 		
	end;  
	close(cargaTxt); 
	close(ade);  
End; 

//----------------------------------------------------------------------
procedure leerArchivo(var a: archivoDeEmpleados; var e: empleado); 
begin
	if (not eof(a)) then 
		read(a,e)
	else
		e.nombre := 'zzz'; 
End; 

//----------------------------------------------------------------------
procedure bajas(var a: archivoDeEmpleados); 
var
	nombreFisico: string[15];
	r, aux: empleado;
	codigo: integer; 
begin
	reset(a); 
	write('* Código del empleado que quiere dar de baja: '); readln(codigo); 
	read(a,r); 
	if (r.nro <> codigo) then begin
		seek(a,0); 
		leerArchivo(a, aux); 
	end; 	

	while(aux.nro <> valorAlto) and (aux.nro <> codigo) do 
		leerArchivo(a,e); 
	leerArchivo(a,e); 	

	if(aux.nro = codigo) then begin
		seek(a, filepos(a) -1); 
		write(a,r); 
		seek(a, filesize(a)-1); 
		truncate(a); 
	end
	else begin
		seek(a, filesize(a)-1); 
		truncate(a); 
	end; 
	close(a); 	
End; 

//----------------------------------------------------------------------
procedure menu(var boton: integer); 
begin
	writeln('------------------------------'); 
	writeln('		 MENÚ 		'); 
	writeln('------------------------------');
	writeln(); 
	Writeln(' - Ingrese la opción que desea - '); 
	writeln(); 
	writeln('* 1_ Crear un nuevo Archivo de Empleados.');
	writeln(); 
	writeln('* 2_ Mostrar los datos de un Empleado.'); 
	writeln(); 
	writeln('* 3_ Mostrar la lista de todos los Empleados.');
	writeln(); 
	writeln('* 4_ Mostrar los empelados mayores de 70 años próximos a jubilarse.');
	writeln(); 
	writeln('* 5_ Agregar 1 o más empleados al archivo. Ingrese - fin - para finalizar la carga.'); 
	writeln(); 
	writeln('* 6_ Modificar la edad de uno o más empleados. Ingrese - fin - para finalizar.'); 
	writeln();
	writeln('* 7_ Exportar un archivo a texto.');
	writeln(); 
	writeln('* 8_ Exportar archivos de empleados con DNI 00 (DNI inexistente)'); 
	writeln(); 
	writeln('* 9_ Dar de baja a un empelado.');	
	writeln(); 
	writeln('* 0_ Salir del menú.');
	readln(boton); 	
	ClrScr;		  
End; 

VAR
	empleados: archivoDeEmpleados; 
	boton: integer; 
BEGIN
	write('* Nombre físico del archivo: '); readln(nombreFisico);
	assign(empleados, nombreFisico);
	cargarArchivo(empleados); 
	
	menu(boton); 
	while (boton <> 0) do begin
		case boton of
			1: cargarArchivo(empleados); 
			2: mostrarXNomAp(empleados); 
			3: mostrarEmplados(empleados); 
			4: mostrarProxAJubilarse(empleados); 
			5: agregarInformacion(empleados);
			6: modificarEdad(empleados);
			7: exportarATxt(empleados); 
			8: exportarFaltaDni(empleados);
			9: bajas(empleados);   
			else	
				writeln('*** OPCIÓN INVÁLIDA ****'); 
		end;
		menu(boton); 		
	end; 		
END.



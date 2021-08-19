program fodP2E7Empresa;
const
	corte = -1;
type
	cliente = record
		codigo: integer; 
		nombre: string; 
		apellido: string; 
	end; 
	
	fecha = record
		anio: integer; 
		mes: integer; 
		dia: integer; 
	end; 
	
	registroMaestro = record
		cli: cliente; 
		fech: fecha; 
		monto: real; 
	end;
	
	maestro = file of registroMaestro; 
//----------------------------------------------------------------------
 

//----------------------------------------------------------------------
procedure generarMaestro(); 
	
//----------------------------------------------------------------------

BEGIN
	
	
END.


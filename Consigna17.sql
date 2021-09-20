# vistas

alter view vistaClientes as
select
	ClienteID as ID,
    Contacto,
    case
		when length(trim(fax)) = 0 then concat("TEL: ", Telefono)
        else Fax
	end as Fax
from clientes;
    
SELECT * FROM emarket.vistaclientes;

select
	case 
		when length(trim(fax)) = 0 then Telefono
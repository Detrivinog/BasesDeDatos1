# Clase 17

select 
	substring(upper(nombre),1, 10), 
    upper(left(nombre, 10)) as NombreCancion, 
    time_format((sec_to_time(milisegundos/1000)), "%i:%S") as Tiempo,
    round(bytes/1000) as kilobytes,
    concat("$", format(precio_unitario, 3)) as Precio,
    case 
		when compositor is null or compositor = '' then '<sindatos>'
        when locate(',', compositor) != 0 then left(compositor, locate(',', compositor)-1)
        else compositor
	end as Compositor
from canciones;

# vistas
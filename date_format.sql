create view vi_facturas as
select 
	FacturaID as NumeroFactura, 
	date_format(FechaFactura, "%d/%m/%Y") as FechaFactura, 
	date_format(FechaEnvio, "%d/%m/%Y") as FechaEnvio,
    format(Transporte, 2) as Transporte,
    concat(DireccionEnvio, " ",CiudadEnvio, " ",CodigoPostalEnvio, " ",PaisEnvio) as Destino
from facturas;

select * 
	from vi_facturas vf
	left join facturadetalle fd on vf.NumeroFactura = fd.FacturaID; 

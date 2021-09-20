# Utilizar emarket
#1- Devolver la Cantidad de facturas, minima y maxima fecha por pais
select 
	PaisEnvio, count(FacturaID) as CantidadFacturas, min(FechaFactura), max(FechaFactura) 
    from facturas
    group by PaisEnvio
    order by CantidadFacturas desc;

#2- Devolver la Cantidad de facturas por pais y por anio de factura (fecha de registro)
select 
	PaisEnvio, 
    year(FechaRegistro) as anio,
    count(FacturaID) as cantidadFacturas    
    from facturas
    group by PaisEnvio, anio
    order by cantidadFacturas  desc;

#3- Devolver la cantidad de facturas enviadas por anio (fechaEnvio)
select
	year(FechaEnvio) as anio,
    count(FacturaID) as cantidadFacturas
    from facturas
    group by anio
    order by anio desc;

#4- Devolver la suma total de precios de procutos facturados por pais
select 
	f.PaisEnvio,
	round(sum((fd.PrecioUnitario * fd.Cantidad)*(1 - fd.Descuento)), 2) as total
    from facturadetalle as fd
    left join facturas f on fd.FacturaID = f.FacturaID
    group by PaisEnvio;
    
#5- Devolver la suma total de precios facturados por producto
select 
	p.ProductoNombre,
    round(sum((fd.PrecioUnitario * fd.Cantidad)*(1 - fd.Descuento)), 2) as total
    from facturadetalle as fd
    left join productos p on fd.ProductoID = p.ProductoID
    group by ProductoNombre
    order by total desc;
    
#6- Devolver la suma total y cantidad de productos facturados por categoria
select
	c.CategoriaNombre,
    sum(fd.Cantidad) as Cantidad,
    round(sum((fd.PrecioUnitario * fd.Cantidad)*(1 - fd.Descuento)), 2) as Total
    from facturadetalle as fd
    left join productos p on fd.ProductoID = p.ProductoID
    left join categorias c on p.CategoriaID = c.CategoriaID
    group by c.CategoriaNombre
    order by c.CategoriaNombre;
    
#7- Devolver la cantidad de facturas y la suma total por cada una de las regiones de los empleados
select
	e.Regiones,
    count(f.FacturaID) as Cantidad,
    round(sum((fd.PrecioUnitario * fd.Cantidad)*(1 - fd.Descuento)), 2) as Total
    from facturadetalle as fd
    left join facturas f on fd.FacturaID = f.FacturaID
    left join empleados e on f.EmpleadoID = e.EmpleadoID
    group by e.Regiones;

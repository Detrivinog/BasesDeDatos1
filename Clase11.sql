/*
select * from emarket.categorias;
select CategoriaNombre, Descripcion from emarket.categorias;
select * from emarket.productos;

select * from emarket.productos
where Discontinuado = 1

select ProductoNombre from emarket.productos
where ProveedorID = 8

select * from emarket.productos
where PrecioUnitario between 10 and 22

select ProductoNombre from emarket.productos
where UnidadesStock <= NivelReorden
*/

select * from emarket.productos
where UnidadesStock <= NivelReorden 


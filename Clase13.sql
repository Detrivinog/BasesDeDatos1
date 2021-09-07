select COUNT(*) from clientes 
where pais = "Brazil";

select count(*) from canciones
group by id_genero;

select sum(total) from facturas;
select avg(milisegundos) as duracionAlbum from canciones
group by id_genero;

select min(bytes) from canciones;

select sum(total), id_cliente from facturas
group by id_cliente
having sum(total) > 45;
select titulo from spotify.cancion
where titulo like "%z%";

select titulo from spotify.cancion
where titulo like "_a%s";

select titulo as "Título", cantcanciones as "Cantidad de canciones" from playlist
order by cantcanciones desc 
limit 5;

select nombreusuario as "Nombre del usuario" from usuario
order by fecha_nac desc 
limit 10
offset 5;

select titulo as "Título" from cancion
order by cantreproduccion desc 
limit 5;

select titulo as "Título" from album
order by titulo;

 insert into usuario (idUsuario,nombreusuario, nyap, sexo, CP, Pais_idPais)
 values (20,"nuevousuariodespotify@gmail.com", "Elmer Gomez", "15-11-1991", "M", "B4129ATF", 2)








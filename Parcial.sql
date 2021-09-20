select titulo, cantidadLikes from video
order by cantidadLikes desc
limit 5;

insert into usuario (nombre, email, password, fechaNacimiento, 
codigoPostal, Pais_idPais, Avatar_idAvatar) 
values ("Juan Jose Batzal", "jjbatzal@gmail.com", " jj1597", 
"2000-04-01 00:00:00", "1429", 9, 85);

select * from usuario;

select nombre, fechaNacimiento from usuario 
where fechaNacimiento between "2000-01-01" and "2000-12-31";

select upper(nombre) from pais
order by nombre;

select titulo, cantidadReproducciones from video
where cantidadReproducciones > 500000;

# 6. Mostrar por usuario la cantidad de playlists que posee, pero solo para aquellos que tengan más de 1 playlist creada en el año 2021. 

select 
	u.nombre, 
    count(p.idPlaylist) as cantidad
    from usuario u
    left join playlist p on u.idUsuario = p.Usuario_idUsuario
    where year(p.fechaCreacion) = 2021
    group by u.nombre
    having cantidad > 1;
    
#7. Generar un reporte de las reacciones generadas en el 2021, con el siguiente formato : Nombre de Reacción Nombre de Usuario Título de Video Fecha 

select
	tr.nombre as "Nombre de la Reacción",
    u.nombre as "Nombre de Usuario",
    v.titulo as "Títutlo de Video",
    r.fecha as Fecha
    from reaccion r
    left join tiporeaccion tr
    on r.TipoReaccion_idTipoReaccion = tr.idTipoReaccion
    left join usuario u
    on r.Usuario_idUsuario = u.idUsuario
    left join video v
    on r.Video_idVideo = v.idVideo
    where year(Fecha) = 2021;

#8. Listar la cantidad de videos según sean públicos o privados. 

select
	case
		when privado = 0 then "Público"
        when privado = 1 then "Privado"
	end as "Público/Privado",
    count(idVideo) as "Cantidad de videos"
	from video
    group by privado;

#9. Generar un reporte con los nombres de los usuario que no poseen ninguna Playlist. 

select 
	u.nombre
    from usuario u
    left join playlist p
    on u.idUsuario = p.Usuario_idUsuario
    where isnull(idPlaylist);


#10.Listar todos los videos hayan o no recibido reacciones en el último mes; indicar cuántas reacciones tuvieron y si han sido reproducidos o no. El listado debe estar ordenado alfabéticamente por título del vídeo.

select
	v.titulo as "Titulo del video",
    case
		when v.cantidadReproducciones > 0 then "Reproducido"
        when v.cantidadReproducciones = 0 then "Sin reproducido"
	end as 
    from videos v
    left join reaccion r 
    on v.idVideo = r.Video_idVideo
    group by "Titulo del video"
    order by "Titulo del video";



SELECT 
	v.titulo, 
	count(r.idReaccion) "Reacciones", 
	case 
		when v.cantidadReproducciones = 0 then "No" 
        else "Si" end as "Ha sido reproducido?"  
	FROM video v
	left join reaccion r on r.Video_idVideo = v.idVideo
	where v.cantidadReproducciones > 0
	group by v.titulo
	order by v.titulo;


SELECT c.nombre AS Avatar, b.nombre AS  Pais ,count(*) avatar_pais
FROM usuario a
INNER JOIN pais b ON a.Pais_idPais = b.idPais
INNER JOIN avatar c ON a.Avatar_idAvatar = c.idAvatar
GROUP BY b.nombre,c.nombre
ORDER BY avatar_pais DESC





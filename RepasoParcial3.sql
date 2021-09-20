# Repaso del parcial 

# 1 El total agrupado por tipo de reacción de las 10 videos mas vistos (Nombre de canción, tipo de reacción, 
# cantidad de vistas, cantidad de reacción)

select 
	v.titulo,
    treac.nombre,
	count(reac.idReaccion) as cantidad,
    v.cantidadReproducciones
    from video v
    left join reaccion reac
    on v.idVideo = reac.Video_idVideo
    left join tiporeaccion treac
    on reac.TipoReaccion_idTipoReaccion = treac.idTipoReaccion
    group by v.titulo, reac.TipoReaccion_idTipoReaccion
    order by v.cantidadReproducciones desc
    limit 20;
    

#Traer la lista de videos de las playlist por usuarios 
#(tener encuenta en solo traer los usuarios que si tienen playlist)

select 
	u.nombre, 
    p.nombre,
    v.titulo
    from usuario u
    inner join playlist p on u.idUsuario = p.Usuario_idUsuario
    left join playlist_video pv on p.idPlaylist = pv.Playlist_idPlaylist
    left join video v on pv.Video_idVideo = v.idVideo;
    
    
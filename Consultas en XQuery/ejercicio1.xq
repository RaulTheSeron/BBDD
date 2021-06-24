(:Obtener los nombres de los goleadores cuyo nombre comience por "P",
 sin repetición, ordenados alfabéticamente:)
for $j in distinct-values (doc("Liga")//jugador)
let $nombre := $j[starts-with($j,"P")]
order by $nombre
return $nombre
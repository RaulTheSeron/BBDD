(: Obtener los nombres de los equipos más goleadores como local,
 indicando el nombre del equipo y el número de goles:)
for $datos in  distinct-values(//local/@nombre )
let $goles:=(count(for $partidos in //partido
where $partidos/local/@nombre=$datos
return $partidos/local/goles/jugador))

order by $goles descending
return <EquipoPichichiLocal>{data($datos)} {string(" ")} {data($goles)}</EquipoPichichiLocal>

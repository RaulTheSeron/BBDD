(:Obtener los nombres de los equipos más goleadores , indicando el nombre
 del equipo y el número de goles, ordenado desdendentemente:)
for $equipo in distinct-values(doc("Liga")//partido/*/@nombre)
let $goles := count(//partido/*[@nombre = $equipo]/goles/jugador)
order by $goles descending
return
<pichichi>{concat($equipo," ")}{$goles}</pichichi>
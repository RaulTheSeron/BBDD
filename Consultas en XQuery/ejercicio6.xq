(:Obtener los nombres goleadores ordenados descendentemente por número de goles y después alfabéticamente.:)
for $jugador in distinct-values(data(//jugador))
let $goles := count(for $g in //jugador
              where $g = $jugador
              return $g)
order by $jugador
order by $goles descending
return 
<pichichi>{data($jugador)}-{$goles}</pichichi>
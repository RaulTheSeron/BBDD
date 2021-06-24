(:Mostrar los nombres de los equipos y el resultado en función de sus goleadores, así como sus goleadores:)
for $partido in doc("Liga")//partido
let $goleadores := data($partido/*/goles/jugador)
let $local := concat(string($partido/local/@nombre)," ")
let $visitante := concat(" ",string($partido/visitante/@nombre))
let $golesLocal := count($partido/local//jugador)
let $golesVisitante := count($partido/visitante//jugador)
return 
<partido>
  <resultado>{$local}{$golesLocal}-{$golesVisitante}{$visitante}</resultado>
  <goleadores>{$goleadores}</goleadores>
</partido>

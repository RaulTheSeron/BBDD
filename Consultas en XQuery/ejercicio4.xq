(: Mostrar los nombres de los equipos y el resultado de los encuentros disputados, con espacios en blanco entre los datos mostrados:)
for $partido in doc("Liga")//partido
let $local := concat(string($partido/local/@nombre)," ")
let $visitante := concat(" ",string($partido/visitante/@nombre))
let $golesLocal := count($partido/local//jugador)
let $golesVisitante := count($partido/visitante//jugador)
return 
<partido>{$local}{$golesLocal}-{$golesVisitante}{$visitante}</partido>

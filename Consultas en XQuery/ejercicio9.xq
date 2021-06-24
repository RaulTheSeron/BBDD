(:Mostrar el total de goles de la temporada, el gol más tempranero y el gol más tardío.:)
let $rapido := min(//jugador/@min)
let $tardio := max(//jugador/@min)
let $totales := count(//jugador)
return 
<goles>
  <total>{$totales}</total>
  <rapido>{$rapido}</rapido>
  <tardio>{$tardio}</tardio>
</goles>
(:Mostrar los jugadores y los minutos en los que se han marcado goles ordenados ascendentemente:)
for $jugador in doc("Liga")//jugador
let $minuto := string($jugador/@min)
order by $jugador ascending
return <gol>{data($jugador)}-{$minuto}</gol>
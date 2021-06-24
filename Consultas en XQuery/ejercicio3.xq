(: Obtener los nombres de los equipos de la liga, bien actúen como local o como visitante, ordenados alfabéticamente:)
for $b in distinct-values(doc("Liga")//partido/*/@nombre)
order by $b
return $b
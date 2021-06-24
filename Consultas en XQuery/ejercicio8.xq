(:Mostrar los nombres de los equipos de cada partido ordenados por fecha del partido:)
for $p in doc("Liga")//partido
order by $p/@fecha
return <partido>
  {string($p/local/@nombre)}-{string($p/visitante/@nombre)}---{string($p/@fecha)}
  </partido>
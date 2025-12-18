USE bd_spotify;
/* CONSULTA DE VIRALIDAD: Artistas nuevos en 2025 que superan la media de 2010 */
SELECT 
    a.nombre AS artista, 
    a.num_reproducciones, 
    g.nombre_genero AS genero
FROM artistas a
JOIN canciones c ON a.id_artista = c.id_artista
JOIN generos g ON c.id_genero = g.id_genero
WHERE c.anio = 2025 
  /* Aseguramos que el artista no tiene canciones en años anteriores */
  AND a.id_artista NOT IN (
      SELECT DISTINCT id_artista 
      FROM canciones 
      WHERE anio < 2025
  )
  /* Que supere la media de reproducciones de los artistas de 2010 */
  AND a.num_reproducciones > (
      SELECT AVG(a2.num_reproducciones) 
      FROM artistas a2 
      JOIN canciones c2 ON a2.id_artista = c2.id_artista 
      WHERE c2.anio = 2010
  )
GROUP BY a.nombre, a.num_reproducciones, g.nombre_genero
ORDER BY a.num_reproducciones DESC;
-- El "Artista Comodín" es aquel que tiene canciones en más de un género y que, además, es similar a muchos otros artistas de vuestra base de datos. Es el puente perfecto para que los fans del Rock no se vayan cuando empieza el Pop.
/* ARTISTA COMODÍN: El puente entre géneros y fans */
SELECT 
    a.nombre AS artista,
    COUNT(DISTINCT c.id_genero) AS total_generos_distintos,
    GROUP_CONCAT(DISTINCT g.nombre_genero SEPARATOR ' + ') AS mezcla_generos,
    /* Contamos cuántas comas hay en artistas_similares para estimar su red de conexiones */
    (LENGTH(a.artistas_similares) - LENGTH(REPLACE(a.artistas_similares, ',', '')) + 1) AS indice_conexion,
    a.num_reproducciones
FROM artistas a
JOIN canciones c ON a.id_artista = c.id_artista
JOIN generos g ON c.id_genero = g.id_genero
GROUP BY a.nombre, a.artistas_similares, a.num_reproducciones
/* Filtramos para que al menos toque 2 géneros */
HAVING total_generos_distintos > 1
/* Priorizamos a los que tienen más mezcla de géneros y más artistas similares */
ORDER BY total_generos_distintos DESC, indice_conexion DESC
LIMIT 5;
-- Artistas top españoles 
/* TALENTO NACIONAL: Artistas top españoles o de habla hispana */
SELECT 
    nombre, 
    oyentes, 
    num_reproducciones,
    LEFT(biografia, 150) AS fragmento_bio
FROM artistas
WHERE biografia LIKE '%Spain%' 
   OR biografia LIKE '%Spanish%'
   OR biografia LIKE '%España%'
   OR biografia LIKE '%español%'
   OR biografia LIKE '%española%'
ORDER BY num_reproducciones DESC
LIMIT 10;
-- artista zamorano --
/* ORGULLO LOCAL: Artistas de Zamora o con raíces zamoranas */
SELECT 
    nombre, 
    oyentes, 
    num_reproducciones,
    LEFT(biografia, 200) AS fragmento_bio
FROM artistas
WHERE biografia LIKE '%Zamora%' 
   OR biografia LIKE '%zamorano%'
   OR biografia LIKE '%zamorana%'
ORDER BY num_reproducciones DESC;
-- artista de castilla y leon --
/* TALENTO REGIONAL: Artistas de Castilla y León */
SELECT 
    nombre, 
    oyentes, 
    num_reproducciones,
    LEFT(biografia, 200) AS fragmento_bio
FROM artistas
WHERE biografia LIKE '%Castilla y León%' 
   OR biografia LIKE '%Castile and Leon%'
   OR biografia LIKE '%Valladolid%'
   OR biografia LIKE '%Salamanca%'
   OR biografia LIKE '%Burgos%'
   OR biografia LIKE '%León%'
   OR biografia LIKE '%Palencia%'
   OR biografia LIKE '%Zamora%'
   OR biografia LIKE '%Segovia%'
   OR biografia LIKE '%Soria%'
   OR biografia LIKE '%Ávila%'
ORDER BY num_reproducciones DESC;
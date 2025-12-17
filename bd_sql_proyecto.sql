USE bd_spotify;

# GENEROS
CREATE TABLE generos (
  id_genero INTEGER PRIMARY KEY AUTO_INCREMENT,
  nombre_genero VARCHAR(100) UNIQUE
);
# ARTISTAS
CREATE TABLE artistas (
  id_artista INTEGER PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  biografia TEXT,
  oyentes INTEGER,
 num_reproducciones INTEGER,
artistas_similares TEXT
);
# CANCIONES
CREATE TABLE canciones (
  id_cancion INTEGER PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
anio INTEGER,
 id_genero INTEGER, id_artista INTEGER,
 FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
FOREIGN KEY (id_artista) REFERENCES artistas(id_artista)
);

-- INSERTAR GÉNEROS
INSERT INTO generos (nombre_genero) VALUES 
('rock'),
('pop'),
('indie'),
('punk');
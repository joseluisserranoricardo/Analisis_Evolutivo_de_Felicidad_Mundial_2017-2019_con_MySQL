-- ==========================================================
-- PROYECTO: Análisis de Felicidad Mundial (2017-2019)
-- TECNOLOGÍA: MySQL
-- DESCRIPCIÓN: Integración de datos históricos y análisis de mejora
-- ==========================================================

-- 1. Creación de la estructura
CREATE DATABASE IF NOT EXISTS proyecto_felicidad;
USE proyecto_felicidad;

-- Borramos la tabla si existe para poder re-ejecutar el script limpiamente
DROP TABLE IF EXISTS felicidad_mundial;

CREATE TABLE felicidad_mundial (
    pais VARCHAR(100),
    ranking INT,
    puntaje FLOAT,
    anio INT
);

-- NOTA: La carga de datos se realizó mediante el 'Table Data Import Wizard'
-- siguiendo la secuencia: Importar 2017 -> Update -> Importar 2018 -> Update...

/* -- Comandos utilizados post-importación para etiquetar cada año:
UPDATE felicidad_mundial SET anio = 2017 WHERE anio IS NULL;
UPDATE felicidad_mundial SET anio = 2018 WHERE anio IS NULL;
UPDATE felicidad_mundial SET anio = 2019 WHERE anio IS NULL;
*/

-- 2. ANÁLISIS DE DATOS

-- Consulta A: Identificar los 5 países con mejor promedio histórico en el trienio
SELECT pais, AVG(puntaje) as promedio_historico
FROM felicidad_mundial
GROUP BY pais
ORDER BY promedio_historico DESC
LIMIT 5;

-- Consulta B: Cálculo de mejora absoluta entre el año base (2017) y el final (2019)
-- Se utiliza un SELF-JOIN para comparar registros del mismo país en diferentes años.
SELECT 
    f19.pais, 
    (f19.puntaje - f17.puntaje) as mejora
FROM felicidad_mundial f17
JOIN felicidad_mundial f19 ON f17.pais = f19.pais
WHERE f17.anio = 2017 AND f19.anio = 2019
ORDER BY mejora DESC
LIMIT 10;
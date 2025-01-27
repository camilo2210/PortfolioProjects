--Historical Best Picture Winners from 1928 
SELECT year_ceremony, name, film
FROM the_oscar_award 
WHERE (category = 'OUTSTANDING PICTURE' OR category = 'OUTSTANDING PRODUCTION' OR category = 'BEST PICTURE') AND winner = 'True'
ORDER BY year_ceremony 

--Historical international film
SELECT year_ceremony, name, film 
FROM the_oscar_award
WHERE (CATEGORY =  'INTERNATIONAL FEATURE FILM' OR category = 'FOREIGN LANGUAGE FILM') AND winner = 'True'

--Historical Best Director Winners
SELECT year_ceremony, name
FROM the_oscar_award
WHERE category = 'DIRECTING' AND winner = 'True'

--how many prices are given historical 
SELECT SUM(
    CASE 
        WHEN winner = 'TRUE' THEN 1
        WHEN winner = 'FALSE' THEN 0
    END
) AS Total_premios_entregados
FROM the_oscar_award

--Categorias o personas con mas premios
-- Top directors who won both Best Picture and Best Director
SELECT 
    d.name AS Director,
    COUNT(DISTINCT bp.film) AS Best_Picture_Wins,
    COUNT(DISTINCT d.film) AS Best_Director_Wins
FROM the_oscar_award AS bp
JOIN the_oscar_award AS d
    ON bp.film = d.film 
    AND bp.year_ceremony = d.year_ceremony
WHERE 
    bp.category IN ('OUTSTANDING PICTURE', 'OUTSTANDING PRODUCTION', 'BEST PICTURE') 
    AND bp.winner = 'TRUE' -- Aseguramos que sean ganadores en "Best Picture"
    AND d.category = 'DIRECTING' 
    AND d.winner = 'True' -- Aseguramos que sean ganadores en "Best Director"
GROUP BY d.name
ORDER BY Best_Picture_Wins DESC;


-- Count the number of athletes from each countryl
SELECT 
    Country, COUNT(*) as total_athletes
FROM 
    tbl_athletes
GROUP BY 
    Country
ORDER BY 
    total_athletes DESC;

-- Calculate the total medals won by each country;
SELECT
    TeamCountry,
    SUM(Gold) as total_gold,
    SUM(Silver) as total_silver,
    SUM(Bronze) as total_bronze
FROM   
    tbl_medals
GROUP BY 
    TeamCountry
ORDER BY
    total_gold DESC;

-- Calculate the average number of entries by gender for each dicipline;
SELECT 
    Discipline,
    AVG(Female) as avg_female,
    AVG(Male) as avg_male
FROM 
    tbl_entriesgender
GROUP BY
    Discipline;

-- Top 5 discipline has most female
SELECT TOP 5
    Discipline,
    Female
FROM 
    tbl_entriesgender
ORDER BY 
    Female DESC

-- Top 5 discipline has most male
SELECT TOP 5
    Discipline,
    Male
FROM 
    tbl_entriesgender
ORDER BY 
    Male DESC;


-- Find country has most players by discipline

WITH count_players_by_country_discipline AS(
    SELECT
        Country, 
        Discipline,
        COUNT(*) AS number_of_players
    FROM 
        tbl_athletes
    GROUP BY
        Country,Discipline
),
ranking_number_of_players AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY Discipline ORDER BY number_of_players DESC) AS rank
    FROM 
        count_players_by_country_discipline
)

SELECT 
    Discipline,
    Country as country_has_most_player,
    number_of_players 
FROM
    ranking_number_of_players
WHERE 
    rank = 1
ORDER BY
    number_of_players DESC;
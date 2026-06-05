-- 1. Create a brand new database for our project
CREATE DATABASE mlbb_esports_db;
USE mlbb_esports_db;

-- 2. Create the Hero Characteristics Table (Dimension Table)
CREATE TABLE Hero_Stats_Dim (
    hero_name VARCHAR(50) PRIMARY KEY,
    primary_role VARCHAR(30),
    lane VARCHAR(30),
    base_hp INT,
    base_mana INT,
    physical_damage INT
);

-- 3. Create the Meta Performance Statistics Table (Fact Table)
CREATE TABLE Esports_Performance_Fact (
    performance_id INT AUTO_INCREMENT PRIMARY KEY,
    hero_name VARCHAR(50),
    esport_wins INT,
    esport_loss INT,
    total_matches INT,
    win_rate DECIMAL(5,4),
    FOREIGN KEY (hero_name) REFERENCES Hero_Stats_Dim(hero_name)
);
SELECT 
    h.primary_role,
    COUNT(h.hero_name) AS total_heroes,
    SUM(f.total_matches) AS combined_matches,
    ROUND(AVG(f.win_rate) * 100, 2) AS average_win_rate_percentage
FROM hero_stats_dim h
JOIN esports_performance_fact f ON h.hero_name = f.hero_name
GROUP BY h.primary_role
ORDER BY average_win_rate_percentage DESC;
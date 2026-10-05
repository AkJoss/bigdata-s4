-- =============================================================================
-- Activity 09 — seed city row + sample weather check
-- @author José Alberto Rocha Munguía
-- =============================================================================

USE gans;

-- Fixed VALUES keyword and Rome coordinates:
-- latitude ≈ 41.8931, elevation ≈ 35 m, longitude ≈ 12.4828
INSERT INTO city_pop (
    city, country, country_code, population,
    elevation_meters, latitude, longitude, municipality_iso_country
) VALUES (
    'Rome', 'Italy', 'ITA', 2872800,
    35, 41.8931, 12.4828, 'IT'
);

SELECT * FROM weather_data LIMIT 15;

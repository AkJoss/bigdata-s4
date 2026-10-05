-- =============================================================================
-- Activity 09 — GANS schema (cities, airports, weather, flight arrivals)
-- Coursework: Big Data fundamentals (4th semester)
-- @author José Alberto Rocha Munguía
-- Dialect: MySQL
-- =============================================================================

CREATE DATABASE IF NOT EXISTS gans;
USE gans;

DROP TABLE IF EXISTS flight_arrival;
DROP TABLE IF EXISTS weather_data;
DROP TABLE IF EXISTS airport;
DROP TABLE IF EXISTS city_pop;

CREATE TABLE IF NOT EXISTS city_pop (
    city VARCHAR(255),
    country VARCHAR(255),
    country_code VARCHAR(3),
    population DECIMAL,
    elevation_meters DECIMAL,
    latitude DECIMAL,
    longitude DECIMAL,
    municipality_iso_country VARCHAR(255),
    PRIMARY KEY (municipality_iso_country)
);

CREATE TABLE IF NOT EXISTS airport (
    airport_name VARCHAR(255),
    latitude_deg DECIMAL,
    longitude_deg DECIMAL,
    elevation_ft DECIMAL,
    iso_country VARCHAR(3),
    iso_region VARCHAR(255),
    municipality VARCHAR(255),
    icao_code VARCHAR(255),
    iata_code VARCHAR(255),
    municipality_iso_country VARCHAR(255),
    PRIMARY KEY (icao_code),
    FOREIGN KEY (municipality_iso_country) REFERENCES city_pop (municipality_iso_country)
);

CREATE TABLE IF NOT EXISTS weather_data (
    weather_id INT AUTO_INCREMENT,
    weather_datetime DATETIME,
    temperature DECIMAL,
    humidity INTEGER,
    weather_status VARCHAR(255),
    wind DECIMAL,
    rain_qty DECIMAL,
    snow DECIMAL,
    municipality_iso_country VARCHAR(255),
    PRIMARY KEY (weather_id),
    FOREIGN KEY (municipality_iso_country) REFERENCES city_pop (municipality_iso_country)
);

CREATE TABLE IF NOT EXISTS flight_arrival (
    arrival_id INT AUTO_INCREMENT,
    scheduled_arrival_time DATETIME,
    flight_number VARCHAR(255),
    from_airport VARCHAR(255),
    airline VARCHAR(255),
    aircraft VARCHAR(255),
    icao_code VARCHAR(255),
    PRIMARY KEY (arrival_id),
    FOREIGN KEY (icao_code) REFERENCES airport (icao_code)
);

-- Smoke check
SELECT * FROM weather_data LIMIT 10;
